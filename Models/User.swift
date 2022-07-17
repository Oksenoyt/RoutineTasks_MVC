//
//  File.swift
//  RoutineTasks
//
//  Created by Elena Kholodilina on 17.07.2022.
//

struct User {
    let login: String
    let password: String
    let person: Person
    
    static func getUser() -> User {
        User(
            login: "user",
            password: "password",
            person: Person(
                firstName: "Arseniy",
                familyName: "Oksenoyt",
                email: "a.oksenoyt@gmail.com",
                photo: "Arseniy"
            )
        )
    }
}

struct Person {
    let firstName: String
    let familyName: String
    let email: String
    let photo: String
}
