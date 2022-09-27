import Foundation

class CourseInfo {

    private var lectures: [Lecture] = []
    private var students: [Student] = []
    private let repository = StudentRepository()

    init() {
        reloadStudents()
    }

    // TODO: add the full list of students
    func reloadStudents() {
        students = repository.getStudents(for: "Jose", "Luis", "Jorge")
        lectures = ["Ana", "Uriel", "Alex", "Daniel", "Abner", "Josue"].map(Lecture.init)
    }

    var numberOfLectures: Int {
        lectures.count
    }

    var numberOfStudents: Int {
        students.count
    }

    func student(for index: Int) -> Student {
        students[index]
    }

    func lecture(for index: Int) -> Lecture {
        lectures[index]
    }
}
