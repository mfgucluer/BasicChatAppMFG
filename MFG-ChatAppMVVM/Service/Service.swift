//
//  FetchDataService.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 12/9/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct Service {
    static func fetchUsers(completion: @escaping([User])-> Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            users = snapshot?.documents.map({User(data: $0.data())}) ?? []
            completion(users)
        }
    }
    
    static func sendMessage(message: String, toUser: User, completion: @escaping(Error?)->Void ){
        guard let currentUid = Auth.auth().currentUser?.uid else {
            print("Error: current user UID is nil.")
            return
        }
        
        // UID'leri kontrol et
        print("Sending message from: \(currentUid) to: \(toUser.uuid)")

        let data =  [
            "text": message,
            "fromId": currentUid,
            "toId": toUser.uuid,
            "timeStamp": Timestamp(date: Date()),
        ] as [String: Any]

        let fromMessagePath = Firestore.firestore().collection("messages").document(currentUid).collection(toUser.uuid)
        let toMessagePath = Firestore.firestore().collection("messages").document(toUser.uuid).collection(currentUid)
        
        // Mesaj yükleme işlemi
        fromMessagePath.addDocument(data: data) { error in
            if let error = error {
                print("Error uploading message to sender's path: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            toMessagePath.addDocument(data: data, completion: completion)
        }
    }

    

    
    
    
}
