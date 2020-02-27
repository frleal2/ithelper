//
//  ContactForm.swift
//  itHelper2.0
//
//  Created by Felipe on 2/23/20.
//  Copyright © 2020 division. All rights reserved.
//

import SwiftUI
import CoreData

struct ContactForm: View {
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let orgs: Organization
    
    
    @State var first_Name = ""
    @State var lastName = ""
    @State var email = ""
    @State var phone = ""
    
    
    var body: some View {
        NavigationView{
            List{
                Section(){
                    TextField("Enter First Name", text: $first_Name)
                    TextField("Enter Last Name", text: $lastName)
                    //TextField("Ocupation", text: $firstName)
                }
                
                Section(){
                    TextField("Enter Phone Number", text: $phone)
                    TextField("Enter E-mail", text: $email)
                }
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("New Contact", displayMode: .inline)
            .navigationBarItems(trailing:
            Button(action: {
             guard self.first_Name != "" else {return}
                
              let newContact = Contact(context: self.managedObjectContext)
             
                newContact.firstName = self.first_Name
                newContact.lastName = self.lastName
                newContact.email = self.email
                newContact.phone = self.phone
                //newContact.organization = self.orgs
                
                self.orgs.addToContact(newContact)
             
             do {
               //try self.managedObjectContext.save()
               print("Contact saved.")
                print(self.orgs.name)
               self.presentationMode.wrappedValue.dismiss()
             } //catch {
               //print(error.localizedDescription)
             //}
             
             
            }, label: {Text("Save")}))
        }
    }
}


struct ContactForm_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let orgs = Organization(context: moc)
        
        return NavigationView{
            
            ContactsView(orgs: orgs)
            
        }
    }
}
