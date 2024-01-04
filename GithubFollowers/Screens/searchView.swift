//
//  searchView.swift
//  GithubFollowers
//
//

import SwiftUI

struct searchView: View {
    @State var searchUser = ""
    var body: some View {
        NavigationView{
            VStack {
                Image("gh-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom)
                
                TextField("Enter Username", text: $searchUser)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                VStack {
                    NavigationLink(destination: userDetail(username: searchUser)) {
                        VStack{
                            Text("SEARCH")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 350 ,height: 40)
                                .background(.green)
                                .cornerRadius(10)
                        }
                    }
                }
                
                
                
            }
        }
    }
}

#Preview {
    searchView()
}
