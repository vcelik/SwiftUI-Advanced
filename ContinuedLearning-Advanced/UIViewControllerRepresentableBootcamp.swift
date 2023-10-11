//
//  UIViewControllerRepresentableBootcamp.swift
//  ContinuedLearning-Advanced
//
//  Created by Volkan Celik on 05/10/2023.
//

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    
    @State private var showScreen:Bool=false
    @State private var image:UIImage?=nil
    
    
    var body: some View {
        VStack{
            Text("hi")
            
            if let image=image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width:200,height: 200)
            }
            
            Button {
                showScreen.toggle()
            } label: {
                Text("Click here!")
            }
            .sheet(isPresented: $showScreen, content: {
                UIImagePickerControllerRepresentable(image: $image,showScreen: $showScreen)
                //BasicUIViewControllerRepresentable(labelText: "New text here")
            })

        }
    }
}

#Preview {
    UIViewControllerRepresentableBootcamp()
}

struct UIImagePickerControllerRepresentable:UIViewControllerRepresentable{
    
    @Binding var image:UIImage?
    @Binding var showScreen:Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc=UIImagePickerController()
        vc.allowsEditing=false
        vc.delegate=context.coordinator
        return vc
    }
    
    //from SwiftUI to UIKit
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    //from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image,showScreen: $showScreen)
    }
    
    class Coordinator:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        @Binding var image:UIImage?
        @Binding var showScreen:Bool
        
        init(image:Binding<UIImage?>,showScreen:Binding<Bool>){
            self._image=image
            self._showScreen=showScreen
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let newImage=info[.originalImage] as? UIImage else {return}
            image=newImage
            showScreen=false
        }
    }
}

struct BasicUIViewControllerRepresentable:UIViewControllerRepresentable{
    
    let labelText:String
    
    func makeUIViewController(context: Context) -> some UIViewController {
//        let vc=UIViewController()
//        vc.view.backgroundColor = .blue
//        
//        let label=UILabel()
//        label.text=labelText
//        label.textColor=UIColor.white
//        
//        vc.view.addSubview(label)
//        label.frame=vc.view.frame
        let vc=MyFirstViewController()
        vc.labelText=labelText
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class MyFirstViewController:UIViewController{
    
    var labelText:String="Starting value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let label=UILabel()
        label.text=labelText
        label.textColor=UIColor.white
        
        view.addSubview(label)
        label.frame=view.frame
    }
}
