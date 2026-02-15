import Testing
import Foundation
import Combine

@testable import BerlinClock

@Suite("BerlinClockViewModel Tests")
struct BerlinClockViewModelTests {
    
    @Test("Initial digitalTimeText is empty")
    func initialState_isEmpty() {
        
        let mockService = MockBerlinClockService()
        let mockConvertor = MockBerlinLampStateConvertor()
        
        let viewModel = BerlinClockViewModel(
            clockService: mockService,
            berlinLampStateConvertor: mockConvertor
        )
        
        #expect(viewModel.digitalTimeText == "")
    }

}
