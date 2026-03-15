//TODO: is there a good filesystem api library for swift or do i just have to make my own...

import Foundation
import SystemPackage

func / (lhs: FilePath, rhs: String) -> FilePath {
  lhs.appending(rhs)
}

extension FilePath {
  init(url: URL) {
    self.init(url.path)
  }
  func toURL() -> URL {
    URL(fileURLWithPath: self.string)
  }
  func exists() -> Bool {
    FileManager.default.fileExists(atPath: self.string)
  }
  func createDirectory() throws {
    try FileManager.default.createDirectory(
      atPath: self.string, withIntermediateDirectories: true)
  }
  private func createParentsIfNeeded() throws {
    try self.removingLastComponent().createDirectory()
  }
  func write(_ string: String, executable: Bool = false) throws {
    try createParentsIfNeeded()
    try string.write(toFile: self.string, atomically: true, encoding: String.Encoding.utf8)
    if executable {
      try makeExecutable()
    }
  }
  func write(data: Data, executable: Bool = false) throws {
    try createParentsIfNeeded()
    try data.write(to: self.toURL())
    if executable {
      try makeExecutable()
    }
  }
  func makeExecutable() throws {
    #if os(Windows)
      return
    #endif
    let attributes = try FileManager.default.attributesOfItem(atPath: self.string)
    if let currentPermissions = attributes[.posixPermissions] as? NSNumber {
      try FileManager.default.setAttributes(
        [.posixPermissions: currentPermissions.uint16Value | 0o111],
        ofItemAtPath: self.string)
    }
  }
  func move(to destination: FilePath) throws {
    try FileManager.default.moveItem(atPath: self.string, toPath: destination.string)
  }
}
