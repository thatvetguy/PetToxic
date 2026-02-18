import SwiftUI

struct VaccinationSummaryCard: View {
    let pet: Pet
    @State private var showingVaccinationLog = false

    /// Group records by vaccine name, keep only the most recent per vaccine
    private var latestPerVaccine: [VaccinationRecord] {
        var latest: [String: VaccinationRecord] = [:]
        for record in pet.vaccinationRecords {
            if let existing = latest[record.vaccineName] {
                if record.dateAdministered > existing.dateAdministered {
                    latest[record.vaccineName] = record
                }
            } else {
                latest[record.vaccineName] = record
            }
        }
        return Array(latest.values)
    }

    private var statusCounts: (current: Int, dueSoon: Int, overdue: Int) {
        var current = 0, dueSoon = 0, overdue = 0
        for record in latestPerVaccine {
            switch VaccinationStatus.from(nextDueDate: record.nextDueDate) {
            case .current: current += 1
            case .dueSoon: dueSoon += 1
            case .overdue: overdue += 1
            case nil: break
            }
        }
        return (current, dueSoon, overdue)
    }

    var body: some View {
        Button {
            showingVaccinationLog = true
        } label: {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                // Header
                HStack(spacing: 6) {
                    Image(systemName: "syringe.fill")
                        .font(.caption)
                        .foregroundColor(AppColors.teal)

                    Text("Vaccinations")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.5))
                }

                // Status pills or empty state
                if pet.vaccinationRecords.isEmpty {
                    Text("No records")
                        .font(.caption)
                        .italic()
                        .foregroundColor(.white.opacity(0.4))
                } else {
                    let counts = statusCounts
                    HStack(spacing: 8) {
                        if counts.current > 0 {
                            StatusPill(
                                count: counts.current,
                                label: "Current",
                                color: VaccinationStatus.current.color
                            )
                        }
                        if counts.dueSoon > 0 {
                            StatusPill(
                                count: counts.dueSoon,
                                label: "Due Soon",
                                color: VaccinationStatus.dueSoon.color
                            )
                        }
                        if counts.overdue > 0 {
                            StatusPill(
                                count: counts.overdue,
                                label: "Overdue",
                                color: VaccinationStatus.overdue.color
                            )
                        }
                    }
                }
            }
            .padding(AppSpacing.md)
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.small))
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showingVaccinationLog) {
            NavigationStack {
                VaccinationLogView(pet: pet)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Done") {
                                showingVaccinationLog = false
                            }
                        }
                    }
            }
        }
    }
}

// MARK: - Status Pill

private struct StatusPill: View {
    let count: Int
    let label: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Text("\(count)")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(color)

            Text(label)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.15))
        .clipShape(Capsule())
    }
}
