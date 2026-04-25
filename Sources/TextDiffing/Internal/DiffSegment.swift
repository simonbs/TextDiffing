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
        let destination = refined(basedOn: other)
        let source = other.refined(basedOn: destination)

        let diff = destination.difference(from: source)
        var segments: [DiffSegment<Element>] = source.map { element in
            return DiffSegment(type: .same, element: element)
        }
        var deletedOffsets: Set<Int> = []
        for change in diff {
            switch change {
            case let .insert(offset, element, _):
                let deltaOffset = deletedOffsets.filter { $0 <= offset }.count
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

    private func refined(basedOn referenceTokens: [String]) -> [String] {
        let referenceSet = Set(referenceTokens)
        return flatMap { token -> [String] in
            if token.allSatisfy(\.isWhitespace) || referenceSet.contains(token) {
                return [token]
            }
            return splitToken(token, using: referenceTokens) ?? [token]
        }
    }

    private func splitToken(_ token: String, using referenceTokens: [String]) -> [String]? {
        for startIdx in referenceTokens.indices {
            let refToken = referenceTokens[startIdx]
            guard !refToken.allSatisfy(\.isWhitespace),
                  token.hasPrefix(refToken),
                  token != refToken else { continue }

            var accumulated = refToken
            var parts = [refToken]
            var j = startIdx + 1
            while j < referenceTokens.count && accumulated.count < token.count {
                let nextToken = referenceTokens[j]
                j += 1
                if nextToken.allSatisfy(\.isWhitespace) { continue }
                accumulated += nextToken
                parts.append(nextToken)
            }
            if accumulated == token {
                return parts
            }
        }
        return nil
    }
}
