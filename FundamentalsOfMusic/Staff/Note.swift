//
//  Note.swift
//  FundamentalsOfMusic
//
//  Created by Jeremy Fitzpatrick on 2/17/23.
//

import Foundation
import SwiftUI

struct Note: Identifiable {
    var id: String { name.rawValue }
    var name: NoteName
    var octave: CGFloat
    var clef: Clef
    var duration: NoteDuration
    var accidental: Accidental
    
    init(_ name: NoteName, _ accidental: Accidental = .none, octave: CGFloat = 0, duration: NoteDuration = .quarter, clef: Clef = .treble) {
        self.name = name
        self.clef = clef
        self.duration = duration
        self.octave = octave
        self.accidental = accidental
    }
    
    var heightMultiplier: CGFloat {
        let isTreble = clef == .treble
        switch name {
        case .a: return isTreble ? 3 : 1
        case .b: return isTreble ? 4 : 2
        case .c: return isTreble ? 5 : 3
        case .d: return isTreble ? 6 : 4
        case .e: return isTreble ? 0 : 5
        case .f: return isTreble ? 1 : 6
        case .g: return isTreble ? 2 : 0
        }
    }
    
    var image: Image {
        return duration.image
    }
    
    enum NoteDuration: String {
        case sixteenth
        case eighth
        case quarter
        case half
        case whole
        
        var image: Image {
            return Image(rawValue + "Note")
        }
    }
    
    enum Accidental: String {
        case none
        case flat
        case sharp
        
        var image: Image {
            return Image(rawValue + "Mod")
        }
    }
    
    enum NoteName: String {
        case a, b, c, d, e, f, g
    }
}

enum KeyNote: String {
    case bFlat = "b flat"
    case eFlat = "e flat"
    case aFlat = "a flat"
    case dFlat = "d flat"
    case gFlat = "g flat"
    case cFlat = "c flat"
    case fFlat = "f flat"
    
    case fSharp = "f sharp"
    case cSharp = "c sharp"
    case gSharp = "g sharp"
    case dSharp = "d sharp"
    case aSharp = "a sharp"
    case eSharp = "e sharp"
    case bSharp = "b sharp"
    
    var components: [String] {
        rawValue.components(separatedBy: " ")
    }
    
    var name: String {
        components[0]
    }
    
    var accidental: String {
        components[1]
    }
    
    var note: Note {
        let needsOctave = (self == .eFlat || self == .fSharp || self == .gSharp || self == .eSharp)
        return Note(Note.NoteName(rawValue: name)!, Note.Accidental(rawValue: accidental)!, octave: needsOctave ? 2 : 1)
    }
}
