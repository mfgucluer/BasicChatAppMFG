//
//  AuthenticationService.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 10/9/24.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseFirestore


struct AuthenticationServiceUser {
    var emailText: String
    var passwordText: String
    var nameText: String
    var usernameText: String
}

struct AuthenticationService {
    
    static func login(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?)->Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    static func register(profileImageUpload: UIImage, user: AuthenticationServiceUser, completion: @escaping(Error?)->Void ) {
        
        let photoID = UUID().uuidString
        guard let profileData = profileImageUpload.jpegData(compressionQuality: 0.5) else { return }
        
        let reference = Storage.storage().reference(withPath: "media/profile_image/\(photoID).jpeg")
        
        // Profil resmini yükleme işlemi
        reference.putData(profileData, metadata: nil) { storageMeta, error in
            if let error = error {
                completion(error)
                print("Error uploading image: \(error.localizedDescription)")
                return // Hata durumunda işlemi sonlandır
            }
            
            // Profil resminin URL'sini alma işlemi
            reference.downloadURL { url, error in
                if let error = error {
                    completion(error)
                    print("Error fetching download URL: \(error.localizedDescription)")
                    return // Hata durumunda işlemi sonlandır
                }
                
                guard let profileImageUrl = url?.absoluteString else {
                    completion(error)
                    print("Error: profileImageUrl is nil")
                    return
                }
                
                // Firebase Authentication ile kullanıcı oluşturma
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText) { result, error in
                    if let error = error as NSError? {
                        completion(error)
                        print("Error creating user: \(error.localizedDescription)")
                        print("Error code: \(error.code)") // Firebase error code'u görmeyi sağlar
                        return
                    }
                    guard let userUUID = result?.user.uid else { return }
                    
                    // Firestore'a kullanıcı verilerini kaydetme
                    let data: [String: Any] = [
                        "email": user.emailText,
                        "name": user.nameText,
                        "username": user.usernameText,
                        "profileImageUrl": profileImageUrl,
                        "uuid": userUUID
                    ]
                    
                    Firestore.firestore().collection("users").document(userUUID).setData(data, completion: completion) //yukaridaki completion'u buradakine esitleyebiliryouz.
                    
                }
            }
        }
    }
    
    
    
    
    
}
