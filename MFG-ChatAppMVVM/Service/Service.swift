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
    
//    static func sendMessage(message: String, toUser: User, completion: @escaping(Error?)->Void ){
//        guard let currentUid = Auth.auth().currentUser?.uid else { return  }
//        let data =  [
//            "text": message,
//            "fromId": currentUid,
//            "toId": toUser.uid,
//            "timeStamp": Timestamp(date: Date()),
//        ] as [String: Any]
//        Firestore.firestore().collection("messages").document(currentUid).collection(toUser.uid).addDocument(data: data) { error in
//            Firestore.firestore().collection("messages").document(toUser.uid).collection(currentUid).addDocument(data: data, completion: completion)
//        }
//        
//        
//    }
    
    static func sendMessage(message: String, toUser: User, completion: @escaping(Error?)->Void ) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let conversationId = "\(currentUid)_\(toUser.uid)" // ya da alfabetik sıraya göre: "\(min(currentUid, toUser.uid))_\(max(currentUid, toUser.uid))"
        
        let data = [
            "text": message,
            "fromId": currentUid,
            "toId": toUser.uid,
            "timeStamp": Timestamp(date: Date()),
        ] as [String : Any]

        Firestore.firestore().collection("conversations").document(conversationId).collection("messages").addDocument(data: data, completion: completion)
    }

    
    static func fetchMessages(user: User, completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let conversationId = "\(currentUid)_\(user.uid)" // İki kullanıcı arasındaki konuşma kimliği

        Firestore.firestore().collection("conversations").document(conversationId).collection("messages").order(by: "timestamp", descending: false).getDocuments { snapshot, error in
            var messages = [Message]()
            
            if let error = error {
                print("Mesajlar alınamadı: \(error.localizedDescription)")
                return
            }
            
            snapshot?.documents.forEach({ document in
                let data = document.data()
                let message = Message(data: data)
                messages.append(message)
            })
            
            completion(messages)
        }
    }

    
    
    
}
