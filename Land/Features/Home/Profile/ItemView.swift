//
//  ExpandedBottomSheet.swift
//  Land
//
//  Created by Luka Vujnovac on 21.11.2024..
//

import SwiftUI

struct ItemView: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    /// View Properties
    @State private var animateContent: Bool = false
    @State private var offsetY: CGFloat = 0
    
    let item: Item
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            let dragProgress = 1.0 - (offsetY / (size.height * 0.6))
            let cornerProgress = max(0, dragProgress)
            
            ZStack {
                RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius * cornerProgress : 0, style: .continuous)
                    .fill(.clear)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: animateContent ? deviceCornerRadius * cornerProgress : 0, style: .continuous)
                            .fill(.white)
                            .opacity(animateContent ? 1 : 0)
                            .shadow(color: .black.opacity(0.2), radius: 30, x: 5, y: -10)
                    })
                    .overlay(alignment: .top) {
                        ItemCellView(expandSheet: $expandSheet, animation: animation, item: item)
                            .allowsHitTesting(false)
                            .opacity(animateContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: item.id + "BGVIEW", in: animation)
                    .opacity(animateContent ? cornerProgress : 0)
                
                VStack(spacing: 15) {
                    HStack(spacing: 21) {
                        Button {
                            withAnimation(.smooth(duration: 0.3)) {
                                expandSheet = false
                                animateContent = false
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 23))
                                .foregroundStyle(.black)
                        }
                        
                        HStack(spacing: 2) {
                            Text(title1 + title2)
                            Image(systemName: "arrow.down")
                                .font(.system(size: 9, weight: .light))
                                .foregroundStyle(.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .opacity(animateContent ? cornerProgress : 0)
                    .offset(y: animateContent ? 0 : size.height)
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        imageContent
                            .frame(height: size.width - 50)
                            .padding(.top, size.height < 700 ? 10 : 30)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 14) {
                                buttonsSection
                                Divider()
                            }
                            VStack(alignment: .leading, spacing: 12) {
                                Text("april 3, 2024")
                                    .font(.standard(size: 12, weight: 360))
                                    .foregroundStyle(.black)
                                    .kerning(-0.12)
                                
                                Text(username + " " + comment)
                                
                                Text("comments")
                                    .font(.standard(size: 12, weight: 360))
                                    .foregroundStyle(.black)
                                    .kerning(-0.12)
                            }
                        }
                        .offset(y: animateContent ? 0 : size.height)
                        .opacity(animateContent ? cornerProgress : 0)
                    }
                    .padding(.horizontal, 10)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .contentShape(.rect)
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translationY = value.translation.height
                        offsetY = (translationY > 0 ? translationY : 0)
                        
                    }).onEnded({ value in
                        withAnimation(.smooth(duration: 0.3)) {
                            if (offsetY + (value.velocity.height * 0.3)) > size.height * 0.2 {
                                expandSheet = false
                                animateContent = false
                            } else {
                                offsetY = .zero
                            }
                        }
                    })
            )
            .ignoresSafeArea(.container, edges: .all)
            .allowsTightening(!animateContent)
        }
        .onAppear {
            withAnimation(.smooth(duration: 0.3)) {
                animateContent = true
            }
        }
    }
    
    var imageContent: some View {
        GeometryReader {
            let size = $0.size
            
            item.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipShape(.rect(cornerRadius: 24))
        }
        .matchedGeometryEffect(id: item.id + "ARTWORK", in: animation)
    }
    
    func actionButton(imageName: String, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: imageName)
                .font(.system(size: 22))
                .foregroundStyle(Color.custom(hex: "666666"))
            
            Text(text)
                .font(.standard(size: 12, weight: 360))
                .kerning(-0.12)
                .foregroundStyle(Color.custom(hex: "666666"))
        }
        .contentShape(.capsule)
    }
    
    var username: AttributedString {
        var result = AttributedString(item.title)
        result.font = .standard(size: 12, weight: 480)
        result.foregroundColor = .black
        result.font = result.font?.weight(.medium)
        result.kern = -0.12
        return result
    }
    
    var comment: AttributedString {
        var result = AttributedString(item.description)
        result.font = .standard(size: 12, weight: 360)
        result.foregroundColor = .black
        result.kern = -0.12
        return result
    }
    
    var title1: AttributedString {
        var result = AttributedString("in")
        result.font = .standard(size: 11, weight: 472)
        result.foregroundColor = .custom(hex: "666666")
        result.kern = -0.11
        return result
    }
    
    var title2: AttributedString {
        var result = AttributedString(" Letters to remember")
        result.font = .standard(size: 11, weight: 472)
        result.foregroundColor = .black
        result.kern = -0.11
        return result
    }
    
    var buttonsSection: some View {
        HStack {
            HStack(spacing: 26) {
                Button {
                    
                } label: {
                    actionButton(imageName: "square.3.layers.3d.down.forward", text: "101")
                }
                
                Button {
                    
                } label: {
                    actionButton(imageName: "text.bubble", text: "101")
                }
            }
            .padding(.leading, 19)
            .padding(.trailing, 24)
            .padding(.top, 9)
            .padding(.bottom, 11)
            .background(Color.custom(hex: "F0F0F0"), in: .capsule)
            
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "bookmark")
                    .font(.system(size: 22))
                    .foregroundStyle(.black)
                    .padding(15)
                    .background(Color.custom(hex: "F0F0F0"), in: .circle)
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var animation
    ItemView(expandSheet: .constant(true), animation: animation, item: sampleImages.first!)
}
