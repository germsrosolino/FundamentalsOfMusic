//
//  SheetItemsService.swift
//  FundamentalsOfMusic
//
//  Created by Jeremy Fitzpatrick on 2/18/23.
//

import SwiftUI

class SheetItemsService: ObservableObject {
    @Published var sheetItem: SheetItem?
    @Published var fullScreenItem: FullScreenItem?
    
    func present(item: SheetItem) {
        fullScreenItem = nil
        sheetItem = item
    }
    
    func present(item: FullScreenItem) {
        sheetItem = nil
        fullScreenItem = item
    }
    
    func dismiss() {
        sheetItem = nil
        fullScreenItem = nil
    }
}

enum SheetItem: Identifiable {
    case levelAssessment
    
    var id: Self { self }
    
    @ViewBuilder
    var view: some View {
        switch self {
        default: EmptyView()
        }
    }
}

enum FullScreenItem: Identifiable {
    case basicsLanding
    case intermediateLanding
    case advancedLanding
    
    var id: Self { self }
    
    @ViewBuilder
    var view: some View {
        switch self {
        default: EmptyView()
        }
    }
}
