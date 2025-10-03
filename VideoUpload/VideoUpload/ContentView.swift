//
//  ContentView.swift
//  VideoUpload
//
//  Created by Alexander Jackson on 10/3/25.
//

import AVKit
import Authenticator
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: VideoUploadViewModel
    //    lazy var player: AVPlayer = AVPlayer(url: viewModel.waterfallUrl ?? URL(string: "")!)

    var body: some View {
        Authenticator { state in
            VStack {
                if let player = viewModel.player {
                    VideoPlayer(player: player)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxWidth: .infinity, maxHeight: 500)
                        .padding()
                        .onAppear {
                            player.play()
                        }

                }
                Button("Upload") {
                    Task {
                        await viewModel.uploadToS3(fileName: "waterfall")
                    }
                }
                Button("Sign Out") {
                    Task {
                        viewModel.player?.pause()
                        viewModel.player = nil
                        await state.signOut()
                    }
                }
            }
            .padding()

        }
    }
}

#Preview {
    ContentView(viewModel: VideoUploadViewModel())
}
