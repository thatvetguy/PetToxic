//
//  LabWorkGuideService.swift
//  PetToxic
//
//  Created by Claude Code on 2/5/26.
//

import Foundation

class LabWorkGuideService {
    static let shared = LabWorkGuideService()

    /// All lab parameters
    private(set) var allParameters: [LabParameter] = []

    private init() {
        allParameters = Self.cbcParameters + Self.chemistryParameters + Self.coagulationParameters + Self.pancreasParameters + Self.urinalysisParameters
    }

    // MARK: - CBC Parameters (18 total)

    private static let cbcParameters: [LabParameter] = [

        // ══════════════════════════════════════════════════════════════
        // MARK: - Red Blood Cells (8 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Red Blood Cell Count",
            abbreviation: "RBC",
            alternateAbbreviations: nil,
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "The total number of red blood cells circulating in the bloodstream. Red blood cells carry oxygen from the lungs to tissues throughout the body.",
            highMeaning: "Your veterinarian may be concerned about dehydration, which concentrates the blood, or less commonly, conditions that cause the body to overproduce red blood cells.",
            lowMeaning: "Your veterinarian may be concerned about anemia, which can result from blood loss, destruction of red blood cells, or inadequate production by the bone marrow. Anemia affects how much oxygen the blood can deliver to tissues.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["anemia", "red cells", "erythrocytes", "oxygen"]
        ),

        LabParameter(
            name: "Hematocrit",
            abbreviation: "HCT",
            alternateAbbreviations: ["Hct"],
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "The percentage of blood volume made up of red blood cells, calculated by an automated analyzer.",
            highMeaning: "Your veterinarian may be concerned about dehydration or conditions causing increased red blood cell production.",
            lowMeaning: "Your veterinarian may be concerned about anemia from blood loss, red blood cell destruction, or bone marrow problems. Fewer red blood cells means the blood can carry less oxygen to tissues.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["anemia", "dehydration", "crit"]
        ),

        LabParameter(
            name: "Hemoglobin",
            abbreviation: "Hgb",
            alternateAbbreviations: ["Hb", "HGB"],
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "The protein inside red blood cells that binds and carries oxygen. This measures the total amount of hemoglobin in the blood.",
            highMeaning: "Your veterinarian may be concerned about dehydration or conditions that increase red blood cell numbers.",
            lowMeaning: "Your veterinarian may be concerned about anemia, which reduces the blood's ability to deliver oxygen to tissues.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["anemia", "oxygen", "iron"]
        ),

        LabParameter(
            name: "Mean Corpuscular Volume",
            abbreviation: "MCV",
            alternateAbbreviations: nil,
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "The average size of individual red blood cells. This helps classify the type of anemia when present.",
            highMeaning: "Your veterinarian may note that red blood cells are larger than normal (macrocytic), which can occur with certain nutritional deficiencies or when the body is actively regenerating red blood cells.",
            lowMeaning: "Your veterinarian may note that red blood cells are smaller than normal (microcytic), which can occur with iron deficiency or certain chronic conditions.",
            speciesNotes: "Some dog breeds, particularly Akitas and Shiba Inus, normally have smaller red blood cells.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["cell size", "macrocytic", "microcytic", "anemia type"]
        ),

        LabParameter(
            name: "Mean Corpuscular Hemoglobin",
            abbreviation: "MCH",
            alternateAbbreviations: nil,
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "The average amount of hemoglobin contained in each red blood cell.",
            highMeaning: "Your veterinarian may note this alongside elevated MCV, as larger cells typically contain more hemoglobin.",
            lowMeaning: "Your veterinarian may be concerned about iron deficiency or other causes of inadequate hemoglobin production.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["hemoglobin content", "anemia"]
        ),

        LabParameter(
            name: "Mean Corpuscular Hemoglobin Concentration",
            abbreviation: "MCHC",
            alternateAbbreviations: nil,
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "The average concentration of hemoglobin within red blood cells. This indicates how \"full\" of hemoglobin each cell is.",
            highMeaning: "True increases are rare. Your veterinarian may suspect hemolysis (breakdown of red blood cells) in the sample, or certain conditions affecting red blood cell shape.",
            lowMeaning: "Your veterinarian may be concerned about iron deficiency or conditions where red blood cells don't fill properly with hemoglobin (hypochromic anemia).",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["hemoglobin concentration", "hypochromic", "iron"]
        ),

        LabParameter(
            name: "Red Cell Distribution Width",
            abbreviation: "RDW",
            alternateAbbreviations: nil,
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "How much variation exists in the size of red blood cells. A higher number means more variation in cell sizes.",
            highMeaning: "Your veterinarian may note this indicates anisocytosis (mixed cell sizes), which often occurs when the body is producing new red blood cells in response to anemia or blood loss.",
            lowMeaning: "Low values are not typically concerning and indicate uniform red blood cell size.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["anisocytosis", "cell size variation", "regeneration"]
        ),

        LabParameter(
            name: "Reticulocyte Count",
            abbreviation: "Retic",
            alternateAbbreviations: ["Retics", "% Reticulocytes"],
            category: .redBloodCells,
            panelType: .cbc,
            whatItMeasures: "The number of young, immature red blood cells recently released from the bone marrow. This shows whether the bone marrow is actively producing new red blood cells.",
            highMeaning: "Your veterinarian will view this as a positive sign that the bone marrow is responding appropriately to anemia or blood loss (regenerative anemia).",
            lowMeaning: "In an anemic patient, your veterinarian may be concerned that the bone marrow is not responding appropriately (non-regenerative anemia), which requires further investigation.",
            speciesNotes: "Cats may take longer to show a reticulocyte response than dogs.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["regenerative", "non-regenerative", "bone marrow response", "young red cells", "immature"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - White Blood Cells (6 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "White Blood Cell Count",
            abbreviation: "WBC",
            alternateAbbreviations: nil,
            category: .whiteBloodCells,
            panelType: .cbc,
            whatItMeasures: "The total number of white blood cells in the bloodstream. White blood cells are the immune system's primary defense against infection and disease.",
            highMeaning: "Your veterinarian may be concerned about infection, inflammation, stress, or in some cases, leukemia. The specific type of white cell that is elevated helps determine the cause.",
            lowMeaning: "Your veterinarian may be concerned about overwhelming infection, bone marrow suppression, viral disease, or certain medications affecting white cell production.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["infection", "immune", "leukocytes", "inflammation"]
        ),

        LabParameter(
            name: "Neutrophils",
            abbreviation: "Neut",
            alternateAbbreviations: ["Segs", "PMNs"],
            category: .whiteBloodCells,
            panelType: .cbc,
            whatItMeasures: "The most abundant type of white blood cell, neutrophils are the first responders to bacterial infections and inflammation. Results may show both a percentage and an absolute count.",
            highMeaning: "Your veterinarian may be concerned about bacterial infection, inflammation, stress, or corticosteroid effects. This is called neutrophilia.",
            lowMeaning: "Your veterinarian may be concerned about overwhelming infection (where neutrophils are consumed faster than produced), bone marrow problems, or certain viral infections. This is called neutropenia.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["bacterial infection", "inflammation", "segs", "neutrophilia", "neutropenia"]
        ),

