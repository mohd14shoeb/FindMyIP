//
//  IPAddressView.swift
//  FindMyIP
//
//  Created by Shoeb Khan on 20/12/23.
//

import SwiftUI

public struct IPAddressView: View {
    @StateObject var viewModel = IPInfoViewModel()
    public init() {}

    public var body: some View {
       VStack {
           if self.viewModel.isLoading {
               LoadingIndicatorView(isLoading: self.viewModel.isLoading,
                                    error: self.viewModel.errorMessage) {
                   self.getAPICall()
               }
           } else {
               Text(viewModel.ipAddress)
           }
       }
       .task {
           self.getAPICall()
       }
   }
    
   func getAPICall() {
       self.viewModel.fetchIPAddress()
   }
}

#Preview {
    IPAddressView()
}
