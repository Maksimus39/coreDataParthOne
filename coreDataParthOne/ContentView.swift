import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Форма создания
                VStack(spacing: 12) {
                    TextField("Заголовок", text: $title)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Содержание", text: $content, axis: .vertical)
                        .lineLimit(3...6)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Создать заметку") {
                        guard !title.isEmpty, !content.isEmpty else { return }
                        viewModel.createNote(title: title, content: content)
                        title = ""
                        content = ""
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || content.isEmpty)
                }
                .padding(.horizontal)
                
                // Список заметок
                List(viewModel.notes, id: \.id) { note in
                    NavigationLink(destination: EditNoteView(viewModel: viewModel, note: note)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content ?? "")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions(edge: .trailing) {  // ← ВНУТРИ ForEach
                        Button(role: .destructive) {
                            viewModel.deleteNote(note)  // ← Конкретная заметка
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Заметки")
            .onAppear {
                viewModel.loadNotes()
            }
        }
    }
}
