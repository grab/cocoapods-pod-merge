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
import Subspecs.AppAuth

// Merged Swift Pods cannot be import individually, only all or none.
import MergedSwiftPods
import AlamofireGroup

// Unmerged pods are unaffected
import Nuke

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

  let request = ImageRequest(url: URL(string: "https://github.com/grab/cocoapods-pod-merge")!)

  override func viewDidLoad() {
    super.viewDidLoad()

    // SnapKit Usage
    let box = UIView()
    box.snp.makeConstraints { _ in }
    
    let authorizationEndpoint = URL(string: "https://accounts.google.com/o/oauth2/v2/auth")!
    let tokenEndpoint = URL(string: "https://www.googleapis.com/oauth2/v4/token")!
    let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint,
                                                tokenEndpoint: tokenEndpoint)
  }
}

