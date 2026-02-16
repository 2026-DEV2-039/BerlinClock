import Combine
import Foundation
import Combine

enum LampShape {
    case circle
    case rectangle
}

struct BerlinClockLampPresentationModel: Equatable {
    let isOn: Bool
    let lampColor: BerlinClockLampColor
}

struct BerlinClockRowModel: Equatable {
    let type: BerlinClockRowType
    let shape: LampShape
    let lamps: [BerlinClockLampPresentationModel]
}

final class BerlinClockViewModel: ObservableObject {
    
    // MARK: - Published properties
    @Published private(set) var digitalTimeText: String = ""
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
    
    func stopClock() {
        cancellables.removeAll()
    }
}

//MARK: Presentation Methods
private extension BerlinClockViewModel {
    
    func handleClockTick(_ digitalTime: DigitalTime) {
        digitalTimeText = formattedText(from: digitalTime)
        let state = berlinLampStateConvertor.convertDigitalTimeToBerlinClock(digitalTime)
        lampsRows = buildRows(from: state)
    }
    
    func formattedText(from time: DigitalTime) -> String {
        String(format: "%02d:%02d:%02d",
               time.hours,
               time.minutes,
               time.seconds)
    }
    
    func buildRows(from state: BerlinClockState) -> [BerlinClockRowModel] {
        BerlinClockRowType.displayOrder.map { type in
            getLampsRowModel(
                type: type,
                lamps: lamps(for: type, state: state)
            )
        }
    }
    
    func lamps(for type: BerlinClockRowType,state: BerlinClockState) -> [BerlinClockLampsState] {
        switch type {
        case .seconds:
            return [state.secondsLamp]
        case .fiveHoursRowCase:
            return state.fiveHoursLamps
        case .oneHoursRowCase:
            return state.oneHoursLamps
        case .fiveMinsRowCase:
            return state.fiveMinsLamps
        case .oneMinsRowCase:
            return state.oneMinsLamps
        }
    }

    func getLampsRowModel(type: BerlinClockRowType, lamps: [BerlinClockLampsState]) -> BerlinClockRowModel {
        let shape: LampShape
        
        switch type {
        case .seconds:
            shape = .circle
        case .fiveMinsRowCase,
                .oneMinsRowCase,
                .fiveHoursRowCase,
                .oneHoursRowCase:
            shape = .rectangle
        }
        
        let presentationLamps = lamps.map { lamp -> BerlinClockLampPresentationModel in
            switch lamp {
            case .off:
                return BerlinClockLampPresentationModel(
                    isOn: false,
                    lampColor: .noOffColor
                )
                
            case .on(let color):
                return BerlinClockLampPresentationModel(
                    isOn: true,
                    lampColor: color
                )
            }
        }
        return BerlinClockRowModel(type: type, shape: shape, lamps: presentationLamps)
    }
}


