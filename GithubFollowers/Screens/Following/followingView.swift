//
//  followingView.swift
//  GithubFollowers
//
//

import SwiftUI

struct followingView: View {
    @State private var model = FollowingViewModel()
    @State var username: String
    
    let layout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
            VStack{
                ScrollView(.vertical){
                    LazyVGrid(columns: layout) {
                        ForEach(model.following, id: \.self) { following in
                            NavigationLink( destination: userDetail(username: following.login )) {
                                VStack(spacing: 20){
                                    AsyncImage(url: URL(string: following.avatarUrl )) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 95, height: 95)
                                    .clipShape(Circle())
                                    
                                    Text(following.login)
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
            .overlay{
                if model.following.isEmpty{
                    ContentUnavailableView(label: {
                        Label("User : \(username)\n0 following", systemImage: "person.slash")
                    })
                    .offset(y: -40)
                }
            }
            .task {
                 model.fetchFollowing(username: username)
            }
    }
}

#Preview {
    followingView(username: "SAllen0400")
}
