import Foundation

enum BerlinClockLampsState: Equatable, Sendable {
    case on(BerlinClockLampColor)
    case off
}
