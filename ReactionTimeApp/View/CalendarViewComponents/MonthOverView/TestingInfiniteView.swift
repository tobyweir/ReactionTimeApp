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
            LazyVStack {
                ForEach (content , id: \.self) { num in
                    SimpleContentView(content: num)
                        .onAppear {
                            if (num == content[0]) {
                                expandContentUp(by: 1)
                            } else if (num == content[content.count - 1]) {
                                expandContentDown(by: 1)
                            }
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: Binding($currNum), anchor: .center)
        .onAppear {
            initView()
        }
        .onChange(of: currNum) {

        }
    }

    func initView () {
        expandContentUp(by: 1)
        expandContentDown(by: 1)
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


#Preview {
    InfiniteViewOwner()
}

