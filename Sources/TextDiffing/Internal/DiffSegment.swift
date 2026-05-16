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
        let (insertedByDestinationOffset, removedBySourceOffset) = changeMaps(
            for: destination.difference(from: source)
        )

        var sourceIndex = 0
        var destinationIndex = 0
        var segments: [DiffSegment<Element>] = []
        func appendSegment(_ type: DiffSegmentType, _ element: Element) {
            guard let lastSegment = segments.last, lastSegment.type == type else {
                segments.append(DiffSegment(type: type, element: element))
                return
            }
            segments[segments.count - 1] = DiffSegment(type: type, element: lastSegment.element + element)
        }

        while sourceIndex < source.count || destinationIndex < destination.count {
            if let removed = removedBySourceOffset[sourceIndex], !removed.isEmpty {
                for element in removed {
                    appendSegment(.removed, element)
                    sourceIndex += 1
                }
                continue
            }

            if let inserted = insertedByDestinationOffset[destinationIndex], !inserted.isEmpty {
                for element in inserted {
                    appendSegment(.inserted, element)
                    destinationIndex += 1
                }
                continue
            }

            if sourceIndex < source.count, destinationIndex < destination.count {
                appendSegment(.same, source[sourceIndex])
                sourceIndex += 1
                destinationIndex += 1
                continue
            }

            if sourceIndex < source.count {
                appendSegment(.removed, source[sourceIndex])
                sourceIndex += 1
            } else if destinationIndex < destination.count {
                appendSegment(.inserted, destination[destinationIndex])
                destinationIndex += 1
            }
        }

        return segments
    }

    private func changeMaps(
        for diff: CollectionDifference<Element>
    ) -> ([Int: [Element]], [Int: [Element]]) {
        var insertedByOffset: [Int: [Element]] = [:]
        var removedByOffset: [Int: [Element]] = [:]
        for change in diff {
            switch change {
            case let .insert(offset, element, _):
                insertedByOffset[offset, default: []].append(element)
            case let .remove(offset, element, _):
                removedByOffset[offset, default: []].append(element)
            }
        }
        return (insertedByOffset, removedByOffset)
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
