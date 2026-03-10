import Foundation

protocol Tool {
    var name: String { get }
    func getLatestVersion() async -> String?
    /// automatically detect whether the current project uses this tool
    func detect() -> Bool
    func install(platform: Platform, path: URL) async
}
