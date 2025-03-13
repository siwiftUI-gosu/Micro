//
//  BackNavigationBar.swift
//  Micro
//
//  Created by pinocchio22 on 3/12/25.
//

import SwiftUI

struct BackNavigationBar: View {
    @Environment(\.dismiss) var dismiss
    @State private var isTapped = false
    
    var title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image("icon_leftBack")
                .frame(width: 24, height: 24)
                .scaleEffect(isTapped ? 1.1 : 1.0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isTapped = false
                        dismiss()
                    }
                }
            
            Spacer()
            
            Text(title)
            
            Spacer()
            
            Spacer()
                .frame(width: 24, height: 24)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
}

#Preview {
    BackNavigationBar(title: "타이틀")
}
