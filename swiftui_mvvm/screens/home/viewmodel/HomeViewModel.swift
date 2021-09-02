//
//  HomeViewModel.swift
//  swiftui_mvvm
//
//  Created by User on 2021/04/26.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    
    @Published var posts = [Post]()
    @Published var post = Post()

    func apiPostList(){
        isLoading = true
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.isLoading = false
            
            switch response.result {
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.posts =  posts
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiPostSingle(id: Int){
        isLoading = true
        AFHttp.get(url: AFHttp.API_POST_SINGLE + String(id), params: AFHttp.paramsEmpty(), handler: {response in
            self.isLoading = false
            
            switch response.result {
            case .success:
                let post = try! JSONDecoder().decode(Post.self, from: response.data!)
                self.post = post
            case let .failure(error):
                print(error)
            }
        })
    }
    
    func apiPostCreate(post:Post,handler: @escaping (Bool) -> Void){
        isLoading = true
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: {response in
            self.isLoading = false
            
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
    
    func apiPostUpdate(post:Post,handler: @escaping (Bool) -> Void){
        isLoading = true
        AFHttp.put(url: AFHttp.API_POST_UPDATE + String(post.id!), params: AFHttp.paramsPostUpdate(post: post), handler: {response in
            self.isLoading = false
            
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
    
    func apiPostDelete(post:Post,handler: @escaping (Bool) -> Void){
        isLoading = true
        AFHttp.del(url: AFHttp.API_POST_DELETE + String(post.id!), params: AFHttp.paramsEmpty(), handler: {response in
            self.isLoading = false
            
            switch response.result {
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                print(error)
                handler(false)
            }
        })
    }
    
}
