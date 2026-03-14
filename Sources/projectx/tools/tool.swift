import SystemPackage

protocol Tool: Sendable {
    var name: String { get }
    func getLatestVersion() async throws -> String
    /// automatically detect whether the current project uses this tool
    func isUsedInProject(projectDir: FilePath) -> Bool
    // TODO: architecture
    func install(version: String, installToPath: FilePath) async throws
}
