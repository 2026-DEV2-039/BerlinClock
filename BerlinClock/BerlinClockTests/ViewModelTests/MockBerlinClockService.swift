import Testing
import Foundation
import Combine

@testable import BerlinClock

final class MockBerlinClockService: BerlinClockServiceProtocol {
    
    private let subject = PassthroughSubject<DigitalTime, Never>()
    
    var timePublisher: AnyPublisher<DigitalTime, Never> {
        subject.eraseToAnyPublisher()
    }
    
    func send(_ value: DigitalTime) {
        subject.send(value)
    }
}

