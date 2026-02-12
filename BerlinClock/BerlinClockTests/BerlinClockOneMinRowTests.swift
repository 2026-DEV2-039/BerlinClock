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
    
    @Test("Test one minute row one lamp is on when hours is 1")
    func oneMinuteRow_isOneLampOn_whenMinutesIsOne() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.oneMinutesLamps(1)
        #expect(result == [.on(.yellowColor), .off(.defaultColor), .off(.defaultColor), .off(.defaultColor)])
    }
}
