//
//  models.swift
//  DunyaKasifiCan
//
//  Created by Can Kıraç on 20.04.2025.
//

import Foundation

// MARK: - Veri Modelleri
struct CountryStamp: Identifiable {
    let id = UUID()
    let countryName: String
    let dateVisited: Date
    let stampImageName: String
}

struct Achievement: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
}

struct Badge: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
}

// Diğer yardımcı yapılar
struct AnimatedLogoView: View {
    var body: some View {
        Text("Dünya Kaşifi Akademisi")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct AvatarPreview: View {
    @Binding var avatar: UserSession.Avatar
    
    var body: some View {
        // Basit bir avatar önizleme
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
            
            Text("\(avatar.hairStyle) saç, \(avatar.eyeColor) gözler")
                .font(.caption)
        }
    }
}

// Diğer özel görünümler...
