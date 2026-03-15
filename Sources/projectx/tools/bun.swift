import Foundation
import FoundationNetworking
import SWCompression
import SystemPackage

struct Bun: Tool {
  let name = "bun"
  func getLatestVersion() async throws -> String {
    // eg. "bun-v1.3.10"
    try await String(
      GithubRepo(owner: "oven-sh", repo: "bun").getLatestVersion().trimmingPrefix("bun-v"))
  }

  func isUsedInProject(projectDir: FilePath) -> Bool {
    (projectDir / "bun.lock").exists()
  }

  func install(version: String, installToPath: FilePath) async throws {
    #if os(Linux)
      let architecture =
        switch architecture {
        case .x86_64:
          "x64"
        case .arm64:
          "aarch64"
        default:
          try fail("unsupported architecture: \(architecture)")
        }
      let (localURL, _) = try await URLSession.shared.download(
        from: URL(
          string:
            "https://github.com/oven-sh/bun/releases/download/bun-v\(version)/bun-linux-\(architecture).zip"
        )!)
      let zipEntries = try ZipContainer.open(container: Data(contentsOf: localURL))
      let executableName = "bun"
      let bun = zipEntries.first { $0.info.name.hasSuffix("/\(executableName)") }!.data!
      try (installToPath / "bin" / executableName).write(data: bun, executable: true)
    #else
      try fail("TODO")
    #endif
  }
}
