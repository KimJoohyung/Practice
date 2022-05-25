//
//  PracticesApp.swift
//  Shared
//
//  Created by 김주형 on 2022/03/29.
//

import SwiftUI
import GooglePlaces
import FBSDKCoreKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


@main
struct PracticesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            ChatWithIMG()
            Splash()
                .onOpenURL(perform: handleURL)
        }
    }
    
    func handleURL(_ url: URL) {
    print(url)
        if (AuthApi.isKakaoTalkLoginUrl(url)){
            AuthController.handleOpenUrl(url: url)
        }
    }
    
    
}
