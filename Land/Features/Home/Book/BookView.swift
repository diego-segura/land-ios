//
//  BookView.swift
//  Land
//
//  Created by Luka Vujnovac on 27.11.2024..
//

import SwiftUI

struct BookView: View {
    
    private let userImage: UIImage?
    
    @Namespace private var animation
    @StateObject private var viewModel: BookViewModel
    
    init(viewModel: @autoclosure @escaping () -> BookViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
        userImage = UIImage(data: LocalStorage.userProfile?.imageData ?? Data())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 67) {
                
                infoSection
                
                LazyVGrid(columns: [.init(spacing: 5, alignment: .top), .init(spacing: 5, alignment: .top)]) {
                    LazyVStack(spacing: 5) {
                        addButton
                        ForEach(viewModel.state.items[0]) { item in
                            itemView(item: item)
                        }
                    }
                    LazyVStack(spacing: 5) {
                        ForEach(viewModel.state.items[1]) { item in
                            itemView(item: item)
                        }
                        Spacer()
                    }
                }
                .safeAreaPadding(.horizontal, 10)
            }
        }
        .safeAreaPadding(.top, 20)
        .safeAreaInset(edge: .top) {
            HStack {
                Button {
                    viewModel.trigger(.onPop)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18))
                        .foregroundStyle(.black)
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("edit info")
                        .font(.standard(size: 14, weight: 360))
                        .frame(height: .heightForFontSize(size: 18))
                        .foregroundStyle(Color.custom(hex: "999999"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 2.5)
                }
                .fixedSize()
                .buttonStyle(.standard)
                .clipShape(.capsule)
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
            .background(.white)
        }
        .navigationBarBackButtonHidden()
        .blur(radius: viewModel.state.expandSheet ? 3.5 : 0)
        .overlay {
            if let selectedItem = viewModel.state.selectedItem, viewModel.state.expandSheet {
                ItemView(expandSheet: $viewModel.state.expandSheet, animation: animation, item: selectedItem)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        .onAppear {
            viewModel.trigger(.onAppear)
        }
        .onDisappear {
            viewModel.trigger(.onDisappear)
        }
    }
    
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("camera roll")
                .font(.standard(size: 24, weight: 310))
                .foregroundStyle(.black)
            HStack(spacing: 6) {
                if let userImage {
                    Image(uiImage: userImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .clipShape(.circle)
                }
                Text("messybirkin")
                    .font(.standard(size: 14, weight: 360))
                    .foregroundStyle(Color.custom(hex: "999999"))
            }
            
            HStack(spacing: 8) {
                Image(systemName: "square.3.layers.3d.down.left")
                    .font(.system(size: 14))
                Text("\(viewModel.state.items[0].count + viewModel.state.items[1].count) entries")
                    .font(.standard(size: 14, weight: 360))
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 14))
                Text("updated 10 secs ago")
                    .font(.standard(size: 14, weight: 360))
            }
            .foregroundStyle(Color.custom(hex: "999999"))
        }
        .padding(.horizontal, 50)
    }
    
    var addButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("add entries")
                    .font(.standard(size: 16, weight: 310))
                    .frame(height: .heightForFontSize(size: 20))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "plus")
                    .font(.system(size: 16, design: .rounded))
            }
            .padding(.vertical, 3)
            .padding(.horizontal, 20)
        }
        .buttonStyle(.standard)
        .clipShape(.capsule)
    }
    
    func itemView(item: Item) -> some View {
        ZStack {
            if viewModel.state.expandSheet {
                GeometryReader {
                    let size = $0.size
                    
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(.rect(cornerRadius: 24))
                }
                .transition(.blurReplace)
                .opacity(item.id == viewModel.state.selectedItem?.id ? 0 : 1)
            } else {
                ItemCellView(expandSheet: $viewModel.state.expandSheet, animation: animation, item: item)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.3)) {
                            viewModel.state.selectedItem = item
                            viewModel.state.expandSheet = true
                        }
                    }
                    .matchedGeometryEffect(id: item.id + "BGVIEW", in: animation)
            }
        }
//        .frame(height: 245)
    }
}

#Preview {
    NavigationStack {
        BookView(viewModel: BookViewModel())
    }
}

private struct GridItemView: View {
    
    let item: Item
    
    var body: some View {
        VStack(spacing: 5) {
            item.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 24))
        }
    }
}
