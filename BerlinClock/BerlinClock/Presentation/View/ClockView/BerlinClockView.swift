import SwiftUI

struct BerlinClockView: View {
    @StateObject private var viewModel: BerlinClockViewModel
    
    init(viewModel: BerlinClockViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.lampsRows, id: \.type) { row in
                HStack(spacing: 8) {
                    ForEach(row.lamps.indices, id: \.self) { index in
                        LampView(
                            lamp: row.lamps[index],
                            shape: row.shape
                        )
                    }
                }
                .padding(.vertical, row.shape == .circle ? 0 : 8)
                .padding(.horizontal, row.shape == .circle ? 0 : 16)
                
                if row.type != viewModel.lampsRows.last?.type {
                    verticalSpine
                }
            }
            Text(viewModel.digitalTimeText)
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .padding(.top, 34)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).ignoresSafeArea())
        .onAppear {
            viewModel.startClock()
        }
    }
    
    // MARK: Helpers
    private var verticalSpine: some View {
        Rectangle()
            .fill(Color.primary.opacity(0.3))
            .frame(width:8, height: 18)
    }
    
    private func resolveColor(for row: BerlinClockRowModel) -> Color {
        guard let lamp = row.lamps.first else {
            return Color.gray.opacity(0.3)
        }
        
        return lamp.isOn
        ? lamp.lampColor.swiftUIColor
        : Color.gray.opacity(0.3)
    }
}

private extension BerlinClockLampColor {
    var swiftUIColor: Color {
        switch self {
        case .redColor: Color(.systemRed)
        case .yellowColor: Color(.systemYellow)
        case .noOffColor: Color.gray.opacity(0.3)
        }
    }
}

//MARK: Preview for testing UI live
#Preview("Live Clock - Light") {
    let service = BerlinClockService()
    let convertor = BerlinClockRowCalculator()
    
    let viewModel = BerlinClockViewModel(
        clockService: service,
        berlinLampStateConvertor: convertor
    )
    
    BerlinClockView(viewModel: viewModel)
}

#Preview("Live Clock - Dark") {
    let service = BerlinClockService()
    let convertor = BerlinClockRowCalculator()
    
    let viewModel = BerlinClockViewModel(
        clockService: service,
        berlinLampStateConvertor: convertor
    )
    
    BerlinClockView(viewModel: viewModel)
        .preferredColorScheme(.dark)
}
