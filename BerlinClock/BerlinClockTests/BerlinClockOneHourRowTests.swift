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
}
