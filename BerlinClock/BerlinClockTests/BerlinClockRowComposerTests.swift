import Testing
@testable import BerlinClock

@Suite("BerlinClockRowComposer Tests")
@MainActor
struct BerlinClockRowComposerTests {
    
    @Test("Test composing BerlinClock state")
    func compose_returnsBerlinClockAllLampsState() {
        let calculator = BerlinClockRowCalculator()
        let state = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 0)
        
        // seconds lamp should be a single LampState (no count)
        #expect(state.secondsLamp == BerlinClockLampsState.on(.yellowColor))
        // top minutes row has 11 lamps
        #expect(state.fiveMinsLamps.count == 11)
        // bottom minutes row has 4 lamps
        #expect(state.oneMinsLamps.count == 4)
        // top hours row has 4 lamps
        #expect(state.fiveHoursLamps.count == 4)
        // bottom hours row has 4 lamps
        #expect(state.oneHoursLamps.count == 4)
    }
    
    @Test("Seconds lamp is ON at 0 seconds")
    func secondsLamp_isOn_atZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 0)
        
        if case .on(.yellowColor) = result.secondsLamp {
            #expect(true)
        } else {
            Issue.record("Expected seconds lamp ON at 0")
        }
    }
    
    @Test("Seconds lamp is OFF at 1 second")
    func secondsLamp_isOff_atOne() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 1)
        #expect(result.secondsLamp == .off)
    }
}

