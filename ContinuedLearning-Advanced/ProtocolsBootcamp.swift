//
//  ProtocolsBootcamp.swift
//  ContinuedLearning-Advanced
//
//  Created by Volkan Celik on 05/10/2023.
//

import SwiftUI

struct DefaultColorTheme:ColorThemeProtocol{
    let primary:Color = .blue
    let secondary:Color = .white
    let tertiary:Color = .gray
}

struct AlternativeColorTheme:ColorThemeProtocol{
    let primary:Color = .blue
    let secondary:Color = .white
    let tertiary:Color = .green
}

protocol ColorThemeProtocol{
    var primary:Color {get}
    var secondary:Color {get}
    var tertiary:Color {get}
}

struct AnotherColorTheme:ColorThemeProtocol{
    var primary: Color = .blue
    var secondary: Color = .red
    var tertiary: Color = .purple
}

protocol ButtonTextProtocol{
    var buttonText:String {get}
}

protocol ButtonPressedProtocol{
    func buttonPressed()
}

protocol ButtonDataSourceProtocol:ButtonTextProtocol,ButtonPressedProtocol{
    
}

class DefaultDataSource:ButtonDataSourceProtocol{
    var buttonText:String="Protocols are awesome"
    
    func buttonPressed(){
        print("Button was pressed")
    }
}

class AlternativetDataSource:ButtonTextProtocol{
    func buttonPressed() {
        
    }
    
    var buttonText:String="Protocols are lame."
}

struct ProtocolsBootcamp: View {
    
    //let colorTheme:DefaultColorTheme = DefaultColorTheme()
    //let colorTheme:AlternativeColorTheme = AlternativeColorTheme()
    //let colorTheme:ColorThemeProtocol = AlternativeColorTheme()
    let colorTheme:ColorThemeProtocol
    let datasource:ButtonDataSourceProtocol
    //let datasource2:ButtonPressedProtocol

    var body: some View {
        ZStack{
            colorTheme.tertiary
                .ignoresSafeArea()
            Text(datasource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    datasource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: DefaultColorTheme(),datasource: DefaultDataSource())
}
