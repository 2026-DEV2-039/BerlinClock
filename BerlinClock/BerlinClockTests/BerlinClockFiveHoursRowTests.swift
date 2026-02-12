import Testing
@testable import BerlinClock

@Suite("BerlinClockFiveHoursRow Tests")
@MainActor
struct BerlinClockFiveHoursRowTests {

    @Test("Test five hours row is all of when hour is zero")
    func fiveHoursRow_isAllOff_whenMinutesIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveHoursLamps(0)
        let expected = expectedfiveHoursRow(for: 0)
        #expect(result == expected)
    }
    
    @Test("Test five hour row turns on one lamp for five hours")
    func fiveHourRow_turnsOnOneLamp_forFiveHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveHoursLamps(5)
        let expected = expectedfiveHoursRow(for: 5)
        #expect(result == expected)
    }
    
    @Test("Test five hour row turns on two lamps for ten hours")
    func fiveHourRow_turnsOnTwoLamps_forTenHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveHoursLamps(10)
        let expected = expectedfiveHoursRow(for: 10)
        #expect(result == expected)
    }
}

// MARK: Helper function for test case
extension BerlinClockFiveHoursRowTests {
    func expectedfiveHoursRow(for hours: Int) -> [BerlinClockLampsState] {
        let onCount = hours / 5
        return (1...4).map { index in
            if index <= onCount {
                let color: BerlinClockLampColor =  .redColor
                return .on(color)
            } else {
                return .off(.defaultColor)
            }
        }
    }
}
