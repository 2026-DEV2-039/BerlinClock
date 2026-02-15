import Foundation
import Combine

protocol BerlinClockServiceProtocol {
    var timePublisher: AnyPublisher<DigitalTime, Never> { get }
}
