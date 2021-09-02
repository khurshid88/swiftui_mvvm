//
//  HomeScreen.swift
//  swiftui_mvvm
//
//  Created by User on 2021/04/26.
//

import SwiftUI

//https://developer.apple.com/forums/thread/650449

struct HomeViewScreen: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showingEdit = false
    
    func delete(indexSet: IndexSet) {
        let post = viewModel.posts[indexSet.first!]
        viewModel.apiPostDelete(post: post, handler: {value in
            viewModel.apiPostList()
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.posts, id:\.self){ post in
                        PostCell(post: post).onLongPressGesture {
                            showingEdit.toggle()
                        }.sheet(isPresented: $showingEdit) {
                            EditViewScreen()
                        }
                    }
                    .onDelete(perform: delete)
                    
                }.listStyle(PlainListStyle())
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(leading:
                                    Button(action: {
                                        viewModel.apiPostList()
                                    }, label: {
                                        Image("ic_refresh")
                                    }), trailing:
                                        NavigationLink(
                                            destination: CreateViewScreen(),
                                            label: {
                                                Image("ic_add")
                                            })
            )
            .navigationBarTitle("SiftUI MVVM",displayMode: .inline)
        }.onAppear{
            viewModel.apiPostList()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewScreen()
    }
}
