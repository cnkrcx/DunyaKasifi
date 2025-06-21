import Foundation
import Firebase
import FirebaseFirestore

class DataService {
    static let shared = DataService()
    
    private let db = Firestore.firestore()

    func saveUserData(userId: String, name: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = db.collection("users").document(userId)
        let data: [String: Any] = [
            "name": name,
            "email": email,
            "created_at": Timestamp()
        ]
        
        userRef.setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchUserData(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let userRef = db.collection("users").document(userId)
        
        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                let data = document.data() ?? [:]
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
            }
        }
    }

    func saveMissionData(missionId: String, name: String, description: String, reward: Int, status: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let missionRef = db.collection("missions").document(missionId)
        let data: [String: Any] = [
            "name": name,
            "description": description,
            "reward": reward,
            "status": status,
            "created_at": Timestamp()
        ]
        
        missionRef.setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchMissionData(missionId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let missionRef = db.collection("missions").document(missionId)
        
        missionRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                let data = document.data() ?? [:]
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Mission not found"])))
            }
        }
    }

    func saveRewardData(rewardId: String, name: String, type: String, value: Int, description: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let rewardRef = db.collection("rewards").document(rewardId)
        let data: [String: Any] = [
            "name": name,
            "type": type,
            "value": value,
            "description": description,
            "created_at": Timestamp()
        ]
        
        rewardRef.setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchRewardData(rewardId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let rewardRef = db.collection("rewards").document(rewardId)
        
        rewardRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                let data = document.data() ?? [:]
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Reward not found"])))
            }
        }
    }

    func fetchCollectionData(collectionName: String, completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void) {
        db.collection(collectionName).getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let querySnapshot = querySnapshot {
                completion(.success(querySnapshot.documents))
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Collection not found"])))
            }
        }
    }

    func updateDocumentData(collectionName: String, documentId: String, updatedData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collectionName).document(documentId).updateData(updatedData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func deleteDocumentData(collectionName: String, documentId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collectionName).document(documentId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func saveUserProgress(userId: String, missionId: String, progress: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        let userProgressRef = db.collection("user_progress").document(userId)
        let data: [String: Any] = [
            "mission_id": missionId,
            "progress": progress,
            "last_updated": Timestamp()
        ]
        
        userProgressRef.setData(data, merge: true) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchUserProgress(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let userProgressRef = db.collection("user_progress").document(userId)
        
        userProgressRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                let data = document.data() ?? [:]
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User progress not found"])))
            }
        }
    }

    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func signOutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
}
// Placeholder for \(file) content.
