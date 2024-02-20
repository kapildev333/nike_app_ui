//
//  ContentView.swift
//  nike_app
//
//  Created by Kapil Soni on 2024-02-19.
//

import SwiftUI

struct ShoppingPage: View {
    @State private var cartCount = 0 // State variable to keep track of cart count
    @State private var selectedImageIndex = 0 // State variable to keep track of selected image index
    
    let productImages = ["nike1", "nike2", "nike3"] // Array of product images
    let shoeColor = Color.blue // Example color, replace with actual color of the shoes
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Background color
            
            VStack {
                // App Bar
                AppBar(cartCount: $cartCount)
                
                // Product Slider
                ProductSlider(images: productImages, selectedIndex: $selectedImageIndex)
                
                // Product Details
                VStack(alignment: .leading, spacing: 16) {
                    Text("Nike Shoe") // Product name
                        .font(.title)
                        .foregroundColor(Color.black)
                    
                    Text("$100") // Product price
                        .font(.headline)
                        .foregroundColor(Color.gray)
                    
                    HStack {
                        ForEach(0..<5) { index in
                            Image(systemName: index < 4 ? "star.fill" : "star.leadinghalf.fill") // Star rating
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(index < 4 ? Color.yellow : Color.gray)
                        }
                    }
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, magna at dapibus fringilla, magna risus eleifend felis.") // Product description
                        .foregroundColor(Color.gray)
                        .lineLimit(3)
                        .font(.body)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20) // Rounded rectangle background for product details
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: 4) // Shadow effect
                )
                .padding()
                
                // Add to Cart Button
                Button(action: {
                    self.cartCount += 1 // Increment cart count when button is tapped
                }) {
                    Text("Add to Cart") // Button text
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(shoeColor) // Background color based on shoe color
                        .cornerRadius(10) // Rounded corners
                        .padding(.horizontal, 20)
                }
                .padding()
                
                Spacer() // Spacer to push content to the top
            }
        }
    }
}

struct AppBar: View {
    @Binding var cartCount: Int // Binding for cart count
    
    var body: some View {
        HStack {
            Button(action: {
                // Handle navigation or menu toggle action
            }) {
                Image(systemName: "line.horizontal.3") // Menu icon
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()
            
            Spacer() // Spacer to push content to the sides
            
            Text("Shop") // Title of the app
                .font(.title)
                .bold() // Making the text bold
                .foregroundColor(.black)
            
            Spacer() // Spacer to push content to the sides
            
            Button(action: {
                // Handle cart action
            }) {
                Image(systemName: "cart") // Cart icon
                    .font(.title)
                    .foregroundColor(.black)
            }
            .badge(count: cartCount) // Badge with cart count
        }
        .padding() // Padding for the entire app bar
    }
}

struct ProductSlider: View {
    let images: [String] // Array of product images
    @Binding var selectedIndex: Int // Binding for selected image index
    
    var body: some View {
        VStack {
            TabView(selection: $selectedIndex) { // TabView for displaying images
                ForEach(0..<images.count) { index in
                    Image(images[index]) // Image from the array
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 300) // Fixed height for the image slider
            .padding(.horizontal)
            
            PageControl(numberOfPages: images.count, currentPage: $selectedIndex) // Page control to indicate current image
                .padding(.top, -20)
        }
    }
}

struct PageControl: View {
    let numberOfPages: Int // Total number of pages (images)
    @Binding var currentPage: Int // Binding for current page index
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages) { index in
                Circle()
                    .frame(width: 8, height: 8) // Circle indicator
                    .foregroundColor(index == currentPage ? Color.blue : Color.gray) // Highlight current page
            }
        }
        .padding(.bottom, 10) // Padding for the page control
    }
}

extension View {
    func badge(count: Int) -> some View {
        self.overlay(
            ZStack {
                if count > 0 {
                    Circle() // Badge background
                        .fill(Color.red)
                        .frame(width: 20, height: 20)
                        .offset(x: 15, y: -10)
                    
                    Text("\(count)") // Badge text with count
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(x: 15, y: -10)
                }
            }
        )
    }
}

struct ShoppingPage_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingPage()
    }
}
