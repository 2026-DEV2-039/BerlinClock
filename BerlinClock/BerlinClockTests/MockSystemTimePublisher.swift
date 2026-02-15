import Testing
import Foundation
import Combine

@testable import BerlinClock

struct MockSystemTimePublisher : SystemTimerPublisherProtocol {
    private let subject = PassthroughSubject<Date, Never>()
    
    func publisher(interval: TimeInterval) -> AnyPublisher<Date, Never> {
        subject.eraseToAnyPublisher()
    }
    
    // Manual trigger for tests
    func send(_ date: Date) {
        subject.send(date)
    }
}
