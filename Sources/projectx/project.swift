import CollectionConcurrencyKit
import Foundation
import Logging
import SystemPackage

struct Project {
  let rootDir, projectxDir, projectxBinDir: FilePath
  init(root: FilePath = FilePath(FileManager.default.currentDirectoryPath)) throws {
    self.rootDir = root
    projectxDir = root / ".projectx"
    projectxBinDir = projectxDir / "bin"
    if !projectxDir.exists() {
      try (projectxDir / ".gitignore").write("*")
      try (projectxBinDir / "activate").write(
        "export PATH=\"\(projectxBinDir):\(ProcessInfo.processInfo.environment["PATH"]!)\""
      )
    }
  }

  func install(tool: Tool, version: String) async throws {
    logger.info("installing \(tool.name) v\(version)")
    try await tool.install(version: version, installToPath: projectxDir)
  }

  /// - Returns: an array of tools that were detected and installed
  func detectAndInstallTools() async throws -> [Tool] {
    return try await allTools.concurrentCompactMap { tool in
      if tool.isUsedInProject(projectDir: rootDir) {
        try await install(tool: tool, version: try tool.getLatestVersion())
        return tool
      }
      return nil
    }
  }
}
