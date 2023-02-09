//
//  Login.swift
//  RPB
//
//  Created by Bilal Nisar on 09/02/2023.
//

import Foundation
import SwiftUI

extension URI{
    enum Users: String {
        case info = "consumers/me"
        case login = "consumers/login"
        case socialLogin = "social/login"
        case signUp = "consumers"
        case verifyOTP = "consumers/verify-otp"
        case forgotPassword = "consumers/forgot-password"
        case uploadImage = "media/upload/consumer_profile"
    }
}
