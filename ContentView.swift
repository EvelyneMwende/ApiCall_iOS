//
//  ContentView.swift
//  SwiftUIAPICalls
//
//  Created by Eclectics on 17/03/2022.
//

import SwiftUI

struct URLImage: View{
    let urlString: String
    
    @State var data :Data?
    
    var body: some View{
        //if we have the data show it
        if let data = data, let uiimage = UIImage(data: data){
                Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130, height: 70)
                .background(Color.gray)
            
        }else {
            //show placeholder image
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:130, height: 70)
                .background(Color.gray)
                .onAppear{
                    //call function
                    fetchData()
                }
        }
        
    }
    
    private func fetchData(){
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data,
            _, _ in
            self.data = data
        }
        
        task.resume()
    }
}
struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            List{
                //loop to show contents
                ForEach(viewModel.courses, id: \.self){
                    //Create a horizontal stack
                    course in HStack{
                        URLImage(urlString: course.image)
                            .frame(width:130, height: 70)
                            .background(Color.gray)
                        Text(course.name)
                            .bold()
                    }
                    .padding(3)
                        
                    }
                }.navigationTitle("Courses")
                .onAppear {
                    viewModel.fetch() //give back array of courses
            }
          }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
