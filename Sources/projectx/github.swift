import OctoKit

struct GithubRepo {
    let owner: String
    let repo: String

    // TODO: dependency inject this
    let octokit: Octokit = Octokit()

    func getLatestVersion() async -> String? {
        do {
            return try await octokit.getLatestRelease(owner: owner, repository: repo).tagName
        } catch let e {
            print("failed to get latest release: \(e)")
        }
        return nil
    }
    // TODO: download release asset
}