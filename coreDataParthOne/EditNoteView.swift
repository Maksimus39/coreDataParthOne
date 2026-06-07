import SwiftUI

struct EditNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ContentViewModel
    let note: Note
    
    @State private var title: String
    @State private var content: String
    
    init(viewModel: ContentViewModel, note: Note) {
        self.viewModel = viewModel
        self.note = note
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.content ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Заголовок") {
                    TextField("Заголовок", text: $title)
                }
                
                Section("Содержание") {
                    TextField("Содержание", text: $content, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            .navigationTitle("Редактировать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        viewModel.updateNote(note, title: title, content: content)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
