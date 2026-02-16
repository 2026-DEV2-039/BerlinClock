import SwiftUI

struct LampView: View {
    let lamp: BerlinClockLampPresentationModel
    let shape: LampShape
    
    var body: some View {
        Group {
            if shape == .circle {
                Circle()
                    .fill(fillColor)
                    .overlay(circleBorder)
                    .frame(width: Layout.circleSize,
                           height: Layout.circleSize)
            } else {
                RoundedRectangle(cornerRadius: Layout.cornerRadius)
                    .fill(fillColor)
                    .overlay(rectangleBorder)
                    .frame(height: Layout.rectangleHeight)
            }
        }
        .animation(.easeInOut(duration: Layout.animationDuration),
                   value: lamp.isOn)
    }
}

// MARK: - Private Helpers
private extension LampView {
    var fillColor: Color {
        lamp.isOn
        ? lamp.lampColor.swiftUIColor
        : Layout.offColor
    }
    
    var circleBorder: some View {
        Circle()
            .stroke(Layout.borderColor,
                    lineWidth: Layout.borderWidth)
    }
    
    var rectangleBorder: some View {
        RoundedRectangle(cornerRadius: Layout.cornerRadius)
            .stroke(Layout.borderColor,
                    lineWidth: Layout.borderWidth)
    }
}

// MARK: - Layout Constants
private enum Layout {
    static let circleSize: CGFloat = 100
    static let rectangleHeight: CGFloat = 50
    
    static let cornerRadius: CGFloat = 6
    
    static let borderWidth: CGFloat = 10
    static let borderColor: Color = Color.primary.opacity(0.3)
    
    static let offColor: Color = Color.gray.opacity(0.35)
    
    static let animationDuration: Double = 0.2
}

// MARK: - Color Mapping
private extension BerlinClockLampColor {
    var swiftUIColor: Color {
        switch self {
        case .redColor:
            return Color(.systemRed)
        case .yellowColor:
            return Color(.systemYellow)
        case .noOffColor:
            return Layout.offColor
        }
    }
}
