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
    
    private let contextualString: String
    private let transcript: PassthroughSubject<Result<String, RecognizerError>, Never>
    private var cancellables = Set<AnyCancellable>()
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer = SFSpeechRecognizer()
    
    init(contextualString: String, transcript: PassthroughSubject<Result<String, RecognizerError>, Never>) {
        self.transcript = transcript
        self.contextualString = contextualString
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
    }
    
    deinit {
        reset()
    }
    
    private func transcribe() {
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }
            do {
                let (audioEngine, request) = try self.prepareEngine()
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
    
    private func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.contextualStrings = [contextualString]
        
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
        }
        
        if let result = result {
            #warning("shoul also send timestamp and confidence level")
            speak(result.bestTranscription.formattedString)
        }
    }
    
    private func speak(_ message: String) {
        transcript.send(.success(message))
    }
    
    private func speakError(_ error: Error) {
        var newError = RecognizerError.general
        if let error = error as? RecognizerError {
            newError = error
        } else {
            newError = RecognizerError.custom(error.localizedDescription)
        }
        transcript.send(.failure(newError))
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

