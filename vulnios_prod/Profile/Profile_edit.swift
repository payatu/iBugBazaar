
//  Profile_edit.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 05/05/23.
//
import SwiftUI
import UIKit
import MobileCoreServices

struct Profile_edit: View {
    @State private var username = ""
     @State private var showImagePicker = false
     @State private var selectedImage: UIImage? = nil
     @State private var selectedFileURL: URL? = nil // Add this line
     @StateObject var vm = viewModel()
    @State private var isProfileSaved = false

    func saveImageToUserDefaults(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }
    }

    func saveFile() {
        guard let fileURL = selectedFileURL else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            selectedImage = UIImage(data: data)
        } catch {
            print("Error loading image data: \(error)")
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                } else {
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage, selectedFileURL: $selectedFileURL)
                    }
                }

                TextField("Username", text: $username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                    .shadow(radius: 3)
                    .padding(.horizontal)

                Button(action: {
                    if let uiImage = selectedImage {
                        saveImageToUserDefaults(image: uiImage)
                        vm.currentuser.profileImage = uiImage
                    }
                    saveFile()
                    vm.currentuser.username = username
                }) {
                    Text("Save Changes")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                        .shadow(radius: 3)
                }

                .padding()
            }
            .padding()
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Back") {})
        }
    }
}

struct Profile_edit_Previews: PreviewProvider {
    static var previews: some View {
        Profile_edit()
    }
}





// ImagePicker.swift (Create a new file for this)

import SwiftUI
import UIKit
import MobileCoreServices

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var selectedFileURL: URL?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeHTML as String] // Allow JPG, PNG, and HTML files
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            if let fileURL = info[.imageURL] as? URL {
                parent.selectedFileURL = fileURL
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
