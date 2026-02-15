import Testing
import Foundation
import Combine

@testable import BerlinClock

@Suite("BerlinClockService Tests")
struct BerlinClockServiceTests {
    
    @Test("Emits initial value immediately")
    func initialEmission() {
        let fixedDate = Date(timeIntervalSince1970: 0)
        let mockTime = MockSystemTimeProvider(date: fixedDate)
        let mockTimer = MockSystemTimePublisher()
        
        let service = BerlinClockService(timeProvider: mockTime,
                                         timerPublisher: mockTimer)
        
        var values: [DigitalTime] = []
        
        let cancellable = service.timePublisher
            .sink { values.append($0) }
        
        #expect(values.count == 1)
        #expect(values[0].seconds == 0)
        
        _ = cancellable
    }
    
}
