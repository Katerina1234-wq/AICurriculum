import Foundation

struct CurriculumData {
    let topic: String
    let readingContent: String
    let videoURLs: [String]
    let flashcards: [Flashcard]
}

struct Flashcard: Identifiable, Hashable {
    let id: UUID = UUID()
    let question: String
    let answer: String
}
