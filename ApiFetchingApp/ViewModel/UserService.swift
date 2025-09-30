//
//  UserService.swift
//  ApiFetchingApp
//
//  Created by Mustafa Ertunç on 17.09.2025.
//


import Foundation

// API URL'ini bir sabit olarak tanımlıyoruz.
let apiURL = "https://jsonplaceholder.typicode.com/users"

// UserService sınıfı, API'den veri çekmekten sorumlu olacak.
class UserService {
    
    // Asenkron bir fonksiyon tanımlıyoruz.
    func fetchUsers() async throws -> [User] {
        
        // 1. URL'i oluştur ve doğruluğunu kontrol et.
        guard let url = URL(string: apiURL) else {
            throw NSError(domain: "UserServiceError", code: 100, userInfo: [NSLocalizedDescriptionKey: "Geçersiz URL"])
        }
        
        // 2. URLSession ile veri çekme işlemini başlat.
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // 3. Gelen JSON verisini 'User' struct dizisine dönüştür.
        let users = try JSONDecoder().decode([User].self, from: data)
        
        // 4. Dönüştürülen veriyi döndür.
        return users
    }
}