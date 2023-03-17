//
//  Note.swift
//  FundamentalsOfMusic
//
//  Created by Jeremy Fitzpatrick on 2/17/23.
//

import Foundation
import SwiftUI

enum Note: String {
    case A, Ab, Asharp,
         B, Bb, Bsharp,
         C, Cb, Csharp,
         D, Db, Dsharp,
         E, Eb, Esharp,
         F, Fb, Fsharp,
         G, Gb, Gsharp
    
    var accidental: Accidental {
        switch self {
        case .A, .B, .C, .D, .E, .F, .G: return .none
        case .Ab, .Bb, .Cb, .Db, .Eb, .Fb, .Gb: return .flat
        case .Asharp, .Bsharp, .Csharp, .Dsharp, .Esharp, .Fsharp, .Gsharp: return .sharp
        }
    }
    
    var base: BaseNoteValue {
        switch self {
        case .A, .Ab, .Asharp: return .a
        case .B, .Bb, .Bsharp: return .b
        case .C, .Cb, .Csharp: return .c
        case .D, .Db, .Dsharp: return .d
        case .E, .Eb, .Esharp: return .e
        case .F, .Fb, .Fsharp: return .f
        case .G, .Gb, .Gsharp: return .g
        }
    }
    
    enum BaseNoteValue: String {
        case a, b, c, d, e, f, g
    }
}

struct StaffNote: Identifiable {
    var id: UUID { UUID() }
    var value: Note
    var octave: CGFloat
    var duration: NoteDuration
    
    init(note: Note, octave: CGFloat = 0, duration: NoteDuration = .quarter) {
        self.value = note
        self.octave = octave
        self.duration = duration
    }
    
    var icon: Image {
        duration.icon
    }
    
    var trebleMultiplier: CGFloat {
        switch value.base {
        case .a: return 3
        case .b: return 4
        case .c: return 5
        case .d: return 6
        case .e: return 0
        case .f: return 1
        case .g: return 2
        }
    }
    
    var bassMultiplier: CGFloat {
        switch value.base {
        case .a: return 1
        case .b: return 2
        case .c: return 3
        case .d: return 4
        case .e: return 5
        case .f: return 6
        case .g: return 0
        }
    }
}

enum Clef: String {
    case treble, bass //, tenor, alto TODO: Add support for these two as well
    
    var icon: Image {
        return Image(rawValue + "Clef")
    }
    
    var offset: CGFloat {
        switch self {
        case .treble: return 0
        case .bass: return -5
        }
    }
    
    var height: CGFloat {
        return 35
    }
}

enum NoteDuration: String {
    case sixteenth, eighth, quarter, half, whole
    
    var icon: Image {
        return Image(rawValue + "Note")
    }
}

enum Accidental: String {
    case flat, sharp, none
    
    var icon: Image? {
        switch self {
        case .none: return nil
        default: return Image(rawValue + "Mod")
        }
    }
    
    var width: CGFloat {
        switch self {
        case .none: return 0
        case .flat: return 5
        case .sharp: return 10
        }
    }
    
    var offsetMultiplier: CGFloat {
        switch self {
        case .none: return 0
        case .sharp: return 2
        case .flat : return 1
        }
    }
}

//
//struct Note: Identifiable {
//    var id: String { name.rawValue }
//    var name: NoteName
//    var octave: CGFloat
//    var clef: Clef
//    var duration: NoteDuration
//    var accidental: Accidental
//    
//    init(_ name: NoteName, _ accidental: Accidental = .none, octave: CGFloat = 0, duration: NoteDuration = .quarter, clef: Clef = .treble) {
//        self.name = name
//        self.clef = clef
//        self.duration = duration
//        self.octave = octave
//        self.accidental = accidental
//    }
//    
//    var heightMultiplier: CGFloat {
//        let isTreble = clef == .treble
//        switch name {
//        case .a: return isTreble ? 3 : 1
//        case .b: return isTreble ? 4 : 2
//        case .c: return isTreble ? 5 : 3
//        case .d: return isTreble ? 6 : 4
//        case .e: return isTreble ? 0 : 5
//        case .f: return isTreble ? 1 : 6
//        case .g: return isTreble ? 2 : 0
//        }
//    }
//    
//    var image: Image {
//        return duration.image
//    }
//    
//    enum NoteDuration: String {
//        case sixteenth
//        case eighth
//        case quarter
//        case half
//        case whole
//        
//        var image: Image {
//            return Image(rawValue + "Note")
//        }
//    }
//    
//    enum Accidental: String {
//        case none
//        case flat
//        case sharp
//        
//        var image: Image {
//            return Image(rawValue + "Mod")
//        }
//    }
//    
//    enum NoteName: String {
//        case a, b, c, d, e, f, g
//    }
//}
//
//enum KeyNote: String {
//    case bFlat = "b flat"
//    case eFlat = "e flat"
//    case aFlat = "a flat"
//    case dFlat = "d flat"
//    case gFlat = "g flat"
//    case cFlat = "c flat"
//    case fFlat = "f flat"
//    
//    case fSharp = "f sharp"
//    case cSharp = "c sharp"
//    case gSharp = "g sharp"
//    case dSharp = "d sharp"
//    case aSharp = "a sharp"
//    case eSharp = "e sharp"
//    case bSharp = "b sharp"
//    
//    var components: [String] {
//        rawValue.components(separatedBy: " ")
//    }
//    
//    var name: String {
//        components[0]
//    }
//    
//    var accidental: String {
//        components[1]
//    }
//    
//    var note: Note {
//        let needsOctave = (self == .eFlat || self == .fSharp || self == .gSharp || self == .eSharp)
//        return Note(Note.NoteName(rawValue: name)!, Note.Accidental(rawValue: accidental)!, octave: needsOctave ? 2 : 1)
//    }
//}
