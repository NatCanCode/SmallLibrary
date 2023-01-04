//
//  FavoriteBookView.swift
//  SmallLibrary
//
//  Created by N N on 03/01/2023.
//

import SwiftUI

struct FavoriteBookView: View {
    //  isSet indicates the button current state and provides a constant value for the preview. @Binding propagates the changes made inside this view back to the data source.
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle favorite", systemImage: isSet  ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .accentColor : .gray)
        }
    }
}


struct FavoriteBookView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteBookView(isSet: .constant(true))
    }
}
