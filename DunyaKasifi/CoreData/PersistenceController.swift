import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DunyaKasifi")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchEntities<T: NSManagedObject>(_ entityType: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        if let sortDescriptors = sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch \(entityType): \(error)")
            return []
        }
    }

    func fetchEntity<T: NSManagedObject>(_ entityType: T.Type, predicate: NSPredicate? = nil) -> T? {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch \(entityType): \(error)")
            return nil
        }
    }

    func createEntity<T: NSManagedObject>(_ entityType: T.Type) -> T {
        let context = container.viewContext
        let entity = T(context: context)
        return entity
    }

    func deleteEntity<T: NSManagedObject>(_ entity: T) {
        let context = container.viewContext
        context.delete(entity)
        saveContext()
    }

    func batchDelete<T: NSManagedObject>(_ entityType: T.Type, predicate: NSPredicate? = nil) {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entityType))
        fetchRequest.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("Error executing batch delete: \(error)")
        }
    }

    func updateEntity<T: NSManagedObject>(_ entity: T, with updates: [String: Any]) {
        let context = container.viewContext
        for (key, value) in updates {
            entity.setValue(value, forKey: key)
        }
        saveContext()
    }

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask { context in
            block(context)
            saveContext()
        }
    }

    func resetAllData() {
        let context = container.viewContext
        let entities = container.managedObjectModel.entities
        
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name!)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
            } catch {
                print("Failed to reset entity \(entity.name!): \(error)")
            }
        }
        saveContext()
    }

    func countEntities<T: NSManagedObject>(_ entityType: T.Type) -> Int {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSNumber>(entityName: String(describing: entityType))
        fetchRequest.resultType = .countResultType
        
        do {
            let countResult = try context.fetch(fetchRequest)
            return countResult.first?.intValue ?? 0
        } catch {
            print("Failed to count entities of type \(entityType): \(error)")
            return 0
        }
    }

    func mergeChangesFromContextDidSaveNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let context = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> else {
            return
        }
        
        for updatedObject in context {
            print("Merged changes from context: \(updatedObject)")
        }
    }

    func setupContextObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleContextSaveNotification(_:)), name: .NSManagedObjectContextDidSave, object: container.viewContext)
    }

    @objc func handleContextSaveNotification(_ notification: Notification) {
        mergeChangesFromContextDidSaveNotification(notification)
    }
    
    func clearMemoryCache() {
        let context = container.viewContext
        context.reset()
    }
    
    func addUniqueConstraint(toEntity entityName: String, attributeName: String) {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let uniquePredicate = NSPredicate(format: "%K == %@", attributeName, "SomeValue")
        fetchRequest.predicate = uniquePredicate
        
        let result = try? context.fetch(fetchRequest)
        
        if let existingEntity = result?.first as? NSManagedObject {
            context.delete(existingEntity)
        }
    }

    func fetchAllEntities<T: NSManagedObject>(_ entityType: T.Type, limit: Int? = nil) -> [T] {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch \(entityType): \(error)")
            return []
        }
    }

    func fetchEntityWithLimit<T: NSManagedObject>(_ entityType: T.Type, limit: Int) -> T? {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        fetchRequest.fetchLimit = limit
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch entity: \(error)")
            return nil
        }
    }

    func performBatchUpdate<T: NSManagedObject>(_ entityType: T.Type, predicate: NSPredicate?, updates: [String: Any]) {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entityType))
        fetchRequest.predicate = predicate
        
        let batchUpdateRequest = NSBatchUpdateRequest(fetchRequest: fetchRequest)
        batchUpdateRequest.propertiesToUpdate = updates
        batchUpdateRequest.resultType = .updatedObjectIDsResultType
        
        do {
            let result = try context.execute(batchUpdateRequest) as! NSBatchUpdateResult
            let objectIDs = result.result as! [NSManagedObjectID]
            let objects = objectIDs.compactMap { context.object(with: $0) as? T }
            for object in objects {
                for (key, value) in updates {
                    object.setValue(value, forKey: key)
                }
            }
            saveContext()
        } catch {
            print("Failed to perform batch update: \(error)")
        }
    }

    func fetchByAttribute<T: NSManagedObject>(_ entityType: T.Type, attribute: String, value: Any) -> T? {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        fetchRequest.predicate = NSPredicate(format: "%K == %@", attribute, value)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch entity by attribute: \(error)")
            return nil
        }
    }
}

extension PersistenceController {
    func mergeChangesFromContextDidSaveNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let context = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> else {
            return
        }
        
        for updatedObject in context {
            print("Merged changes from context: \(updatedObject)")
        }
    }
}
// Placeholder for \(file) content.
