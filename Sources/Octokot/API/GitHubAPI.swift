import Foundation

public struct GitHubAPI: Api {
    public let client: GHClient

    public init(configuration: GHConfiguration = .default) {
        self.client = GHSession(configuration: configuration)
    }

    public init(client: GHClient) {
        self.client = client
    }
}

extension GitHubAPI {
    /// The Users API allows to get public and private information about the authenticated user.
    public var user: AuthenticatedUserApi {
        AuthenticatedUserApi(client: client)
    }

    /// The Repos API allows to create, manage and control the workflow of public and private GitHub repositories.
    public var repos: ReposApi {
        ReposApi(client: client)
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
        try await client.execute(client.configuration.request).decode()
    }

    /// Get GitHub meta information.
    ///
    ///     GET /meta
    ///
    /// - Note: The IP addresses shown in the documentation's response are only example values.
    ///         You must always query the API directly to get the latest list of IP addresses.
    /// - Returns: meta information about GitHub, including a list of GitHub's IP addresses.
    ///            For more information, see "About GitHub's IP addresses."
    public func meta() async throws -> Meta {
        try await execute {
            $0.url.appendPathComponent("meta")
        }.decode()
    }
}

// MARK: - Emojis

extension GitHubAPI {
    /// Get emojis.
    ///
    ///     GET /emojis
    ///
    /// Lists all the emojis available to use on GitHub.
    public func emojis() async throws -> [String: String] {
        try await execute {
            $0.url.appendPathComponent("emojis")
        }.decode()
    }

    public func zen() async throws -> String {
        try await execute {
            $0.url.appendPathComponent("zen")
        }.string
    }
}
