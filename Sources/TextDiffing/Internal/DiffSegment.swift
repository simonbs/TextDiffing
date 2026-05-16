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
        var insertedByDestinationOffset: [Int: [Element]] = [:]
        var removedBySourceOffset: [Int: [Element]] = [:]

        for change in diff {
            switch change {
            case let .insert(offset, element, _):
                insertedByDestinationOffset[offset, default: []].append(element)
            case let .remove(offset, element, _):
                removedBySourceOffset[offset, default: []].append(element)
            }
        }

        var sourceIndex = 0
        var destinationIndex = 0
        var segments: [DiffSegment<Element>] = []

        while sourceIndex < source.count || destinationIndex < destination.count {
            if let removed = removedBySourceOffset[sourceIndex], !removed.isEmpty {
                for element in removed {
                    segments.append(DiffSegment(type: .removed, element: element))
                    sourceIndex += 1
                }
                continue
            }

            if let inserted = insertedByDestinationOffset[destinationIndex], !inserted.isEmpty {
                for element in inserted {
                    segments.append(DiffSegment(type: .inserted, element: element))
                    destinationIndex += 1
                }
                continue
            }

            if sourceIndex < source.count, destinationIndex < destination.count {
                segments.append(DiffSegment(type: .same, element: source[sourceIndex]))
                sourceIndex += 1
                destinationIndex += 1
                continue
            }

            if sourceIndex < source.count {
                segments.append(DiffSegment(type: .removed, element: source[sourceIndex]))
                sourceIndex += 1
            } else if destinationIndex < destination.count {
                segments.append(DiffSegment(type: .inserted, element: destination[destinationIndex]))
                destinationIndex += 1
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
