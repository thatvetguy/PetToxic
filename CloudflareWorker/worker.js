// Pet Toxic — App Event Tracker
// Cloudflare Worker + KV
//
// POST /track  — records an event
//   Body: { "event": "call:aspca" | "call:pph" | "call:emergencyvet" | "share" | "search_miss", "term": "optional" }
//
// GET  /stats?key=SECRET  — returns all counts
// GET  /stats?key=SECRET&section=misses  — returns top missed search terms
//
// KV keys:
//   total:{event}          — lifetime count per event
//   daily:{event}:{date}   — daily count per event
//   miss:{term}            — count per missed search term

const STATS_KEY = "SASI-2026";

const VALID_EVENTS = ["call:aspca", "call:pph", "call:emergencyvet", "share", "search_miss"];

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type",
    };

    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    // POST /track — record an event
    if (url.pathname === "/track" && request.method === "POST") {
      try {
        const body = await request.json();
        const event = body.event;

        if (!VALID_EVENTS.includes(event)) {
          return new Response("Invalid event", { status: 400, headers: corsHeaders });
        }

        const today = new Date().toISOString().slice(0, 10);

        // Increment total count
        const totalKey = `total:${event}`;
        const currentTotal = parseInt(await env.CALL_TRACKING.get(totalKey) || "0");
        await env.CALL_TRACKING.put(totalKey, String(currentTotal + 1));

        // Increment daily count
        const dailyKey = `daily:${event}:${today}`;
        const currentDaily = parseInt(await env.CALL_TRACKING.get(dailyKey) || "0");
        await env.CALL_TRACKING.put(dailyKey, String(currentDaily + 1));

        // For search misses, also store the term
        if (event === "search_miss" && body.term) {
          const term = body.term.toLowerCase().trim().slice(0, 100);
          if (term.length > 0) {
            const missKey = `miss:${term}`;
            const currentMiss = parseInt(await env.CALL_TRACKING.get(missKey) || "0");
            await env.CALL_TRACKING.put(missKey, String(currentMiss + 1));
          }
        }

        return new Response(JSON.stringify({ ok: true }), {
          headers: { "Content-Type": "application/json", ...corsHeaders },
        });
      } catch (e) {
        return new Response("Bad request", { status: 400, headers: corsHeaders });
      }
    }

    // GET /stats — view counts
    if (url.pathname === "/stats" && request.method === "GET") {
      const key = url.searchParams.get("key");
      if (key !== STATS_KEY) {
        return new Response("Unauthorized", { status: 401, headers: corsHeaders });
      }

      const section = url.searchParams.get("section");

      // Missed search terms section
      if (section === "misses") {
        const misses = {};
        const list = await env.CALL_TRACKING.list({ prefix: "miss:" });
        for (const key of list.keys) {
          const term = key.name.replace("miss:", "");
          const count = parseInt(await env.CALL_TRACKING.get(key.name) || "0");
          misses[term] = count;
        }
        // Sort by count descending
        const sorted = Object.entries(misses)
          .sort((a, b) => b[1] - a[1])
          .slice(0, 50);

        return new Response(JSON.stringify({ missed_terms: Object.fromEntries(sorted) }, null, 2), {
          headers: { "Content-Type": "application/json", ...corsHeaders },
        });
      }

      // Main stats
      const totals = {};
      for (const event of VALID_EVENTS) {
        totals[event] = parseInt(await env.CALL_TRACKING.get(`total:${event}`) || "0");
      }

      // Daily breakdown (last 30 days)
      const daily = {};
      for (let i = 0; i < 30; i++) {
        const date = new Date();
        date.setDate(date.getDate() - i);
        const dateStr = date.toISOString().slice(0, 10);

        const dayCounts = {};
        let hasData = false;
        for (const event of VALID_EVENTS) {
          const count = parseInt(await env.CALL_TRACKING.get(`daily:${event}:${dateStr}`) || "0");
          if (count > 0) {
            dayCounts[event] = count;
            hasData = true;
          }
        }
        if (hasData) {
          daily[dateStr] = dayCounts;
        }
      }

      const stats = { totals, daily };

      return new Response(JSON.stringify(stats, null, 2), {
        headers: { "Content-Type": "application/json", ...corsHeaders },
      });
    }

    return new Response("Not found", { status: 404, headers: corsHeaders });
  },
};
