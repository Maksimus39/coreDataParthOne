import Foundation
import CoreData

final class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "db")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() throws {
        guard viewContext.hasChanges else { return }
        try viewContext.save()
    }
    
    // MARK: - CREATE
    func createNote(title: String, content: String) throws -> Note {
        let note = Note(context: viewContext)
        note.id = UUID().uuidString
        note.title = title
        note.content = content
        note.data = Date()
        
        try saveContext()
        return note
    }
    
    // MARK: - READ
    func fetchNotes() throws -> [Note] {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: "data", ascending: true)]
        return try viewContext.fetch(request)
    }
    
    // MARK: - UPDATE
    func updateNote(_ note: Note, title: String, content: String) throws {
        note.title = title
        note.content = content
        try saveContext()
    }
    
    // MARK: - DELETE
    func deleteNote(_ note: Note) throws {
        viewContext.delete(note)
        try saveContext()
    }
}
