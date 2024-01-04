//
//  followerViewModel.swift
//  GithubFollowers
//
//

import Foundation

@Observable
class FollowerViewModel {
    var followers: [dataFollower] = []
    var page = 1
    var returendUser: dataUser?
    var isLoading = false
    
    func fetchFollowers(username: String) {
            isLoading = true
            NetworkManager.shared.fetchFollowersOrFollowing(username: username, isFollowers: true, page: page) { result in
                switch result {
                case .success(let followers):
                    self.followers.append(contentsOf: followers)
                case .failure(let error):
                    print("Error fetching followers: \(error.localizedDescription)")
                }
                self.isLoading = false
            }
        }
}
