import Foundation

struct Swift: Tool {
    let name = "swift"
    func getLatestVersion() async -> String? {
        await GithubRepo(owner: "swiftlang", repo: "swift").getLatestVersion()
    }
    func detect() -> Bool {
        return false // TODO
    }

    func install(platform: Platform, path: URL) async {
        
    }
}