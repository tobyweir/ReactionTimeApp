//
//  ProfileEditorView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 27/08/2025.
//

import SwiftUI
import PhotosUI

struct ProfileEditorView: View {
    let model: Controller
    @State private var avatarItem: PhotosPickerItem?
    @State var displayPhotosPicker: Bool = false
    @Binding var avatarImage: Image?
    @Binding var username: String

    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .padding(.horizontal)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.vertical)
            HStack {
                Spacer()
                Button {
                    displayPhotosPicker = true
                } label: {
                    Label("Edit", systemImage: "photo.badge.plus.fill")
                }
                Spacer()
            }

            ZStack {
                profilePictureView
                    .onTapGesture {
                        displayPhotosPicker = true
                    }
                avatarImage?

                    .resizable()
            }
                    .frame(width: 200, height: 200)
            Form {
                Section {
                    TextField("Username" , text: $username)
                }
            }
            .photosPicker(isPresented: $displayPhotosPicker, selection: $avatarItem)
            .photosPickerStyle(.presentation)
            .scrollDisabled(true)
            .formStyle(.automatic)

                }
        .onChange(of: username) {
            model.resultStore.saveUsernameToFile(username: username)
        }
        .onChange(of: avatarItem) {
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                    avatarImage = loaded
                    model.resultStore.saveImageToFile(image: avatarImage!)
                } else {
                    print("Failed")
                }
            }
        }
    }

    var profilePictureView: some View {
        HStack {
            Spacer()
            ZStack{
                Color.gray
                    .frame(maxWidth: 200, maxHeight: 200)
                    .aspectRatio(1 , contentMode: .fit)
                Text("?").bold().font(.title)
            }
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var image: Image?
    @Previewable @State var username: String = ""
    ProfileEditorView(model: Controller(), avatarImage: $image, username: $username)
}
