//
//  TermsOfServiceView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 14/06/25.
//

import SwiftUI
import WebKit

struct TermsOfServiceView: View {
    var body: some View {
        WebView(htmlFileName: "terms_of_service")
            .edgesIgnoringSafeArea(.all)
    }
}
