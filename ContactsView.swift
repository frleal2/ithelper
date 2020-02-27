//
//  ContactsView.swift
//  itHelper2.0
//
//  Created by Felipe on 2/21/20.
//  Copyright © 2020 division. All rights reserved.
//

import SwiftUI
import CoreData

struct ContactsRow: View{
    
    var cons: Contact
    
    var body: some View{
        VStack{
            Text(cons.firstName)
        }
    }
}

struct ContactsView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let orgs: Organization
    
    @State var showContactForm = false
    
    var body: some View {
        VStack{
            List{
                ForEach(self.orgs.contactArray){contact in
                    NavigationLink(destination: ContactDetailView(cons: contact)){
                            VStack {
                                Text(contact.firstName).font(.headline)
                                //Text(contact.lastName).font(.subheadline)
                            }
                        }
                    
                }
                .onDelete{
                    IndexSet in
                    for index in IndexSet{
                        self.managedObjectContext.delete(self.orgs.contactArray[index])
                    }
                }
            }
        }
    .navigationBarTitle("Contacts")
    .navigationBarItems(trailing: Button(action: {
        self.showContactForm = true}, label: {
            Image(systemName: "plus.circle")
            .resizable()
                .frame(width: 32, height: 32, alignment: .center)}))
        .sheet(isPresented: $showContactForm){
            ContactForm(orgs: self.orgs).environment(\.managedObjectContext, self.managedObjectContext)
    }
    }
}

struct ContactsView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let orgs = Organization(context: moc)
        
        return NavigationView{
            
            ContactsView(orgs: orgs)
            
        }
        
    }
}
