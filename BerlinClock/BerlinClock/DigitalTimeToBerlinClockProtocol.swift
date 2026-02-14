import Foundation

protocol DigitalTimeToBerlinClockProtocol {
    func convertDigitalTimeToBerlinClock(digitalTime: DigitalTime) -> BerlinClockState
}
