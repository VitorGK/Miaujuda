import Foundation
import AuthenticationServices

class ServerService {
    public static var shared = ServerService()
    private let baseUrl: String = "https://project-pets.herokuapp.com"
    private let jwtToken = UserDefaults.standard.string(forKey: "jwtToken")
    
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
    
    // MARK: --- GET ALL POSTS
    func getAllPetPosts(completion: @escaping (Result<[PetPost], Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + UrlRoute.petPost.rawValue) else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let responseJson = try JSONDecoder().decode([PetPost].self, from: data)
                    completion(.success(responseJson))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
    
    // MARK: --- Get Latest PetPost and User data
    func getLatestPetPost(completion: @escaping (Result<PetPostAndUser, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + UrlRoute.latestPetPost.rawValue) else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let petPostAndUserData = try JSONDecoder().decode(PetPostAndUser.self, from: data)
                    completion(.success(petPostAndUserData))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
    
    // MARK: --- GET USER BY ID
        func getUser(by id: String, completion: @escaping (Result<User, Error>) -> Void) {
            let session = URLSession.shared
            guard let url = URL(string: baseUrl + UrlRoute.user.rawValue + id) else {
//                assertionFailure()
//                completion(.failure(NSError(domain: "Invalid URL", code: Int(errSecParam))))
                return
            }
            var request = URLRequest(url: url)
            guard let jwtToken = self.jwtToken else {
                //assertionFailure()
//                completion(.failure(NSError(domain: "Invalid JWT", code: Int(errSecAuthFailed))))
                return
            }
            
            request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")

            session.dataTask(with: request) { data, _, error in
                if let data = data {
                    do {
//                        let JSONString = String(data: data, encoding: .utf8)
//                        print(JSONString)
                        let responseJson = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(responseJson))
                    } catch {
                        print(error)
                        completion(.failure(error))
                    }
                } /*else if let error = error {
                    completion(.failure(error))
                } else {
                    assertionFailure()
                    completion(.failure(NSError(domain: "Unexpected code", code: Int(errSecInvalidScope))))
                }*/
            }
            .resume()
        }
    
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
}
