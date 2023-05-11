//
//  SideMenuContainerView.swift
//  AntiSpy
//
//  Created by Rome on 4/18/23.
//

import Foundation
import SwiftUI

struct SideMenuContainerView: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .leading) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        self.isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .padding(.vertical, 50)
                    .background(Color("StartPageBackgroundColor"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

struct SideMenuContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuContainerView(isShowing: .constant(true), content: AnyView(SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(false))))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("SideMenuContainerView")
        
        SideMenuContainerView(isShowing: .constant(true), content: AnyView(SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(false))))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("SideMenuContainerView (2)")
        
        SideMenuContainerView(isShowing: .constant(true), content: AnyView(SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(false))))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("SideMenuContainerView (3)")
    }
}
