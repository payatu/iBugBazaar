//
//  Binary_cookie.swift
//  vulnios_prod
//
//  Created by Kapil Gurav on 20/11/23.
//
import SwiftUI
@available(iOS 15.0, *)
struct BinaryCookiesExerciseView: View {
    @State private var name: String = ""
    @State private var sessionToken: String = ""
    @State private var csrfToken: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section("User Information") {
                    TextField("Name", text: $name)
                    TextField("Session Token", text: $sessionToken)
                    TextField("CSRF Token", text: $csrfToken)
                }

                Section("Verify Cookies") {
                    Button("Verify") {
                        if verifyCredentials() {
                            print("Cookies are valid")
                        } else {
                            print("Cookies are not valid")
                        }
                    }
                }
            }
            .navigationBarTitle("Binary Cookies Exercise")
        }
    }

    private func verifyCredentials() -> Bool {
        let endpointURL = URL(string: "http://www.github.com/OWASP/iGoat")!

        let cookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies(for: endpointURL)!

        for cookie in cookies {
            switch cookie.name {
            case "username":
                if cookie.value != name {
                    return false
                }
            case "CSRFtoken":
                if cookie.value != csrfToken {
                    return false
                }
            case "sessionKey":
                if cookie.value != sessionToken {
                    return false
                }
            default:
                break
            }
        }

        return true
    }
}

//Need to update this code

//struct BinaryCookiesExerciseView_Previews: PreviewProvider {
  //  static var previews: some View {
    //    BinaryCookiesExerciseView()
  //  }
//}
