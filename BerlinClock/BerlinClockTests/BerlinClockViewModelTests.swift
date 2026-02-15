import Testing
import Foundation
import Combine

@testable import BerlinClock

@Suite("BerlinClockViewModel Tests")
struct BerlinClockViewModelTests {
    
    @Test("Test initial digitalTimeText is empty")
    func digitalTimeText_isEmpty_whenInitialState() {
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        #expect(viewModel.digitalTimeText == "")
    }
    
    @Test("Test no update before startClock is called")
    func digitalTimeText_noUpdate_whenTimeIsNotEmitted() {
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        mockService.send(DigitalTime(hours: 12, minutes: 34, seconds: 56))
        
        #expect(viewModel.digitalTimeText == "")
    }

    @Test("Test digitalTimeText updated after startClock")
    func digitalTimeText_updatesCorrectly_whenTimeIsEmitted() {
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        viewModel.startClock()
        
        mockService.send(DigitalTime(hours: 9, minutes: 8, seconds: 7))
        
        #expect(viewModel.digitalTimeText == "09:08:07")
    }
    
    @Test("Test multiple digital time updates")
    func digitalTimeText_updatesCorrectly_whenTimeIsContinouslyEmitted() {
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        viewModel.startClock()
        
        mockService.send(DigitalTime(hours: 1, minutes: 2, seconds: 3))
        #expect(viewModel.digitalTimeText == "01:02:03")
        
        mockService.send(DigitalTime(hours: 4, minutes: 5, seconds: 6))
        #expect(viewModel.digitalTimeText == "04:05:06")
    }
    
    @Test("Test formatting of leading zeros correctly")
    func digitalTimeText_formattedCorrectly_whenHoursHasLeadingZero() {
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        viewModel.startClock()
        
        mockService.send(DigitalTime(hours: 3, minutes: 4, seconds: 5))
        
        #expect(viewModel.digitalTimeText == "03:04:05")
    }
    
    @Test("Test lampState updates when time is in initial state 0.0.0")
    func lampState_isEmpty_whenTimeIsNotStarted() {
        
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let expectedState = BerlinClockState.empty
        mockConvertor.stubState = expectedState
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        viewModel.startClock()
        
        let time = DigitalTime(hours: 0, minutes: 0, seconds: 0)
        
        mockService.send(time)
        
        #expect(viewModel.lampsRows.first?.lamps.first?.isOn == false)
        #expect(mockConvertor.receivedTime == time)
    }
    
    @Test("Test lampState reflects latest emitted value")
    func lampState_reflectsLatestValue_whenMultipleTimesAreEmitted() {
        
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let firstState = BerlinClockState.empty
        
        let secondState = BerlinClockState(
            secondsLamp: .on(.yellowColor),
            fiveMinsLamps: Array(repeating: .on(.redColor), count: 11),
            oneMinsLamps: Array(repeating: .off, count: 4),
            fiveHoursLamps: Array(repeating: .off, count: 4),
            oneHoursLamps: Array(repeating: .off, count: 4)
        )
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        viewModel.startClock()
        
        mockConvertor.stubState = firstState
        mockService.send(DigitalTime(hours: 1, minutes: 1, seconds: 1))
        
        mockConvertor.stubState = secondState
        mockService.send(DigitalTime(hours: 2, minutes: 2, seconds: 2))
        
        #expect(viewModel.lampsRows.first?.lamps.first?.lampColor == .yellowColor)
    }
    
    @Test("Test rows are built correctly from BerlinClockState")
    func rows_areBuiltCorrectly_fromState() {
        
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let customState = BerlinClockState(
            secondsLamp: .on(.yellowColor),
            fiveMinsLamps: Array(repeating: .off, count: 11),
            oneMinsLamps: Array(repeating: .off, count: 4),
            fiveHoursLamps: Array(repeating: .off, count: 4),
            oneHoursLamps: Array(repeating: .off, count: 4)
        )
        
        mockConvertor.stubState = customState
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        viewModel.startClock()
        
        mockService.send(DigitalTime(hours: 0, minutes: 0, seconds: 0))
        
        #expect(viewModel.lampsRows.count == 5)
        #expect(viewModel.lampsRows.first?.type == .seconds)
        #expect(viewModel.lampsRows.first?.lamps.first?.isOn == true)
        #expect(viewModel.lampsRows.first?.lamps.first?.lampColor == .yellowColor)
    }
}
