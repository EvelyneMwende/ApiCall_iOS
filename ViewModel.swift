//
//  ViewModel.swift
//  SwiftUIAPICalls
//
//  Created by Eclectics on 17/03/2022.
//

import Foundation
import SwiftUI
struct Course: Hashable, Codable{
    let name:String
    let image: String
}

class ViewModel: ObservableObject{
    //every time the array is updated the view will know it needs to update
    @Published var courses:[Course] = []
    func fetch(){
        guard let url = URL(string:
            "https://iosacademy.io/api/v1/courses/index.php")
        else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _,
            error in
            guard let data = data, error == nil else{
                return
            }
            
            //Convert to JSON
            do{
                let courses = try JSONDecoder().decode([Course].self,
                    from:data)
                DispatchQueue.main.async {
                    //ui updates done on main thread
                    self?.courses = courses
                }
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
}

