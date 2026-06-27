import ArgumentParser

@main
struct Projectx: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    abstract: "install tool(s)",
    subcommands: [Install.self, Activate.self]
  )
}
