import Testing
@testable import BerlinClock

@Suite("BerlinClockSecondsRow Tests")
struct BerlinClockSecondsRowTests {
    // Helper Arguments
    private static let evenSeconds = Array(stride(from: 0, through: 59, by: 2))
    
    @Test("Test seconds lamp is on when seconds is even")
    func secondsLamp_isOn_whenSecondsIsEven() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(0)
        #expect(result == "ON")
    }
    
    @Test("Seconds lamp is ON for even seconds (parameterized)", arguments: BerlinClockSecondsRowTests.evenSeconds)
    func secondsLamp_isOn_whenSecondsIsEvenWithArgs(seconds: Int) {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(seconds)
        
        #expect(result == "ON")
    }
    
    @Test("Test seconds lamp is off when second is odd")
    func secondsLamp_isOff_whenSecondsIsOdd() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(1)
        #expect(result == "OFF")
    }
}
