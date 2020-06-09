//
//  ContentView.swift
//  Pushkin WatchLandmarks WatchKit Extension
//
//  Created by RAS on 08.06.2020.
//  Copyright © 2020 Anna Romanova. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    
    @EnvironmentObject private var userData: UserData

    var body: some View {
        SubView().environment(\.managedObjectContext, managedObjectContext).environmentObject(UserData())
    }
}


struct SubView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject private var userData: UserData
    
    @FetchRequest(entity: ItemCD.entity(),
                  sortDescriptors: [NSSortDescriptor (keyPath: \ItemCD.name, ascending: true)])
    var itemsListed: FetchedResults<ItemCD>
    
    @FetchRequest(entity: ItemCD.entity(),
                  sortDescriptors: [NSSortDescriptor (keyPath: \ItemCD.name, ascending: true)],
                  predicate: NSPredicate(format: "isVisited == false"))
    var itemsNotVisited: FetchedResults<ItemCD>
    
    
    var body: some View {
      
        ScrollView {
            
            Toggle(isOn: $userData.showNotVisitedOnly) {
                Text("Hide Visited")
            }
            
            if !self.userData.showNotVisitedOnly{
                ForEach(itemsListed, id: \.self) { object in
                    NavigationLink(destination: WatchItemCDDetail(item: object).environment(\.managedObjectContext, self.managedObjectContext)) {
                        WatchListRow(item: object)
                    }
                }
            }
            
            else{
                ForEach(itemsNotVisited, id: \.self) { object in
                    NavigationLink(destination: WatchItemCDDetail(item: object).environment(\.managedObjectContext, self.managedObjectContext)) {
                        WatchListRow(item: object)
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            ContentView()
                .previewDevice("Apple Watch Series 4 - 44mm")
            
            ContentView()
                .previewDevice("Apple Watch Series 2 - 38mm")
        }
    }
}
