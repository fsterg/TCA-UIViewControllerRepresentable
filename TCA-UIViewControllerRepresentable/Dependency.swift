import Dependencies
import Foundation

public struct Client {
    var canDrop: @Sendable (String, Int) async throws -> Bool
}

public extension DependencyValues {
    var client: Client {
        get { self[Client.self] }
        set { self[Client.self] = newValue }
    }
}

extension Client: TestDependencyKey {
    public static var testValue: Client = Self(
        canDrop: unimplemented("Client.canDrop")
    )
}

extension Client: DependencyKey {
    public static var liveValue: Client = Self { string, integer in
        if let stringInteger = Int(string) {
            // Just simulate that we need two arguments to return a result after a while
            try await Task.sleep(for: .seconds(1))
            return (stringInteger+integer) % 2 == 0
        } else {
            throw NSError(domain: "Client", code: 0)
        }
    }
}
