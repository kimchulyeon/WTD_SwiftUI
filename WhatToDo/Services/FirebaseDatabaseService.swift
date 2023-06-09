//
//  FirebaseDatabaseService.swift
//  WhatToDo
//
//  Created by chulyeon kim on 2023/06/09.
//

import Foundation
import FirebaseFirestore

let DB_BASE = Firestore.firestore()

class FirebaseDatabaseService {
    static let shared = FirebaseDatabaseService()
    
    private init() { }
    
    private var REF_USERS = DB_BASE.collection("users")
    
    //MARK: - FUNC ==================
    /// 유저 정보를 데이터베이스에 저장
    func saveUserInfo(_ name: String, _ email: String, _ userUID: String, _ provider: String, completion: @escaping (_ docID: String) -> Void) {
        let document = self.REF_USERS.document()
        let documentID = self.REF_USERS.document().documentID
        
        let userData: [String: Any] = [
            CommonConstant.name: name,
            CommonConstant.email: email,
            CommonConstant.provider: provider,
            CommonConstant.userUID: userUID,
            CommonConstant.docID: documentID,
            CommonConstant.createdAt: FieldValue.serverTimestamp(),
        ]
        
        document.setData(userData) { error in
            if let error = error {
                print("❌ Error while save user info in database with \(error.localizedDescription)")
                return
            }
            completion(documentID)
            return
        }
    }
    
    /// 소셜 로그인 uid로 기존 회원인지 체크해서 데이터베이스 documentID를 가져옴
    func checkIsUserExist(with userUID: String, completion: @escaping (_ docID: String?) -> Void) {
        self.REF_USERS.whereField(CommonConstant.userUID, isEqualTo: userUID).getDocuments { querySnapshot, error in
            if let error = error {
                print("❌ Error while checking existing user with \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let snapshot = querySnapshot, snapshot.count > 0, let docuemnt = snapshot.documents.first {
                let docID = docuemnt.documentID
                completion(docID)
                return
            } else {
                completion(nil)
                return
            }
        }
    }
    
    /// documentID로 유저 정보 가져오기
    func getUserInfo(with docID: String, completion: @escaping (_ name: String?, _ email: String?, _ userUID: String?, _ provider: String?, _ docID: String) -> Void) {
        self.REF_USERS.document(docID).getDocument { docSnapshot, error in
            if let error = error {
                print("❌ Error while get user info with documentID with \(error.localizedDescription)")
                return
            }
            
            if let document = docSnapshot {
                let name = document.get(CommonConstant.name) as? String
                let email = document.get(CommonConstant.email) as? String
                let userUID = document.get(CommonConstant.userUID) as? String
                let provider = document.get(CommonConstant.provider) as? String
                let docID = document.documentID
                
                completion(name, email, userUID, provider, docID)
                return
            }
        }
    }
}
