//
//  ContactDetailView.swift
//  itHelper2.0
//
//  Created by Felipe on 2/27/20.
//  Copyright © 2020 division. All rights reserved.
//

import SwiftUI
import CoreData

struct ContactDetailView: View {
    
    let cons: Contact
    
    var body: some View {
        Text(cons.firstName)
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
        let cons = Contact(context: moc)
        
        return NavigationView{
            
            ContactDetailView(cons: cons)
            
        }
    }
}
