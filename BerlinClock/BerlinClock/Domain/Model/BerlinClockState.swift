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
        fiveMinsLamps: Array(repeating: .off, count: 11),
        oneMinsLamps: Array(repeating: .off, count: 4),
        fiveHoursLamps: Array(repeating: .off, count: 4),
        oneHoursLamps: Array(repeating: .off, count: 4)
    )
}
