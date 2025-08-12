//
//  TestingInfiniteView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 09/08/2025.
//

import SwiftUI

struct InfiniteViewOwner: View {
    @State var currNumber: Int = 100

    var body: some View {
            VStack {
                Text("\(currNumber)")
                    .font(.system(size: 20 , weight: .heavy))
            TestingInfiniteView(currNum: $currNumber)
        }
    }
}

struct TestingInfiniteView: View {
    @State var content: [Int]
    @Binding var currNum: Int

    init(currNum: Binding<Int>) {
        self._currNum = currNum
        self.content = [currNum.wrappedValue]
    }
    var body: some View {
        ScrollView {
            List {
                VStack {
                    ForEach (content , id: \.self) { num in
                        SimpleContentView(content: num)
                            .onAppear {
                                if (num == content[10]) {
                                    expandContentUp(by: 10)
                                } else if (num == content[content.count - 1]) {
                                    expandContentDown(by: 10)
                                }
                            }
                    }
                }
            }
            .scrollTargetLayout()
//            .onChange(of: currNum) { oldValue , newValue in
//                if (newValue > oldValue && newValue == content[content.count - 1]) {
//                    expandContentDown(by: 12)
//                } else if (oldValue > newValue && newValue == content[5]) {
//                }
//            }
     }
        .scrollPosition(id: Binding($currNum), anchor: .center)
        .onAppear {
            initView()
        }
    }

    func initView () {
        expandContentUp(by: 20)
        expandContentDown(by: 20)
    }

    func expandContentUp(by count: Int) {
        for _ in 0..<count {
            content = [content[0] - 1] + content
        }
    }

    func expandContentDown(by count: Int) {
        for _ in 0..<count {
            content = content + [content[content.count - 1] + 1]
        }
    }
}


struct SimpleContentView: View {
    let content: Int
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.green)
            Text("\(content)")
        }.aspectRatio(0.5 , contentMode: .fit)
    }
}

struct TestInfinityList: View {

    @State var visibleItems: Set<Int> = []
    @State var items: [Int] = Array(0...20)

    var body: some View {
        ScrollViewReader { value in

            List(items, id: \.self) { item in
                VStack {
//                    Text("Item \(item)")
                        SimpleContentView(content: item)
                }.id(item)
                .onAppear {
                    self.visibleItems.insert(item)

                    /// if this is the second item on the list, then time to add with a short delay
                    /// another item at the top
                    if items[1] == item {
//                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            withAnimation(.easeIn) {
                                items.insert(items.first! - 1, at: 0)
                            }
//                        }
                    }
                }
                .onDisappear {
                    self.visibleItems.remove(item)
                }
                .frame(height: 300)
            }
            .onAppear {
                value.scrollTo(10, anchor: .top)
            }
        }
    }
}

struct TestInfinityList2: View {

//    @State var visibleItems: Set<Int> = []
    @State var items: [Int] = Array(0...20)
    var model: Controller = Controller()
    @State var currItem: Int = 10
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollViewReader { scrollProxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(items, id: \.self) { item in
                            ZStack {
                                Color.clear
                                MonthView(start: Date.now, model: model)
                                Text("\(item)")
                            }
                            .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
                            .id(item)
                            .onAppear {
//                                self.visibleItems.insert(item)

                                if items[1] == item {
                                    items.insert(items.first! - 1, at: 0)
                                } else if items[items.count - 2] == item {
                                    items.append(items.last! + 1)
                                }
                            }
                            .onDisappear {
//                                self.visibleItems.remove(item)
                            }
                        }
                    }
                }
                .scrollPosition(id: Binding($currItem))
                .onAppear {
                    scrollProxy.scrollTo(11)
                }
            }
        }
    }
}

//Another option is to create massive amounts of months in each direction with lazyVStack, unsure

#Preview {
    TestInfinityList2()
}

