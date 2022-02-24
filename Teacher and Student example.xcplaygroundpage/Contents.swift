
struct Student {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct Teacher {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct Staff {
    let name: String
    let isFullTime: Bool
}

enum User {
    case student(Student)
    case teacehr(Teacher)
    case staff(Staff)
}

func updateProfile(_ user: User) {
    switch user {
    case .student(let student):
        print(student)
    case .teacher(let teacher):
        print(teacher)
    case .staff(let staff):
        print(staff)
    }
}

let user = User.student(Student(name: "Marcio Student",
                                courses: ["one course", "other course"],
                                isFullTime: true))

updateProfile(user)

