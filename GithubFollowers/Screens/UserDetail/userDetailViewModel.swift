//
//  userDetailViewModel.swift
//  GithubFollowers
//
//

import Foundation

@Observable
class UserViewModel {
    
    var returendUser: dataUser? = nil
    var isLoading = false
    
    func fetchUserDetails2(username: String) {
            isLoading = true
            NetworkManager.shared.fetchUserDetails(username: username) { result in
                switch result {
                case .success(let user):
                    self.returendUser = user
                case .failure(let error):
                    print("Error fetching user details: \(error.localizedDescription)")
                }
                self.isLoading = false
            }
        }
    }

    

