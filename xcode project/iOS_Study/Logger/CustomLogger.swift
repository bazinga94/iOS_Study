//
//  CustomLogger.swift
//  iOS_Study
//
//  Created by Jongho Lee on 2021/06/10.
//

import Foundation
import os

class CustomLogger {

	// MARK: - 선택된 type에 해당하는 로그를 출력
	private static func makeLogString(description: String, logType: String, tag: Any?, message: Any) -> String {

//		let dateFormatter = DateFormatter()
//		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
//		dateFormatter.timeZone = TimeZone.autoupdatingCurrent
//		dateFormatter.locale = Locale.current
//		let timestamp = dateFormatter.string(from: Date.init()) // 현재 시간
		let thread = Thread.current.isMainThread ? "main": Thread.current.name ?? "-" // 현재 스레드

		if let tag = tag {
//			return "\n" + description + "\n" + "[\(timestamp)] [\(thread)] [\(logType)] [Tag: \(tag)]\n>>> \(message)\n<<<\n"
			return "\n" + description + "\n" + "[\(thread)] [Tag: \(tag)]\n>>> \(message)\n<<<\n"
		} else {
			return "\n" + description + "\n" + "[\(thread)] \n>>>\n\(message)\n<<<\n"
		}
	}

	static func error(fileName: String = #file, lineNumber: Int = #line, functionName: String = #function, tag: Any?, message: Any) {
		var description: String = "[‼️] [\(sourceFileName(filePath: fileName))] \(functionName) [Line: \(lineNumber)]"

		description = self.makeLogString(description: description, logType: "error", tag: tag, message: message)
		if #available(iOS 14.0, *) {
			let logger = Logger()
			logger.error("\(description)")
		} else if #available(iOS 10.0, *) {
			os_log("%@", type: .error, description)
		} else {
			print(description)
		}
//		fatalError(description)
	}

	static func info(fileName: String = #file, lineNumber: Int = #line, functionName: String = #function, tag: Any?, message: Any) {
		var description: String = "[‼️][\(sourceFileName(filePath: fileName))] [\(functionName)] [Line: \(lineNumber)]"

		description = self.makeLogString(description: description, logType: "info", tag: tag, message: message)
		if #available(iOS 14.0, *) {
			let logger = Logger()
			logger.info("\(description)")
		} else if #available(iOS 10.0, *) {
			os_log("%@", type: .info, description)
		} else {
			print(description)
		}
	}

	private static func sourceFileName(filePath: String) -> String {
		let components = filePath.components(separatedBy: "/")
		return components.isEmpty ? "" : components.last!
	}

	private static func convertToString(_ string: Any?) -> String {
		if let string = string as? String {
			return string
		} else {
			return ""
		}
	}
}
