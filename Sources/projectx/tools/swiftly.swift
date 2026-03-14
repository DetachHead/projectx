import Foundation
import FoundationNetworking
import SWCompression
import SystemPackage

struct Swiftly: Tool {
    let name = "swift"
    func getLatestVersion() async throws -> String {
        try await GithubRepo(owner: "swiftlang", repo: "swiftly").getLatestVersion()
    }

    func isUsedInProject(projectDir: FilePath) -> Bool {
        (projectDir / "Package.swift").exists()
    }

    // TODO: this doesnt use the version
    func install(version: String, installToPath: FilePath) async throws {
        #if os(Linux)
            let (localURL, _) = try await URLSession.shared.download(
                from: URL(
                    string:
                        "https://download.swift.org/swiftly/linux/swiftly-\(architecture).tar.gz"
                )!)
            let decompressedData = try GzipArchive.unarchive(archive: Data(contentsOf: localURL))
            let tarEntries = try TarContainer.open(container: decompressedData)
            let executableName = "swiftly"
            let swiftly = tarEntries.first { $0.info.name == executableName }!.data!
            try (installToPath / "bin" / executableName).write(data: swiftly, executable: true)
        #else
            try fail("TODO")
        #endif
    }
}
