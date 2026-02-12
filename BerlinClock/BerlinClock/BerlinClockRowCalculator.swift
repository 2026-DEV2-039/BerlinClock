import Foundation

private enum BerlinClockRowType {
    case fiveMinsRowCase
    case oneMinsRowCase
    case fiveHoursRowCase
    case oneHoursRowCase

    var lampCount: Int {
        switch self {
        case .fiveMinsRowCase: return 11
        case .oneMinsRowCase: return 4
        case .fiveHoursRowCase: return 4
        case .oneHoursRowCase: return 4
        }
    }
}

struct BerlinClockRowCalculator {
    
    //MARK: Seconds Row Methods
    func secondsLamp(_ seconds: Int) -> BerlinClockLampsState {
        switch seconds % 2 {
        case 0:
            return .on(.yellowColor)
        default:
            return .off(.defaultColor)
        }
    }
    
    //MARK: Minutes Row Methods
    func fiveMinutesLamps(_ minutes: Int) -> [BerlinClockLampsState] {
        let onCount = minutes / 5
        return fillLampFromLeft(rowType: .fiveMinsRowCase, onCount: onCount) { index in
            let isQuarter = (index + 1).isMultiple(of: 3)
            let color : BerlinClockLampColor  = isQuarter ? .redColor : .yellowColor
            return .on(color)
        }
    }
    
    func oneMinutesLamps(_ minutes: Int) -> [BerlinClockLampsState] {
        let onCount = minutes % 5
        return fillLampFromLeft(rowType: .oneMinsRowCase, onCount: onCount) { _ in
                .on(.yellowColor)
        }
    }
    
    //MARK: Hours Row Methods
    func fiveHoursLamps(_ hours: Int) -> [BerlinClockLampsState] {
        let onCount = hours / 5
        return fillLampFromLeft(rowType: .fiveHoursRowCase, onCount: onCount) { _ in
                .on(.redColor)
        }
    }
    
    func oneHourLamps(_ hours: Int) -> [BerlinClockLampsState] {
        let onCount = hours % 5
        return fillLampFromLeft(rowType: .oneHoursRowCase, onCount: onCount) { _ in
                .on(.redColor)
        }
    }
}

// MARK: Helper Functions
extension BerlinClockRowCalculator {
    private func fillLampFromLeft(rowType: BerlinClockRowType,
                                  onCount: Int,
                                  onLampAt onLamp: (Int) -> BerlinClockLampsState) -> [BerlinClockLampsState] {
        (0..<rowType.lampCount).map { index in
            index < onCount ? onLamp(index) : .off(.defaultColor)
        }
    }
}
