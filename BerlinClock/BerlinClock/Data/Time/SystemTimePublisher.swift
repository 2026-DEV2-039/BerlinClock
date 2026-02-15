import Foundation
import Combine

//MARK: SystemTimerPublisherProtocol
protocol SystemTimerPublisherProtocol {
    func publisher(interval: TimeInterval) -> AnyPublisher<Date, Never>
}

//MARK: SystemTimerPublisher Implementation
final class SystemTimerPublisher: SystemTimerPublisherProtocol {
    func publisher(interval: TimeInterval) -> AnyPublisher<Date, Never> {
        Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
    }
}

