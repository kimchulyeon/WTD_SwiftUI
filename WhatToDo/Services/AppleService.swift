//
//  AppleService.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/08.
//

import Foundation
import SwiftUI
import CryptoKit
import AuthenticationServices
import FirebaseAuth

class AppleService: NSObject, ASAuthorizationControllerDelegate {
    static let shared = AppleService()

    var loginView: LoginView!

    private override init() { }

    // Unhashed nonce.
    fileprivate var currentNonce: String?

    // https://firebase.google.com/docs/auth/ios/apple?hl=ko&authuser=0&_gl=1*1hdqmt7*_ga*MTMxMTIxNjg5OC4xNjc4Njc5MTY5*_ga_CW55HF8NVT*MTY4NTUxNTY1NC43LjEuMTY4NTUxNzkwNy4wLjAuMA..
    func startSignInWithAppleFlow(view: LoginView) {
        self.loginView = view

        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }

    // https://firebase.google.com/docs/auth/ios/apple?hl=ko&authuser=0&_gl=1*1hdqmt7*_ga*MTMxMTIxNjg5OC4xNjc4Njc5MTY5*_ga_CW55HF8NVT*MTY4NTUxNTY1NC43LjEuMTY4NTUxNzkwNy4wLjAuMA..
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }

        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }

        return String(nonce)
    }

    // 로그인하면 실행되는 로직
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            let email = appleIDCredential.email ?? ""

            var name = "홍길동"
            if let fullName = appleIDCredential.fullName {
                let formatter = PersonNameComponentsFormatter()
                name = formatter.string(from: fullName)
            }

            // Initialize a Firebase credential, including the user's full name.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                           rawNonce: nonce,
                                                           fullName: appleIDCredential.fullName)
            // 파이어베이스 로그인
            FirebaseAuthService.shared.loginToFirebase(credential: credential) { userUID, isNewUser, isError, docID  in
                guard let userUID = userUID else { return }

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
                        FirebaseDatabaseService.shared.saveUserInfo(name, email, userUID, "apple") { docID in
                            UserDefaultsUtil.shared.setAuthInfo(name, email, userUID, docID, "apple") // docID 추가
                        }
                    }
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("❌ Sign in with Apple errored: \(error.localizedDescription)")
        self.loginView.isShowErrorAlert.toggle()
    }

}

