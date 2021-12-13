import Foundation
import AuthenticationServices

enum UrlRoute: String {
    case user = "/user"
    case petpost = "/petpost"
    case item = "/item"
    case auth = "/auth/login"
//    case validate = "/auth/profile"
}

class ServerService {
    public static var shared = ServerService()
    let baseUrl: String = "https://project-pets.herokuapp.com"
    private let jwtToken = UserDefaults.standard.string(forKey: "jwtToken")
    
    // MARK: --- POST REQUEST
    public func postRequest(route: UrlRoute, body: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + route.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else { return }
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
    func getRequest(route: UrlRoute, id: String = "", completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + route.rawValue + (id != "" ? "/" + id : "")) else { return }
        var request = URLRequest(url: url)
        guard let jwtToken = self.jwtToken else { return }
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
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
