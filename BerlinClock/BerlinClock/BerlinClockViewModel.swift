import Combine
import Foundation
import Combine

struct BerlinClockRowModel: Equatable {
    let type: BerlinClockRowType
    let lamps: [BerlinClockLampsState]
}

final class BerlinClockViewModel: ObservableObject {
    
    // MARK: - Published properties
    @Published private(set) var digitalTimeText: String = ""
    @Published private(set) var allLampsState: BerlinClockState = .empty
    @Published private(set) var lampsRows: [BerlinClockRowModel] = []

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
        let state = berlinLampStateConvertor.convertDigitalTimeToBerlinClock(digitalTime)
        allLampsState = state
        lampsRows = buildRows(from: allLampsState)
    }
    
    func formattedText(from time: DigitalTime) -> String {
        String(format: "%02d:%02d:%02d",
               time.hours,
               time.minutes,
               time.seconds)
    }
    
    func buildRows(from state: BerlinClockState) -> [BerlinClockRowModel] {
        let secondsLampsRow =  BerlinClockRowModel(type: .seconds, lamps: [state.secondsLamp])
        let fiveHoursLampsRow =  BerlinClockRowModel(type: .fiveHoursRowCase, lamps: state.fiveHoursLamps)
        let oneHoursLampsRow =  BerlinClockRowModel(type: .oneHoursRowCase, lamps: state.oneHoursLamps)
        let fiveMinsLampsRow =  BerlinClockRowModel(type: .fiveMinsRowCase, lamps: state.fiveMinsLamps)
        let oneMinsLampsRow =  BerlinClockRowModel(type: .oneMinsRowCase, lamps: state.oneMinsLamps)
      
        return [secondsLampsRow, fiveHoursLampsRow, oneHoursLampsRow, fiveMinsLampsRow, oneMinsLampsRow]
    }
}


