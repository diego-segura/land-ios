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
                        ForEach(viewModel.state.items[1]) { item in
                            itemView(item: item)
                        }
                    }
                    LazyVStack(spacing: 5) {
                        ForEach(viewModel.state.items[0]) { item in
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
                switch selectedItem {
                case .image(let image):
                    ItemView(
                        expandSheet: $viewModel.state.expandSheet,
                        animation: animation,
                        item: image,
                        book: viewModel.state.book
                    )
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
                case .text(let text):
                    Text(text.text)
                case .link:
                    EmptyView()
                }
            }
        }
        .onAppear {
            viewModel.trigger(.onAppear)
        }
    }
    
    var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.state.book.name)
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
                Text(LocalStorage.userProfile?.username ?? "")
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
                Text("updated \(viewModel.state.lastUpdated)")
                    .font(.standard(size: 14, weight: 360))
            }
            .foregroundStyle(Color.custom(hex: "999999"))
        }
        .padding(.horizontal, 50)
    }
    
    var addButton: some View {
        Button {
            viewModel.trigger(.onAdd)
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
    
    @ViewBuilder
    func itemView(item: GridItem) -> some View {
        switch item {
        case .image(let image):
            imageView(item: image)
            
        case .text(let text):
            textView(item: text)
            
        case .link:
            Text("link")
        }
    }
    
    func textView(item: TextGridItem) -> some View {
        Text(item.text)
            .lineLimit(8)
            .font(.standard(size: 12, weight: 360))
            .padding(17)
            .frame(maxWidth: .infinity)
            .background(Color.custom(hex: "f2f2f2"), in: .rect(cornerRadius: 24))
    }
    
    func imageView(item: ImageGridEntity) -> some View {
        ImageView(expandSheet: $viewModel.state.expandSheet, animation: animation, selectedItemId: viewModel.state.selectedItem?.id, item: item) {
            withAnimation(.smooth(duration: 0.3)) {
                viewModel.state.selectedItem = .image(item)
                viewModel.state.expandSheet = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookView(viewModel: BookViewModel(book: Book(name: "book", items: [])))
    }
}

private struct ImageView: View {
    
    @Binding var expandSheet: Bool
    let animation: Namespace.ID
    let selectedItemId: String?
    let item: ImageGridEntity
    var onTap: () -> Void
    let image: UIImage?
    
    init(
        expandSheet: Binding<Bool>,
        animation: Namespace.ID,
        selectedItemId: String?,
        item: ImageGridEntity,
        onTap: @escaping () -> Void
    ) {
        self._expandSheet = expandSheet
        self.animation = animation
        self.selectedItemId = selectedItemId
        self.item = item
        self.onTap = onTap
        self.image = UIImage(data: item.imageData)
    }
    
    var body: some View {
        ZStack {
            if expandSheet {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(.rect(cornerRadius: 24))
                        .transition(.blurReplace)
                        .opacity(item.id == selectedItemId ? 0 : 1)
                }
            } else {
                ItemCellView(expandSheet: $expandSheet, animation: animation, item: item)
                    .onTapGesture {
                        onTap()
                    }
                    .matchedGeometryEffect(id: item.id + "BGVIEW", in: animation)
            }
        }
    }
}

private struct GridItemView: View {
    
    let item: ImageGridEntity
    
    let image: UIImage?
    
    init(item: ImageGridEntity) {
        self.item = item
        self.image = UIImage(data: item.imageData)
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 24))
        }
    }
}
