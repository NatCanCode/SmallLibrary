//
//  ContentView.swift
//  SmallLibrary
//
//  Created by N N on 02/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showingAddBook = false
    //    @State var isFavorite: Bool
    
    @State private var searchText = ""
    
    func filterItems() -> [FetchedResults<Item>.Element] {
            let elementItems = items.map { $0 }
            let filterResult = items.filter { item in
                guard let title = item.title else {
                    return false
                }
                return title.localizedCaseInsensitiveContains(searchText)
            }

            return searchText.isEmpty ? elementItems : filterResult
        }
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    var body: some View {
        NavigationStack {
//            Text("Searching for \(searchText)")
//                .foregroundColor(.accentColor)
            List {
                ForEach(filterItems()) { item in
                    NavigationLink {
                        BookDetailView(item: item, isFavorite: false)
//                        VStack(spacing: 10) {
//                            Text(item.title ?? "No title")
////                                .bold()
////                                .font(.title)
//                                .font(.custom(
////                                        "AmericanTypewriter",
//                                        "Montserrat-Bold",
//                                        fixedSize: 36))
//                                .foregroundColor(.white)
//                            Text(item.author ?? "No author")
//                                .font(.title2)
//                                .foregroundColor(.white)
////                                .font(.system(.largeTitle, design: .serif))
//                            Text(String(item.year))
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .padding(.bottom, 15)
//                            Text(item.category ?? "No category")
//                                .padding(.top, 15)
//                                .padding(.bottom)
//                                .foregroundColor(.accentColor)
//                            Text(item.plot ?? "No plot")
//                                .frame(maxWidth: .infinity)
//                                .padding()
////                                .blur(radius: 30)
//                                .background(.ultraThinMaterial)
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//
////                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                            Spacer()
//                        }
//                        .padding()
//                        .background(Image("book-and-coffee")
//                            .resizable()
//                            .scaledToFill()
//                            .ignoresSafeArea())
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title ?? "No title")
                                    .bold()
                                    .font(.headline)
                                Text(item.author ?? "No author")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            if item.isFavorite {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
//            .searchable(text: $searchText)
            .searchable(text: $searchText, placement:  .navigationBarDrawer(displayMode: .always),
                            prompt: "Look for a book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        showingAddBook.toggle()
                    }, label: {
                           Label("Add Item", systemImage: "plus")
                    })
                    .sheet(isPresented: $showingAddBook) {
                        AddBookView()
                    }
                }
            }
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Image("book-and-coffee")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
