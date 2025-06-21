import Foundation

class Logger {
    
    static let shared = Logger()
    
    private var logFileURL: URL
    private var logQueue: DispatchQueue
    private let fileManager = FileManager.default
    private let maxLogSize = 50 * 1024 * 1024 // 50 MB
    
    private init() {
        logQueue = DispatchQueue(label: "com.dunyakasifi.loggerQueue", qos: .background)
        
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        logFileURL = documentsDirectory.appendingPathComponent("app_log.txt")
        
        if !fileManager.fileExists(atPath: logFileURL.path) {
            fileManager.createFile(atPath: logFileURL.path, contents: nil, attributes: nil)
        }
    }
    
    func logInfo(message: String) {
        log(message: message, level: .info)
    }
    
    func logWarning(message: String) {
        log(message: message, level: .warning)
    }
    
    func logError(message: String) {
        log(message: message, level: .error)
    }
    
    func logDebug(message: String) {
        log(message: message, level: .debug)
    }
    
    private func log(message: String, level: LogLevel) {
        let timestamp = getCurrentTimestamp()
        let logMessage = "[\(timestamp)] [\(level.rawValue)] \(message)\n"
        
        logQueue.async {
            self.appendLog(logMessage)
        }
    }
    
    private func appendLog(_ message: String) {
        let logData = Data(message.utf8)
        
        if let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(logData)
            fileHandle.closeFile()
        } else {
            try? logData.write(to: logFileURL)
        }
        
        checkLogFileSize()
    }
    
    private func checkLogFileSize() {
        if let fileSize = try? fileManager.attributesOfItem(atPath: logFileURL.path)[.size] as? Int, fileSize ?? 0 > maxLogSize {
            rotateLogFile()
        }
    }
    
    private func rotateLogFile() {
        let backupFileURL = logFileURL.deletingPathExtension().appendingPathExtension("bak")
        
        do {
            try fileManager.moveItem(at: logFileURL, to: backupFileURL)
            fileManager.createFile(atPath: logFileURL.path, contents: nil, attributes: nil)
        } catch {
            print("Failed to rotate log file: \(error)")
        }
    }
    
    func getLogs(completion: @escaping (String) -> Void) {
        logQueue.async {
            if let logContents = try? String(contentsOf: self.logFileURL, encoding: .utf8) {
                completion(logContents)
            } else {
                completion("Failed to read log file.")
            }
        }
    }
    
    func clearLogs() {
        logQueue.async {
            do {
                try self.fileManager.removeItem(at: self.logFileURL)
                self.fileManager.createFile(atPath: self.logFileURL.path, contents: nil, attributes: nil)
            } catch {
                print("Failed to clear log file: \(error)")
            }
        }
    }
    
    private func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    enum LogLevel: String {
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"
        case debug = "DEBUG"
    }
}

extension Logger {
    func logAPIRequest(endpoint: String, parameters: [String: Any]) {
        let message = "API Request - Endpoint: \(endpoint), Parameters: \(parameters)"
        logDebug(message: message)
    }
    
    func logAPIResponse(endpoint: String, statusCode: Int, response: Any) {
        let message = "API Response - Endpoint: \(endpoint), Status Code: \(statusCode), Response: \(response)"
        logInfo(message: message)
    }
    
    func logUserActivity(action: String, details: String) {
        let message = "User Activity - Action: \(action), Details: \(details)"
        logInfo(message: message)
    }
    
    func logErrorDetails(error: Error, context: String) {
        let message = "Error - Context: \(context), Error: \(error.localizedDescription)"
        logError(message: message)
    }
    
    func logNetworkRequest(url: String, method: String, headers: [String: String]?) {
        let message = "Network Request - URL: \(url), Method: \(method), Headers: \(headers ?? [:])"
        logDebug(message: message)
    }
    
    func logNetworkResponse(url: String, statusCode: Int, responseData: Any) {
        let message = "Network Response - URL: \(url), Status Code: \(statusCode), Response: \(responseData)"
        logInfo(message: message)
    }
    
    func logDatabaseQuery(query: String, parameters: [String: Any]) {
        let message = "Database Query - Query: \(query), Parameters: \(parameters)"
        logDebug(message: message)
    }
    
    func logFileOperation(operation: String, filePath: String) {
        let message = "File Operation - Operation: \(operation), File Path: \(filePath)"
        logDebug(message: message)
    }
    
    func logNotification(notificationName: String, userInfo: [AnyHashable: Any]) {
        let message = "Notification - Name: \(notificationName), User Info: \(userInfo)"
        logInfo(message: message)
    }
    
    func logAppLifecycle(event: String) {
        let message = "App Lifecycle Event - \(event)"
        logInfo(message: message)
    }
}
// Placeholder for \(file) content.
