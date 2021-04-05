//
//  Service.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 03/04/21.
//

import Foundation
import UIKit
import SystemConfiguration
class Service:NSObject {
    
    static let shared = Service()
    override init() {
    }
    
    let Base_URL = "http://139.59.83.144:9050/api"
    
    
    func GETResults<Element: Decodable>(extraParam : String,targetView:UIViewController,myStruct: Element.Type, onTaskCompleted : @escaping (Decodable)->(Void),onTryAgain :  @escaping (Bool) -> ()) {
        
      
            
            guard let url = URL(string:extraParam) else{return}
            
            print(url)
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    if error?._code == NSURLErrorTimedOut {
                        DispatchQueue.main.async {
                           
                            let alert = UIAlertController(title: "The server request timed out", message: "", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.cancel, handler: { (act) in
                                onTryAgain(true)
                            }))
                            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { (act2) in
                                targetView.dismiss(animated: true, completion: nil)
                            }))
                            targetView.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    guard let dataIs = data else { return }
                    
                    do {
                        let res = try JSONDecoder().decode(myStruct.self, from: dataIs)
                        DispatchQueue.main.async {
                            onTaskCompleted(res)
                        }
                        
                    }catch {
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Unable to Process Your Request", message: "", preferredStyle: UIAlertController.Style.alert)
                           
                            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.cancel, handler: { (act) in
                                onTryAgain(true)
                            }))
                            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { (act2) in
                                targetView.dismiss(animated: true, completion: nil)
                            }))
                            targetView.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                
                }.resume()
    }
//        }else {
//            DispatchQueue.main.async {
//                onAnimationStop(true)
//                let alert = UIAlertController(title: "No Internet Connection", message: "", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: { (act) in
//                    onTryAgain(true)
//                }))
//                alert.addAction(UIAlertAction(title: "Go To Settings", style: UIAlertAction.Style.default, handler: { (act1) in
//                    targetView.dismiss(animated: true, completion: nil)
//                    if let url = URL(string:"App-Prefs:root=Settings&path=General") {
//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    }
//                }))
//                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { (act2) in
//                    targetView.dismiss(animated: true, completion: nil)
//                }))
//                targetView.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
    
    func POSTService<Element: Codable>(serviceType : String, postString : NSDictionary,targetView:UIViewController,myStruct: Element.Type, onTaskCompleted : @escaping (Codable)->(Void),onTryAgain :  @escaping (Any) -> ())
       // ,onerrorResponse: @escaping (Any) -> (Void)
    {
        
        guard let url = URL(string: "\(Base_URL)/\(serviceType)") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: postString, options: [])
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(urlRequest)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard  let httpResponse = response as? HTTPURLResponse else{return}
            print("StatusCode",httpResponse.statusCode)
            print(data)
            onTryAgain(error?.localizedDescription ?? "")
          //  print("Error",error?.localizedDescription)
           // onerrorResponse(httpResponse.statusCode)
            if error != nil {
                guard let error = error else{return}
                onTryAgain(error)
                print(error as Any)
            } else {
                
                do {
                    guard let dataIs = data else { return }
                    let res = try JSONDecoder().decode(myStruct.self, from: dataIs)
                    DispatchQueue.main.async {
                        print(res)
                        onTaskCompleted(res)
                    }
                    
                }catch {
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                       // onTryAgain(error)
                    }
                    
                    
                }
            }
            }.resume()
        
        
        
        
    }
    
}
