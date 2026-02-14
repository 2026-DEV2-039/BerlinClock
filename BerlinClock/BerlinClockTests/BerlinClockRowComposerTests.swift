import Testing
@testable import BerlinClock

@Suite("BerlinClockRowComposer Tests")
@MainActor
struct BerlinClockRowComposerTests {
    
    @Test("Test composing BerlinClock state")
    func compose_returnsBerlinClockAllLampsState() {
        let calulator = BerlinClockRowCalculator()
        let state = calulator.allRowLampsState(hours: 0, minutes: 0, seconds: 0)
        
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
}

