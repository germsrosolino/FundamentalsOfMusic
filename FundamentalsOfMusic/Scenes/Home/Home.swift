//
//  Home.swift
//  FundamentalsOfMusic
//
//  Created by Jeremy Fitzpatrick on 2/18/23.
//

import SwiftUI

struct Home: View {
    @ObservedObject var sheetItemsService: SheetItemsService = SheetItemsService()
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .foregroundColor(.white)
            Text("Let's Study Music")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("darkTurqoise"))
        .ignoresSafeArea()
        
        .sheet(item: $sheetItemsService.sheetItem) { page in
            page.view
        }
        
        .fullScreenCover(item: $sheetItemsService.fullScreenItem) { page in
            page.view
        }
        
        .environmentObject(sheetItemsService)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
