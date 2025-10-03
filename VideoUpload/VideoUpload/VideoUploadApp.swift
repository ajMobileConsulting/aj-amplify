//
//  VideoUploadApp.swift
//  VideoUpload
//
//  Created by Alexander Jackson on 10/3/25.
//

import Authenticator
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import SwiftUI

@main
struct VideoUploadApp: App {
    let viewModel = VideoUploadViewModel()
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure(with: .amplifyOutputs)
            print("Amplify configured with Auth and Storage plugins")
        } catch {
            print("App Error: \(error.localizedDescription)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
