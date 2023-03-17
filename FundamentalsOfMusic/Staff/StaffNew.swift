//
//  SwiftUIView.swift
//  FundamentalsOfMusic
//
//  Created by Jeremy Fitzpatrick on 3/15/23.
//

import SwiftUI

struct StaffNew: View {
    var clef: Clef
    var notes: [StaffNote]
    
    var maxHeight: CGFloat = 40
    var noteHeight: CGFloat {
        maxHeight / 10
    }
    
    // TODO: Need to handle extension staff lines for notes off the staff, but that's gonna be a motherfucker
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            StaffBase()
                .offset(y: -noteHeight)
            
            HStack {
                clef.icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: clef.height)
                    .offset(y: clef.offset)
                
                ForEach(notes) { note in
                    HStack(spacing: 2) {
                        if let accidental = note.value.accidental, let icon = accidental.icon {
                            icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: accidental.width)
                                .offset(y: (offset(for: note) + (noteHeight * accidental.offsetMultiplier)))
                        }
                        
                        note.icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10)
                        .offset(y: offset(for: note))
                    }
                }
            }
        }
        .frame(maxHeight: maxHeight)
    }
    
    func offset(for note: StaffNote) -> CGFloat {
        // 7 notes in the musical alphabet
        let octaveOffset = note.octave > 0 ? noteHeight * 7 : 0
        let multiplier = clef == .treble ? note.trebleMultiplier : note.bassMultiplier
        let offset = noteHeight * multiplier
        return -offset - octaveOffset
    }
    
    struct StaffBase: View {
        var body: some View {
            VStack {
                StaffLine()
                StaffLine()
                StaffLine()
                StaffLine()
                StaffLine()
            }
        }
    }
    
    struct StaffLine: View {
        var body: some View {
            Divider().background(Color.primary)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StaffNew(clef: .bass, notes: [StaffNote(note: .Bb), StaffNote(note: .Ab), StaffNote(note: .Gb), StaffNote(note: .Fb), StaffNote(note: .Eb), StaffNote(note: .Cb), StaffNote(note: .Eb), StaffNote(note: .Fsharp), StaffNote(note: .Esharp), StaffNote(note: .Fsharp), StaffNote(note: .Gsharp)])
    }
}
