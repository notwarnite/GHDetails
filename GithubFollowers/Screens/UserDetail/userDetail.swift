//
//  userDetail.swift
//  GithubFollowers
//
//

import SwiftUI

struct userDetail: View {
    @State private var model = UserViewModel()
    @State var username: String
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    AsyncImage(url: URL(string: model.returendUser?.avatarUrl ?? "" )) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    Spacer()
                    
                    VStack{
                        Text(model.returendUser?.login ?? "<login>")
                        Text(model.returendUser?.name ?? "<name>")
                        
                        if ((model.returendUser?.location) != nil) {
                            Text(model.returendUser?.location ?? "<location>")
                        }
                    }
                    Spacer()
                }
                
                Divider()
                    .frame(height: 2)
                    .background(Color.green)
                
                if ((model.returendUser?.bio) != nil) {
                    
                    Text(model.returendUser?.bio ?? "<bio>")
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.green)
                }
                
                List {
                    HStack{
                        Label(
                            title: { Text("Repositories") },
                            icon: { Image(systemName: "folder") }
                        )
                        .foregroundColor(.green)
                        
                        Text(String(model.returendUser?.publicRepos ?? 0))
                            .foregroundColor(.green)
                        
                    }
                    
                    NavigationLink(destination: followerView(username: model.returendUser?.login ?? "")) {
                        HStack{
                            Label(
                                title: { Text("Followers") },
                                icon: { Image(systemName: "heart") }
                            )
                            Text(String(model.returendUser?.followers ?? 0))
                            
                        }
                        .foregroundColor(.green)
                    }
                    
                    NavigationLink(destination: followingView(username: model.returendUser?.login ?? "")) {
                        HStack{
                            Label(
                                title: { Text("Following") },
                                icon: { Image(systemName: "person.2") }
                            )
                            Text(String(model.returendUser?.following ?? 0))
                            
                        }
                        .foregroundColor(.green)
                    }
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
                
            }
            .navigationBarBackButtonHidden(true)
            .accentColor(.green)
            .redacted(reason: model.isLoading ? .placeholder : [])
            .padding()
            .task {
                model.fetchUserDetails2(username: username)
            }
        }
        
    }
}

#Preview {
    userDetail(username: "notwarnite")
}
