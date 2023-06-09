//
//  GoogleService.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import SwiftUI
import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class GoogleService: NSObject {
    static let shared = GoogleService()

    private var vc: UIViewController? // rootViewController

    var loginView: LoginView!

    private override init() { }

    func startSignInWithGoogle(view: LoginView) {
        self.loginView = view

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let viewController = windowScene.windows.first?.rootViewController as? UIViewController {
                self.vc = viewController
            }
        }

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        guard let vc = self.vc else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { result, error in
            if let error = error {
                print("Google signing error with \(error.localizedDescription)")
                self.loginView.isShowErrorAlert.toggle()
            } else {
                if let result = result {
                    let user = result.user
                    let idToken = user.idToken?.tokenString ?? ""
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                   accessToken: user.accessToken.tokenString)

                    guard let name = user.profile?.name,
                          let email = user.profile?.email else { return }

                    FirebaseAuthService.shared.loginToFirebase(credential: credential) { userUID, isNewUser, isError, docID  in
                        guard let userUID else { return }

                        if !isError {
                            if !isNewUser {
                                print("✅ 기존 유저")
                                guard let docID = docID else { return }
                                FirebaseDatabaseService.shared.getUserInfo(with: docID) { name, email, userUID, provider, docID in
                                    guard let name = name,
                                          let email = email,
                                          let userUID = userUID,
                                          let provider = provider else { return }
                                    
                                    UserDefaultsUtil.shared.setAuthInfo(name, email, userUID, docID, provider)
                                }
                            } else {
                                print("✅ 신규 유저")
                                FirebaseDatabaseService.shared.saveUserInfo(name, email, userUID, "google") { docID in
                                    UserDefaultsUtil.shared.setAuthInfo(name, email, userUID, docID, "google") // docID 추가
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

