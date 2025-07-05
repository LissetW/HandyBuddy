//
//  PrivacyPolicyView.swift
//  HandyBuddy
//
//  Created by Winonito Programmer on 15/06/25.
//

import SwiftUI
import WebKit

struct PrivacyPolicyView: View {
    var body: some View {
        WebView(htmlFileName: "privacy_policy")
            .edgesIgnoringSafeArea(.all)
    }
}
