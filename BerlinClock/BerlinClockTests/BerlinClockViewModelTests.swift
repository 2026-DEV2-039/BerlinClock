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
}
