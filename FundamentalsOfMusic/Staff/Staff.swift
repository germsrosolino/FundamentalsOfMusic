//
//  Staff.swift
//  FundamentalsOfMusic
//
//  Created by Jeremy Fitzpatrick on 2/17/23.
//

import SwiftUI

struct Staff: View {
    var notes: [Note]
    
    var clef: Clef
    
    var key: Note
    
    private var maxHeight: CGFloat = 40
    internal var noteHeight: CGFloat {
        maxHeight / 10
    }
    
    init(notes: [Note], clef: Clef = .treble, key: Note = Note(.c)) {
        self.notes = notes
        self.clef = clef
        self.key = key
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                VStack {
                    StaffLine()
                    StaffLine()
                    StaffLine()
                    StaffLine()
                    StaffLine()
                }
                HStack(alignment: .bottom) {
                    clef.image
                        .resizable()
                        .frame(width: 30, height: geometry.frame(in: .local).height, alignment: .center)
                    
                    keySignature(for: key)
                    
                    ForEach(notes) { note in
                        HStack(spacing: 2) {
                            if key.name == .c {
                                note.accidental.image
//                                    .accidental()
                                    .offset(y: modOffset(for: note))
                            }
                            
                            note.image
//                                .note()
                                .offset(y: offset(for: note))
                        }
                    }
                }
            }
        }
        .frame(maxHeight: maxHeight)
    }
    
    private func offset(for note: Note) -> CGFloat {
        // 7 notes in the musical alphabet
        let octaveOffset = note.octave > 1 ? noteHeight * 7 : 0
        let offset = noteHeight * note.heightMultiplier
        return -offset - octaveOffset
    }
    
    private func modOffset(for note: Note) -> CGFloat {
        // 7 notes in the musical alphabet
        let octaveOffset = note.octave > 1 ? noteHeight * 7 : 0
        let offset = noteHeight * note.heightMultiplier
        return (-offset - octaveOffset) + (noteHeight * 1.5)
    }
    
    private func keySignature(for key: Note) -> some View {
        let notes = keyValues(for: key).compactMap({ $0.note })
        return HStack(spacing: 1) {
            ForEach(notes) { note in
                note.accidental.image
//                    .accidental()
                    .offset(y: offset(for: note) - (noteHeight * 0.25))
            }
        }
    }
    
    private func keyValues(for key: Note) -> [KeyNote] {
        switch key.name {
        case .a:
            return key.accidental == .flat ? [.bFlat, .eFlat, .aFlat] : [.fSharp, .cSharp, .gSharp]
        case .b:
            return key.accidental == .flat ? [.bFlat, .eFlat] : [.fSharp, .cSharp, .gSharp, .dSharp, .aSharp]
        case .c:
            return key.accidental == .flat ? [.bFlat, .eFlat, .aFlat, .dFlat, .gFlat, .cFlat, .fFlat] : []
        case .d:
            return key.accidental == .flat ? [.bFlat, .eFlat, .aFlat, .dFlat, .gFlat] : [.fSharp, .cSharp]
        case .e:
            return key.accidental == .flat ? [.bFlat, .eFlat, .aFlat] : [.fSharp, .cSharp, .gSharp, .dSharp]
        case .f:
            return [.bFlat]
        case .g:
            return key.accidental == .flat ? [.bFlat, .eFlat, .aFlat, .dFlat, .gFlat, .cFlat] : [.fSharp]
        }
    }
    
    struct StaffLine: View {
        var body: some View {
            Divider().background(Color.primary)
        }
    }
}

enum Clef: String {
    case bass
    case treble
    
    var image: Image {
        return Image(rawValue + "Clef")
    }
}

struct Staff_Previews: PreviewProvider {
    static var previews: some View {
        Staff(notes: [Note(.b, .flat), Note(.d, .flat), Note(.f, octave: 2), Note(.e, .flat, octave: 2)], key: Note(.c))
    }
}
