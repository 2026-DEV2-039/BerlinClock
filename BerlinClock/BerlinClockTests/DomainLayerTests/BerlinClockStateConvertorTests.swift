import Testing
@testable import BerlinClock

@Suite("BerlinClockRowComposer Tests")
@MainActor
struct BerlinClockRowComposerTests {
    
    @Test("Test composing BerlinClock state")
    func compose_returnsBerlinClockAllLampsState() {
        let calculator = BerlinClockRowCalculator()
        let state = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 0))
        
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
    
    @Test("Test seconds lamp is ON at 0 seconds")
    func secondsLamp_isOn_atZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 0))
        
        if case .on(.yellowColor) = result.secondsLamp {
            #expect(true)
        } else {
            Issue.record("Expected seconds lamp ON at 0")
        }
    }
    
    @Test("Test seconds lamp is OFF at 1 second")
    func secondsLamp_isOff_atOne() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 1))
        #expect(result.secondsLamp == .off)
    }
    
    @Test("Test seconds lamp is ON at even seconds")
    func secondsLamp_isOn_atEvenSeconds() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 58))
        
        if case .on = result.secondsLamp {
            #expect(true)
        } else {
            Issue.record("Expected ON at even second")
        }
    }
    
    @Test("Test all minute lamps are OFF at 0 minutes")
    func minutes_areAllOff_atZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 0))
        
        #expect(result.fiveMinsLamps.allSatisfy { $0 == .off })
        #expect(result.oneMinsLamps.allSatisfy { $0 == .off })
    }
    
    @Test("Test one minute row shows 4 lamps at 4 minutes")
    func oneMinuteRow_atFourMinutes() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 4, seconds: 0))
        
        #expect(result.fiveMinsLamps.allSatisfy { $0 == .off })
        #expect(result.oneMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
    }
    
    @Test("Test five minute row turns first lamp ON at 5 minutes")
    func fiveMinuteRow_turnsOn_atFive() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 5, seconds: 0))
        
        if case .on(.yellowColor) = result.fiveMinsLamps[0] {
            #expect(true)
        } else {
            Issue.record("Expected first five-minute lamp ON")
        }
        
        #expect(result.oneMinsLamps.allSatisfy { $0 == .off })
    }

    @Test("Test third five-minute lamp is red at 15 minutes")
    func fiveMinuteRow_marksQuarterRed() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 15, seconds: 0))
        
        if case .on(.redColor) = result.fiveMinsLamps[2] {
            #expect(true)
        } else {
            Issue.record("Expected red quarter lamp at index 2")
        }
    }
    
    @Test("Test 59 minutes sets correct lamps")
    func minuteRow_atFiftyNine() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 59, seconds: 0))
        
        #expect(result.fiveMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 11)
        
        #expect(result.oneMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
    }
    
    @Test("Test all hour lamps are OFF at 0 hours")
    func hours_areAllOff_atZero() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 0))
        
        #expect(result.fiveHoursLamps.allSatisfy { $0 == .off })
        #expect(result.oneHoursLamps.allSatisfy { $0 == .off })
    }
    
    @Test("Test one hour row shows 4 lamps at 4 hours")
    func oneHourRow_atFour() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 4, minutes: 0, seconds: 0))
        
        #expect(result.fiveHoursLamps.allSatisfy { $0 == .off })
        #expect(result.oneHoursLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
    }
    
    @Test("Test five hour row turns first lamp ON at 5 hours")
    func fiveHourRow_turnsOn_atFive() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 5, minutes: 0, seconds: 0))
        
        if case .on(.redColor) = result.fiveHoursLamps[0] {
            #expect(true)
        } else {
            Issue.record("Expected first five-hour lamp ON")
        }
        
        #expect(result.oneHoursLamps.allSatisfy { $0 == .off })
    }

    @Test("Test 23 hours sets correct hour lamps")
    func hourRow_atTwentyThree() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 23, minutes: 0, seconds: 0))
        
        #expect(result.fiveHoursLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
        
        #expect(result.oneHoursLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 3)
    }
    
    @Test("Test full clock state at 23:59:59")
    func fullClock_atMaxTime() {
        let calculator = BerlinClockRowCalculator()
        let result = calculator.convertDigitalTimeToBerlinClock(DigitalTime(hours: 23, minutes: 59, seconds: 59))
        
        #expect(result.secondsLamp == .off)
        #expect(result.fiveMinsLamps.count == 11)
        #expect(result.oneMinsLamps.count == 4)
        #expect(result.fiveHoursLamps.count == 4)
        #expect(result.oneHoursLamps.count == 4)
    }
    
    @Test("Test midnight 00:00:00 produces all lamps OFF except seconds ON")
    func midnight_state() {
        let converter = BerlinClockRowCalculator()
        let state = converter.convertDigitalTimeToBerlinClock(DigitalTime(hours: 0, minutes: 0, seconds: 0))
        if case .on(.yellowColor) = state.secondsLamp {
            #expect(true)
        } else {
            Issue.record("Seconds should be ON at even second")
        }
        
        #expect(state.fiveMinsLamps.allSatisfy { $0 == .off })
        #expect(state.oneMinsLamps.allSatisfy { $0 == .off })
        #expect(state.fiveHoursLamps.allSatisfy { $0 == .off })
        #expect(state.oneHoursLamps.allSatisfy { $0 == .off })
    }
    
    @Test("Test seconds toggles ON/OFF")
    func seconds_toggle() {
        let converter = BerlinClockRowCalculator()
        let even = converter.convertDigitalTimeToBerlinClock(DigitalTime(hours: 1, minutes: 1, seconds: 2))
        let odd = converter.convertDigitalTimeToBerlinClock(DigitalTime(hours: 1, minutes: 1, seconds: 3))
        #expect(even.secondsLamp != odd.secondsLamp)
    }
    
    @Test("Test 13:17:01 full composition correct")
    func complex_time_composition() {
        let converter = BerlinClockRowCalculator()
        let state = converter.convertDigitalTimeToBerlinClock(DigitalTime(hours: 13,
                                                                                       minutes: 17,
                                                                                       seconds: 1))
        #expect(state.secondsLamp == .off)
        #expect(state.fiveHoursLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 2)
        
        #expect(state.oneHoursLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 3)
        
        #expect(state.fiveMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 3)
        
        #expect(state.oneMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 2)
    }
    
    @Test("Test 23:59:59 produces correct max state")
    func max_time_state() {
        let converter = BerlinClockRowCalculator()
        let state = converter.convertDigitalTimeToBerlinClock(DigitalTime(hours: 23,
                                                                                      minutes: 59,
                                                                                      seconds: 59))
        
        #expect(state.secondsLamp == .off)
        
        #expect(state.fiveHoursLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
        
        #expect(state.oneHoursLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 3)
        
        #expect(state.fiveMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 11)
        
        #expect(state.oneMinsLamps.filter {
            if case .on = $0 { return true }
            return false
        }.count == 4)
    }
}

