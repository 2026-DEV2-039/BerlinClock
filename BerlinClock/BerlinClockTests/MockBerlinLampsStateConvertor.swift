import Testing
import Foundation

@testable import BerlinClock

final class MockBerlinLampStateConvertor: DigitalTimeToBerlinClockProtocol {
    
    func convertDigitalTimeToBerlinClock(_ digitalTime: DigitalTime) -> BerlinClockState {
        BerlinClockState(secondsLamp: .off,
                         fiveMinsLamps: Array(repeating: .off, count: 11),
                         oneMinsLamps: Array(repeating: .off, count: 4),
                         fiveHoursLamps: Array(repeating: .off, count: 4),
                         oneHoursLamps: Array(repeating: .off, count: 4))
    }
}
