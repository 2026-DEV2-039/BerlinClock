import Foundation

//MARK: SystemTimeProviderProtocol
protocol SystemTimeProviderProtocol {
    func now() -> Date
}

//MARK: SystemTimeProvider Implementation
final class SystemTimeProvider: SystemTimeProviderProtocol {
    func now() -> Date {
        Date()
    }
}
