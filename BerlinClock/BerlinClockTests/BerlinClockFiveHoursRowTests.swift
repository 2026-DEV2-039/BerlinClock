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
}

// MARK: Helper function for test case
extension BerlinClockFiveHoursRowTests {
    func expectedfiveHoursRow(for hours: Int) -> [BerlinClockLampsState] {
        let onCount = 0
        return (1...4).map { index in
            if index <= onCount {
                let color: BerlinClockLampColor =  .yellowColor
                return .on(color)
            } else {
                return .off(.defaultColor)
            }
        }
    }
}
