//
//  ExtensionDelegate.swift
//  Pushkin WatchLandmarks WatchKit Extension
//
//  Created by RAS on 08.06.2020.
//  Copyright © 2020 Anna Romanova. All rights reserved.
//

import WatchKit
import CoreData


class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        
        firstLoad()
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Pushkin_Landmarks")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func firstLoad(){
        
        let previouslyLaunched =
          UserDefaults.standard.bool(forKey: "previouslyLaunched")
        
        //check if first lunch
        if !previouslyLaunched {
            
            let modelName = "Pushkin_Landmarks"
        
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
            
            // Default directory where the CoreDataStack will store its files
            let directory = NSPersistentContainer.defaultDirectoryURL()
            
            let url = directory.appendingPathComponent(
               modelName + ".sqlite")
            
            // 2: Copying the SQLite file
            let seededDatabaseURL = Bundle.main.url(
              forResource: modelName,
              withExtension: "sqlite")!
            
            _ = try? FileManager.default.removeItem(at: url)

            do {
              try FileManager.default.copyItem(at: seededDatabaseURL,
                                               to: url)
            } catch let nserror as NSError {
              fatalError("Error: \(nserror.localizedDescription)")
            }
            
            // 3: Copying the SHM file
            let seededSHMURL = Bundle.main.url(forResource: modelName,
              withExtension: "sqlite-shm")!
            let shmURL = directory.appendingPathComponent(
              modelName + ".sqlite-shm")

            _ = try? FileManager.default.removeItem(at: shmURL)

            do {
              try FileManager.default.copyItem(at: seededSHMURL,
                                               to: shmURL)
            } catch let nserror as NSError {
              fatalError("Error: \(nserror.localizedDescription)")
            }
            
            // 4: Copying the WAL file
            let seededWALURL = Bundle.main.url(forResource: modelName,
              withExtension: "sqlite-wal")!
            let walURL = directory.appendingPathComponent(
              modelName + ".sqlite-wal")

            _ = try? FileManager.default.removeItem(at: walURL)

            do {
              try FileManager.default.copyItem(at: seededWALURL,
                                               to: walURL)
            } catch let nserror as NSError {
              fatalError("Error: \(nserror.localizedDescription)")
            }
            
        }
    }

}
