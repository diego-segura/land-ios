//
//  AddEntryView.swift
//  Land
//
//  Created by Luka Vujnovac on 29.11.2024..
//

import SwiftUI

struct AddEntryView: View {
    
    @StateObject private var viewModel: AddEntryViewModel
    
    init(viewModel: @autoclosure @escaping () -> AddEntryViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 43) {
                VStack(spacing: 56) {
                    Text("adding an entry")
                        .font(.standard(size: 24, weight: 310))
                        .kerning(-0.48)
                        .foregroundStyle(.black)
                    
                    
                    VStack(spacing: 26) {
                        ElementView(element: viewModel.state.gridItem)
                        HStack {
                            Text("optional".uppercased())
                                .font(.standard(size: 10, weight: 420))
                                .foregroundStyle(Color.custom(hex: "666666"))
                                .opacity(0)
                            Button {
                                viewModel.trigger(.onAddCaptions)
                            } label: {
                                Text("add captions")
                                    .font(.standard(size: 14, weight: 360))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, -6)
                            }
                            .buttonStyle(.dark)
                            .fixedSize()
                            
                            Text("optional".uppercased())
                                .font(.standard(size: 10, weight: 320))
                                .foregroundStyle(Color.custom(hex: "666666"))
                        }
                    }
                }
                
//                Spacer(minLength: 0)
                
                VStack(spacing: 36){
                    Text("to which book?")
                        .font(.standard(size: 24, weight: 310))
                    
                    VStack(spacing: 5) {
                        createBookButton(title: "create a new book") {
                            viewModel.trigger(.onAddBook)
                        }
                        ForEach(viewModel.state.books, id: \.id) { book in
                            bookButton(book: book) {
                                viewModel.trigger(.onBookSelected(book))
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .padding(.top, 11)
        .customBackButton {
            viewModel.trigger(.onPop)
        }
    }
    
    func bookButton(book: Book, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack {
                HStack(spacing: 7){
                    Text(book.name)
                        .font(.standard(size: 16, weight: 360))
                    Text("\(book.items.count) entries")
                        .font(.standard(size: 16, weight: 360))
                        .foregroundStyle(Color.custom(hex: "999999"))
                }
                Spacer()
                Image(systemName: "plus")
                    .font(.system(size: 16))
            }
            .padding(.leading, 23)
            .padding(.trailing, 20)
            .padding(.vertical, 8)
        }
        .buttonStyle(.standard)
        .clipShape(.rect(cornerRadius: 24))
    }
    
    func createBookButton(title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.standard(size: 16, weight: 360))
                Spacer()
                Image(systemName: "plus")
                    .font(.system(size: 16))
            }
            .padding(.leading, 23)
            .padding(.trailing, 20)
            .padding(.vertical, 8)
        }
        .buttonStyle(.standard)
        .clipShape(.rect(cornerRadius: 24))
    }
}

private struct ElementView: View {
    
    let element: GridItem
    
    var body: some View {
        switch element {
        case .image(let element):
            Image(uiImage: UIImage(data: element.imageData) ?? UIImage())
        case .text(let element):
            textView(element)
        case .link:
            EmptyView()
        }
    }
    
    func textView(_ element: TextGridItem) -> some View {
        Text(element.text)
            .font(.standard(size: 14, weight: 360))
            .foregroundStyle(Color.custom(hex: "1A1A1A"))
            .allowsTightening(false)
            .fixedSize(horizontal: false, vertical: true)
            .opacity(0.8)
            .lineSpacing(3)
            .padding(.horizontal, 45)
            .padding(.vertical, 36)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(Color.custom(hex: "d9d9d9"), lineWidth: 1)
            }
            .padding(.horizontal, 42)
    }
}

#Preview {
    AddEntryView(viewModel: AddEntryViewModel(item: .text(TextGridItem(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))))
}
