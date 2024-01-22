//
//  dataAPI.swift
//  bernat.segura_oscar.julian
//
//  Created by Alumne on 23/11/2021.
//

import Foundation

class dataAPI {
    func getData(info tableInfo: Any, updateView: @escaping ([[String: Any]]) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")
        if let url = url {
            let task = session.dataTask(with: url) { data, response, error in
                // ERRORS LOCALS:
                guard error == nil else {
                    self.handleClientError(error)
                    return
                }
                //ERROR HTTP/S
                guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    self.handleServerError(response!)
                    return
                }
                //DADES
                if let data = data {
                    //let str = String(decoding: data, as: UTF8.self)
                    //print(str)
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDictionary = json as? [[String: Any]] {
                            updateView(jsonDictionary)
                            return
                        }
                    } catch {
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func uploadData(_ taskName: String) {
        var json = [String: Any]()
        json["title"] = taskName
        json["completed"] = false
        json["userId"] = 10
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options:[])
            let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")
            if let url = url {
                var session = URLRequest(url: url)
                session.httpMethod = "POST"
                session.httpBody = data
                session.addValue("application/json", forHTTPHeaderField: "Content-Type")
                session.addValue("application/json", forHTTPHeaderField: "Accept")

                let task = URLSession.shared.dataTask(with: session) { data, response, error in
                    // ERRORS LOCALS:
                    guard error == nil else {
                        self.handleClientError(error)
                        return
                    }
                    //ERROR HTTP/S
                    guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                        self.handleServerError(response!)
                        return
                    }
                    //DADES
                    if let httpResponse = response as? HTTPURLResponse{
                        if httpResponse.statusCode == 201{
                            print("Task created")
                        }
                    }
                }
                task.resume()
            }
        } catch {
            
        }
    }
    
    func handleClientError(_: Error?) {
        print("Client error")
        
    }
    
    func handleServerError(_: URLResponse) {
        print("Server error")
    }
}
