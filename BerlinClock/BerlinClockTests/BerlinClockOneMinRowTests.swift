import Testing
@testable import BerlinClock

@Suite("BerlinClockOneMinRow Tests")
@MainActor
struct BerlinClockOneMinRowTests {

    @Test("Test one minute row is all off when minute is zero")
    func oneMinuteRow_isAllOff_whenMinutesIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneMinutesLamps(0)
        #expect(result.allSatisfy { $0 == .off(.defaultColor) })
    }
    
    @Test("Test one minute row one lamp is on when hours is 1")
    func oneMinuteRow_isOneLampOn_whenMinutesIsOne() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneMinutesLamps(1)
        #expect(result == [.on(.yellowColor), .off(.defaultColor), .off(.defaultColor), .off(.defaultColor)])
    }
    
    @Test("Test one miute row for (parametrised) minutes", arguments: [2, 3, 4, 6, 7, 8, 9, 11])
    func oneMinuteRow_isLampOn_whenMinutesArgs(minutes: Int) {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneMinutesLamps(minutes)
        let expected = expectedOneMinuteRow(for: minutes)
        #expect(result == expected)
    }
}

// MARK: Helper function for test case
extension BerlinClockOneMinRowTests {
    func expectedOneMinuteRow(for minutes: Int) -> [BerlinClockLampsState] {
        let onCount = minutes % 5
        return (1...4).map { index in
            if index <= onCount {
                return .on(.yellowColor)
            } else {
                return .off(.defaultColor)
            }
        }
    }
}
