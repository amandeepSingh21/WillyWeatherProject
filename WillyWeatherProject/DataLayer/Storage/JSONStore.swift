import Foundation

public class JSONCache<T: Codable> {
    
    fileprivate let storageType: StorageType
    fileprivate var uniquieIdentifier: String = ""
    public var isCachingEnabled: Bool = true
    
    public init(storageType: StorageType, isCachingEnabled: Bool = true) {
        self.storageType = storageType
        self.isCachingEnabled = isCachingEnabled
        
    }
 
    
    public func save(_ object: T,uniquieIdentifier: String) {
        
    }
    
    public func storedValue(at uniquieIdentifier: String) -> T? {
        return nil
    }
    
    public func cleanup() {
        
    }
    
    
}



public class JSONStore<T>: JSONCache<T> where T: Codable {
    
    
    public override init(storageType: StorageType, isCachingEnabled: Bool = true) {
        super.init(storageType: storageType, isCachingEnabled: isCachingEnabled)
        ensureFolderExists()
    }
   
    
    
    public override func save(_ object: T,uniquieIdentifier: String) {
        guard isCachingEnabled else { return }
        self.uniquieIdentifier = uniquieIdentifier
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: fileURL)
        } catch let e {
            print("ERROR: \(e)")
        }
    }
    
    public override func storedValue(at uniquieIdentifier: String) -> T? {
        guard isCachingEnabled else { return nil }
        self.uniquieIdentifier = uniquieIdentifier
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(T.self, from: data)
        } catch let e {
            print("ERROR: \(e)")
            return nil
        }
    }
    
    public override func cleanup() {
        self.storageType.clearStorage()
    }

    
    private var folder: URL {
        return storageType.folder
    }
    
    private var fileURL: URL {
        return folder.appendingPathComponent(uniquieIdentifier)
    }
    
    private func ensureFolderExists() {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: folder.path, isDirectory: &isDir) {
            if isDir.boolValue {
                return
            }
            
            try? FileManager.default.removeItem(at: folder)
        }
        try? fileManager.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
    }
    
}

