import ArgumentParser

struct Install: ParsableCommand {
    @Argument(help: "name of the tool to install")
    var tool: String?

    func run() {
        print("Hello, world! \(tool ?? "")")
    }
}

@main
struct Projectx: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "install tool(s)",
        subcommands: [Install.self]
    )
}