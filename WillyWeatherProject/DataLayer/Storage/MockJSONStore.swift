import Foundation

public class MockJSONStore<T>: JSONCache<T> where T: Codable {
    
    var cache: [String: T] = [:]
    var isReturnedFromCache = false
    
    public override init(storageType: StorageType, isCachingEnabled: Bool = true) {
        super.init(storageType: storageType, isCachingEnabled: isCachingEnabled)
        
    }
    
    
    
    public override func save(_ object: T,uniquieIdentifier: String) {
        guard isCachingEnabled else { return }
        cache[uniquieIdentifier] = object
    }
    
    public override func storedValue(at uniquieIdentifier: String) -> T? {
        guard isCachingEnabled else {
            self.isReturnedFromCache = false
            return nil
        }
        
        if self.cache[uniquieIdentifier] != nil {
            self.isReturnedFromCache = true
            
        }
        return self.cache[uniquieIdentifier]
        
    }
    
    public override func cleanup() {
        self.cache = [:]
    }
    
    
}

