//
//  WatchItemCDDetail.swift
//  Pushkin WatchLandmarks Extension
//
//  Created by RAS on 04.06.2020.
//  Copyright © 2020 Anna Romanova. All rights reserved.
//

import SwiftUI
import CoreData

struct WatchItemCDDetail: View {
    
    @ObservedObject var item: ItemCD
    var managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                Image(uiImage: UIImage(data: item.img!)!)
                    .resizable()
                    .frame(width: 125.0, height: 125.0)
                    .cornerRadius(5.0)
                    .scaledToFit()
                
                Text(item.name!)
                    .font(.footnote)
                    .lineLimit(4)
                
                Button(action: {
                   self.updateItem(self.item)
                })
                {
                    if self.item.isVisited {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(Color.red)
                    } else {
                        Image(systemName: "checkmark.seal")
                            .foregroundColor(Color.gray)
                    }
                }
                
                Divider()
                
                Text(item.site!.absoluteString)
                    .font(.footnote)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                
                Text(item.address!)
                    .font(.caption)
                
                Divider()
                
                WatchMapView(item: item)
                    .scaledToFit()
                    .padding()
                
                Divider()
                
                Text(item.descript!)
                    .multilineTextAlignment(.center)
            }
            .padding(16)
        }
        .navigationBarTitle("Pushkin Landmarks")
    }
    
    func updateItem(_ item: ItemCD){
        
        var isVisited: Bool
        
        if item.isVisited == false{
            isVisited = true
        }
        else{
            isVisited = false
        }
        
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ItemCD")
        fetchRequest.predicate = NSPredicate(format: "name == %@", item.name!)
        fetchRequest.fetchLimit = 1

        do {
            let test = try managedObjectContext.fetch(fetchRequest)
            
            managedObjectContext.performAndWait{
                let setUpdate = test[0] as! NSManagedObject
                setUpdate.setValue(isVisited, forKey: "isVisited")
                try? managedObjectContext.save()
            }
            
        } catch {
            print(error)
        }
    }
    
}


