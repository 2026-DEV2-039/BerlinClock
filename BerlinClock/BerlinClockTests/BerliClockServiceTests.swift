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
        
        let service = BerlinClockService(
            timeProvider: mockTime,
            timerPublisher: mockTimer
        )
        
        var values: [DigitalTime] = []
        let cancellable = service.timePublisher
            .sink { values.append($0) }
        
        let mockDigitalTime = DigitalTime(hours: 0, minutes: 0, seconds: 0)
        
        #expect(values.count == 1)
        #expect(values[0].seconds == mockDigitalTime.seconds)

        _ = cancellable
    }

    
    @Test("Test emits when timer sends value")
    func emitsOnTimerSend() {
        
        let calendar = Calendar(identifier: .gregorian)
        
        let date = calendar.date(from: DateComponents(
            year: 2026,
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
        
        let mockDigitalTime = DigitalTime(hours: 12, minutes: 34, seconds: 56)
        
        #expect(values.count == 2)
        #expect(values[1].hours == mockDigitalTime.hours)
        #expect(values[1].minutes == mockDigitalTime.minutes)
        #expect(values[1].seconds == mockDigitalTime.seconds)

        _ = cancellable
    }
    
    @Test("Test handles midnight correctly")
    func midnightTime() {
        let calendar = Calendar(identifier: .gregorian)
        
        let midnight = calendar.date(from: DateComponents(
            year: 2026,
            month: 1,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0
        ))!
        
        let mockTime = MockSystemTimeProvider(date: midnight)
        let mockTimer = MockSystemTimePublisher()
        
        let service = BerlinClockService(
            calendar: calendar,
            timeProvider: mockTime,
            timerPublisher: mockTimer
        )
        
        var values: [DigitalTime] = []
        
        let cancellable = service.timePublisher
            .sink { values.append($0) }
        
        let mockDigitalTime = DigitalTime(hours: 0, minutes: 0, seconds: 0)
        
        #expect(values.count == 1)
        #expect(values[0].hours == mockDigitalTime.hours)
        #expect(values[0].minutes == mockDigitalTime.minutes)
        #expect(values[0].seconds == mockDigitalTime.seconds)
        
        _ = cancellable
    }
    
    @Test("Test updated timeProvider value")
    func updatedTimeBetweenTicks() {
        let calendar = Calendar(identifier: .gregorian)
        let mockTime = MockSystemTimeProvider(date: Date())
        let mockTimer = MockSystemTimePublisher()
        
        let service = BerlinClockService(
            calendar: calendar,
            timeProvider: mockTime,
            timerPublisher: mockTimer
        )
        
        var values: [DigitalTime] = []
        
        let cancellable = service.timePublisher
            .sink { values.append($0) }
        
        // Change time
        let newDate = calendar.date(from: DateComponents(hour: 5, minute: 6, second: 7))!
        mockTime.currentDate = newDate
        mockTimer.send(newDate)
        
        let mockDigitalTime = DigitalTime(hours: 5, minutes: 6, seconds: 7)
        
        #expect(values.last?.hours == mockDigitalTime.hours)
        #expect(values.last?.minutes == mockDigitalTime.minutes)
        #expect(values.last?.seconds == mockDigitalTime.seconds)
        
        _ = cancellable
    }
}
