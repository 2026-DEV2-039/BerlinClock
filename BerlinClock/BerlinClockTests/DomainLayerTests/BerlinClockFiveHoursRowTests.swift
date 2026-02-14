import Testing
@testable import BerlinClock

@Suite("BerlinClockFiveHoursRow Tests")
@MainActor
struct BerlinClockFiveHoursRowTests {

    @Test("Test five hours row is all of when hour is zero")
    func fiveHoursRow_isAllOff_whenHoursIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 0))
        let expected = expectedfiveHoursRow(for: 0)
        #expect(result.fiveHoursLamps == expected)
    }
    
    @Test("Test five hour row turns on one lamp for five hours")
    func fiveHourRow_turnsOnOneLamp_forFiveHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 5, minutes: 0, seconds: 0))
        let expected = expectedfiveHoursRow(for: 5)
        #expect(result.fiveHoursLamps == expected)
    }
    
    @Test("Test five hour row turns on two lamps for ten hours")
    func fiveHourRow_turnsOnTwoLamps_forTenHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 10, minutes: 0, seconds: 0))
        let expected = expectedfiveHoursRow(for: 10)
        #expect(result.fiveHoursLamps == expected)
    }
    
    @Test("Test five hour row turns on three lamps for fifteen hours")
    func fiveHourRow_turnsOnThreeLamps_forFifteenHours() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 15, minutes: 0, seconds: 0))
        let expected = expectedfiveHoursRow(for: 15)
        #expect(result.fiveHoursLamps == expected)
    }
    
    @Test("Test five hour row lamps for parameterized hours",
          arguments: [0, 5, 10, 15, 20, 23])
    func fiveHourRow_isCorrect_forParameterizedHours(hours: Int) {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: hours, minutes: 0, seconds: 0))
        let expected = expectedfiveHoursRow(for: hours)
        #expect(result.fiveHoursLamps == expected)
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
                return .off
            }
        }
    }
}
