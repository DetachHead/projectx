import OctoKit

struct GithubRepo {
  let owner: String
  let repo: String

  // TODO: dependency inject this
  let octokit: Octokit = Octokit()

  func getLatestVersion() async throws -> String {
    try await octokit.getLatestRelease(owner: owner, repository: repo).tagName
  }
  // TODO: download release asset
}
