//
//  HomeViewModel.swift
//  Practices (iOS)
//
//  Created by 김주형 on 2022/04/27.
//

import SwiftUI
import FBSDKLoginKit
import KakaoSDKUser
import AuthenticationServices


struct UserProfile{
    static let shared = UserProfile()
    
    
    enum LoginType{
        case facebook,apple,google,kakao
    }
    var id = UUID()
    var userid : String?
    var nickname : String?
    var userEmail : String?
    var password : String?
    var profileIMGURL : String?
    var token : Any?
    var logintype : LoginType?
    
    
    
    private init(){}
    
    mutating func removeProfile(){
        self.userid = nil
        self.userEmail = nil
        self.nickname = nil
        self.password = nil
        self.logintype = nil
        self.token = nil
        self.profileIMGURL = nil
    }
}

class RelationLoginViewModel:ObservableObject{
    @Published var logged = false
    @Published var userProfile = UserProfile.shared
    
    @Published var manager = LoginManager()
    
    func logoutEvent(){
        logged = false
        if let type = userProfile.logintype{
            switch type {
            case .facebook:
                print("facebook Logout")
                manager.logOut()
            case .apple:
                print("apple Logout")
            case .google:
                print("google Logout")
            case .kakao:
                UserApi.shared.logout { err in
                    if let err = err {
                        print(err)
                    }
                }
                print("kakao Logout")
            }
        }
        userProfile.removeProfile()
    }
    
    
    func fbLoginEvent(){
        manager.logIn(permissions: ["public_profile","email"], from: nil) { result, error in
            if error != nil{
                print("💀\(#function)-\(String(describing: error?.localizedDescription))")
                return
            }
            
            if !result!.isCancelled{
                self.logged = true
                
                let request = GraphRequest(graphPath: "me", parameters: ["fields":"email"])
                
                request.start { _, res, _ in
                    guard let profileData = res as? [String:Any] else {return}
                    
                    if let email =  profileData["email"] as? String{
                        self.userProfile.userEmail = email
                    }
                    
                    if let id =  profileData["id"] as? String{
                        self.userProfile.logintype = .facebook
                        self.userProfile.userid = id
                    }
                }
            }
        }
    }
    
    func kakaoLoginEvent(){
        if(UserApi.isKakaoTalkLoginAvailable()){
            UserApi.shared.loginWithKakaoTalk { (OAuthToken, error) in
                if let err = error{
                    print("💀\(#function)-\(err)")
                    return
                }
                
                if let token = OAuthToken
                {
                    
                    self.userProfile.token = token
                    self.loadKakaoTokenInfo()
                }
            }
        }
    }
    
    func loadKakaoTokenInfo(){
        UserApi.shared.me { userInformation, error in
            if let err = error{
                print("💀\(#function)-\(err)")
            }
            else{
                self.userProfile.logintype = .kakao
                self.logged = true
                if let uinfo = userInformation?.id {
                        self.userProfile.userid = String(uinfo)
                }
                if let value = userInformation?.properties?["nickname"]{
                    self.userProfile.nickname = value
                }
                if let value = userInformation?.properties?["profile_image"]{
                    self.userProfile.profileIMGURL = value
                }
            }
        }
    }
    
}
