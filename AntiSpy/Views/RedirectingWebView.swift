//
//  RedirectingWebView.swift
//  AntiSpy
//
//  Created by Rome on 4/13/23.
//

import Foundation
import SwiftUI

struct RedirectingWebView: View {
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                VStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(
                    Image("RedirectingWebBackgroundImage")
                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        .aspectRatio(contentMode: .fill)
                )
                VStack {
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("OverlayBackgroundColor"), Color("OverlayBackgroundColor")]), startPoint: .top, endPoint: .bottom)
                )
                
                HStack() {
                    Text("Redirecting to web ...")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
            }
            .ignoresSafeArea(edges: .all)
        }
    }
}

struct RedirectingWebView_Previews: PreviewProvider {
    static var previews: some View {
        RedirectingWebView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("RedirectingToWeb1")
        
        RedirectingWebView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("RedirectingToWeb2")
        
        RedirectingWebView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("RedirectingToWeb3")
    }
}
