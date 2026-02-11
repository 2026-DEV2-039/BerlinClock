import Foundation

struct BerlinClockRowCalculator {
    //MARK: Seconds Row Methods
    func secondsLamp(_ seconds: Int) -> BerlinClockLampsState {
        switch seconds % 2 {
        case 0:
            return .ON
        default:
            return .OFF
        }
    }
}
