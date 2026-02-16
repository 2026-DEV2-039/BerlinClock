import SwiftUI

struct LampView: View {
    let lamp: BerlinClockLampPresentationModel
    let shape: LampShape
    
    private let circleSize: CGFloat = 120
    private let rectangleHeight: CGFloat = 50
    
    var body: some View {
        Group {
            if shape == .circle {
                Circle()
                    .fill(resolveColor())
                    .frame(width: circleSize, height: circleSize)
                    .overlay(
                        Circle()
                            .stroke(Color.primary.opacity(0.4), lineWidth: 10)
                    )
                
            } else {
                
                Rectangle()
                    .fill(resolveColor())
                    .frame(height: rectangleHeight)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.primary.opacity(0.25), lineWidth: 10)
                    )
            }
        }
        .animation(.easeInOut(duration: 0.2), value: lamp.isOn)
    }
    
    private func resolveColor() -> Color {
        lamp.isOn
        ? lamp.lampColor.swiftUIColor
        : Color.gray.opacity(0.35)
    }
}

private extension BerlinClockLampColor {
    var swiftUIColor: Color {
        switch self {
        case .redColor:
            return Color(.systemRed)
        case .yellowColor:
            return Color(.systemYellow)
        case .noOffColor:
            return Color.gray.opacity(0.35)
        }
    }
}


#Preview("Circle - ON") {
    LampView(
        lamp: BerlinClockLampPresentationModel(
            isOn: true,
            lampColor: .yellowColor
        ),
        shape: .circle
    )
    .padding()
    .background(Color(.systemBackground))
}

#Preview("Circle - OFF") {
    LampView(
        lamp: BerlinClockLampPresentationModel(
            isOn: false,
            lampColor: .yellowColor
        ),
        shape: .circle
    )
    .padding()
    .background(Color(.systemBackground))
}

#Preview("Rectangle - ON Red") {
    LampView(
        lamp: BerlinClockLampPresentationModel(
            isOn: true,
            lampColor: .redColor
        ),
        shape: .rectangle
    )
    .padding()
    .background(Color(.systemBackground))
}

#Preview("Rectangle - OFF") {
    LampView(
        lamp: BerlinClockLampPresentationModel(
            isOn: false,
            lampColor: .redColor
        ),
        shape: .rectangle
    )
    .padding()
    .background(Color(.systemBackground))
}

#Preview("Dark Mode - Rectangle ON") {
    LampView(
        lamp: BerlinClockLampPresentationModel(
            isOn: true,
            lampColor: .yellowColor
        ),
        shape: .rectangle
    )
    .padding()
    .background(Color(.systemBackground))
    .preferredColorScheme(.dark)
}
