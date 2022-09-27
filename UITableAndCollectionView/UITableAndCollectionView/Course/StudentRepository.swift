import Foundation

class StudentRepository {

    public func getStudents(for names: String...) -> [Student] {
        names.map {
            let bio = generateBio()
            return Student(name: $0, biography: bio)
        }
    }

    private func generateBio() -> String {
        let range = Range(uncheckedBounds: (0, lorem.count))
        let line = Int.random(in: range)
        return lorem[line]
    }

    private var lorem: [String] = {
        guard let loremFile = Bundle.main.path(forResource: "lorem", ofType: "txt"),
              let loremText = try? String(contentsOfFile: loremFile) else {
            return []
        }
        return loremText.split(separator: "\n").map({ String($0) })
    }()

}
