//
//  UserListView.swift
//  ApiFetchingApp
//
//  Created by Mustafa Ertunç on 17.09.2025.
//


import SwiftUI

// UserListView, View-Model'ı kullanarak veriyi görüntüler.
struct UserListView: View {
    
    // View-Model'ı @StateObject ile başlatıyoruz.
    // Bu, View-Model'ın ömrünü bu View'e bağlar.
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Yükleme durumu
                if viewModel.isLoading {
                    ProgressView("Kullanıcılar Yükleniyor...")
                } 
                // Hata durumu
                else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } 
                // Veri başarılı bir şekilde yüklendiğinde
                else {
                    List {
                        ForEach(viewModel.users) { user in
                            // Her kullanıcı için kart tasarlıyoruz.
                            UserCardView(user: user)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Kullanıcılar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Listeleme butonunu toolbar'a ekliyoruz.
                    Button("Listele") {
                        viewModel.fetchUsers()
                    }
                }
            }
        }
        // İlk açılışta veriyi çek.
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

// Her bir kullanıcı için özel bir kart tasarımı
struct UserCardView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(user.name)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            HStack(spacing: 15) {
                VStack(alignment: .leading) {
                    Label("E-posta", systemImage: "envelope")
                        .foregroundColor(.gray)
                    Text(user.email)
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Label("Telefon", systemImage: "phone")
                        .foregroundColor(.gray)
                    Text(user.phone)
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.caption)
            
            Divider()
            
            VStack(alignment: .leading) {
                Label("Adres", systemImage: "house")
                    .foregroundColor(.gray)
                Text("\(user.address.street), \(user.address.suite)")
                    .font(.body)
                Text("\(user.address.city), \(user.address.zipcode)")
                    .font(.body)
            }
            .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
#Preview {
    UserListView()
}
