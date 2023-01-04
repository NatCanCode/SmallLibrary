//
//  SearchBarView.swift
//  SmallLibrary
//
//  Created by N N on 03/01/2023.
//

//import SwiftUI
//
//struct SearchBarView: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    @State private var searchText = ""
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//    
//    @State private var showingAddBook = false
//    
//    func filterItems() -> [FetchedResults<Item>.Element] {
//        let elementItems = items.map { $0 }
//        let filterResult = items.filter { item in
//            guard let title = item.title else {
//                return false
//            }
//            return title.localizedCaseInsensitiveContains(searchText)
//        }
//        
//        return searchText.isEmpty ? elementItems : filterResult
//    }
//    
//    var body: some View {
//        List {
//            ForEach(filterItems()) { item in
//                NavigationLink {
//                    BookDetailView(item: item, isFavorite: true)
//                } label: {
//                    VStack{
//                        Text(item.title!)
//                            .fontWeight(.semibold)
//                        Text(item.author!)
//                    }
//                }
//            }
////            .onDelete(perform: deleteItems)
//        }
//        
//        
//        //            NavigationStack {
//        //                Text("Searching for \(searchText)")
//        ////                    .navigationTitle("Searchable Example")
//        //            }
//        ////            .searchable(text: $searchText, prompt: "Look for something")
//        //            .searchable(text: $searchText, placement:  .navigationBarDrawer(displayMode: .always),
//        //                prompt: "Look for something")
//        //            .onChange(of: searchText.lowercased()) { book in
//        //                if !book.isEmpty {
//        //                    searchBook = ?.filter { $0.title.lowercased().contains(book) }
//        //                } else {
//        //                    searchBook = ?
//        //                }
//        //            }
//    }
//}
//
//
//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
