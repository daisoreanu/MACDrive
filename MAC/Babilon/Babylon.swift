//
//  Babylon.swift
//  MAC
//
//  Created by Daisoreanu Laurentiu on 25.03.2023.
//

import Foundation
import Combine
import SwiftUI

enum BabylonState {
    case standby
    case recording(String)
    case final(String)
#warning("The user should not know anything about the recognize, a new error name with many other cases should be created")
    case error(RecognizerError)
}

struct EventData {
    let eventType: EventType
    let screenClass: String
    let screenDescription: String
}

final class Babylon: ObservableObject {
    
    static let shared = Babylon()
    
    @Published var state: BabylonState = .standby
    
    private var speachRecognizer: SpeechRecognizer?
    private var voiceAssystentName: String?
    private let transcript = PassthroughSubject<Result<String, RecognizerError>, Never>()
    private let voiceCommand = PassthroughSubject<Result<String, RecognizerError>, Never>()
    private var eventsData: [EventData] = []
    private var events: [EventType] { return eventsData.map { $0.eventType } }
    private var cancellables = Set<AnyCancellable>()
    private var isListening = false
    private var isListeningFirstIteration = true
    private var previousRecordin = ""
    
    private let networkManager: ApiNetworkManagerProtocol = ApiNetworkManager()
    
    
    private init() {}
    
    func setVoiceAssystentName(_ name: String) {
        self.voiceAssystentName = name
    }
    
    func setListener(_ listener: BabylonState) {
        self.state = listener
    }
    
    func start() {
        guard let voiceAssystentName = voiceAssystentName else {
            return
        }
        if speachRecognizer == nil {
            speachRecognizer = SpeechRecognizer(contextualString: voiceAssystentName, transcript: transcript)
            
        }
        speachRecognizer?.startListening()
        configureBindings()
    }
    
    func stop() {
        speachRecognizer?.stopListening()
    }
    
    func addEvent(_ event: EventType, screenClass: String, screenDescription: String) {
        eventsData.append(EventData(eventType: event, screenClass: screenClass, screenDescription: screenDescription))
    }
    
    func removeEvent(_ event: EventType, screenClass: String) {
        eventsData = eventsData.filter { storedEvent in
            #warning("Should use Equatable")
            if storedEvent.eventType.id == event.id && storedEvent.screenClass == screenClass {
                return false
            }
            return true
        }
    }
    
    func addEvents(_ newEvents: [EventType], screenClass: String, screenDescription: String) {
        for eventType in newEvents {
            eventsData.append(EventData(eventType: eventType, screenClass: screenClass, screenDescription: screenDescription))
        }
    }
    
    func removeEvents(for screenClass: String) {
        eventsData = eventsData.filter { storedEvent in
            if storedEvent.screenClass == screenClass {
                    return false
            }
            return true
        }
    }
    
    func removeAllEvents() {
        eventsData = []
    }
    
    private func configureBindings() {
        voiceCommand.debounce(for: .milliseconds(1500), scheduler: DispatchQueue.main).sink { recording in
            switch recording {
            case .success(let currentVoiceCommand):
                self.state = .final("Hey Andrea" + " " + currentVoiceCommand)
                print("FINAL: \(currentVoiceCommand)")
                self.interpretRequest(userInput: self.processVoiceInput(currentVoiceCommand))
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isListening = false
        }
        .store(in: &cancellables)
        
        transcript.sink { recording in
            switch recording {
            case .success(let currentRecording):
                print(currentRecording)
                let currentRecordingLowercased = self.processVoiceInput(currentRecording)
                let splitedStringArray = currentRecordingLowercased.components(separatedBy: CharacterSet.whitespacesAndNewlines)
                if splitedStringArray.count >= 2 {
                    let lastTwoWords = String(splitedStringArray.suffix(2).joined(separator: [" "]))
                    if lastTwoWords == "hey andrea" {
                        self.isListening = true
                        self.state = .recording(lastTwoWords.capitalized)
                    }
                }
                if self.isListening {
                    let request =  currentRecordingLowercased.components(separatedBy: "hey andrea")
                    if let voicceRequest = request.last, !voicceRequest.isEmpty {
                        self.voiceCommand.send(.success(voicceRequest))
                        self.state = .recording("Hey Andrea" + " " + voicceRequest)
                    }
                }
            case .failure(let error):
                self.voiceCommand.send(.failure(error))
            }
        }.store(in: &cancellables)
    }
    
    private func interpretRequest(userInput: String) {
        networkManager.perform(requestWith: VoiceCommandEndpoins.dynamicCommandRequest(userInput: userInput, actions: events), requiresAuthentication: false)
        { [weak self] (result: Result<DinamycEventResponse, ApiNetworkError>) in
            switch result {
            case .success(let dynamicEventResponse):
                DispatchQueue.main.async {
                    self?.state = .standby
                    self?.isListening = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self!.state = .error(RecognizerError.general)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self?.state = .standby
                        self?.isListening = false
                    }
                }
            }
        }
    }
    
    private func processVoiceInput(_ voiceInput: String) -> String {
        var str = voiceInput.lowercased()
        str = str.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
        str = str.replacingOccurrences(of: "^\\n*", with: "", options: .regularExpression)
        return str
    }
    
}