        LabParameter(
            name: "Lymphocytes",
            abbreviation: "Lymph",
            alternateAbbreviations: nil,
            category: .whiteBloodCells,
            panelType: .cbc,
            whatItMeasures: "White blood cells involved in immune responses, including producing antibodies and fighting viral infections. Results may show both a percentage and an absolute count.",
            highMeaning: "Your veterinarian may be concerned about chronic infection, immune stimulation, or in some cases, lymphocytic leukemia or lymphoma.",
            lowMeaning: "Your veterinarian may note this commonly occurs with stress or corticosteroid use. It can also occur with certain viral infections or immune system disorders.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["immune", "viral", "antibodies", "lymphocytosis", "lymphopenia", "lymphoma"]
        ),

        LabParameter(
            name: "Monocytes",
            abbreviation: "Mono",
            alternateAbbreviations: nil,
            category: .whiteBloodCells,
            panelType: .cbc,
            whatItMeasures: "Large white blood cells that migrate into tissues and become macrophages, which engulf debris, dead cells, and pathogens. Results may show both a percentage and an absolute count.",
            highMeaning: "Your veterinarian may be concerned about chronic inflammation, infection, stress, or tissue damage. Monocytes often increase during the recovery phase of infections.",
            lowMeaning: "Low monocyte counts are generally not clinically significant on their own.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["macrophage", "chronic inflammation", "tissue damage"]
        ),

        LabParameter(
            name: "Eosinophils",
            abbreviation: "Eos",
            alternateAbbreviations: nil,
            category: .whiteBloodCells,
            panelType: .cbc,
            whatItMeasures: "White blood cells involved in allergic reactions and parasitic infections. Results may show both a percentage and an absolute count.",
            highMeaning: "Your veterinarian may be concerned about allergies, parasites (especially intestinal worms, heartworm, or fleas), or certain skin conditions. Less commonly, eosinophilic diseases or certain cancers.",
            lowMeaning: "Your veterinarian may note this commonly occurs with stress or corticosteroid use. Low counts are usually not concerning on their own.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["allergies", "parasites", "worms", "heartworm", "flea allergy", "eosinophilia"]
        ),

        LabParameter(
            name: "Basophils",
            abbreviation: "Baso",
            alternateAbbreviations: nil,
            category: .whiteBloodCells,
            panelType: .cbc,
            whatItMeasures: "The rarest type of white blood cell, involved in allergic and inflammatory reactions. They are normally present in very low numbers.",
            highMeaning: "Elevated basophils are uncommon. Your veterinarian may consider allergic reactions, parasitic infections, or rarely, certain blood disorders.",
            lowMeaning: "Because basophils are normally very rare, low counts are expected and not clinically significant.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["allergic", "rare white cell", "basophilia"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Platelets (1 parameter)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Platelet Count",
            abbreviation: "PLT",
            alternateAbbreviations: ["Plts", "Thrombocytes"],
            category: .platelets,
            panelType: .cbc,
            whatItMeasures: "The number of platelets (small cell fragments) circulating in the blood. Platelets are essential for blood clotting and stopping bleeding.",
            highMeaning: "Your veterinarian may note this can occur with inflammation, iron deficiency, or after spleen removal. Significantly elevated counts occasionally require further evaluation.",
            lowMeaning: "Your veterinarian may be concerned about increased bleeding risk. Causes include immune-mediated destruction, bone marrow problems, severe infections, or platelet consumption from active bleeding. Clumping in the sample can cause falsely low results.",
            speciesNotes: "Cats commonly have platelet clumping, which can cause automated analyzers to report falsely low counts. Your veterinarian may note this on the report.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["clotting", "bleeding", "thrombocytopenia", "thrombocytosis", "bruising"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Cage-Side Tests (3 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Packed Cell Volume",
            abbreviation: "PCV",
            alternateAbbreviations: ["Crit"],
            category: .cageSideTests,
            panelType: .cbc,
            whatItMeasures: "The percentage of blood volume occupied by red blood cells, measured by spinning blood in a small tube and reading the result visually. PCV is the manual version of hematocrit (HCT).",
            highMeaning: "Your veterinarian may be concerned about dehydration or, less commonly, conditions causing increased red blood cell production.",
            lowMeaning: "Your veterinarian may be concerned about anemia from blood loss, red blood cell destruction, or inadequate production. Anemia affects how much oxygen the blood can deliver to tissues. PCV is often the first test performed in emergencies to assess for anemia.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["anemia", "dehydration", "spun hematocrit", "in-house", "emergency"]
        ),

        LabParameter(
            name: "Total Solids",
            abbreviation: "TS",
            alternateAbbreviations: ["TP"],
            category: .cageSideTests,
            panelType: .cbc,
            whatItMeasures: "A quick estimate of protein concentration in the blood, measured by placing plasma from a spun blood tube on a refractometer. This is read alongside PCV from the same sample.",
            highMeaning: "Your veterinarian may be concerned about dehydration or chronic inflammation. When both PCV and TS are elevated together, dehydration is likely.",
            lowMeaning: "Your veterinarian may be concerned about protein loss (from intestinal disease, kidney disease, or blood loss) or inadequate protein production by the liver. When PCV is low but TS is normal, blood loss is less likely than red cell destruction.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["protein", "dehydration", "refractometer", "in-house", "plasma protein"]
        ),

