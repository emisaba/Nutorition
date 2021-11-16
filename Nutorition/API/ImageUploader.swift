import FirebaseStorage

struct ImageUploader {
    
    static func uploadFoodImage(image: UIImage, completion: @escaping((String) -> Void)) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/food_category/\(fileName)")
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            ref.downloadURL { url, error in
                guard let urlString = url?.absoluteString else { return }
                completion(urlString)
            }
        }
    }
}
