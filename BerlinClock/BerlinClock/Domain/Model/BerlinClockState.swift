import Foundation

struct BerlinClockState: Equatable, Sendable {
    let secondsLamp: BerlinClockLampsState
    let fiveMinsLamps: [BerlinClockLampsState]
    let oneMinsLamps: [BerlinClockLampsState]
    let fiveHoursLamps: [BerlinClockLampsState]
    let oneHoursLamps: [BerlinClockLampsState]
}

extension BerlinClockState {
    static let empty = BerlinClockState(
        secondsLamp: .off,
        fiveMinsLamps: emptyRow(for: .fiveMinsRowCase),
        oneMinsLamps: emptyRow(for: .oneMinsRowCase),
        fiveHoursLamps: emptyRow(for: .fiveHoursRowCase),
        oneHoursLamps: emptyRow(for: .oneMinsRowCase)
    )
}

private extension BerlinClockState {
    static func emptyRow(for type: BerlinClockRowType) -> [BerlinClockLampsState] {
        Array(repeating: .off, count: type.lampCount)
    }
}
