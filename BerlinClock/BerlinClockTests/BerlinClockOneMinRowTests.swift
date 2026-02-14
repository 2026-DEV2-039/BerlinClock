import Testing
@testable import BerlinClock

@Suite("BerlinClockOneMinRow Tests")
@MainActor
struct BerlinClockOneMinRowTests {

    @Test("Test one minute row is all off when minute is zero")
    func oneMinuteRow_isAllOff_whenMinutesIsZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 0)
        #expect(result.oneMinsLamps.allSatisfy { $0 == .off })
    }
    
    @Test("Test one minute row one lamp is on when hours is 1")
    func oneMinuteRow_isOneLampOn_whenMinutesIsOne() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 1, seconds: 0)
        #expect(result.oneMinsLamps == [.on(.yellowColor), .off, .off, .off])
    }
    
    @Test("Test one miute row for (parametrised) minutes", arguments: [2, 3, 4, 6, 7, 8, 9, 11])
    func oneMinuteRow_isLampOn_whenMinutesArgs(minutes: Int) {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: minutes, seconds: 0)
        let expected = expectedOneMinuteRow(for: minutes)
        #expect(result.oneMinsLamps == expected)
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
                return .off
            }
        }
    }
}
