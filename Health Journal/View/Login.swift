//
//  Login.swift
//  Health Journal
//
//  Created by Sadrac Tijerina on 11/9/20.
//  Copyright © 2020 M-A-I-D-S. All rights reserved.
//

import SwiftUI

struct Login: View {
    var body: some View {
        
        NavigationView{
            Home()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .navigationBarHidden(true)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

struct Home: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack{
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 100)
                    .padding(.vertical)
                
                HStack{
                    VStack(alignment: .leading, spacing: 12, content: {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Please sign in to continue")
                            .foregroundColor(Color.white.opacity(0.5))
                    })
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .padding(.leading, 15)
                
                HStack{
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    TextField("Email", text: $email)
                }
                .padding()
                .background(Color.white.opacity(email == "" ? 0 : 0.12))
                .cornerRadius(10)
                .padding(.horizontal)
                
                HStack{
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    SecureField("Password", text: $password)
                }
                .padding()
                .background(Color.white.opacity(password=="" ? 0 : 0.12))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Login")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("BackgroundColor"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("ThemeBlue"))
                        .clipShape(Capsule())
                })
                .padding(.top)
                .disabled(email != "" && password != "" ? false : true)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Forgot Password?")                        .foregroundColor(Color("ThemeBlue"))

                })
                .padding(.top, 8)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 6) {
                    Text("Don't have an account? ")
                        .foregroundColor(Color.white.opacity(0.6))
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Register")
                            .fontWeight(.bold)
                            .foregroundColor(Color("ThemeBlue"))
                    })
                }
                .padding(.vertical)
            }
            .background(Color("BackgroundColor").ignoresSafeArea(.all, edges: .all))
        } else {
            // Fallback on earlier versions
        }
    }
}
