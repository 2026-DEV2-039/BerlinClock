import Testing
@testable import BerlinClock

@Suite("BerlinClockFiveMinRow Tests")
@MainActor
struct BerlinClockFiveMinRowTests {
    
    @Test("Test five minute row is all of when minute is zero")
    func fiveMinuteRow_isAllOff_whenMinutesIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(0)
        let expected = expectedfiveMinuteRow(for: 0)
        #expect(result == expected)
    }
    
    @Test("Test five minute row turns on one Lamp for five minutes")
    func fiveMinuteRow_turnsOnOneLamp_forFiveMinutes() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(5)
        let expected = expectedfiveMinuteRow(for: 5)
        #expect(result == expected)
    }
    
    @Test("Test five minute row turns on two Lamp for ten minutes")
    func fiveMinuteRow_turnsOnTwoLamp_forFiveMinutes() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(10)
        let expected = expectedfiveMinuteRow(for: 10)
        #expect(result == expected)
    }
    
    @Test("Test five minute row turns on three Lamps for fifteen minutes")
    func fiveMinuteRow_marksQuarterHourLampRed_forFifteenMinutes() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(15)
        let expected = expectedfiveMinuteRow(for: 15)
        #expect(result == expected)
    }
    
    @Test("Test minutes lamp is ON for minutes (parameterized)", arguments: [20, 25, 30, 35, 40, 45, 50, 55, 60])
    func fiveMinuteRow_IsLampON_forArgsMinutes(minutes: Int) {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(minutes)
        let expected = expectedfiveMinuteRow(for: minutes)
        #expect(result == expected)
    }
}

// MARK: Helper function for test case
extension BerlinClockFiveMinRowTests {
    
    func expectedfiveMinuteRow(for minutes: Int) -> [BerlinClockLampsState] {
        let onCount = minutes / 5
        return (1...11).map { index in
            if index <= onCount {
                let color: BerlinClockLampColor = (index % 3 == 0) ? .redColor : .yellowColor
                return .on(color)
            } else {
                return .off
            }
        }
    }
}
