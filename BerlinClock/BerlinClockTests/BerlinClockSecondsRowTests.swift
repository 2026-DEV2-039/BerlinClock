import Testing
@testable import BerlinClock

@Suite("BerlinClockSecondsRow Tests")
struct BerlinClockSecondsRowTests {

    @Test("Test seconds lamp is on when seconds is even")
    func secondsLamp_isOn_whenSecondsIsEven() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(0)
        #expect(result == "ON")
    }
}
