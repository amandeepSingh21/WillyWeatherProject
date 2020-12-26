import Foundation

enum StorageType {
    case cache
    case permanent
    
    var searchPathDirectory: FileManager.SearchPathDirectory {
        switch self {
        case .cache: return .cachesDirectory
        case .permanent: return .documentDirectory
        }
    }
    
    var folder: URL {
        let path = NSSearchPathForDirectoriesInDomains(self.searchPathDirectory, .userDomainMask, true).first!
        let subfolder = "com.md.WillyWeatherProject.json_storage"
        return URL(fileURLWithPath: path).appendingPathComponent(subfolder)
    }
    
    func clearStorage() {
        try? FileManager.default.removeItem(at: folder)
    }
}
