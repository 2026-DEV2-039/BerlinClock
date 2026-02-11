import Foundation

enum BerlinClockLampsState: Equatable, Sendable {
    case on(BerlinClockLampColor)
    case off(BerlinClockLampColor)
}

extension BerlinClockLampsState {
    var isOn: Bool {
        switch self {
        case .on: return true
        case .off: return false
        }
    }
    
    var lampColor: BerlinClockLampColor {
        switch self {
        case .on(let color),
                .off(let color):
            return color
        }
    }
}
