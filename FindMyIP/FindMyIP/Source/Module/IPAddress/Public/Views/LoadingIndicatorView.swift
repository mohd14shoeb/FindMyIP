//
//  LoadingIndicatorView.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import SwiftUI

 public struct LoadingIndicatorView: View {
    
   private let isLoading: Bool
   private let error: String?
   private let retryAction: (() -> Void)?
    
     public init(isLoading: Bool, 
                 error: String?,
                 retryAction: ( () -> Void)?) {
         self.isLoading = isLoading
         self.error = error
         self.retryAction = retryAction
     }
     
     public var body: some View {
            Group {
                if isLoading,
                    let error = error,
                    error.isEmpty {
                    VStack(alignment: .center) {
                        ProgressView()
                            .controlSize(.large)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.gray))
                    }
                } else if let error = error,
                            !error.isEmpty {
                    HStack {
                        VStack(spacing: 8) {
                            Text(error).padding(.all, 10)
                            if self.retryAction != nil {
                                Button(action: self.retryAction!) {
                                    Text("Retry")
                                        .font(. system(size: 16)).bold()
                                }
                                .foregroundColor(Color.blue)
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .font(. system(size: 16)).fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    }
                }
            }
    }
}

#Preview {
    LoadingIndicatorView(isLoading: true, error: "") {
        print("hello")
    }.border(.red)
}
