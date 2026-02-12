import Testing
@testable import BerlinClock

@Suite("BerlinClockOneMinRow Tests")
@MainActor
struct BerlinClockOneMinRowTests {

    @Test("Test bottom minute row is all off when minute is zero")
    func oneMinuteRow_isAllOff_whenMinutesIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneMinutesLamps(0)
        #expect(result.allSatisfy { $0 == .off(.defaultColor) })
    }
}
