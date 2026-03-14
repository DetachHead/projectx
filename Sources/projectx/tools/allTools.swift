let allTools: [Tool] = [Swiftly(), Bun()]

func getTool(_ name: String) -> Tool? {
    return allTools.first { $0.name == name}
}