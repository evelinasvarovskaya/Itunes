//
//  LocalDataService.swift
//  Itune project
//
//  Created by Эвелина Сваровская on 07.01.2023.
//

import CoreData
import Foundation

final class LocalDataService {

    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Itune_project")
        container.loadPersistentStores { _, _ in }
        return container
    }()

    func getImage(url: String) -> Data? {
        let fetchRequest = Image.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        do {
            let images = try container.viewContext.fetch(fetchRequest)
            
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            
            let image = images.first
            guard let uuid = image?.imageUUID else {
                print("No uuid in image")
                return nil
            }
            let imagePath = documentsDirectory.appending(path: uuid.uuidString)
            let imageData = try Data(contentsOf: imagePath)
            return imageData
        } catch {
            print(error)
            return nil
        }
    }
    
    func saveImage(name: String, image: Data) {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentsDirectory = paths[0]
        let uuid = UUID()
        documentsDirectory.append(path: uuid.uuidString)
        
        try? image.write(to: documentsDirectory)
        
        let context = container.newBackgroundContext()
        
        context.perform {
            print("Is main thread", Thread.isMainThread)
            let image = Image(context: context)
            image.imageUUID = uuid
            image.url = name
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

