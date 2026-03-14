import ArgumentParser
import Foundation
import SystemPackage

struct Install: AsyncParsableCommand {
    @Argument(help: "name of the tool to install")
    var tool: String?

    func run() async throws {
        let project = try Project()
        if let toolName = tool {
            if let tool = getTool(toolName) {
                try await project.install(tool: tool, version: try await tool.getLatestVersion())
            } else {
                try fail("unknown tool: \(toolName)")
            }
        } else {
            let installedTools = try await project.detectAndInstallTools()
            if installedTools.count > 0 {
                logger.info("installed \(installedTools.map { $0.name }.joined(separator: ", "))")
            } else {
                try fail(
                    "could not detect any tools to install. try passing a tool name explicitly.")
            }
        }
    }
}
