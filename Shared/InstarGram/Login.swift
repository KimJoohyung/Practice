//
//  facebookLogin.swift
//  Practices (iOS)
//
//  Created by 김주형 on 2022/04/27.
//

import SwiftUI
import FBSDKLoginKit
import AuthenticationServices

struct Login: View {
    @ObservedObject var viewmodel = RelationLoginViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(spacing:25){
            if let imgURL = viewmodel.userProfile.profileIMGURL{
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: imgURL)){phase in
                        switch phase{
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame( maxWidth: 300, minHeight: 300)
                        default:
                            EmptyView()
                        }
                        
                        
                    }
                        
                        
                        .frame(width: 70, height: 70)
                }
            }
            Button(action: {
                if viewmodel.logged{
                    viewmodel.logoutEvent()
                }
                else{
                    viewmodel.kakaoLoginEvent()
                }
            }) {
                Text(viewmodel.logged ? "로그아웃":"카카오로그인")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color.yellow)
                    .clipShape(Capsule())
            }
            
            Button(action: {
                if viewmodel.logged{
                    viewmodel.logoutEvent()
                }
                else{
                    viewmodel.fbLoginEvent()
                }
            }) {
                Text(viewmodel.logged ? "로그아웃":"페북로긴")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,35)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            
            SignInWithAppleButton(.continue) { request in
                request.requestedScopes = [.email,.fullName]
            } onCompletion: { result in
                switch result{
                case .success(let auth):
                    switch auth.credential{
                    case let credential as ASAuthorizationAppleIDCredential:
                        viewmodel.userProfile.userid = credential.user
                        viewmodel.userProfile.userEmail = credential.email
                        viewmodel.userProfile.logintype = .apple
                        viewmodel.logged = true
//                        viewmodel.userProfile.userid = userid
                    default : break
                    }
                case.failure(let error):
                    print("💀\(#function)-\(error.localizedDescription)")
                }
            }
            .signInWithAppleButtonStyle(
                colorScheme == .dark ? .white : .black
            )
            .frame(width:240,height: 45)
            .cornerRadius(45/2)
            .padding()
            
            Text(viewmodel.userProfile.userEmail != nil ? viewmodel.userProfile.userEmail! : "")
                .fontWeight(.bold)
            Text(viewmodel.userProfile.userid != nil ? viewmodel.userProfile.userid! : "")
                .fontWeight(.bold)
        }
    }
    
    
}

struct facebookLogin_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
