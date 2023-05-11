//
//  PrivacyPolicyView.swift
//  AntiSpy
//
//  Created by Rome on 4/18/23.
//

import Foundation
import SwiftUI

struct PrivacyPolicyView: View {
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
                        Text("Privacy Policy View")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(alignment: .top)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("Privacy Policy")
        
        PrivacyPolicyView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("Privacy Policy (2)")
        
        PrivacyPolicyView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("Privacy Policy (3)")
    }
}
