//
//  SideMenuView.swift
//  AntiSpy
//
//  Created by Rome on 4/17/23.
//

import Foundation
import SwiftUI

struct SideMenuView: View {
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            ZStack {
                GeometryReader { geo in
                    VStack() {
                        Button(action: {
                            self.presentSideMenu.toggle()
                        }) {
                            Image("MenuCloseIconImage")
                        }
                    }
                    .frame(maxWidth: geo.size.width, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, geo.safeAreaInsets.top)
                    
                    VStack() {
                        Image("AppLogoImage")
                    }
                    .frame(maxWidth: geo.size.width, alignment: .center)
                    .padding(.top, geo.safeAreaInsets.top - 10)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(SideMenuRowType.allCases, id: \.self){ row in
                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                                selectedSideMenuTab = row.rawValue
                                presentSideMenu.toggle()
                            }
                        }
                        
                        Spacer()	
                    }
                    .frame(maxWidth: geo.size.width, alignment: .leading)
                    .padding(.top, geo.safeAreaInsets.top + 80)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: UIScreen.main.bounds.height, alignment: .top)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("StartPageBackgroundColor"), Color("StartPageBackgroundColor")]), startPoint: .top, endPoint: .bottom)
        )
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View {
        
        Button(action: {
            action()
        }) {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Rectangle()
                        .fill(Color("StartPageBackgroundColor"))
                        .frame(width: 8)
                    
                    ZStack {
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("MenuItemIconColor"))
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    
                    Text(title)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            .frame(height: 50)
            .background(
                LinearGradient(gradient: Gradient(colors: [isSelected ? Color("MenuItemHoverColor") : Color("StartPageBackgroundColor"), Color("StartPageBackgroundColor")]), startPoint: .leading, endPoint: .trailing)
            )
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("SideMenuView")
        SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("SideMenuView (2)")
        SideMenuView(selectedSideMenuTab: .constant(0), presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("SideMenuView (3)")
    }
}
