import Testing
import Foundation
import Combine

@testable import BerlinClock

final class MockBerlinClockService: BerlinClockServiceProtocol {
    
    private let subject = PassthroughSubject<DigitalTime, Never>()
    private(set) var subscriptionCount = 0

    var timePublisher: AnyPublisher<DigitalTime, Never> {
        subscriptionCount += 1
        return subject.eraseToAnyPublisher()
    }
    
    func send(_ value: DigitalTime) {
        subject.send(value)
    }
}

