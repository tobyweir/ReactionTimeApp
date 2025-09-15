//
//  ProfileView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 27/08/2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    let model: Controller
    @State var showEditSheet: Bool = false
    @State var image: Image?
    @State var username: String = ""

    init (model: Controller) {
        self.model = model
        self.image = model.resultStore.loadImageFromFile()
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                editButton
                    .padding(.horizontal , 25)
            }
            ZStack {
                profilePictureView
                image?
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            profileUsernameView
            acountStatsList
        }
        .sheet(isPresented: $showEditSheet) {
            ProfileEditorView(model: model, avatarImage: $image, username: $username)
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
            ZStack{
                Color.gray
                    .frame(maxWidth: 200, maxHeight: 200)
                    .aspectRatio(1 , contentMode: .fit)
                Text("?").bold().font(.title)
            }
            Spacer()
        }
    }

    var profileUsernameView: some View {
        HStack {
            Spacer()
            Text("\(username == "" ? "Username" : username)")
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

    var acountStatsList: some View {
        List {
            Section(header: Text("Acount Statistics").font(.title).bold()) {
            }
            Section(header: Text("Average Reaction Time"), footer: Text("The mean of all results recorded on the app")) {
                if (model.resultStore.results.count > 1) {
                    Text("\(ChartData.calcMean(on: model.resultStore.results))ms")
                } else {
                    Text("~")
                }
            }
            Section(header: Text("Best Result"), footer: Text("The fastest reaction recorded on the app")) {
                if (model.resultStore.results.count > 1) {
                    Text("\(Int( model.resultStore.results.min(by: {$0.time < $1.time})!.time * 1000 ))ms")
                } else {
                    Text("~")
                }
            }
            Section(header: Text("Result Count"), footer: Text("Total count of all results recorded on the app")) {
                Text("\(model.resultStore.results.count)")
            }
        }
        .scrollDisabled(true)
        .listStyle(.grouped)
    }
}

#Preview {
    ProfileView(model: Controller())
}
