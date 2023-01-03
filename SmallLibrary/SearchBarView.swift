//
//  SearchBarView.swift
//  SmallLibrary
//
//  Created by N N on 03/01/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var searchText = ""
    
    var body: some View {
            NavigationStack {
                Text("Searching for \(searchText)")
//                    .navigationTitle("Searchable Example")
            }
            .searchable(text: $searchText, prompt: "Look for something")
        }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
