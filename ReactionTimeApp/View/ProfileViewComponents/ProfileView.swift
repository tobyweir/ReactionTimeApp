//
//  ProfileView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 27/08/2025.
//

import SwiftUI

struct ProfileView: View {
    let model: Controller
    @State var showEditSheet: Bool = false

    var body: some View {
        VStack {
            editButton
            profilePictureView
            profileUsernameView
            acountStatsView
        }
        .sheet(isPresented: $showEditSheet) {
            ProfileEditorView()
        }

    }

    var editButton: some View {
        Button {
            showEditSheet = true
        } label: {
            Image(systemName: "square.and.pencil")
        }
    }

    var profilePictureView: some View {
        HStack {
            Spacer()
            Color.blue
                .frame(maxWidth: 200, maxHeight: 200)
                .aspectRatio(1 , contentMode: .fit)
            Spacer()
        }
    }

    var profileUsernameView: some View {
        HStack {
            Spacer()
            Text("Username")
            Spacer()
        }
    }

    var acountStatsView: some View {
        VStack {
            HStack{
                Text("Lifetime Stats")
                    .padding(.leading)
                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(.black), alignment: .bottom)
                Spacer()
            }
            HStack {
                Text("Average Reaction Time: \(ChartData.calcMean(on: model.resultStore.results))ms")
                    .padding(.leading)
                Spacer()
            }
            HStack {
                if (model.resultStore.results.count > 1) {
                    Text("Best Result: \(Int( model.resultStore.results.min(by: {$0.time < $1.time})!.time * 1000 ))")
                        .padding(.leading)
                } else {
                    Text("Best Result: ~")
                        .padding(.leading)
                }
                Spacer()
            }
            HStack {
                Text("Result Count: \(model.resultStore.results.count)")
                    .padding(.leading)
                Spacer()
            }
        }
    }
}

#Preview {
    ProfileView(model: Controller())
}
