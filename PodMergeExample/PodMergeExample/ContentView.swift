//
//  ContentView.swift
//  PodMergeExample
//
//  Created by Siddharth Gupta on 29/9/19.
//  Copyright © 2019 Grab. All rights reserved.
//

import SwiftUI

// Import Merged Pods like this:
import UI.FLAnimatedImage
import UI.IQKeyboardManager
import UI.MBProgressHUD
import UI.TTTAttributedLabel

import Networking.AFNetworking
import Networking.SDWebImage

// Unmerged pods are unaffected
import Alamofire
import Moya

// Cannot import individual pods anymore, uncomment to check:
// import MBProgressHUD
// import AFNetworking

struct ContentView: View {
  var body: some View {
    Text("Hello World")
  }
}

struct ContentView_Previews: PreviewProvider {

  // Using stuff from the merged pods, just to check:

  let image = FLAnimatedImageView()
  let keyboard = IQKeyboardManager.shared()
  let hud = MBProgressHUD()
  let label = TTTAttributedLabel(frame: .zero)

  let session = AFHTTPSessionManager()
  let sdImage = SDWebImageManager()

  let moya: Task = .requestData(Data())

  static var previews: some View {
    ContentView()
  }
}
