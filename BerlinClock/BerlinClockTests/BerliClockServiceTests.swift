import Testing
import Foundation
import Combine

@testable import BerlinClock

@Suite("BerlinClockService Tests")
struct BerlinClockServiceTests {
    
    @Test("Test emits initial value immediately")
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
    
    @Test("Test emits when timer sends value")
    func emitsOnTimerSend() {
        
        let calendar = Calendar(identifier: .gregorian)
        
        let date = calendar.date(from: DateComponents(
            year: 2024,
            month: 1,
            day: 1,
            hour: 12,
            minute: 34,
            second: 56
        ))!
        
        let mockTime = MockSystemTimeProvider(date: date)
        let mockTimer = MockSystemTimePublisher()
        
        let service = BerlinClockService(
            calendar: calendar,
            timeProvider: mockTime,
            timerPublisher: mockTimer
        )
        
        var values: [DigitalTime] = []
        
        let cancellable = service.timePublisher
            .sink { values.append($0) }
        
        mockTimer.send(date)
        
        #expect(values.count == 2)
        #expect(values[1].hours == 12)
        #expect(values[1].minutes == 34)
        #expect(values[1].seconds == 56)
        
        _ = cancellable
    }
}
