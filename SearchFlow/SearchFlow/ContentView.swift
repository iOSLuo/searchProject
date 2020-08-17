//
//  ContentView.swift
//  SearchFlow
//
//  Created by 罗博 on 2020/8/2.
//  Copyright © 2020 罗博. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    /// 是否隐藏头部视图
    @State var showTop = true
    
    var body: some View {
        VStack(spacing: 0.0) {
            if showTop {
                HStack {
                    Text("Search")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.leading, 15.0)
                    Spacer()
                }
            }
            SearchBar(showTop: $showTop)
                .padding(.horizontal, 5.0)
            
            List {
                /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
            .onTapGesture {
                SearchBar(showTop: self.$showTop).showTopView()
                self.hiddenKeyboard()
            }
        }
        .background(Color(hex: 0xF9F9F9).edgesIgnoringSafeArea(.all))
    }
    
    // MARK: - 隐藏键盘
    private func hiddenKeyboard() {
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        keyWindow?.endEditing(true)
    }
}

// MARK: - 自定义搜索框
struct SearchBar: UIViewRepresentable {
    @Binding var showTop: Bool
    typealias UIViewType = UISearchBar
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar.init()
        searchBar.placeholder = "Tap here to search"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
    
    /// 显示头部视图动画效果
    func showTopView() {
        withAnimation(.easeIn(duration: 0.35)) {
            showTop = true
        }
    }
    
    class Cordinator: NSObject, UISearchBarDelegate {
        @Binding var showTop: Bool
        init(showTop: Binding<Bool>) {
            _showTop = showTop
        }
        
        // MARK: - UISearchBarDelegate
        /// 开始编辑隐藏头部视图
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            withAnimation(.easeOut(duration: 0.35)) {
                showTop = false
            }
        }
        /// 输入文本获取搜索结果
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
        }
    }
    
    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(showTop: $showTop)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - 自定义16进制色值
extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
