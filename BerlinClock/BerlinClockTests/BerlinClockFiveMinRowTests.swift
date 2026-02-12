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

}
