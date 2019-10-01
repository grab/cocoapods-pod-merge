//
//  ViewController.swift
//  PodMergeExample
//
//  Created by Siddharth Gupta on 30/9/19.
//  Copyright © 2019 Grab. All rights reserved.
//

import UIKit

// Import Merged Pods like this:
import UI.FLAnimatedImage
import UI.IQKeyboardManager
import UI.MBProgressHUD
import UI.TTTAttributedLabel

import Networking.AFNetworking
import Networking.SDWebImage

// Merged Swift Pods cannot be import individually, only all or none.
import MergedSwiftPods

// Unmerged pods are unaffected
import Moya

// Cannot import individual pods anymore, uncomment to check:
// import MBProgressHUD
// import AFNetworking

class ViewController: UIViewController {

  // Using stuff from the merged pods, just to check:
  let image = FLAnimatedImageView()
  let keyboard = IQKeyboardManager.shared()
  let hud = MBProgressHUD()
  let label = TTTAttributedLabel(frame: .zero)

  let session = AFHTTPSessionManager()
  let sdImage = SDWebImageManager()

  let error: AFError = .invalidURL(url: "")
  let json: SwiftyJSONError = .elementTooDeep

  let moya: Task = .requestData(Data())
}

