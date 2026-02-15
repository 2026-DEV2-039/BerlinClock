import Testing
import Foundation
@testable import BerlinClock

final class MockSystemTimeProvider: SystemTimeProviderProtocol {
    var currentDate: Date
    
    init(date: Date) {
        self.currentDate = date
    }
    
    func now() -> Date {
        currentDate
    }
}
