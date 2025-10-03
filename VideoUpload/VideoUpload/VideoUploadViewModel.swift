//
//  VideoUploadViewModel.swift
//  VideoUpload
//
//  Created by Alexander Jackson on 10/3/25.
//

import AVKit
import AWSCognitoIdentityProvider
import AWSPluginsCore
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
        do {
            //            // Get the signed-in user's ID (the Cognito identity `sub`)
            //            let authUser = try await Amplify.Auth.getCurrentUser()
            //            let userId = authUser.userId   // ✅ this is the sub
            //
            //            // Build key under user-videos/{sub}/
            //            let key = "user-videos/\(userId)/\(UUID().uuidString).mov"
            //            let path: any StoragePath = .fromString(key)
            //
            //
            //            let result = try await Amplify.Storage.uploadFile(path: path, local: url).value
            //            print("✅ Uploaded video to S3 at key: \(result)")
            // Get the current auth session
            // Hard-coded identityId for testing
            let identityId = "us-east-2:9006324c-7680-c387-6df3-06701158bd21"

            // Construct key that matches your IAM policy
            let key = "user-videos/\(identityId)/\(UUID().uuidString).mov"
            let path: any StoragePath = .fromString(key)

            let result = try await Amplify.Storage.uploadFile(
                path: path,
                local: url
            ).value
            print("✅ Uploaded video to S3 at: \(result)")
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
