import Foundation

struct BerlinClockState: Equatable, Sendable {
    let secondsLamp: BerlinClockLampsState
    let fiveMinsLamps: [BerlinClockLampsState]
    let oneMinsLamps: [BerlinClockLampsState]
    let fiveHoursLamps: [BerlinClockLampsState]
    let oneHoursLamps: [BerlinClockLampsState]
}

