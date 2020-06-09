//
//  WatchListRow.swift
//  Pushkin WatchLandmarks Extension
//
//  Created by RAS on 06.06.2020.
//  Copyright © 2020 Anna Romanova. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import CoreData

struct WatchListRow: View {
    
    @ObservedObject var item: ItemCD
        
    var body: some View {
        
        VStack (alignment: .leading) {
            
            HStack {
                Text(item.name!)
                    .font(.headline)
                
                Spacer()
                
                if item.isVisited {
                    Image(systemName: "checkmark.seal.fill")
                        .imageScale(.medium)
                        .foregroundColor(.red)
                }
                else{
                    Image(systemName: "checkmark.seal")
                        .imageScale(.medium)
                        .foregroundColor(.gray)
                }
            }
            
            Text(item.type!)
                .font(.footnote)

        }
    }
}
