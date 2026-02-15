import Combine
import Foundation
import Combine

final class BerlinClockViewModel: ObservableObject {
    
    // MARK: - Published properties
    @Published private(set) var digitalTimeText: String = ""
    @Published private(set) var allLampsState: BerlinClockState = .empty

    // MARK: - Dependencies
    private let clockService: BerlinClockServiceProtocol
    private let berlinLampStateConvertor: DigitalTimeToBerlinClockProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(clockService: BerlinClockServiceProtocol, berlinLampStateConvertor: DigitalTimeToBerlinClockProtocol ) {
        self.clockService = clockService
        self.berlinLampStateConvertor = berlinLampStateConvertor
    }
    
    // MARK: - Public Binding Trigger
    func startClock() {
        clockService.timePublisher
            .sink { [weak self] digitalTime in
                guard let self = self else { return }
                self.handleClockTick(digitalTime)
            }
            .store(in: &cancellables)
    }
}

//MARK: Presentation
private extension BerlinClockViewModel {
    
    func handleClockTick(_ digitalTime: DigitalTime) {
        digitalTimeText = formattedText(from: digitalTime)
        allLampsState = berlinLampStateConvertor.convertDigitalTimeToBerlinClock(digitalTime)
    }
    
    func formattedText(from time: DigitalTime) -> String {
        String(format: "%02d:%02d:%02d",
               time.hours,
               time.minutes,
               time.seconds)
    }
}


