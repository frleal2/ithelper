//
//  orgDetailView.swift
//  itHelper2.0
//
//  Created by Felipe on 2/11/20.
//  Copyright © 2020 division. All rights reserved.
//

import SwiftUI
import CoreData

struct profileImage: View {
    
    @State var image: Data = .init(count: 0)
    
    let orgs: Organization
    
    var body: some View {
        
        VStack{
            if orgs.logo.count != 0{
                Image(uiImage: UIImage(data: orgs.logo)!)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 2)
                .offset(y: -15)
            }
            else{
                Image(systemName: "photo")
                    .resizable()
                    .padding(.all, 33.0)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 2)
                    .offset(y: -15)
            }
        }
        .padding(.vertical, 25.0)
    }
}

struct contactInfo: View{
    
    let orgs: Organization
    
    var body: some View{
        
        List{
            VStack(alignment: .leading) {
                Text("Type").font(.headline).padding(.bottom, 5.0)
                Text(orgs.type).font(.subheadline)
            }
            VStack(alignment: .leading) {
                Text("Address").font(.headline).padding(.bottom, 5.0)
                Text(orgs.address).font(.subheadline)
            }
            
            VStack(alignment: .leading) {
                Text("City").font(.headline).padding(.bottom, 5.0)
                Text(orgs.city).font(.subheadline)
            }
            
            VStack(alignment: .leading) {
                Text("State").font(.headline).padding(.bottom, 5.0)
                Text(orgs.state).font(.subheadline)
            }
            
            VStack(alignment: .leading) {
                Text("Country").font(.headline).padding(.bottom, 5.0)
                Text(orgs.country).font(.subheadline)
            }
        }.listStyle(GroupedListStyle())
            //.offset()
    }
}

struct horizontalMenu: View{
    
    let orgs: Organization
    
    var body: some View{
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20) {
                
                NavigationLink(destination: ContactsView(orgs: orgs)){
                    VStack {
                        Image(systemName: "person")
                            .resizable()
                            .padding(.all, 20.0)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            .shadow(radius: 2)
                        Text("Contacts")
                            .font(.headline)
                    }.frame(width: 85, height: 120)
                }
                
                VStack {
                    Image(systemName: "desktopcomputer")
                        .resizable()
                        .padding(.all, 20.0)
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 2)
                    Text("Servers")
                        .font(.headline)
                }.frame(width: 85, height: 120)
            
                VStack {
                    
                    Image(systemName: "list.bullet")
                        .resizable()
                        .padding(.all, 20.0)
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 2)
                    Text("IP's")
                        .font(.headline)
                }.frame(width: 85, height: 120)
                
                VStack {
                    Image(systemName: "envelope")
                        .resizable()
                        .padding(.all, 20.0)
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 2)
                     Text("POP/IMAP")
                        .font(.headline)
                }.frame(width: 85, height: 120)
                
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .padding(.all)
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 2)
                    Text("Contacts")
                        .font(.headline)
                }.frame(width: 85, height: 120)
            }
        }
        .padding(.horizontal)
        
    }
}

struct OrgDetailView: View {
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let orgs: Organization
    
    var body: some View {
        VStack{
                
            profileImage(orgs: orgs)
            
            horizontalMenu(orgs: orgs)
                
            contactInfo(orgs: orgs)
                
            
        }
        .navigationBarTitle(orgs.name)
    }
}

struct orgDetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let orgs = Organization(context: moc)
        
        return NavigationView{
            
            OrgDetailView(orgs: orgs)
        }
    }
}
