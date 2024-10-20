import SwiftUI
import UIKit

// ImagePicker for photo upload
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// Main page2 View
struct page2: View {
    @State private var showPopover = false
    @State private var ingredientName = ""
    @State private var recipeImage: UIImage?
    @State private var showImagePicker = false
    @State private var selectedMeasurement: String = ""
    @State private var quantity: Int = 1
    @State private var ingredients: [(name: String, measurement: String, quantity: Int)] = []

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {

                        // Rectangle for photo upload
                        ZStack {
                            if let image = recipeImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 150)
                                    .clipped()
                            } else {
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 3]))
                                    .foregroundColor(Color(hex: "#FB6112"))
                                    .frame(width: 413, height: 181) // Reduced height
                                    .foregroundColor(Color(hue: 1.0, saturation: 0.04, brightness: 0.234))
                                    .background(Color(hex: "#E4E4E5"))
                                VStack {
                                    Image(systemName: "photo.badge.plus")
                                        .resizable()
                                        .frame(width: 85, height: 71)
                                        .foregroundColor(Color(hex: "#FB6112"))
                                    
                                    Text("Upload Photo")
                                        .fontWeight(.bold)
                                }
                                .onTapGesture {
                                    showImagePicker.toggle() // Show image picker on tap
                                }
                            }
                        }

                        // Title and Description TextFields
                        Text("Title")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.trailing, 310.0)
                        TextField("Title", text: .constant(""))
                            .padding(.all, 9)
                            .frame(height: 45.0)
                            .background(Color(hex: "#E4E4E5"))
                            .cornerRadius(8)

                        Text("Description")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.trailing, 250.0)
                        TextField("Description", text: .constant(""))
                            .padding(.all, 10)
                            .frame(height: 100)
                            .background(Color(hex: "#E4E4E5"))
                            .cornerRadius(8)

                        // Add Ingredient Button
                        HStack {
                            Text("Add Ingredient")
                                .font(.title2)
                                .fontWeight(.bold)

                            Button(action: {
                                showPopover.toggle()
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color(hex: "#FB6112"))
                            }
                            .padding(.leading, 150.0)
                        }

                        // List of Ingredients
                        ForEach(ingredients, id: \.name) { ingredient in
                            ZStack {
                                Rectangle()
                                    .frame(width: 368, height: 52)
                                    .cornerRadius(8)
                                    .foregroundColor(Color(hex: "#E4E4E5"))
                                HStack {
                                    Text("\(ingredient.quantity) \(ingredient.name)")
                                        .padding(.leading, 30)
                                    Spacer()
                                    Button(ingredient.measurement == "Spoon" ? "🥄" : "🥛") {
                                        // Action when the measurement button is clicked
                                    }
                                    .font(.title3)
                                    .frame(width: 60, height: 30)
                                    .background(Color(hex: "#FB6112"))
                                    .opacity(0.8)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .padding(.trailing, 30)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    .padding()
                    .edgesIgnoringSafeArea(.all)
                }

                // Image Picker
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $recipeImage)
                }

                // Popover for adding ingredients
                if showPopover {
                    Color.black.opacity(0.4) // Background dimming
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showPopover = false // Dismiss popover on tap
                        }

                    VStack(spacing: 10) {
                        Text("Ingredient Name")
                            .font(.title3)
                            .fontWeight(.bold)
                        TextField("Ingredient Name", text: $ingredientName)
                            .frame(width: 275.0, height: 39.0)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 10)

                        Text("Measurement")
                            .font(.title3)
                            .fontWeight(.bold)

                        HStack {
                            Button("🥄 Spoon") {
                                selectedMeasurement = "Spoon"
                            }
                            .font(.title3)
                            .frame(width: 130, height: 40)
                            .background(Color(hex: "#FB6112"))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(8)

                            Button("🥛 Cup") {
                                selectedMeasurement = "Cup"
                            }
                            .font(.title3)
                            .frame(width: 130, height: 40)
                            .background(Color(hex: "#FB6112"))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(8)
                        }
                        .padding(.bottom, 10)

                        // Show Stepper for Quantity Selection
                        Text("Quantity for \(selectedMeasurement)")
                            .font(.title3)
                            .fontWeight(.bold)

                        Stepper(value: $quantity, in: 1...10) {
                            Text("\(quantity)")
                        }
                        .padding(.bottom, 10)

                        HStack {
                            Button("Cancel") {
                                showPopover = false // Dismiss on Cancel
                            }
                            .font(.title3)
                            .frame(width: 130, height: 40)
                            .background(Color(hex: "#3B3B3D"))
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .cornerRadius(8)

                            Button("Add") {
                                if !ingredientName.isEmpty && quantity > 0 {
                                    ingredients.append((name: ingredientName, measurement: selectedMeasurement, quantity: quantity))
                                    ingredientName = "" // Clear the ingredient name
                                    quantity = 1 // Reset the quantity
                                    selectedMeasurement = "" // Clear the measurement
                                    showPopover = false // Dismiss on Add
                                }
                            }
                            .font(.title3)
                            .frame(width: 130, height: 40)
                            .background(Color(hex: "#FB6112"))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                    .frame(width: 306, height: 400) // Increased height for stepper
                    .background(Color(hex: "#E4E4E5"))
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .transition(.scale)
                    .animation(.easeInOut)
                }
            }
            .navigationTitle("New Recipe") // Set the title of the navigation bar
        }
    }
}

#Preview {
    page2()
}
