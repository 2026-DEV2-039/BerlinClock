import Foundation
import Combine

final class BerlinClockService {
    private let calendar: Calendar
    private let timeProvider: SystemTimeProviderProtocol
    private let timerPublisher: SystemTimerPublisherProtocol
    
    init(calendar: Calendar = .current,
         timeProvider: SystemTimeProviderProtocol = SystemTimeProvider(),
         timerPublisher: SystemTimerPublisherProtocol = SystemTimerPublisher()) {
        self.calendar = calendar
        self.timeProvider = timeProvider
        self.timerPublisher = timerPublisher
    }
    
    var timePublisher: AnyPublisher<DigitalTime, Never> {
        timerPublisher.publisher(interval: 1.0)
            .map { [weak self] _ in
                guard let self = self else { return DigitalTime(hours: 0, minutes: 0, seconds: 0)}
                return self.now()
            }
            .prepend(now())
            .eraseToAnyPublisher()
    }
    
    //MARK: Helper Methods
    private func clockTime(from date: Date) -> DigitalTime {
        let components = calendar.dateComponents([.hour, .minute, .second],
                                                 from: date)
        
        return DigitalTime(hours: components.hour ?? 0,
                           minutes: components.minute ?? 0,
                           seconds: components.second ?? 0)
    }
    
    private func now() -> DigitalTime {
        clockTime(from: timeProvider.now())
    }
}
