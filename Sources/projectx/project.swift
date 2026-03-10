import Foundation

struct Project {
    let projectxDir: URL
    init(root: URL) {
        projectxDir = root / ".projectx"
    }
}