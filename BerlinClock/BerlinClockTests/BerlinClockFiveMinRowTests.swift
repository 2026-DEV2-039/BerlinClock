import Testing
@testable import BerlinClock

@Suite("BerlinClockFiveMinRow Tests")
@MainActor
struct BerlinClockFiveMinRowTests {
    
    @Test("Test five minute row is all of when minute is zero")
    func fiveMinuteRow_isAllOff_whenMinutesIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(0)
        #expect(result == [.off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor)])
    }
    
    @Test("Test five minute row turns on one Lamp for five minutes")
    func fiveMinuteRow_turnsOnOneLamp_forFiveMinutes() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(5)
        #expect(result == [.off(.yellowColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor)])
    }
    
    @Test("Test five minute row turns on two Lamp for ten minutes")
    func fiveMinuteRow_turnsOnTwoLamp_forFiveMinutes() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.fiveMinutesLamps(10)
        #expect(result == [.off(.yellowColor),
                           .off(.yellowColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor),
                           .off(.defaultColor)])
    }
}
