//
//  UserListViewModel.swift
//  ApiFetchingApp
//
//  Created by Mustafa Ertunç on 17.09.2025.
//


import Foundation

// ViewModel, arayüzün takip edeceği verileri tutar.
class UserListViewModel: ObservableObject {
    
    // @Published ile arayüzün bu değişkenleri takip etmesini sağlıyoruz.
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userService = UserService()
    
    // Bu fonksiyon, veriyi çekme işlemini başlatır.
    func fetchUsers() {
        // Yükleme durumunu başlat
        self.isLoading = true
        self.errorMessage = nil
        
        // Asenkron işlemi yönetmek için bir Task oluştur.
        Task {
            do {
                // Servis katmanından veriyi çek.
                let fetchedUsers = try await userService.fetchUsers()
                
                // Arayüzü ana iş parçacığında güncelle.
                await MainActor.run {
                    self.users = fetchedUsers
                    self.isLoading = false
                }
            } catch {
                // Hata durumunda arayüzü güncelle.
                await MainActor.run {
                    self.errorMessage = "An error occurred while loading data: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
}
