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
    private func secondsLamp(_ seconds: Int) -> BerlinClockLampsState {
        switch seconds % 2 {
        case 0:
            return .on(.yellowColor)
        default:
            return .off
        }
    }
    
    //MARK: Minutes Row Methods
    private func fiveMinutesLamps(_ minutes: Int) -> [BerlinClockLampsState] {
        let onCount = minutes / 5
        return fillLampFromLeft(rowType: .fiveMinsRowCase, onCount: onCount) { index in
            let isQuarter = (index + 1).isMultiple(of: 3)
            let color : BerlinClockLampColor  = isQuarter ? .redColor : .yellowColor
            return .on(color)
        }
    }
    
    private func oneMinutesLamps(_ minutes: Int) -> [BerlinClockLampsState] {
        let onCount = minutes % 5
        return fillLampFromLeft(rowType: .oneMinsRowCase, onCount: onCount) { _ in
                .on(.yellowColor)
        }
    }
    
    //MARK: Hours Row Methods
    private func fiveHoursLamps(_ hours: Int) -> [BerlinClockLampsState] {
        let onCount = hours / 5
        return fillLampFromLeft(rowType: .fiveHoursRowCase, onCount: onCount) { _ in
                .on(.redColor)
        }
    }
    
    private func oneHourLamps(_ hours: Int) -> [BerlinClockLampsState] {
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
            index < onCount ? onLamp(index) : .off
        }
    }
    
     func allRowLampsState(hours: Int, minutes: Int, seconds: Int) -> BerlinClockState {
        let secondsLampState = secondsLamp(seconds)
        let fiveMinsLampsState = fiveMinutesLamps(minutes)
        let oneMinsLampsState = oneMinutesLamps(minutes)
        let fiveHoursLampsState = fiveHoursLamps(hours)
        let oneHoursLampsState = oneHourLamps(hours)
        
        return BerlinClockState(secondsLamp: secondsLampState,
                                fiveMinsLamps: fiveMinsLampsState,
                                oneMinsLamps: oneMinsLampsState,
                                fiveHoursLamps: fiveHoursLampsState,
                                oneHoursLamps: oneHoursLampsState)
    }
}

// MARK: DigitalTimeToBerlinClockProtocol Methods
extension BerlinClockRowCalculator : DigitalTimeToBerlinClockProtocol {
    func convertDigitalTimeToBerlinClock(digitalTime: DigitalTime) -> BerlinClockState {
        return allRowLampsState(hours: digitalTime.hours,
                                minutes: digitalTime.minutes,
                                seconds: digitalTime.seconds)
    }
}
