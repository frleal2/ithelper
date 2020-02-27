//
//  ContentView.swift
//  itHelper2.0
//
//  Created by Felipe on 2/7/20.
//  Copyright © 2020 division. All rights reserved.
//

import SwiftUI

struct orgRow: View {
    
    @State var image: Data = .init(count: 0)
    
    var orgs: Organization

    var body: some View {
        HStack{
            if orgs.logo.count != 0{
                Image(uiImage: UIImage(data: orgs.logo)!)
                .resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 2)
            }
            else{
                Image(systemName: "photo")
                .resizable()
                    .padding(.all, 25.0)
                    .frame(width: 75, height: 75)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 2)
            }
            VStack(alignment: .leading){
                Text(orgs.name).font(.headline)
                Text(orgs.type).font(.subheadline)
            }
            .padding(.leading, 5.0)
        }
    }
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Organization.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Organization.name, ascending: true)])
    var organizations: FetchedResults<Organization>
    
    @State var showOrganizationForm = false
  
    
    var body: some View {
        NavigationView{
            
            VStack{
                HStack{
                    List{
                        ForEach(organizations){organization in
                            NavigationLink(destination: OrgDetailView(orgs: organization)){
                                orgRow(orgs: organization)
                            }
                        }
                        .onDelete{
                            IndexSet in
                            for index in IndexSet{
                                self.managedObjectContext.delete(self.organizations[index])
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Organizations")
            .navigationBarItems(trailing: Button(action: {
                self.showOrganizationForm = true}, label: {
                    Image(systemName: "plus.circle")
                    .resizable()
                        .frame(width: 32, height: 32, alignment: .center)}))
                .sheet(isPresented: $showOrganizationForm){
                    OrganizationForm().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


