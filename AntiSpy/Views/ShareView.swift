//
//  ShareView.swift
//  AntiSpy
//
//  Created by Rome on 4/18/23.
//

import Foundation
import SwiftUI

struct ShareView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("BackButtonIconImage")
                    }
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height, alignment: .topLeading)
                .padding(.horizontal, 20)
                .zIndex(1)
             
                VStack() {
                    Button(action: {
                        self.presentSideMenu.toggle()
                    }) {
                        Text("Share View")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("Share View")
        
        ShareView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("Share View(2)")
        
        ShareView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("Share View(3)")
    }
}
