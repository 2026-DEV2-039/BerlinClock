import Testing
@testable import BerlinClock

// Helper Static Arguments
private let evenSeconds = Array(stride(from: 0, through: 59, by: 2))
private let oddSeconds = Array(stride(from: 1, through: 59, by: 2))

@Suite("BerlinClockSecondsRow Tests")
@MainActor
struct BerlinClockSecondsRowTests {
    @Test("Test seconds lamp is on when seconds is even")
    func secondsLamp_isOn_whenSecondsIsEven() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(0)
        #expect(result == .on(.yellowColor))
    }
    
    @Test("Test Seconds lamp is ON for even seconds (parameterized)", arguments: evenSeconds)
    func secondsLamp_isOn_whenSecondsIsEvenWithArgs(seconds: Int) {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(seconds)
        
        #expect(result == .on(.yellowColor))
    }
    
    @Test("Test seconds lamp is off when second is odd")
    func secondsLamp_isOff_whenSecondsIsOdd() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(1)
        #expect(result == .off(.defaultColor))
    }
    
    @Test("Seconds lamp is off for odd seconds (parameterized)", arguments: oddSeconds)
    func secondsLamp_isOn_whenSecondsIsOddWithArgs(seconds: Int) {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.secondsLamp(seconds)
        #expect(result == .off(.defaultColor))
    }
    
    @Test("Test isOn returns true when lamp state is .on")
    func isOn_returnsTrue_whenStateIsOn() {
        let state = BerlinClockLampsState.on(.yellowColor)
        #expect(state.isOn == true)
    }
    
    @Test("isOn returns false when lamp state is .off")
    func isOn_returnsFalse_whenStateIsOff() {
        let state = BerlinClockLampsState.off(.defaultColor)
        #expect(state.isOn == false)
    }
}
