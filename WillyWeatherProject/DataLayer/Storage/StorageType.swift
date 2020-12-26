import Foundation

public enum StorageType {
    case cache
    case permanent
    
    private var searchPathDirectory: FileManager.SearchPathDirectory {
        switch self {
        case .cache: return .cachesDirectory
        case .permanent: return .documentDirectory
        }
    }
    
    public var folder: URL {
        let path = NSSearchPathForDirectoriesInDomains(self.searchPathDirectory, .userDomainMask, true).first!
        let subfolder = "com.md.WillyWeatherProject.json_storage"
        return URL(fileURLWithPath: path).appendingPathComponent(subfolder)
    }
    
    public func clearStorage() {
        try? FileManager.default.removeItem(at: folder)
    }
}
