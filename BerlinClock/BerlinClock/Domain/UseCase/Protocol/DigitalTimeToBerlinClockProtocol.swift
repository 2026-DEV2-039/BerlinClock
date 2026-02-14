import Foundation

protocol DigitalTimeToBerlinClockProtocol {
    func convertDigitalTimeToBerlinClock(_ digitalTime: DigitalTime) -> BerlinClockState
}
