//
//  BookDetailView.swift
//  SmallLibrary
//
//  Created by N N on 02/01/2023.
//

import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @State var item: Item
    @State var isFavorite: Bool
    //    let predicateIsFavourite = NSPredicate(format: "isFavourite == %@", NSNumber(value: true))
    
    var body: some View {
        VStack(spacing: 10) {
            Text(item.title!)
                .font(.custom(
//                                       "AmericanTypewriter",
                    "Montserrat-Bold",
                    fixedSize: 32))
                .foregroundColor(.white)
            Text(item.author!)
                .font(.title2)
                .foregroundColor(.white)
            //                                .font(.system(.largeTitle, design: .serif))
            Text(String(item.year))
                .font(.title2)
                .foregroundColor(.white)
                .padding(.bottom, 15)
            Text(item.category!)
                .font(.title2)
                .padding(.top, 15)
                .padding(.bottom, 35)
                .foregroundColor(.accentColor)
            Text(item.plot!)
                .frame(maxWidth: .infinity)
                .padding()
            //                                .blur(radius: 30)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            //                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            Spacer()
        }
        .padding()
        .background(Image("book-and-coffee")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                FavoriteBookView(isSet: .constant(true))
            }
        }
    }
}


struct BookDetailView_Previews: PreviewProvider {
    static let persistence = PersistenceController.preview
    static var item: Item = {
        let context = persistence.container.viewContext
        let item = Item(context: context)
        item.title = "Nineteen Eighty-Four"
        item.author = "George Orwell"
        item.category = "Dystopia"
        item.year = 1949
        item.plot = "The book is set in 1984 in Oceania, one of three perpetually warring totalitarian states (the other two are Eurasia and Eastasia). Oceania is governed by the all-controlling Party, which has brainwashed the population into unthinking obedience to its leader, Big Brother."
        return item
    }()
    
    static var previews: some View {
        BookDetailView(item: item, isFavorite: true)
            .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}
