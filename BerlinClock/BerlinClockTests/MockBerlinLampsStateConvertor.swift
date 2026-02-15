import Testing
import Foundation

@testable import BerlinClock

final class MockBerlinLampStateConvertor: DigitalTimeToBerlinClockProtocol {
    var receivedTime = DigitalTime(hours: 0, minutes: 0, seconds: 0)
    var stubState: BerlinClockState = .empty
    
    func convertDigitalTimeToBerlinClock(_ digitalTime: DigitalTime) -> BerlinClockState {
        receivedTime = digitalTime
        return stubState
    }
}
