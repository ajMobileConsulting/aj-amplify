//
//  VideoUploadViewModel.swift
//  VideoUpload
//
//  Created by Alexander Jackson on 10/3/25.
//

import AVKit
import Amplify
import Combine
import Foundation

final class VideoUploadViewModel: ObservableObject {
    @Published var player: AVPlayer?

    init() {
        loadPlayer()
    }

    var waterfallUrl: URL? {
        Bundle.main.url(forResource: "waterfall", withExtension: "mov")
    }

    func uploadToS3(fileName: String) async {
        guard let url = waterfallUrl else { return }
        let task = Amplify.Storage.uploadFile(
            path: .fromString(fileName),
            local: url
        )
        
        do {
            _ = try await task.value
            print("✅ Uploaded sample.mov to S3")
        } catch {
            print("❌ Upload failed:", error)
        }
    }

    @MainActor
    func loadPlayer() {
        if let url = waterfallUrl {
            self.player = AVPlayer(url: url)
        } else {

        }
    }
}
