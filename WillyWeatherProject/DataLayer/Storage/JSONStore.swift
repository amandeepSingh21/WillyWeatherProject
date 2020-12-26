import Foundation

public class JSONStorage<T> where T: Codable {
    
    
    private let storageType: StorageType
    private var filename: String
    
    public init(storageType: StorageType, filename: String) {
        self.storageType = storageType
        self.filename = filename
        self.ensureFolderExists()
    }
    
    
    public func save(_ object: T,filename: String) {
        self.filename = filename
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: fileURL)
        } catch let e {
            print("ERROR: \(e)")
        }
    }
    
    public func storedValue(at filename: String) -> T? {
        self.filename = filename
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
    
    
    private var folder: URL {
        return storageType.folder
    }
    
    private var fileURL: URL {
        return folder.appendingPathComponent(filename)
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
