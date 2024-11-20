//
//  ItemDetailView.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

struct ItemDetailView: View {
    var size: CGSize
    var titleItemSize: CGSize
    var animation: Namespace.ID
    let item: Item
    var onDismiss: (() -> Void)?
    /// View Properties
    @State private var animateLayers: Bool = false
    @State private var scale: CGFloat = 1
    
    var drag: some Gesture {
        DragGesture()
            .onChanged({ value in
                if value.location.x < 100 {
                    scale = (UIScreen.main.bounds.width - value.location.x) / UIScreen.main.bounds.width
                }
                print(value.location.y)
                
                if value.location.y > 70 && value.location.y < 300 {
                    let scale2 = (UIScreen.main.bounds.height - (value.location.y - 70)) / UIScreen.main.bounds.height
                    scale = scale2
                }
            })
            .onEnded({ value in
                if scale < 0.9 {
                    withAnimation(noteAnimation) {
                        animateLayers = false
                    }
                    onDismiss?()
                    withAnimation {
                        scale = 1
                    }
                } else {
                    withAnimation {
                        scale = 1
                    }
                }
            })
    }
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .overlay(alignment: .topLeading) {
                TitleItemView(size: titleItemSize, item: item)
                    .blur(radius: animateLayers ? 200 : 0)
                    .opacity(animateLayers ? 0 : 1)
                    .clipShape(.rect(cornerRadius: 10))
            }
            .overlay(alignment: .topLeading) {
                if animateLayers {
                    HStack(spacing: 21) {
                        Button {
                            withAnimation(noteAnimation) {
                                animateLayers = false
                            }
                            onDismiss?()
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
                    .padding(.leading, 20)
                    .padding(.top, safeArea.top)
                    .zIndex(1)
                }
            }
            .overlay(alignment: .top) {
                content
                    .blur(radius: animateLayers ? 0 : 200)
                    .opacity(animateLayers ? 1 : 0)
                    .padding(.top, safeArea.top + 60)
                    .zIndex(0)
            }
            .clipShape(.rect(cornerRadius: animateLayers ? 0 : 10))
            .matchedGeometryEffect(id: item.id, in: animation)
            .transition(.offset(y: 1))
            .simultaneousGesture(drag)
            .animation(.smooth, value: scale)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(noteAnimation) {
                    animateLayers = true
                }
            }
    }
    
    var content: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(spacing: 16) {
                        item.image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 24))
                        
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
                    Divider()
                    
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
                
                Spacer()
            }
        }
        .scrollDisabled(true)
        .scrollClipDisabled()
        .safeAreaPadding(.horizontal, 10)
        .navigationBarBackButtonHidden()
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
}
