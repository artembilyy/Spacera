//
//  RealmManager.swift
//  Spacera
//
//  Created by Artem Bilyi on 03.01.2023.
//

import RealmSwift
import Foundation

protocol RealmManagerProtocol {
    
    func saveRocket(data: [RocketRealm]) throws
    func deleteRocket(data: [RocketRealm]) throws
    func fetchTasks() -> Results<RocketRealm>
}

class RealmManager: RealmManagerProtocol {
    private let realm: Realm

    init() {
        realm = try! Realm()
    }

    func saveRocket(data: [RocketRealm]) throws {
        try realm.write {
            realm.add(data)
        }
    }
    
    func deleteRocket(data: [RocketRealm]) throws {
        try realm.write {
            realm.delete(data)
        }
    }
    
    func fetchTasks() -> RealmSwift.Results<RocketRealm> {
        return realm.objects(RocketRealm.self)
    }
    
   
}
