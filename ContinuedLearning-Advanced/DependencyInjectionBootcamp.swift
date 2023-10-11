//
//  DependencyInjectionBootcamp.swift
//  ContinuedLearning-Advanced
//
//  Created by Volkan Celik on 05/10/2023.
//

import SwiftUI
import Combine

//PROBLEMS WITH SINGLETONS
//1.Singletons are global
//2.Cant customize the init
//3.Cant swap out service  we cant use another data service like in protocol we use exact class

protocol DataServiceProtocol{
    func getData()->AnyPublisher<[PostsModel],Error>
}


struct PostsModel:Identifiable,Codable{
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

class ProductionDataService:DataServiceProtocol{
    
    //static let instance=ProductionDataService()  //differents threads can reach at the same time
    
    let url:URL //to be able to change the url
    
    init(url:URL){
        self.url=url
    }
    
    func getData()->AnyPublisher<[PostsModel],Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService:DataServiceProtocol{
    
    let testData:[PostsModel]
    
    init(data:[PostsModel]?){
        self.testData=data ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "one"),
            PostsModel(userId: 2, id: 2, title: "Two", body: "two")]
    }

    
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap({$0})
            .eraseToAnyPublisher()
    }
    
    
}



class DependencyInjectionViewModel:ObservableObject{
    
    @Published var dataArray:[PostsModel]=[]
    var cancellables=Set<AnyCancellable>()
    let dataService:DataServiceProtocol
    
    init(dataService:DataServiceProtocol){
        self.dataService=dataService
        loadPosts()
    }
    
    private func loadPosts(){
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray=returnedPosts
            }
            .store(in: &cancellables)

    }
    
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var vm:DependencyInjectionViewModel
    
    init(dataService:DataServiceProtocol){
        _vm=StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(vm.dataArray){post in
                    Text(post.title)
                }
            }
        }
    }
}

#Preview {

    DependencyInjectionBootcamp(dataService: ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!))
}

//class Dependencies{                             //all dependencies  inject this class
//    let dataService:DataServiceProtocol
//    init(dataService:DataServiceProtocol){
//        self.dataService=dataService
//    }
//
//}
