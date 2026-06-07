import Foundation
import Combine
import CoreData

final class ContentViewModel: ObservableObject {
    private let coreManager = CoreDataManager()
    @Published var notes: [Note] = []
    @Published var errorMessage: String?
    
    // MARK: - CREATE
    func createNote(title: String, content: String) {
        do {
            let note = try coreManager.createNote(title: title, content: content)
            print("✅ Создана заметка: \(note.id)")
            loadNotes()  // ← Перезагружаем список
        } catch {
            errorMessage = "Ошибка создания: \(error.localizedDescription)"
            print("❌ Ошибка: \(error)")
        }
    }
    
    // MARK: - READ
    func loadNotes() {
        do {
            notes = try coreManager.fetchNotes()
            print("📚 Загружено заметок: \(notes.count)")
        } catch {
            errorMessage = "Ошибка загрузки: \(error.localizedDescription)"
            print("❌ Ошибка: \(error)")
        }
    }
    
    // MARK: - UPDATE
    func updateNote(_ note: Note, title: String, content: String) {
        do {
            try coreManager.updateNote(note, title: title, content: content)
            print("✅ Обновлена заметка: \(note.id)")
            loadNotes()  // ← Перезагружаем список
        } catch {
            errorMessage = "Ошибка обновления: \(error.localizedDescription)"
            print("❌ Ошибка: \(error)")
        }
    }
    
    // MARK: - DELETE
    func deleteNote(_ note: Note) {
        do {
            try coreManager.deleteNote(note)
            print("✅ Удалена заметка: \(note.id)")
            loadNotes()  // ← Перезагружаем список
        } catch {
            errorMessage = "Ошибка удаления: \(error.localizedDescription)"
            print("❌ Ошибка: \(error)")
        }
    }
}
