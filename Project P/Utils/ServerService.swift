import Foundation
import AuthenticationServices

enum UrlRoute: String {
    case user = "/user"
    case petpost = "/petpost"
    case item = "/item"
    case authUser = "/user/auth/login"
}

class ServerService {
    public static var shared = ServerService()
    let baseUrl: String = "https://project-pets.herokuapp.com"
    
//    var petPosts: [PetPost:[Item]]
    
    // MARK: --- CREATE USER / PETPOST / ITEMS
    public func postRequest(route: UrlRoute, params: [String: Any], completion: @escaping ([String: Any]?, Error?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + route.rawValue) else {
            completion(nil, nil)
            return
        }
        var request = URLRequest(url: url)
        let postString = params.map {
            "\($0.0)=\($0.1)"
        }
        .joined(separator: "&")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let response = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(response as? [String : Any], nil)
                } else {
                    completion(nil, nil)
                }
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    // MARK: --- LOAD DATA
//    public func getRequest(route: UrlRoute) {
//        let session = URLSession.shared
//        guard let url = URL(string: baseUrl + route.rawValue) else { return }
//        let task = session.dataTask(with: url) { data, response, error in
//            do {
//                if let data = data {
//                    let string = String(data: data, encoding: .utf8)
//
//                }
//            } catch let error {
//                print(error)
//            }
//        }
//        task.resume()
//    }
    
    // MARK: --- LOAD IMAGE
    //    public func loadImage(student: Student) {
    //        let urlString: String = baseUrl + student.imageUrl
    //        guard let url: URL = URL(string: urlString) else { return }
    //        DispatchQueue.global(qos: .utility).async {
    //            guard let data = try? Data(contentsOf: url) else { return }
    //            guard let image = UIImage(data: data) else { return }
    //            self.imageCache.setObject(image, forKey: NSNumber(value: student.tia))
    //        }
    //    }
    
    func create(user: User/*, completion: @escaping (Result<User, Error>) -> Void*/) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + UrlRoute.user.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONEncoder().encode(user) else { return }
        print("httpBody:\n\(String(data: httpBody, encoding: String.Encoding.utf8)!)")
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let res = try JSONSerialization.jsonObject(with: data, options: [])
                    print(res)
                } catch let error {
                    print(error)
                }
            }
        }
        .resume()
    }

    func authenticate(appleID: String/*, completion: @escaping (Result<User, Error>) -> Void*/) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + UrlRoute.authUser.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let appleIdData = ["appleID": appleID]
        guard let httpBody = try? JSONEncoder().encode(appleIdData) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let res = try JSONSerialization.jsonObject(with: data, options: [])
                    print(res)
                } catch let error {
                    print(error)
                }
            }
        }
        .resume()
        
//        session.dataTask(with: request) { data, _, error in
//            if let data = data {
//                do {
//                    let res = try JSONDecoder().decode(User.self, from: data)
//                    DispatchQueue.main.async {
////                        completion(.success(res))
//                    }
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//        .resume()
    }
}
