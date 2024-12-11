//
//  PersistenceManager.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation
import SwiftData

protocol PersistenceManagerProtocol {
    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) throws -> [T]
    func insert<T: PersistentModel>(_ object: T)
    func delete<T: PersistentModel>(_ object: T)
    func save() throws
}

class SwiftDataPersistenceManager: PersistenceManagerProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T: PersistentModel {
        return try modelContext.fetch(descriptor)
    }

    func insert<T>(_ object: T) where T: PersistentModel {
        modelContext.insert(object)
    }

    func delete<T>(_ object: T) where T: PersistentModel {
        modelContext.delete(object)
    }

    func save() throws {
        try modelContext.save()
    }
}
