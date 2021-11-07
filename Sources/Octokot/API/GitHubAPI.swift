import Foundation

public struct GitHubAPI: API {
    public var configuration: GHConfiguration

    public init(configuration: GHConfiguration = GHConfiguration()) {
        self.configuration = configuration
    }
}

// MARK: - Meta

extension GitHubAPI {
    /// GitHub API Root.
    ///
    ///     GET /
    ///
    /// Get Hypermedia links to resources accessible in GitHub's REST API.
    public func callAsFunction() async throws -> [String: String] {
        try await configuration.client.execute(configuration.request).decode()
    }

    /// Get GitHub meta information.
    ///
    ///     GET /meta
    ///
    /// - Note: The IP addresses shown in the documentation's response are only example values.
    ///         You must always query the API directly to get the latest list of IP addresses.
    /// - Returns: meta information about GitHub, including a list of GitHub's IP addresses.
    ///            For more information, see "About GitHub's IP addresses."
    public func meta() async throws -> GHResponse {
        try await execute {
            $0.url.appendPathComponent("meta")
        }
    }
}

// MARK: - Emojis

extension GitHubAPI {
    /// Get emojis.
    ///
    ///     GET /emojis
    ///
    /// Lists all the emojis available to use on GitHub.
    public func emojis() async throws -> [String: URL] {
        try await execute {
            $0.url.appendPathComponent("emojis")
        }.decode()
    }
}
