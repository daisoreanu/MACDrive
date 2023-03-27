//
//  SpeechRecognizerError.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 26.03.2023.
//

import Foundation

enum RecognizerError: Error {
    case nilRecognizer
    case notAuthorizedToRecognize
    case notPermittedToRecord
    case recognizerIsUnavailable
    case general
    case custom(String)
    
    var message: String {
        switch self {
        case .nilRecognizer: return "Can't initialize speech recognizer"
        case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
        case .notPermittedToRecord: return "Not permitted to record audio"
        case .recognizerIsUnavailable: return "Recognizer is unavailable"
        case .general: return "Couldn't recognize"
        case .custom(let message): return message
        }
    }
}
