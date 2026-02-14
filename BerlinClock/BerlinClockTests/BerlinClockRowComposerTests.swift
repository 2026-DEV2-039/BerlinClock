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
    
    @Test("Seconds lamp is ON at even seconds")
    func secondsLamp_isOn_atEvenSeconds() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 58)
        
        if case .on = result.secondsLamp {
            #expect(true)
        } else {
            Issue.record("Expected ON at even second")
        }
    }
    
    @Test("All minute lamps are OFF at 0 minutes")
    func minutes_areAllOff_atZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 0)
        
        #expect(result.fiveMinsLamps.allSatisfy { $0 == .off })
        #expect(result.oneMinsLamps.allSatisfy { $0 == .off })
    }
    
    @Test("One minute row shows 4 lamps at 4 minutes")
    func oneMinuteRow_atFourMinutes() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 4, seconds: 0)
        
        #expect(result.fiveMinsLamps.allSatisfy { $0 == .off })
        #expect(result.oneMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
    }
    
    @Test("Five minute row turns first lamp ON at 5 minutes")
    func fiveMinuteRow_turnsOn_atFive() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 5, seconds: 0)
        
        if case .on(.yellowColor) = result.fiveMinsLamps[0] {
            #expect(true)
        } else {
            Issue.record("Expected first five-minute lamp ON")
        }
        
        #expect(result.oneMinsLamps.allSatisfy { $0 == .off })
    }

    @Test("Third five-minute lamp is red at 15 minutes")
    func fiveMinuteRow_marksQuarterRed() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 15, seconds: 0)
        
        if case .on(.redColor) = result.fiveMinsLamps[2] {
            #expect(true)
        } else {
            Issue.record("Expected red quarter lamp at index 2")
        }
    }
    
    @Test("59 minutes sets correct lamps")
    func minuteRow_atFiftyNine() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 59, seconds: 0)
        
        #expect(result.fiveMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 11)
        
        #expect(result.oneMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
    }
    
    @Test("All hour lamps are OFF at 0 hours")
    func hours_areAllOff_atZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.allRowLampsState(hours: 0, minutes: 0, seconds: 0)
        
        #expect(result.fiveHoursLamps.allSatisfy { $0 == .off })
        #expect(result.oneHoursLamps.allSatisfy { $0 == .off })
    }
}

