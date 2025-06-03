import Foundation

enum DiffSegmentType {
    case same
    case inserted
    case removed
}

struct DiffSegment<Element> {
    let type: DiffSegmentType
    let element: Element
}

extension Array where Element == String {
    func diffSegments(comparingWith other: [Element]) -> [DiffSegment<Element>] {
        let diff = difference(from: other)
        var segments: [DiffSegment<Element>] = other.map { element in
            return DiffSegment(type: .same, element: element)
        }
        var deletedOffsets: Set<Int> = []
        for change in diff {
            switch change {
            case let .insert(offset, element, _):
                let deltaOffset = deletedOffsets.filter { $0 < offset }.count
                segments.insert(DiffSegment(type: .inserted, element: element), at: offset + deltaOffset)
            case let .remove(offset, element, _):
                deletedOffsets.insert(offset)
                segments[offset] = DiffSegment(type: .removed, element: element)
            }
        }
        return segments.reduce(into: []) { result, segment in
            guard let lastSegment = result.last, segment.type == lastSegment.type else {
                result.append(segment)
                return
            }
            let joinedElement = lastSegment.element.appending(segment.element)
            let joinedDiffSegment = DiffSegment(type: segment.type, element: joinedElement)
            result.removeLast()
            result.append(joinedDiffSegment)
        }
    }
}
