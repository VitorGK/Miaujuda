import Foundation
import AuthenticationServices

enum UrlRoute: String {
    case user = "/user"
    case petpost = "/petpost"
    case item = "/item"
    case auth = "/auth/login"
    case validate = "/auth/profile"
}

class ServerService {
    public static var shared = ServerService()
    let baseUrl: String = "https://project-pets.herokuapp.com"
    
    // MARK: --- POST REQUEST
    public func postRequest(route: UrlRoute, params: [String: Any], completion: @escaping ([String: Any]?, Error?) -> Void) {
//        let session = URLSession.shared
//        guard let url = URL(string: baseUrl + route.rawValue) else {
//            completion(nil, nil)
//            return
//        }
//        var request = URLRequest(url: url)
//        let postString = params.map {
//            "\($0.0)=\($0.1)"
//        }
//        .joined(separator: "&")
//        request.httpMethod = "POST"
//        request.httpBody = postString.data(using: String.Encoding.utf8)
//        let task = session.dataTask(with: request) { data, response, error in
//            do {
//                if let data = data {
//                    let response = try JSONSerialization.jsonObject(with: data, options: [])
//                    completion(response as? [String : Any], nil)
//                } else {
//                    completion(nil, nil)
//                }
//            } catch let error {
//                completion(nil, error)
//            }
//        }
//        task.resume()
    }
    
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

    // MARK: --- AUTH USER (GET JWT TOKEN)
    func authenticate(appleID: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + UrlRoute.auth.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let appleIdData = ["appleID": appleID]
        guard let httpBody = try? JSONEncoder().encode(appleIdData) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    guard let responseJson = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                    completion(.success(responseJson))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
    
    // MARK: --- GET REQUEST
    func getRequest(route: UrlRoute, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + route.rawValue) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "JWT_TOKEN") ?? "")", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    guard let responseJson = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                    completion(.success(responseJson))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
}
