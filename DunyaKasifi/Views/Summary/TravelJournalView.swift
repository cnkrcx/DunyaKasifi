import SwiftUI

struct TravelJournalView: View {
    
    @State private var journalEntries: [JournalEntry] = []
    @State private var currentEntry: JournalEntry = JournalEntry(title: "", city: "", date: "", description: "", image: nil)
    @State private var isEditing: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showDeleteConfirmation: Bool = false
    @State private var selectedEntryToDelete: JournalEntry? = nil
    
    var body: some View {
        VStack {
            Text("Seyahat Günlüğü")
                .font(.largeTitle)
                .bold()
                .padding()
            
            List {
                ForEach(journalEntries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.title)
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("\(entry.city), \(entry.date)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.bottom, 2)
                        if let image = entry.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                        Text(entry.description)
                            .font(.body)
                            .lineLimit(2)
                            .foregroundColor(.black)
                        
                        Button(action: {
                            self.editEntry(entry: entry)
                        }) {
                            Text("Düzenle")
                                .foregroundColor(.green)
                        }
                        .padding(.top, 5)
                        
                        Button(action: {
                            self.selectedEntryToDelete = entry
                            self.showDeleteConfirmation = true
                        }) {
                            Text("Sil")
                                .foregroundColor(.red)
                        }
                        .padding(.top, 5)
                    }
                    .padding(.vertical, 10)
                }
                .onDelete(perform: deleteEntry)
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Silme Onayı"),
                    message: Text("Bu kaydı silmek istediğinizden emin misiniz?"),
                    primaryButton: .destructive(Text("Evet"), action: {
                        if let entryToDelete = selectedEntryToDelete {
                            deleteEntry(at: [journalEntries.firstIndex(where: { $0.id == entryToDelete.id })!])
                        }
                    }),
                    secondaryButton: .cancel()
                )
            }
            
            HStack {
                Button(action: {
                    self.addNewEntry()
                }) {
                    Text("Yeni Günlük Ekle")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {
                    self.showImagePicker.toggle()
                }) {
                    Text("Fotoğraf Seç")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $currentEntry.image)
                }
            }
            .padding()
        }
        .onAppear {
            loadJournalEntries()
        }
    }
    
    func loadJournalEntries() {
        journalEntries = [
            JournalEntry(title: "Paris Gezisi", city: "Paris", date: "2025-06-01", description: "Eiffel Kulesi'ni ziyaret ettim. Harika bir manzarası vardı.", image: UIImage(named: "eiffel")),
            JournalEntry(title: "Roma Tatili", city: "Roma", date: "2025-06-05", description: "Kolezyum ve Roma Forumu'nu gezdim, tarih kokuyordu.", image: UIImage(named: "colosseum"))
        ]
    }
    
    func addNewEntry() {
        let newEntry = JournalEntry(title: "", city: "", date: "", description: "", image: nil)
        journalEntries.append(newEntry)
        isEditing = true
        currentEntry = newEntry
    }
    
    func editEntry(entry: JournalEntry) {
        isEditing = true
        currentEntry = entry
    }
    
    func saveEntry() {
        if let index = journalEntries.firstIndex(where: { $0.id == currentEntry.id }) {
            journalEntries[index] = currentEntry
        }
        isEditing = false
        currentEntry = JournalEntry(title: "", city: "", date: "", description: "", image: nil)
    }
    
    func cancelEditing() {
        isEditing = false
        currentEntry = JournalEntry(title: "", city: "", date: "", description: "", image: nil)
    }
    
    func deleteEntry(at offsets: IndexSet) {
        journalEntries.remove(atOffsets: offsets)
    }
}

struct JournalEntry: Identifiable {
    var id = UUID()
    var title: String
    var city: String
    var date: String
    var description: String
    var image: UIImage?
}

struct ImagePicker: View {
    @Binding var image: UIImage?
    
    var body: some View {
        VStack {
            Text("Fotoğraf Seç")
                .font(.title)
                .padding()
            
            Button(action: {
                
            }) {
                Text("Fotoğrafı Seç")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                
            }) {
                Text("Kapat")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct TravelJournalView_Previews: PreviewProvider {
    static var previews: some View {
        TravelJournalView()
    }
}

