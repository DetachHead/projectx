import ArgumentParser

struct Activate: ParsableCommand {
  func run() throws {
    #if os(Windows)
      try fail("TODO")
    #else
      // initialize .projectx dir if it doesn't exist already
      _ = try Project()
      // because bash is fucking stupid we can't just set an environment variable so we have to make the user jump through hoops.
      // i cant believe we still use this shit in current year.........
      print("to activate the environment, run `source .projectx/bin/activate`")
    #endif
  }
}
