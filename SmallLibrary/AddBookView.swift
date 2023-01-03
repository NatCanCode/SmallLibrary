//
//  AddBookView.swift
//  SmallLibrary
//
//  Created by N N on 02/01/2023.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<Item>
    
    @State var title: String = ""
    @State var author: String = ""
    @State var year: Int = 0
//    @State var category = 0
    @State var plot: String = ""
    
    enum Category: String, CaseIterable, Identifiable {
        case Action, Classic, Drama, Dystopia, Nonfiction, Thriller
        var id: Self { self }
    }
    @State var selectedCategory: Category = .Classic
    init() {
        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Title", text: $title)
                        TextField("Author", text: $author)
                        Picker("Release year", selection: $year) {
                            ForEach(1900...2023, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(.automatic)
                        .colorMultiply(.accentColor)
                    } header: {
                        Text("Book details")
                            .foregroundColor(.accentColor)
                    }
                    
                    Section {
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(Category.allCases, id: \.self) {
                                Text($0.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(.accentColor)
                    } header: {
                        Text("Category")
                            .foregroundColor(.accentColor)
                    }
                    
                    Section {
                        TextEditor(text:$plot)
                    } header: {
                        Text("Plot")
                            .foregroundColor(.accentColor)
                    }
                }
                Button {
                    addItem()
                    dismiss()
                } label: {
                    Text("Add")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
                }
                ToolbarItem {
                    Button{
                        dismiss()
                    } label: {
                           Text("Cancel")
                    }
                }
            }
            .navigationTitle("New book")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Image("book-and-coffee")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = title
            newItem.author = author
            newItem.year = Int16(year)
            newItem.category = selectedCategory.rawValue
            newItem.plot = plot
       
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
