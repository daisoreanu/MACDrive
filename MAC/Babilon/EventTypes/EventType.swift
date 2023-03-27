//
//  DefaultAction.swift
//  MAC
//
//  Created by Daisoreanu, Laurentiu on 20.03.2023.
//

import Foundation

enum EventType: Identifiable {
    case add(AddEventType)
    case edit(EditEventType)
    case delete(RemoveEventType)
    case toggle(ToggleEventType)
    case sort(SortEventType)
    case standalone(StandaloneEventType)
    case pick(PickEventType)
    case select(SelectEventType)

    var id: String {
        switch self {
        case .add(let addEvent):
            return addEvent.id
        case .edit(let editEvent):
            return editEvent.id
        case .delete(let deleteEvent):
            return deleteEvent.id
        case .toggle(let toggleEvent):
            return toggleEvent.id
        case .sort(let sortEvent):
            return sortEvent.id
        case .standalone(let standaloneEvent):
            return standaloneEvent.id
        case .pick(let pickEvent):
            return pickEvent.id
        case .select(let selectEvent):
            return selectEvent.id
        }
    }
    
    var path: String {
        switch self {
        case .add(let addEvent):
            return addEvent.path
        case .edit(let editEvent):
            return editEvent.path
        case .delete(let deleteEvent):
            return deleteEvent.path
        case .toggle(let toggleEvent):
            return toggleEvent.path
        case .sort(let sortEvent):
            return sortEvent.path
        case .standalone(let standaloneEvent):
            return standaloneEvent.path
        case .pick(let pickEvent):
            return pickEvent.path
        case .select(let selectEvent):
            return selectEvent.path
        }
    }
    
    var description: String {
        switch self {
        case .add(let addEvent):
            return addEvent.description
        case .edit(let editEvent):
            return editEvent.description
        case .delete(let deleteEvent):
            return deleteEvent.description
        case .toggle(let toggleEvent):
            return toggleEvent.description
        case .sort(let sortEvent):
            return sortEvent.description
        case .standalone(let standaloneEvent):
            return standaloneEvent.description
        case .pick(let pickEvent):
            return pickEvent.description
        case .select(let selectEvent):
            return selectEvent.description
        }
    }
    
}
