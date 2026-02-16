import SwiftUI

struct BerlinClockView: View {
    @StateObject private var viewModel: BerlinClockViewModel
    
    init(viewModel: BerlinClockViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: Layout.rootSpacing) {
            ForEach(viewModel.lampsRows, id: \.type) { row in
                HStack(spacing: Layout.lampSpacing) {
                    ForEach(row.lamps.indices, id: \.self) { index in
                        LampView(
                            lamp: row.lamps[index],
                            shape: row.shape
                        )
                    }
                }
                .padding(.vertical, verticalPadding(for: row))
                .padding(.horizontal, horizontalPadding(for: row))
                
                if !isLastRow(row) {
                    rowConnector
                }
            }
            
            Text(viewModel.digitalTimeText)
                .font(.system(size: Layout.digitalFontSize,
                              weight: .bold,
                              design: .monospaced))
                .padding(.top, Layout.digitalTopSpacing)
        }
        .padding(.horizontal, Layout.outerHorizontalPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).ignoresSafeArea())
        .onAppear {
            viewModel.startClock()
        }
        .onDisappear {
            viewModel.stopClock()
        }
    }
}

// MARK: - Layout Constants
private enum Layout {
    static let rootSpacing: CGFloat = 0
    
    static let lampSpacing: CGFloat = 8
    
    static let outerHorizontalPadding: CGFloat = 16
    
    static let rowVerticalPadding: CGFloat = 8
    static let rowHorizontalPadding: CGFloat = 16
    
    static let digitalTopSpacing: CGFloat = 34
    static let digitalFontSize: CGFloat = 28
    
    static let connectorWidth: CGFloat = 8
    static let connectorHeight: CGFloat = 18
}

// MARK: - Helpers
private extension BerlinClockView {
    var rowConnector: some View {
        Rectangle()
            .fill(Color.primary.opacity(0.3))
            .frame(width: Layout.connectorWidth,
                   height: Layout.connectorHeight)
    }
    
    func verticalPadding(for row: BerlinClockRowModel) -> CGFloat {
        row.shape == .circle ? 0 : Layout.rowVerticalPadding
    }
    
    func horizontalPadding(for row: BerlinClockRowModel) -> CGFloat {
        row.shape == .circle ? 0 : Layout.rowHorizontalPadding
    }
    
    func isLastRow(_ row: BerlinClockRowModel) -> Bool {
        row.type == viewModel.lampsRows.last?.type
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
