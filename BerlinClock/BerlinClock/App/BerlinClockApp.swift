import SwiftUI

@main
struct BerlinClockApp: App {
    var body: some Scene {
        WindowGroup {
            BerlinClockView(
                viewModel: makeBerlinClockViewModel()
            )
        }
    }
}

private extension BerlinClockApp {
    // MARK: - Dependency assembly
    private func makeBerlinClockViewModel() -> BerlinClockViewModel {
        let timeProvider = SystemTimeProvider()
        let timePublisher = SystemTimerPublisher()
        let clockService = BerlinClockService(calendar: .current,
                                              timeProvider: timeProvider,
                                              timerPublisher: timePublisher)
        
        let berlinRowStateConvertor = BerlinClockRowCalculator()
    
        return BerlinClockViewModel(clockService: clockService,
                                    berlinLampStateConvertor: berlinRowStateConvertor)
    }
}
