import Testing
@testable import BerlinClock

@Suite("BerlinClockOneHourRow Tests")
@MainActor

struct BerlinClockOneHourRowTests {

    @Test("Test one row lamp is all off when hours is 0")
    func oneHourRow_isAllOff_whenHoursIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneHourLamps(0)
        let expected = expectedOneHoursRows(for: 0)
        #expect(result == expected)
    }
    
    @Test("Test one hour row one lamp is on when hours is 1")
    func oneHourRow_turnsOnOneLamp_forOneHour() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneHourLamps(1)
        let expected = expectedOneHoursRows(for: 1)
        #expect(result == expected)
    }
    
    @Test("Test one hour row two lamps are on when hours is 2")
    func oneHourRow_turnsOnTwoLamps_forTwoHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneHourLamps(2)
        let expected = expectedOneHoursRows(for: 2)
        #expect(result == expected)
    }
    
    @Test("Test one hour row three lamps are on when hours is 3")
    func oneHourRow_turnsOnThreeLamps_forThreeHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneHourLamps(3)
        let expected = expectedOneHoursRows(for: 3)
        #expect(result == expected)
    }
    
    @Test("Test one hour row four lamps are on when hours is 4")
    func oneHourRow_turnsOnFourLamps_forFourHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneHourLamps(4)
        let expected = expectedOneHoursRows(for: 4)
        #expect(result == expected)
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
                return .off(.defaultColor)
            }
        }
    }
}
