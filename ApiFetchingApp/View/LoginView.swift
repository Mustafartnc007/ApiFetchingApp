//
//  LoginView.swift
//  ApiFetchingApp
//
//  Created by Mustafa Ertunç on 17.09.2025.
//


import SwiftUI

// Navigasyon için hashable bir enum tanımlıyoruz.
// Hangi ekranlara geçiş yapılacağını bu enum ile belirliyoruz.
enum AppNavigationPath: Hashable {
    case userList
}

// LoginView, giriş işlemini ve navigasyonu yönetir.
struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    // Navigasyon yığınını yönetmek için bir dizi oluşturuyoruz.
    @State private var path = NavigationPath()
    
    // Uygulama içinde tanımlı olan kullanıcı bilgileri
    private let validUsername = "mustafa"
    private let validPassword = "mustafatest123"
    
    var body: some View {
        // Yeni navigasyon mimarisi: NavigationStack
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Hoş Geldiniz!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Kullanıcı adı ve şifre alanları
                TextField("Kullanıcı Adı", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                SecureField("Şifre", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                // Giriş butonu
                Button("Giriş Yap") {
                    // Kullanıcı girişini doğrula
                    if username == validUsername && password == validPassword {
                        // Yeni navigasyon yapısı: Yığına bir değer ekle.
                        // Bu, otomatik olarak navigationDestination'ı tetikler.
                        path.append(AppNavigationPath.userList)
                    } else {
                        // Hatalı giriş durumunda basit bir uyarı verebiliriz.
                        print("Hatalı kullanıcı adı veya şifre!")
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Giriş")
            // Hatanın çözümü burada: Yığına eklenen değere göre yönlendirme yap.
            .navigationDestination(for: AppNavigationPath.self) { path in
                switch path {
                case .userList:
                    UserListView()
                }
            }
        }
    }
}
#Preview {
    LoginView()
}
