//
//  OrganizationForm.swift
//  itHelper2.0
//
//  Created by Felipe on 2/10/20.
//  Copyright © 2020 division. All rights reserved.
//

import SwiftUI

struct OrganizationForm: View {
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var companyName = ""
    @State var typeOfCompany = ""
    @State var address = ""
    @State var city = ""
    @State var state = ""
    @State var country = ""
    @State var zip = ""
    @State var image : Data = .init(count: 0)
    @State var show = false
    
    
    
    var body: some View {
        NavigationView {
            List{
                
                VStack(alignment: .center){
                    if self.image.count != 0{
                        Button(action:{
                                self.show.toggle()
                            }){
                                Image(uiImage: UIImage(data: self.image)!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 5))
                        }.buttonStyle(PlainButtonStyle())
                            
                        }else{
                            Button(action:{
                                self.show.toggle()
                            }){
                                Image(systemName: "photo")
                                .padding(.all, 37.0)
                               .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                                
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Text("+Add Photo")
                        .foregroundColor(Color.blue)
                   
                }.buttonStyle(BorderlessButtonStyle())
                 .offset(x: 145)
                    .sheet(isPresented: self.$show, content: {
                        ImagePicker(show: self.$show, image: self.$image)
                    })
            
                VStack(alignment: .leading){
                    Text("NAME")
                        .font(.headline)
                    TextField("Enter Company Name", text: $companyName).padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                }
                
                VStack(alignment: .leading){
                    Text("TYPE")
                        .font(.headline)
                    TextField("Enter Company's Occupation", text: $typeOfCompany).padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                }
                
                VStack(alignment: .leading){
                    Text("ADDRESS")
                        .font(.headline)
                    TextField("Enter Company's Address", text: $address).padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                }
                
                VStack(alignment: .leading){
                    Text("CITY")
                        .font(.headline)
                    TextField("Enter Company City", text: $city).padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                }
                
                VStack(alignment: .leading){
                    Text("STATE")
                        .font(.headline)
                    TextField("Enter Company's State", text: $state).padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                }
                
                VStack(alignment: .leading){
                    Text("ZIP CODE")
                        .font(.headline)
                    TextField("Enter ZIP Code", text: $zip).padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                }
                
                VStack(alignment: .leading){
                    Text("COUNTRY")
                        .font(.headline)
                    TextField("Enter Company's Country", text: $country).padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                }
            }
            
            .navigationBarTitle(Text("New Organization"))
            .navigationBarItems(trailing:
                               Button(action: {
                                guard self.companyName != "" else {return}
                                 let newOrg = Organization(context: self.managedObjectContext)
                                
                                newOrg.name = self.companyName
                                newOrg.type = self.typeOfCompany
                                newOrg.address = self.address
                                newOrg.city = self.city
                                newOrg.state = self.state
                                newOrg.logo = self.image
                                
                                do {
                                  try self.managedObjectContext.save()
                                  print("Order saved.")
                                  self.presentationMode.wrappedValue.dismiss()
                                } catch {
                                  print(error.localizedDescription)
                                }
                                
                                
                               }, label: {Text("Save")}))
        }
    }
}

struct OrganizationForm_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationForm()
    }
}
