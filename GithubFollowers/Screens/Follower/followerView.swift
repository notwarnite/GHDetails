//
//  followerView.swift
//  GithubFollowers
//
//

import SwiftUI

struct followerView: View {
    @State private var model = FollowerViewModel()
    @State var username: String
    @State var showUser = false
    @State var selectedUser: String? = nil
    
    let layout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical){
                    LazyVGrid(columns: layout) {
                        ForEach(model.followers, id: \.self) { follower in
                            Button(action: {
                                selectedUser = follower.login
                                showUser.toggle()
                            }){
                                VStack(spacing: 20){
                                    AsyncImage(url: URL(string: follower.avatarUrl )) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 95, height: 95)
                                    .clipShape(Circle())
                                    
                                    Text(follower.login)
                                        .lineLimit(1)
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            .padding()
            .accentColor(.green)
            .redacted(reason: model.isLoading ? .placeholder : [])

            .onChange(of: selectedUser) {
                showUser = true
            }
            .sheet(isPresented: $showUser) {
                userDetail(username: selectedUser ?? "")
                    .accentColor(.green)
            }
            .overlay{
                if model.followers.isEmpty{
                    ContentUnavailableView(label: {
                        Label("User: \(username)\n0 followers", systemImage: "person.slash")
                    })
                    .offset(y: -40)
                }
            }
            .task {
                 model.fetchFollowers(username: username)
            }
            .refreshable {
                 model.fetchFollowers(username: username)
            }
        }
    }
}

#Preview {
    followerView(username: "SAllen0400")
}
