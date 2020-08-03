//
//  ContentView.swift
//  SearchFlow
//
//  Created by 罗博 on 2020/8/2.
//  Copyright © 2020 罗博. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Text("Search")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.leading, 20.0)
                Spacer()
            }
            SearchBar()
                .padding(.horizontal, 10.0)
            
            List {
                /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar.init()
        searchBar.placeholder = "Tap here to search"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
