import Foundation

func / (lhs: URL, rhs: String) -> URL {
    lhs.appendingPathComponent(rhs)
}
