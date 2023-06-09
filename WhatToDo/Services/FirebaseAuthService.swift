//
//  FirebaseService.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
    static let shared = FirebaseAuthService()
    
    private init() {}
    
    /// 소셜 로그인 credential로 Firebase 로그인
    func loginToFirebase(credential: AuthCredential, completion: @escaping (_ userUID: String?, _ isNewUser: Bool, _ isError: Bool, _ docID: String?) -> Void) {
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print("❌ \(error.localizedDescription)")
                completion(nil, true, true, nil)
                return
            }
            
            guard let userUID = result?.user.uid else {
                print("❌ Error with getting user uid")
                completion(nil, true, true, nil)
                return
            }
            
            FirebaseDatabaseService.shared.checkIsUserExist(with: userUID) { docID in
                if docID != nil {
                    completion(userUID, false, false, docID)
                } else {
                    completion(userUID, true, false, nil)
                }
            }
            return
        }
    }
    
    
}
