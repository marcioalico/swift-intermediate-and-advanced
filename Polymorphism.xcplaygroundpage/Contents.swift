struct Teacher {
    let name: String
    let courses: [String]
}

struct Student {
    let name: String
    let courses: [String]
    var grade: String?
}

let teacher = Teacher(name: "Marcio Teacher", courses: ["Geography","Maths"])
let student = Student(name: "Marcio Student", courses: ["Geography","Maths"], grade: "Some grade")

enum User {
    case teacher(Teacher)
    case student(Student)
}

let users = [User.teacher(teacher), User.student(student)]

for user in users {
    switch user {
    case .student(let student):
        print(student.grade ?? "")
    case .teacher(let teacher):
        print(teacher.courses)
    default:
        print("Not student or teacher")
    }
}
