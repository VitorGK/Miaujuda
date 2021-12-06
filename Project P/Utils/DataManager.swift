import Foundation

enum UrlRoute: String {
    case user = "/user"
    case petpost = "/petpost"
    case item = "/item"
}

class DataManager {
    public static var shared = DataManager()
    let baseUrl: String = "https://project-pets.herokuapp.com"
    
    // MARK: --- CREATE USER
    public func postRequest(route: UrlRoute, params: [String: String], completion: @escaping ([String: Any]?, Error?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: baseUrl + route.rawValue) else {
            completion(nil, nil)
            return
        }
        var request = URLRequest(url: url)
        let postString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = session.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let response = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(response as? [String : Any], nil)
                }
                else {
                    completion(nil, nil)
                }
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    // MARK: --- LOAD DATA
    //    public func loadData(_ completion: @escaping () -> Void) {
    //        let session = URLSession.shared
    //        let url = URL(string: baseUrl)
    //        guard let url = url else { return }
    //        let task = session.dataTask(with: url) { data, _, error in
    //            guard let data = data else { return }
    //            if error != nil {
    //                preconditionFailure(String(describing: error?.localizedDescription))
    //            }
    //            do {
    //                self.cohort = try JSONDecoder().decode(Cohort.self, from: data)
    //
    //                guard let cohort = self.cohort else { return }
    //                for student in cohort.students {
    //                    self.loadImage(student: student)
    //                }
    //
    //                DispatchQueue.main.async {
    //                    completion()
    //                }
    //            } catch {
    //                // FIXME: tratar o erro do decoder
    //                print("DEU RUIM NO PARSE")
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
}
