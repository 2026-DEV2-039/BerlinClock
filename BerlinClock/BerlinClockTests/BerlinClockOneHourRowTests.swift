import Testing
@testable import BerlinClock

@Suite("BerlinClockOneHourRow Tests")
@MainActor

struct BerlinClockOneHourRowTests {
    
    @Test("Test one row lamp is all off when hours is 0")
    func oneHourRow_isAllOff_whenHoursIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 0)
        let expected = expectedOneHoursRows(for: 0)
        #expect(result.oneHoursLamps == expected)
    }
    
    @Test("Test one hour row one lamp is on when hours is 1")
    func oneHourRow_turnsOnOneLamp_forOneHour() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 1, minutes: 0, seconds: 0)
        let expected = expectedOneHoursRows(for: 1)
        #expect(result.oneHoursLamps == expected)
    }
    
    @Test("Test one hour row two lamps are on when hours is 2")
    func oneHourRow_turnsOnTwoLamps_forTwoHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 2, minutes: 0, seconds: 0)
        let expected = expectedOneHoursRows(for: 2)
        #expect(result.oneHoursLamps == expected)
    }
    
    @Test("Test one hour row three lamps are on when hours is 3")
    func oneHourRow_turnsOnThreeLamps_forThreeHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 3, minutes: 0, seconds: 0)
        let expected = expectedOneHoursRows(for: 3)
        #expect(result.oneHoursLamps == expected)
    }
    
    @Test("Test one hour row four lamps are on when hours is 4")
    func oneHourRow_turnsOnFourLamps_forFourHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 4, minutes: 0, seconds: 0)
        let expected = expectedOneHoursRows(for: 4)
        #expect(result.oneHoursLamps == expected)
    }
    
    @Test("Test one hour row is all off when hours is multiple of 5")
    func oneHourRow_isAllOff_whenHoursIsMultipleOfFive() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 5, minutes: 0, seconds: 0)
        let expected = expectedOneHoursRows(for: 5)
        #expect(result.oneHoursLamps == expected)
    }
    
    @Test("Test one hour row uses remainder logic for 23 hours")
    func oneHourRow_usesRemainder_forTwentyThreeHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 23, minutes: 0, seconds: 0)
        let expected = expectedOneHoursRows(for: 23)
        #expect(result.oneHoursLamps == expected)
    }
}

// MARK: Helper function for test case
extension BerlinClockOneHourRowTests {
    func expectedOneHoursRows(for hours: Int) -> [BerlinClockLampsState] {
        let onCount = hours % 5
        return (1...4).map { index in
            if index <= onCount {
                return .on(.redColor)
            } else {
                return .off
            }
        }
    }
}
