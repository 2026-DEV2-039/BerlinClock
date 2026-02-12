import Testing
@testable import BerlinClock

@Suite("BerlinClockOneHourRow Tests")
@MainActor

struct BerlinClockOneHourRowTests {

    @Test("Test one row lamp is all off when hours is 0")
    func oneHourRow_isAllOff_whenHoursIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneHourLamps(0)
        #expect(result.allSatisfy { $0 == .off(.defaultColor) })
    }
    
    @Test("Test one hour row one lamp is on when hours is 1")
    func oneHourRow_turnsOnOneLamp_forOneHour() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneHourLamps(1)
        
        #expect(result == [
            .on(.redColor),
            .off(.defaultColor),
            .off(.defaultColor),
            .off(.defaultColor)
        ])
    }
}
