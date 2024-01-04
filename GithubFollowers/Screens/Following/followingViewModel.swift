//
//  followingViewModel.swift
//  GithubFollowers
//
//

import Foundation

@Observable
class FollowingViewModel {
    var following: [dataFollower] = []
    var page = 1
    var isLoading = false
    var returendUser: dataUser?
    
    func fetchFollowing(username: String) {
        isLoading = true
        NetworkManager.shared.fetchFollowersOrFollowing(username: username, isFollowers: false, page: page) { result in
            switch result {
            case .success(let followings):
                self.following.append(contentsOf: followings)
            case .failure(let error):
                print("Error fetching followings: \(error.localizedDescription)")
            }
            self.isLoading = false
        }
    }
}