        LabParameter(
            name: "Buffy Coat",
            abbreviation: "BC",
            alternateAbbreviations: nil,
            category: .cageSideTests,
            panelType: .cbc,
            whatItMeasures: "The thin whitish layer visible between the red blood cells and plasma in a spun blood tube. This layer contains white blood cells and platelets. Veterinarians estimate its thickness as a quick assessment.",
            highMeaning: "Your veterinarian may note an increased buffy coat suggests elevated white blood cell counts, which could indicate infection, inflammation, or rarely, leukemia.",
            lowMeaning: "A thin or absent buffy coat may suggest low white blood cell or platelet counts, though this is a rough estimate and requires confirmation with a complete blood count.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["white layer", "spun tube", "in-house", "white cells", "platelets", "leukemia screen"]
        ),
    ]

    // MARK: - Chemistry Parameters (23 total)

    private static let chemistryParameters: [LabParameter] = [

        // ══════════════════════════════════════════════════════════════
        // MARK: - Kidney Values (4 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Blood Urea Nitrogen",
            abbreviation: "BUN",
            alternateAbbreviations: ["Urea"],
            category: .kidneyValues,
            panelType: .chemistry,
            whatItMeasures: "A waste product from protein metabolism that is filtered out of the blood by the kidneys.",
            highMeaning: "Your veterinarian may be concerned about kidney disease, dehydration, urinary obstruction, or a high-protein diet. BUN can also increase with gastrointestinal bleeding (stomach/intestinal ulcers).",
            lowMeaning: "Your veterinarian may note this can occur with liver disease, low-protein diets, or overhydration. Low values are often not clinically significant on their own.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["kidney", "renal", "urea", "azotemia", "uremia"]
        ),

        LabParameter(
            name: "Creatinine",
            abbreviation: "Creat",
            alternateAbbreviations: ["Crea", "CREA"],
            category: .kidneyValues,
            panelType: .chemistry,
            whatItMeasures: "A waste product from muscle metabolism that is filtered by the kidneys at a relatively constant rate. Creatinine is considered a more specific indicator of kidney function than BUN.",
            highMeaning: "Your veterinarian may be concerned about reduced kidney function, dehydration, or urinary obstruction. Creatinine typically doesn't rise until significant kidney function is lost.",
            lowMeaning: "Your veterinarian may note this in pets with reduced muscle mass or severe weight loss. Low values are generally not concerning.",
            speciesNotes: "Greyhounds and other sighthound breeds normally have higher creatinine due to their muscle mass.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["kidney", "renal", "muscle", "azotemia"]
        ),

        LabParameter(
            name: "Symmetric Dimethylarginine",
            abbreviation: "SDMA",
            alternateAbbreviations: nil,
            category: .kidneyValues,
            panelType: .chemistry,
            whatItMeasures: "A newer kidney biomarker released during normal cell turnover and eliminated by the kidneys. SDMA can detect reduced kidney function earlier than creatinine.",
            highMeaning: "Your veterinarian may be concerned about early kidney disease, as SDMA can increase when only 25-40% of kidney function is lost. It is less affected by muscle mass than creatinine.",
            lowMeaning: "Low SDMA values are not clinically significant.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["kidney", "renal", "early detection", "IDEXX"]
        ),

        LabParameter(
            name: "Phosphorus",
            abbreviation: "Phos",
            alternateAbbreviations: ["P", "Phosphate"],
            category: .kidneyValues,
            panelType: .chemistry,
            whatItMeasures: "A mineral important for bones, teeth, and energy metabolism. The kidneys regulate phosphorus levels in the blood.",
            highMeaning: "Your veterinarian may be concerned about kidney disease (the most common cause in adult pets), as damaged kidneys cannot excrete phosphorus properly. Other causes include certain toxins, parathyroid problems, or bone tumors. High phosphorus is common in young, growing animals and is normal.",
            lowMeaning: "Your veterinarian may be concerned about certain hormonal disorders, malnutrition, or insulin overdose. Low phosphorus can also occur with some toxicities.",
            speciesNotes: "Young, growing puppies and kittens normally have higher phosphorus levels than adults.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["kidney", "renal", "bones", "mineral", "hyperphosphatemia"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Liver Values (5 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Alanine Aminotransferase",
            abbreviation: "ALT",
            alternateAbbreviations: ["SGPT"],
            category: .liverValues,
            panelType: .chemistry,
            whatItMeasures: "An enzyme found primarily inside liver cells. When liver cells are damaged or inflamed, ALT leaks into the bloodstream.",
            highMeaning: "Your veterinarian may be concerned about liver cell damage or inflammation from various causes including toxins, infections, medications, or liver disease. The degree of elevation does not always predict severity.",
            lowMeaning: "Low ALT is not clinically significant and is considered normal.",
            speciesNotes: "ALT is most liver-specific in dogs. In cats, ALT is still useful but the liver contains less of this enzyme.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["liver", "hepatic", "liver damage", "SGPT", "enzymes"]
        ),

        LabParameter(
            name: "Aspartate Aminotransferase",
            abbreviation: "AST",
            alternateAbbreviations: ["SGOT"],
            category: .liverValues,
            panelType: .chemistry,
            whatItMeasures: "An enzyme found in liver cells and muscle cells. It is released into the bloodstream when these cells are damaged.",
            highMeaning: "Your veterinarian may be concerned about liver damage or muscle injury. Since AST is found in both liver and muscle, it is often interpreted alongside ALT (liver-specific) and CK (muscle-specific) to determine the source.",
            lowMeaning: "Low AST is not clinically significant and is considered normal.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["liver", "muscle", "hepatic", "SGOT", "enzymes"]
        ),

        LabParameter(
            name: "Alkaline Phosphatase",
            abbreviation: "ALP",
            alternateAbbreviations: ["Alk Phos", "ALKP"],
            category: .liverValues,
            panelType: .chemistry,
            whatItMeasures: "An enzyme found in liver, bone, intestines, and other tissues. In the liver, it is associated with the bile duct system rather than liver cells themselves.",
            highMeaning: "Your veterinarian may be concerned about bile duct obstruction, certain liver diseases, Cushing's disease, or the effects of some medications (especially steroids). Bone growth or bone disease can also elevate ALP.",
            lowMeaning: "Low ALP is not clinically significant and is considered normal.",
            speciesNotes: "Dogs can have dramatically elevated ALP from steroid effects or Cushing's disease. Cats have less ALP in their liver, so even mild elevations in cats may be more significant. Young, growing animals normally have higher ALP due to bone growth.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["liver", "bile", "Cushing's", "steroids", "bone", "cholestasis"]
        ),

        LabParameter(
            name: "Gamma-Glutamyl Transferase",
            abbreviation: "GGT",
            alternateAbbreviations: nil,
            category: .liverValues,
            panelType: .chemistry,
            whatItMeasures: "An enzyme associated with the bile duct system in the liver. GGT is often used alongside ALP to evaluate bile flow problems.",
            highMeaning: "Your veterinarian may be concerned about bile duct obstruction or diseases affecting bile flow. In dogs, GGT is more specific for liver and bile duct disease than ALP.",
            lowMeaning: "Low GGT is not clinically significant and is considered normal.",
            speciesNotes: "GGT is particularly useful in cats, where it may be more sensitive for detecting liver disease than ALP.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["liver", "bile", "cholestasis", "bile duct"]
        ),

        LabParameter(
            name: "Total Bilirubin",
            abbreviation: "Tbili",
            alternateAbbreviations: ["T. Bili", "Bilirubin"],
            category: .liverValues,
            panelType: .chemistry,
            whatItMeasures: "A yellow pigment produced when red blood cells break down. The liver processes bilirubin so it can be excreted in bile.",
            highMeaning: "Your veterinarian may be concerned about liver disease, bile duct obstruction, or conditions causing excessive red blood cell destruction (hemolysis). Visible yellowing of the skin, gums, or eyes (jaundice/icterus) occurs when bilirubin is significantly elevated.",
            lowMeaning: "Low bilirubin is not clinically significant and is considered normal.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["jaundice", "icterus", "liver", "bile", "hemolysis"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Proteins (3 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Total Protein",
            abbreviation: "TP",
            alternateAbbreviations: nil,
            category: .proteins,
            panelType: .chemistry,
            whatItMeasures: "The total amount of protein in the blood, which includes albumin and globulins. Proteins are essential for immune function, clotting, and maintaining fluid balance.",
            highMeaning: "Your veterinarian may be concerned about dehydration (most common), chronic inflammation, or certain infections. Some cancers can also cause elevated proteins.",
            lowMeaning: "Your veterinarian may be concerned about protein loss through the intestines or kidneys, blood loss, liver disease (reduced production), or malnutrition.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["protein", "albumin", "globulin", "dehydration"]
        ),

        LabParameter(
            name: "Albumin",
            abbreviation: "Alb",
            alternateAbbreviations: nil,
            category: .proteins,
            panelType: .chemistry,
            whatItMeasures: "The most abundant protein in blood, made by the liver. Albumin helps maintain fluid in blood vessels and transports various substances throughout the body.",
            highMeaning: "Your veterinarian may note this is almost always due to dehydration concentrating the blood. True overproduction of albumin does not occur.",
            lowMeaning: "Your veterinarian may be concerned about liver disease (reduced production), protein loss through the kidneys or intestines, or severe malnutrition. Low albumin can lead to fluid accumulation in the abdomen or limbs.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["protein", "liver", "edema", "ascites", "kidney", "intestinal", "hepatic", "liver values"]
        ),

        LabParameter(
            name: "Globulin",
            abbreviation: "Glob",
            alternateAbbreviations: nil,
            category: .proteins,
            panelType: .chemistry,
            whatItMeasures: "A group of proteins including antibodies (immunoglobulins) and other proteins involved in immune function and inflammation. Globulin is often calculated by subtracting albumin from total protein.",
            highMeaning: "Your veterinarian may be concerned about chronic inflammation, infection, or immune stimulation. Certain cancers, particularly multiple myeloma, can cause significantly elevated globulins.",
            lowMeaning: "Your veterinarian may be concerned about immune deficiency (especially in young animals) or protein loss. Low globulins are less common than low albumin.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["immune", "antibodies", "inflammation", "infection", "immunoglobulin"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Electrolytes (7 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Sodium",
            abbreviation: "Na",
            alternateAbbreviations: ["Na+"],
            category: .electrolytes,
            panelType: .chemistry,
            whatItMeasures: "The major electrolyte in blood and body fluids, critical for nerve function, muscle contraction, and fluid balance.",
            highMeaning: "Your veterinarian may be concerned about dehydration, inadequate water intake, or certain hormonal disorders. Severe elevations can cause neurological signs.",
            lowMeaning: "Your veterinarian may be concerned about vomiting, diarrhea, kidney disease, certain hormonal disorders (including Addison's disease), or excessive fluid administration. Severe decreases can cause neurological signs.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["salt", "electrolyte", "dehydration", "Addison's", "fluid balance"]
        ),

        LabParameter(
            name: "Potassium",
            abbreviation: "K",
            alternateAbbreviations: ["K+"],
            category: .electrolytes,
            panelType: .chemistry,
            whatItMeasures: "An electrolyte essential for proper heart, nerve, and muscle function. The body tightly regulates potassium within a narrow range.",
            highMeaning: "Your veterinarian may be concerned about kidney disease (unable to excrete potassium), urinary obstruction, Addison's disease, or tissue damage. Severely elevated potassium is dangerous and can cause life-threatening heart rhythm abnormalities.",
            lowMeaning: "Your veterinarian may be concerned about vomiting, diarrhea, inadequate intake, or certain medications (especially some diuretics). Low potassium can cause muscle weakness.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["electrolyte", "heart", "muscle weakness", "Addison's", "kidney", "arrhythmia"]
        ),

        LabParameter(
            name: "Chloride",
            abbreviation: "Cl",
            alternateAbbreviations: ["Cl-"],
            category: .electrolytes,
            panelType: .chemistry,
            whatItMeasures: "An electrolyte that works closely with sodium to maintain fluid balance and acid-base status. Chloride changes often mirror sodium changes.",
            highMeaning: "Your veterinarian may note this often occurs alongside high sodium with dehydration, or with certain types of acid-base disturbances.",
            lowMeaning: "Your veterinarian may be concerned about vomiting (loss of stomach acid), certain kidney conditions, or respiratory problems. Low chloride often accompanies low sodium.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["electrolyte", "sodium", "acid-base", "vomiting"]
        ),

        LabParameter(
            name: "Calcium",
            abbreviation: "Ca",
            alternateAbbreviations: ["Ca++"],
            category: .electrolytes,
            panelType: .chemistry,
            whatItMeasures: "A mineral essential for bone health, muscle contraction, nerve function, and blood clotting. This measures total calcium, which includes calcium bound to proteins and the active (ionized) form.",
            highMeaning: "Your veterinarian may be concerned about certain cancers (most common cause of significant elevation), kidney disease, Addison's disease, certain toxins (vitamin D, some rodenticides, certain plants), or parathyroid gland problems.",
            lowMeaning: "Your veterinarian may be concerned about eclampsia (nursing mothers), parathyroid problems, kidney disease, pancreatitis, or certain toxins (ethylene glycol). Severely low calcium can cause tremors or seizures.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["bone", "parathyroid", "cancer", "eclampsia", "hypercalcemia", "hypocalcemia", "vitamin D"]
        ),

        LabParameter(
            name: "Ionized Calcium",
            abbreviation: "iCa",
            alternateAbbreviations: ["Ca++ (ionized)"],
            category: .electrolytes,
            panelType: .chemistry,
            whatItMeasures: "The biologically active form of calcium in the blood that is not bound to proteins. Ionized calcium is the form that affects muscle, nerve, and heart function.",
            highMeaning: "Your veterinarian may be concerned about the same conditions as total calcium, but ionized calcium gives a more accurate picture of the body's actual calcium status, especially when protein levels are abnormal.",
            lowMeaning: "Your veterinarian may be concerned about eclampsia, parathyroid problems, or other causes of low calcium. Ionized calcium is particularly useful for confirming true hypocalcemia.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["calcium", "active calcium", "parathyroid", "eclampsia"]
        ),

        LabParameter(
            name: "Magnesium",
            abbreviation: "Mg",
            alternateAbbreviations: nil,
            category: .electrolytes,
            panelType: .chemistry,
            whatItMeasures: "A mineral important for muscle and nerve function, energy production, and bone health. Magnesium is not routinely included on all standard chemistry panels.",
            highMeaning: "Your veterinarian may be concerned about kidney disease (reduced excretion), certain hormonal disorders, or excessive supplementation. High magnesium is relatively uncommon.",
            lowMeaning: "Your veterinarian may be concerned about inadequate intake, gastrointestinal losses, diabetes, or certain medications. Low magnesium can contribute to muscle weakness, heart rhythm abnormalities, or difficulty correcting low potassium or calcium.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["mineral", "muscle", "electrolyte"]
        ),

        LabParameter(
            name: "Total Carbon Dioxide / Bicarbonate",
            abbreviation: "TCO2",
            alternateAbbreviations: ["HCO3", "Bicarb"],
            category: .electrolytes,
            panelType: .chemistry,
            whatItMeasures: "Primarily reflects bicarbonate, a substance that helps buffer acids in the blood and maintain proper pH. This is a key indicator of acid-base balance.",
            highMeaning: "Your veterinarian may note this can occur with certain types of acid-base disturbances, prolonged vomiting, or some respiratory conditions.",
            lowMeaning: "Your veterinarian may be concerned about metabolic acidosis, which can occur with kidney disease, diabetic ketoacidosis, certain toxins (like ethylene glycol), severe diarrhea, or shock.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["acid-base", "acidosis", "alkalosis", "pH", "buffer"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Metabolism (3 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Glucose",
            abbreviation: "Glu",
            alternateAbbreviations: ["BG", "Blood Sugar"],
            category: .metabolism,
            panelType: .chemistry,
            whatItMeasures: "The primary sugar that cells use for energy. Blood glucose levels are regulated by insulin and other hormones.",
            highMeaning: "Your veterinarian may be concerned about diabetes mellitus, stress (especially in cats), Cushing's disease, or recent eating. Persistently elevated glucose with glucose in the urine suggests diabetes.",
            lowMeaning: "Your veterinarian may be concerned about insulin overdose (in diabetic pets), sepsis, liver disease, certain tumors (insulinoma), or in young or toy-breed puppies, inadequate nutrition. Severely low glucose can cause weakness, tremors, seizures, or collapse.",
            speciesNotes: "Cats commonly develop stress hyperglycemia from the veterinary visit itself, which can make diabetes diagnosis challenging.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["blood sugar", "diabetes", "insulin", "hypoglycemia", "hyperglycemia"]
        ),

        LabParameter(
            name: "Cholesterol",
            abbreviation: "Chol",
            alternateAbbreviations: nil,
            category: .metabolism,
            panelType: .chemistry,
            whatItMeasures: "A type of fat (lipid) in the blood that is essential for cell membranes and hormone production. Unlike in humans, high cholesterol in pets is rarely a primary heart disease concern.",
            highMeaning: "Your veterinarian may be concerned about hypothyroidism (most common cause in dogs), Cushing's disease, diabetes, liver disease, or kidney disease. Some pets have inherited high cholesterol.",
            lowMeaning: "Your veterinarian may note this can occur with liver disease, malnutrition, or intestinal malabsorption. Low cholesterol alone is often not clinically significant.",
            speciesNotes: "Dogs with significantly elevated cholesterol may be at risk for pancreatitis.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["lipid", "fat", "hypothyroid", "Cushing's"]
        ),

        LabParameter(
            name: "Triglycerides",
            abbreviation: "Trig",
            alternateAbbreviations: ["TG"],
            category: .metabolism,
            panelType: .chemistry,
            whatItMeasures: "A type of fat in the blood that comes from dietary fat and is also made by the liver. Triglycerides are best measured when the pet has fasted.",
            highMeaning: "Your veterinarian may be concerned about a recent meal (most common cause), diabetes, hypothyroidism, Cushing's disease, pancreatitis, or inherited lipid disorders such as those seen in Miniature Schnauzers. Very high triglycerides can make blood serum appear milky (lipemia).",
            lowMeaning: "Low triglycerides are generally not clinically significant.",
            speciesNotes: "Miniature Schnauzers are prone to inherited high triglycerides and associated pancreatitis risk.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["lipid", "fat", "lipemia", "pancreatitis", "fasting", "Schnauzer"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Muscle (1 parameter)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Creatine Kinase",
            abbreviation: "CK",
            alternateAbbreviations: ["CPK"],
            category: .muscle,
            panelType: .chemistry,
            whatItMeasures: "An enzyme found primarily in muscle tissue. When muscle cells are damaged, CK leaks into the bloodstream.",
            highMeaning: "Your veterinarian may be concerned about muscle injury, recent intense exercise, prolonged recumbency, injections, trauma, or muscle disease. CK rises quickly after muscle damage and returns to normal within days.",
            lowMeaning: "Low CK is not clinically significant and is considered normal.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["muscle", "CPK", "muscle damage", "exercise", "myopathy"]
        ),
    ]

    // MARK: - Coagulation Parameters (2 total)

    private static let coagulationParameters: [LabParameter] = [

        // ══════════════════════════════════════════════════════════════
        // MARK: - Clotting Times (2 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Prothrombin Time",
            abbreviation: "PT",
            alternateAbbreviations: ["Pro Time"],
            category: .clottingTimes,
            panelType: .coagulation,
            whatItMeasures: "PT measures how long it takes blood to clot through the extrinsic and common coagulation pathways. It evaluates several clotting factors including Factor VII, which is one of the first factors depleted in certain types of poisoning.",
            highMeaning: "A prolonged PT may indicate exposure to anticoagulant rodenticides (rat poison), liver disease affecting clotting factor production, vitamin K deficiency, depletion or consumption of clotting factors (such as in disseminated intravascular coagulation, or DIC), or an inherited clotting factor disorder (hemophilia). Your veterinarian may run this test urgently if rodenticide exposure is suspected.",
            lowMeaning: "A shortened PT is not typically considered clinically significant.",
            speciesNotes: "In dogs, PT is one of the first tests to become abnormal after anticoagulant rodenticide ingestion, often changing within 48–72 hours of exposure.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["prothrombin", "clotting", "coagulation", "rat poison", "rodenticide", "bleeding", "vitamin K", "clotting time", "pro time", "hemophilia", "hemophelia"]
        ),

        LabParameter(
            name: "Activated Partial Thromboplastin Time",
            abbreviation: "aPTT",
            alternateAbbreviations: ["PTT", "APTT"],
            category: .clottingTimes,
            panelType: .coagulation,
            whatItMeasures: "aPTT measures how long it takes blood to clot through the intrinsic and common coagulation pathways. Together with PT, it gives your veterinarian a more complete picture of your pet's clotting ability.",
            highMeaning: "A prolonged aPTT may indicate anticoagulant rodenticide poisoning, liver disease, depletion or consumption of clotting factors (such as in DIC), an inherited clotting disorder such as hemophilia, or the presence of a clotting inhibitor. aPTT evaluates several clotting factors in the intrinsic and common pathways, including Factor X. Your veterinarian may be concerned about active or potential bleeding.",
            lowMeaning: "A shortened aPTT is not typically considered clinically significant.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["partial thromboplastin", "clotting", "coagulation", "bleeding", "hemophilia", "hemophelia", "intrinsic pathway", "PTT", "clotting time", "factor X"]
        ),
    ]

    // MARK: - Pancreas Parameters (4 total)

    private static let pancreasParameters: [LabParameter] = [

        // ══════════════════════════════════════════════════════════════
        // MARK: - Pancreatic Enzymes (4 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Amylase",
            abbreviation: "AMYL",
            alternateAbbreviations: ["AMY"],
            category: .pancreaticEnzymes,
            panelType: .pancreas,
            whatItMeasures: "Amylase is an enzyme that helps break down starches and carbohydrates. It is produced by the pancreas and other tissues. Because it is not specific to the pancreas, amylase alone cannot diagnose pancreatitis.",
            highMeaning: "Elevated amylase may suggest pancreatic inflammation, but can also be increased with kidney disease (due to decreased clearance), intestinal disease, or liver disease. Your veterinarian will interpret this value alongside other tests rather than in isolation.",
            lowMeaning: "Low amylase is not typically considered clinically significant.",
            speciesNotes: "Amylase has limited diagnostic value in cats and is primarily used in dogs, though even in dogs it is considered an unreliable marker for pancreatitis on its own.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["amylase", "pancreas", "pancreatitis", "enzyme", "starch", "digestive enzyme"]
        ),

        LabParameter(
            name: "Lipase",
            abbreviation: "LIP",
            alternateAbbreviations: ["LIPA"],
            category: .pancreaticEnzymes,
            panelType: .pancreas,
            whatItMeasures: "Lipase is an enzyme that helps break down fats. Like amylase, it is produced by the pancreas but also by other tissues. Standard lipase tests cannot reliably diagnose pancreatitis on their own.",
            highMeaning: "Elevated lipase may suggest pancreatic inflammation, but can also be increased with kidney disease, intestinal disease, liver disease, or the use of certain medications. Your veterinarian will typically use more specific tests to evaluate for pancreatitis.",
            lowMeaning: "Low lipase is not typically considered clinically significant.",
            speciesNotes: "As with amylase, standard lipase measurement is considered an unreliable marker for pancreatitis in both dogs and cats. More specific pancreatic lipase tests (cPL, fPL) have largely replaced it for diagnosing pancreatitis.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["lipase", "pancreas", "pancreatitis", "enzyme", "fat", "digestive enzyme"]
        ),

        LabParameter(
            name: "Canine Pancreatic Lipase",
            abbreviation: "cPL",
            alternateAbbreviations: ["Spec cPL", "cPLI"],
            category: .pancreaticEnzymes,
            panelType: .pancreas,
            whatItMeasures: "cPL measures a form of lipase produced specifically by the pancreas in dogs. Unlike standard lipase, this test is highly specific to pancreatic tissue, making it much more reliable for evaluating pancreatitis.",
            highMeaning: "An elevated cPL strongly suggests pancreatic inflammation (pancreatitis) in dogs, but does not determine whether the pancreatitis is a primary condition or secondary to another disease process occurring in the body. Your veterinarian may use this test in combination with clinical signs, imaging, and other bloodwork to identify the underlying cause.",
            lowMeaning: "A normal or low cPL makes pancreatitis less likely, though it does not completely rule it out in all cases.",
            speciesNotes: "This test is specific to dogs. The equivalent test for cats is fPL (Feline Pancreatic Lipase).",
            relatedGlossaryTerms: nil,
            searchKeywords: ["canine pancreatic lipase", "cPL", "spec cPL", "cPLI", "pancreatitis", "dog", "pancreas", "IDEXX", "SNAP"]
        ),

        LabParameter(
            name: "Feline Pancreatic Lipase",
            abbreviation: "fPL",
            alternateAbbreviations: ["Spec fPL", "fPLI"],
            category: .pancreaticEnzymes,
            panelType: .pancreas,
            whatItMeasures: "fPL measures a form of lipase produced specifically by the pancreas in cats. It is the most reliable blood test available for evaluating pancreatitis in cats, where the disease can be particularly challenging to diagnose.",
            highMeaning: "An elevated fPL strongly suggests pancreatic inflammation (pancreatitis) in cats. Your veterinarian may note that pancreatitis in cats often presents with vague or subtle signs, making this test especially valuable.",
            lowMeaning: "A normal or low fPL makes pancreatitis less likely, though it does not completely rule it out in all cases.",
            speciesNotes: "This test is specific to cats. Pancreatitis in cats is often associated with concurrent inflammatory bowel disease and cholangitis, a combination sometimes referred to as \"triaditis.\" The equivalent test for dogs is cPL.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["feline pancreatic lipase", "fPL", "spec fPL", "fPLI", "pancreatitis", "cat", "pancreas", "triaditis", "IDEXX", "SNAP"]
        ),
    ]

    // MARK: - Urinalysis Parameters (16 total)

    private static let urinalysisParameters: [LabParameter] = [

        // ══════════════════════════════════════════════════════════════
        // MARK: - Physical (3 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Urine Color",
            abbreviation: "Color",
            alternateAbbreviations: nil,
            category: .physical,
            panelType: .urinalysis,
            whatItMeasures: "Urine color provides a quick visual assessment of hydration status and can hint at underlying conditions. Normal urine in dogs and cats is typically some shade of yellow, ranging from pale straw to amber.",
            highMeaning: "Dark yellow or amber urine may indicate dehydration or concentrated urine. Brown or tea-colored urine may suggest the presence of old blood, muscle breakdown products (myoglobin), or liver-related pigments. Red or pink urine may indicate fresh blood in the urinary tract. Orange urine can sometimes be caused by certain medications or bilirubin.",
            lowMeaning: "Very pale or nearly colorless urine may indicate dilute urine, which your veterinarian may want to evaluate further — especially in pets that are drinking excessively.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["urine color", "colour", "dark urine", "red urine", "brown urine", "orange urine", "pale urine", "blood in urine", "hematuria", "dehydration"]
        ),

        LabParameter(
            name: "Urine Clarity (Turbidity)",
            abbreviation: "Clarity",
            alternateAbbreviations: ["Turbidity", "Appearance"],
            category: .physical,
            panelType: .urinalysis,
            whatItMeasures: "Clarity describes how clear or cloudy a urine sample appears. Normal urine is typically clear to slightly hazy. Your veterinarian assesses clarity as part of the initial physical examination of the sample.",
            highMeaning: "Cloudy or turbid urine may contain white blood cells, red blood cells, bacteria, crystals, mucus, or cellular debris. Your veterinarian will examine the urine sediment under a microscope to determine the cause.",
            lowMeaning: "Clear urine is generally normal and not a cause for concern.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["clarity", "turbidity", "cloudy urine", "turbid", "hazy", "appearance", "clear urine", "mucus"]
        ),

        LabParameter(
            name: "Urine Specific Gravity",
            abbreviation: "USG",
            alternateAbbreviations: ["SG", "Sp. Gr.", "SpGr"],
            category: .physical,
            panelType: .urinalysis,
            whatItMeasures: "Urine specific gravity measures how concentrated or dilute the urine is compared to pure water. It reflects the kidneys' ability to concentrate urine and is one of the most important values on a urinalysis. Your veterinarian measures this using a refractometer.",
            highMeaning: "Highly concentrated urine may indicate dehydration or reduced water intake. While concentrated urine can be normal in a healthy, well-hydrated pet, your veterinarian may evaluate it in the context of other findings.",
            lowMeaning: "Dilute urine may indicate that the kidneys are not concentrating urine effectively, which can be an early sign of kidney disease. It can also be seen with excessive water drinking caused by conditions such as diabetes, Cushing's disease, or certain medications. Your veterinarian may consider USG one of the earliest indicators of kidney function changes.",
            speciesNotes: "Cats typically produce more concentrated urine than dogs. A dilute urine sample in a cat may be more concerning to your veterinarian than the same value in a dog.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["specific gravity", "USG", "concentration", "dilute", "concentrated", "refractometer", "kidney function", "dehydration", "drinking more", "polyuria", "polydipsia", "SG"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Chemical / Dipstick (7 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "Urine pH",
            abbreviation: "pH",
            alternateAbbreviations: nil,
            category: .chemicalDipstick,
            panelType: .urinalysis,
            whatItMeasures: "Urine pH measures how acidic or alkaline the urine is. Diet, medications, infections, and metabolic conditions can all influence urine pH. Your veterinarian uses this value alongside other findings to assess urinary health.",
            highMeaning: "Alkaline urine may be associated with urinary tract infections (particularly those caused by certain bacteria that produce urease), a plant-based or grain-heavy diet, or certain metabolic conditions. Some types of urinary crystals and stones are more likely to form in alkaline urine.",
            lowMeaning: "Acidic urine is common in pets eating meat-based diets and is often normal. However, persistently acidic urine may also be seen with metabolic acidosis, prolonged fasting, or certain disease states. Some types of urinary crystals and stones form preferentially in acidic urine.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["pH", "acidity", "alkaline", "acidic", "urine pH", "urinary stones", "crystals", "urease", "UTI"]
        ),

        LabParameter(
            name: "Urine Protein",
            abbreviation: "UPC / UP",
            alternateAbbreviations: ["Prot", "Protein"],
            category: .chemicalDipstick,
            panelType: .urinalysis,
            whatItMeasures: "The dipstick protein reading detects the presence of protein (primarily albumin) in the urine. Small amounts can be normal, but significant or persistent protein in the urine may prompt your veterinarian to investigate further, often with a more precise test called a urine protein:creatinine ratio (UPC).",
            highMeaning: "Protein in the urine (proteinuria) may indicate kidney disease, urinary tract inflammation or infection, or a systemic condition affecting the kidneys. Your veterinarian may be concerned about kidney damage if protein is found in the absence of infection or inflammation.",
            lowMeaning: "Absent or trace protein on dipstick is generally normal.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["protein", "proteinuria", "albumin", "UPC", "urine protein creatinine ratio", "kidney", "dipstick protein", "urine protein"]
        ),

        LabParameter(
            name: "Urine Glucose",
            abbreviation: "GLU",
            alternateAbbreviations: nil,
            category: .chemicalDipstick,
            panelType: .urinalysis,
            whatItMeasures: "This test detects the presence of glucose (sugar) in the urine. Glucose should not normally be present in urine — the kidneys typically reabsorb all glucose from the urine before it leaves the body.",
            highMeaning: "Glucose in the urine (glucosuria) most commonly indicates diabetes mellitus, meaning blood sugar levels have exceeded the kidneys' ability to reabsorb it. It can also occur with stress (particularly in cats), certain kidney disorders, or some medications. Your veterinarian will compare this finding with blood glucose levels.",
            lowMeaning: "Absent glucose in urine is normal and expected.",
            speciesNotes: "Cats can develop significant stress-related elevations in blood sugar, which may spill glucose into the urine during a stressful veterinary visit — even without diabetes.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["glucose", "sugar", "glucosuria", "diabetes", "blood sugar", "diabetic", "urine sugar"]
        ),

        LabParameter(
            name: "Urine Ketones",
            abbreviation: "KET",
            alternateAbbreviations: nil,
            category: .chemicalDipstick,
            panelType: .urinalysis,
            whatItMeasures: "This test detects ketones in the urine, which are byproducts produced when the body breaks down fat for energy instead of using glucose. Ketones should not normally be present in urine.",
            highMeaning: "Ketones in the urine (ketonuria) most commonly indicate diabetic ketoacidosis (DKA), a serious complication of uncontrolled diabetes. They can also be seen with prolonged fasting, starvation, or severe illness. Your veterinarian may treat the presence of ketones alongside diabetes as an urgent or emergency situation.",
            lowMeaning: "Absent ketones in urine is normal and expected.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["ketones", "ketonuria", "DKA", "diabetic ketoacidosis", "diabetes", "fasting", "fat breakdown", "ketosis"]
        ),

        LabParameter(
            name: "Urine Blood / Hemoglobin",
            abbreviation: "Blood",
            alternateAbbreviations: ["Hgb (urine)", "Occult Blood"],
            category: .chemicalDipstick,
            panelType: .urinalysis,
            whatItMeasures: "This dipstick test detects the presence of blood, free hemoglobin, or myoglobin in the urine. It cannot distinguish between these three, so your veterinarian interprets it alongside the urine sediment (which can identify intact red blood cells) and other findings.",
            highMeaning: "A positive result may indicate bleeding in the urinary tract (hematuria) from infection, stones, trauma, or tumors. It may also reflect hemoglobin released from destroyed red blood cells (hemoglobinuria) or myoglobin from muscle damage (myoglobinuria). Your veterinarian will use the sediment analysis and clinical context to determine the source.",
            lowMeaning: "A negative result is normal and expected.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["blood", "hematuria", "hemoglobin", "hemoglobinuria", "myoglobin", "myoglobinuria", "occult blood", "blood in urine", "red urine"]
        ),

        LabParameter(
            name: "Urine Bilirubin",
            abbreviation: "BIL",
            alternateAbbreviations: ["Bili (urine)", "UBil"],
            category: .chemicalDipstick,
            panelType: .urinalysis,
            whatItMeasures: "This test detects bilirubin in the urine. Bilirubin is a pigment produced when red blood cells are broken down and is normally processed by the liver and excreted in bile.",
            highMeaning: "Bilirubin in the urine (bilirubinuria) may indicate liver disease, bile duct obstruction, or excessive red blood cell destruction (hemolysis). Your veterinarian may investigate further with blood tests including total bilirubin and liver values.",
            lowMeaning: "Absent bilirubin in urine is generally normal.",
            speciesNotes: "Small amounts of bilirubin in the urine can be a normal finding in dogs (especially in concentrated samples from male dogs) due to the way dogs metabolize bilirubin. In cats, any bilirubin in the urine is considered abnormal and warrants further investigation.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["bilirubin", "bilirubinuria", "jaundice", "icterus", "liver", "bile", "hemolysis", "yellow urine"]
        ),

        LabParameter(
            name: "Urobilinogen",
            abbreviation: "UBG",
            alternateAbbreviations: nil,
            category: .chemicalDipstick,
            panelType: .urinalysis,
            whatItMeasures: "Urobilinogen is a byproduct formed when bilirubin is broken down by bacteria in the intestines. A small amount is normally reabsorbed and excreted in the urine.",
            highMeaning: "Elevated urobilinogen may suggest increased red blood cell destruction (hemolysis) or liver disease that impairs bilirubin processing. However, this test is considered unreliable on veterinary dipsticks and your veterinarian may not place significant weight on this value alone.",
            lowMeaning: "Absent urobilinogen may suggest bile duct obstruction (preventing bilirubin from reaching the intestines), though this finding is also difficult to interpret reliably on standard dipstick testing.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["urobilinogen", "UBG", "bilirubin", "liver", "hemolysis", "bile", "dipstick"]
        ),

        // ══════════════════════════════════════════════════════════════
        // MARK: - Sediment (6 parameters)
        // ══════════════════════════════════════════════════════════════

        LabParameter(
            name: "White Blood Cells (Urine Sediment)",
            abbreviation: "WBC (urine)",
            alternateAbbreviations: ["Pyuria", "WBCs/hpf"],
            category: .sediment,
            panelType: .urinalysis,
            whatItMeasures: "This is a count of white blood cells seen under the microscope in a urine sediment sample. White blood cells in urine indicate an inflammatory or immune response somewhere in the urinary tract.",
            highMeaning: "Increased white blood cells in urine (pyuria) most commonly indicate a urinary tract infection (UTI). They can also be seen with bladder inflammation (cystitis) without infection, kidney infection (pyelonephritis), urinary stones, or tumors in the urinary tract. Your veterinarian will often combine this finding with the presence or absence of bacteria to guide next steps.",
            lowMeaning: "Few to no white blood cells in urine sediment is normal.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["white blood cells", "WBC", "pyuria", "urinary tract infection", "UTI", "cystitis", "pyelonephritis", "inflammation", "urine sediment", "hpf"]
        ),

        LabParameter(
            name: "Red Blood Cells (Urine Sediment)",
            abbreviation: "RBC (urine)",
            alternateAbbreviations: ["Hematuria", "RBCs/hpf"],
            category: .sediment,
            panelType: .urinalysis,
            whatItMeasures: "This is a count of red blood cells seen under the microscope in a urine sediment sample. While the dipstick blood test detects blood, hemoglobin, and myoglobin together, the sediment exam identifies actual intact red blood cells.",
            highMeaning: "Red blood cells in urine (hematuria) may indicate a urinary tract infection, bladder or kidney stones, trauma, tumors, bleeding disorders, or inflammation anywhere along the urinary tract. Your veterinarian may note that the method of urine collection matters — samples collected by cystocentesis (needle directly into the bladder) may have a small number of red blood cells from the procedure itself.",
            lowMeaning: "Few to no red blood cells in urine sediment is normal.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["red blood cells", "RBC", "hematuria", "blood in urine", "bladder stones", "kidney stones", "cystocentesis", "urine sediment", "hpf"]
        ),

        LabParameter(
            name: "Bacteria (Urine Sediment)",
            abbreviation: "Bact",
            alternateAbbreviations: nil,
            category: .sediment,
            panelType: .urinalysis,
            whatItMeasures: "The microscopic examination of urine sediment can reveal the presence of bacteria. Your veterinarian evaluates this finding alongside white blood cell count and how the sample was collected, since collection method significantly affects interpretation.",
            highMeaning: "Bacteria in a sample collected by cystocentesis (needle directly into the bladder) strongly suggests a urinary tract infection. Bacteria in a free-catch or catheterized sample may represent contamination from the skin or lower urinary tract and is harder to interpret. Your veterinarian may recommend a urine culture to confirm infection and identify the specific bacteria involved.",
            lowMeaning: "Absent bacteria is generally normal. However, a lack of visible bacteria does not completely rule out infection — some infections involve low numbers of bacteria that may not be seen on sediment exam.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["bacteria", "UTI", "urinary tract infection", "urine culture", "cystocentesis", "free catch", "contamination", "bacteriuria", "sediment"]
        ),

        LabParameter(
            name: "Epithelial Cells (Urine Sediment)",
            abbreviation: "Epith",
            alternateAbbreviations: ["Epi Cells", "Squamous Cells", "Transitional Cells"],
            category: .sediment,
            panelType: .urinalysis,
            whatItMeasures: "Epithelial cells are cells that line the surfaces of the urinary tract. Your veterinarian identifies the type and number of epithelial cells present, which helps determine where in the urinary tract they originated.",
            highMeaning: "Small numbers of transitional epithelial cells (from the bladder lining) can be normal, but large numbers may suggest bladder inflammation, infection, or irritation. Squamous epithelial cells typically indicate contamination from the skin or lower genital tract during sample collection. Your veterinarian may be particularly attentive to clusters of abnormal-appearing transitional cells, which may warrant further investigation.",
            lowMeaning: "Few to no epithelial cells is normal.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["epithelial cells", "squamous", "transitional", "bladder lining", "contamination", "sediment", "epi cells"]
        ),

        LabParameter(
            name: "Urinary Casts",
            abbreviation: "Casts",
            alternateAbbreviations: nil,
            category: .sediment,
            panelType: .urinalysis,
            whatItMeasures: "Casts are cylindrical structures formed in the tiny tubules of the kidneys. They are essentially molds of the tubules and can contain various materials. Their presence generally indicates that something is happening within the kidneys themselves, rather than in the lower urinary tract.",
            highMeaning: "The type of cast helps your veterinarian determine what may be affecting the kidneys. Hyaline casts (clear, protein-based) may be seen in small numbers normally or with mild kidney changes. Granular casts suggest kidney tubular damage or degeneration. Cellular casts containing white or red blood cells point to active inflammation or bleeding within the kidneys. Your veterinarian interprets the type and number of casts alongside other bloodwork and urinalysis findings.",
            lowMeaning: "Absent or rare hyaline casts is normal. The presence of any granular or cellular casts is generally considered significant.",
            speciesNotes: nil,
            relatedGlossaryTerms: nil,
            searchKeywords: ["casts", "urinary casts", "hyaline", "granular", "cellular", "kidney tubules", "renal", "tubular damage", "sediment"]
        ),

        LabParameter(
            name: "Urine Crystals (Crystalluria)",
            abbreviation: "Crystals",
            alternateAbbreviations: ["Crystalluria"],
            category: .sediment,
            panelType: .urinalysis,
            whatItMeasures: "The sediment exam identifies crystals that have formed in the urine. The type of crystal present depends on urine pH, concentration, and the presence of certain minerals or substances. Your veterinarian identifies the crystal type under the microscope, as different types have different clinical significance.",
            highMeaning: "Common crystal types include struvite (often associated with alkaline urine and sometimes urinary tract infections), calcium oxalate (often associated with acidic or concentrated urine), and urate crystals. While small numbers of crystals can sometimes be an incidental finding, significant crystalluria may indicate an increased risk for urinary stone formation. Your veterinarian may recommend dietary changes, increased water intake, or further monitoring depending on the crystal type and quantity.",
            lowMeaning: "Absent crystals is normal. Crystal formation can also be affected by how the sample was handled — refrigerated or old samples are more likely to form crystals that may not have been present in the body.",
            speciesNotes: "Dalmatians and English Bulldogs are genetically predisposed to forming urate crystals and stones due to differences in how they metabolize purines.",
            relatedGlossaryTerms: nil,
            searchKeywords: ["crystals", "crystalluria", "struvite", "calcium oxalate", "urate", "bladder stones", "uroliths", "urinary stones", "sediment", "Dalmatian"]
        ),
    ]

    // MARK: - Filtering

    /// All parameters for a given category (subsection), sorted by display order
    func parameters(for category: LabCategory) -> [LabParameter] {
        allParameters.filter { $0.category == category }
    }

    /// All parameters for a given panel type
    func parameters(for panelType: LabPanelType) -> [LabParameter] {
        allParameters.filter { $0.panelType == panelType }
    }

    /// All categories that have at least one parameter, for a given panel
    func populatedCategories(for panelType: LabPanelType) -> [LabCategory] {
        let categories = Set(allParameters.filter { $0.panelType == panelType }.map { $0.category })
        return LabCategory.categories(for: panelType).filter { categories.contains($0) }
    }

    // MARK: - Sorting

    /// All parameters sorted alphabetically by abbreviation (for A-Z view)
    func allParametersAlphabetical() -> [LabParameter] {
        allParameters.sorted { $0.abbreviation.lowercased() < $1.abbreviation.lowercased() }
    }

    /// Parameters grouped by first letter of abbreviation (for A-Z section headers)
    func parametersByLetter() -> [(letter: String, parameters: [LabParameter])] {
        let sorted = allParametersAlphabetical()
        let grouped = Dictionary(grouping: sorted) { param in
            String(param.abbreviation.prefix(1)).uppercased()
        }
        return grouped.sorted { $0.key < $1.key }
            .map { (letter: $0.key, parameters: $0.value) }
    }

    // MARK: - Search

    /// Search across abbreviation, alternate abbreviations, name, and search keywords
    /// Case-insensitive matching
    func search(query: String) -> [LabParameter] {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return allParameters
        }

        let lowercased = query.lowercased()

        return allParameters.filter { param in
            // Match abbreviation
            param.abbreviation.lowercased().contains(lowercased) ||
            // Match full name
            param.name.lowercased().contains(lowercased) ||
            // Match alternate abbreviations
            (param.alternateAbbreviations?.contains { $0.lowercased().contains(lowercased) } ?? false) ||
            // Match search keywords
            (param.searchKeywords?.contains { $0.lowercased().contains(lowercased) } ?? false)
        }
    }

    // MARK: - Lookup

    /// Find a parameter by its UUID
    func parameter(withID id: UUID) -> LabParameter? {
        allParameters.first { $0.id == id }
    }

    /// Find a parameter by abbreviation (for cross-referencing)
    func parameter(abbreviation: String) -> LabParameter? {
        allParameters.first { $0.abbreviation.lowercased() == abbreviation.lowercased() }
    }
}
