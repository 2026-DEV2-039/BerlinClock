import Foundation

enum BerlinClockRowType: Equatable, Sendable {
    case seconds
    case fiveMinsRowCase
    case oneMinsRowCase
    case fiveHoursRowCase
    case oneHoursRowCase
    
    var lampCount: Int {
        switch self {
        case .seconds: return 1
        case .fiveMinsRowCase: return 11
        case .oneMinsRowCase: return 4
        case .fiveHoursRowCase: return 4
        case .oneHoursRowCase: return 4
        }
    }
    
    static let displayOrder: [BerlinClockRowType] = [.seconds,
                                                     .fiveHoursRowCase,
                                                     .oneHoursRowCase,
                                                     .fiveMinsRowCase,
                                                     .oneMinsRowCase ]
}
