import Foundation

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
        return [.off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor),
                .off(.defaultColor)]
    }
}
