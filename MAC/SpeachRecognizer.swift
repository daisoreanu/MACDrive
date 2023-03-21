//
//  SpeachRecognizer.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 19.03.2023.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI
import Combine


/// A helper for transcribing speech to text using SFSpeechRecognizer and AVAudioEngine.
class SpeechRecognizer: ObservableObject {
    
    
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
    private var defaultCommands: [DefaultCommand] = []
    private var dynamicCommands: [DynamicCommand] = []
    
    var transcript: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let subject = PassthroughSubject<String, Never>()
    private var isListening = false
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    /**
     Initializes a new speech recognizer. If this is the first time you've used the class, it
     requests access to the speech recognizer and the microphone.
     */
    init() {
        recognizer = SFSpeechRecognizer()
        
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speakError(error)
            }
        }
        configureSubscribers()
        
    }
    
    private func configureSubscribers() {
        subject.debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main).sink { value in
//            print(value)
            
            print("========================Final=========================")
            print(value)
            #warning("Do network request")
            print("====================================================")
            
//            self.instruction = ""
            
            self.isListening = false
            self.stopListening()
            self.startListening()

        }
        .store(in: &cancellables)
    }
    
    func addDefaultCommand(_ command: DefaultCommand) {
        defaultCommands.append(command)
    }
    
    func removeDefaultCommand(_ command: DefaultCommand) {
        defaultCommands = defaultCommands.filter { storedCommand in
            return command.id != storedCommand.id
        }
    }
    
    func addDynamicCommand(_ command: DynamicCommand) {
        dynamicCommands.append(command)
    }
    
    func removeDynamicCommand(_ command: DynamicCommand) {
        dynamicCommands = dynamicCommands.filter { storedCommand in
            return storedCommand.dynamicAction != storedCommand.dynamicAction
        }
    }
    
    deinit {
        reset()
    }
    
    /**
        Begin transcribing audio.
     
        Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopTranscribing()`.
        The resulting transcription is continuously written to the published `transcript` property.
     */
    private func transcribe() {
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }
            
            do {
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
            } catch {
                self.reset()
                self.speakError(error)
            }
        }
    }
    
    /// Stop transcribing audio.
    func stopListening() {
        reset()
    }
    
    func startListening() {
        reset()
        transcribe()
    }
    
    /// Reset the speech recognizer.
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.contextualStrings = ["Hey Mac, select powder kiss velvet blur slim stick"]
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
            startListening()
        }
        
        if let result = result {
            DispatchQueue.main.async { [self] in
                let newText = result.bestTranscription.formattedString.lowercased()
                
                print(newText)
                
                if let range = newText.range(of: "hey siri") {
                    isListening = true
                    
                    if isListening {
                        let instruction = newText.substring(from: range.lowerBound)
                        subject.send(instruction)
                    }
                    
                }
            }
            speak(result.bestTranscription.formattedString)
        }
    }
    
    private func speak(_ message: String) {
        transcript = message
    }
    
    private func speakError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
    }

    //str1 is the shorter string
    func getStringDifference(str1: String, str2: String) -> String {
        //convert strings to array
        let str2Arr = Array(str2)
        var newStrArr = [Character]()
        for index in str1.count..<str2.count {
            newStrArr.append(str2Arr[index])
        }
        return String(newStrArr)
    }
    
}

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}

