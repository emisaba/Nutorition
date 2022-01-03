import UIKit

struct SpiceService {
    
    static func uploadSpice(spiceInfos: [SpiceInfo], completion: @escaping(String) -> Void) {
        
        let ref = COLLECTION_SPICES.document()
        let spiceID = ref.documentID
        
        var names: [String] = []
        var amounts: [String] = []
        
        spiceInfos.forEach { spiceInfo in
            names.append(spiceInfo.name)
            amounts.append(spiceInfo.amount)
        }
        
        let data: [String: Any] = ["spiceID": spiceID,
                                   "names": names,
                                   "amounts": amounts]
        
        ref.setData(data) { error in
            if let error = error {
                print("failed to upload ingredient info: \(error.localizedDescription)")
                return
            }
            
            completion(spiceID)
        }
    }
}
