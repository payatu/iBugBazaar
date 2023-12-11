//
//  ContentView.swift
//  CTF2
//
//  Created by Kapil Gurav on 03/05/23.
//

//The loginscreen view has a TextField for the username and a SecureField for the password. When the user clicks on the "Login" button, the authenticateUser function is called. This function checks the username and password against the hardcoded credentials. If the username and password match, the shwoingloginscreen variable is set to true, which will cause the Home view to be displayed. Otherwise, the wrongpassword variable is incremented.

//The authenticateUser function is vulnerable to runtime manipulation because it does not properly validate the username and password. An attacker could easily manipulate the runtime environment to bypass the login checks. For example, an attacker could inject malicious code into the loginscreen view that would change the value of the username or password variables. This would allow the attacker to login to the system even if they do not know the correct credentials.

//To fix the vulnerabilities in the loginscreen view, you can:

//Validate the login function more carefully. This will help to prevent an attacker from bypassing the login checks.

// Insecure Storage of Credentials: Instead of using UserDefaults to store the username and password, you can intentionally store them in an insecure manner, such as plain text, in a local file or database.

// Lack of Input Validation: Avoid performing proper input validation in the authenticateUser function. You can skip validating the username and password inputs, allowing for potentially harmful values.

// Hardcoded Credentials: Instead of comparing the username and password against hardcoded values, you can leave the authentication logic empty or compare the values against a known set of credentials that are easily guessable.

// Lack of Rate Limiting or Account Lockout: Do not implement any mechanisms to prevent brute-force attacks or limit the number of login attempts. This can make it easier for attackers to perform automated login attempts.


import SwiftUI

struct LoginAttempt: Identifiable, Codable {
    var id = UUID()
    let username: String
    let password: String
    let timestamp: Date
}

struct Loginscreen: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongAttempt = false
    @State private var isLoggedIn = false
    @State private var loginAttempts: [LoginAttempt] = []

    var body: some View {
        NavigationView {
            ZStack {
                Color.red.ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.5)
                    .foregroundColor(.white.opacity(1))

                VStack {
                    Image("Home")
                        .resizable()
                        .frame(width: 350, height: 350)

                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Login") {
                        authenticateUser()
                    }
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()

                    if wrongAttempt {
                        Text("Invalid username or password.")
                            .foregroundColor(.black)
                            .padding()
                    }

                    NavigationLink("", destination: Home(), isActive: $isLoggedIn)
                }
            }
            .onAppear {
                checkToken()
                loadLoginAttempts()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func authenticateUser() {
        // Print entered username and password to device logs
        print("Entered Username: \(username)")
        print("Entered Password: \(password)")

        // Implement proper validation checks for the username and password
        if username.isEmpty || password.isEmpty {
            print("Username or password cannot be empty.")
            return
        }

        // Validate the credentials against the stored credentials
        let storedUsername = "Bandit"
        let storedPassword = "payatu"

        if username != storedUsername || password != storedPassword {
            print("Invalid username or password.")
            saveLoginAttempt(username: username, password: password)
            return
        }

        // Check if a token exists
        if let _ = UserDefaults.standard.string(forKey: "AuthToken") {
            // If a token exists, proceed to home screen
            isLoggedIn = true
        } else {
            // If a token does not exist, create a new token and proceed to home screen
            createAndSaveToken(withPin: "")
        }
    }

    func checkToken() {
        if let _ = UserDefaults.standard.string(forKey: "AuthToken") {
            // If a token exists, proceed to home screen
            isLoggedIn = true
        }
    }

    func createAndSaveToken(withPin pin: String) {
        let token = UUID().uuidString
        UserDefaults.standard.set(token, forKey: "AuthToken")
        UserDefaults.standard.set(pin, forKey: "UserPIN")

        // Print the token to the console for verification
        print("Stored Token: \(token)")
    }

    func saveLoginAttempt(username: String, password: String) {
        let attempt = LoginAttempt(username: username, password: password, timestamp: Date())
        loginAttempts.append(attempt)
        saveLoginAttempts()
    }

    func saveLoginAttempts() {
        do {
            let data = try JSONEncoder().encode(loginAttempts)
            UserDefaults.standard.set(data, forKey: "LoginAttempts")
        } catch {
            print("Error encoding login attempts: \(error)")
        }
    }

    func loadLoginAttempts() {
        if let data = UserDefaults.standard.data(forKey: "LoginAttempts") {
            do {
                loginAttempts = try JSONDecoder().decode([LoginAttempt].self, from: data)
            } catch {
                print("Error decoding login attempts: \(error)")
            }
        }
    }
}

struct Loginscreen_Previews: PreviewProvider {
    static var previews: some View {
        Loginscreen()
    }
}



//Here's a summary of the flow:

  //  First Login:
    //    Log in with your credentials.
      //  A token is generated and saved locally.
        //pin based authentication is attempted (if available).

    //Exit and Reopen:
      //  The application checks for a token.
        //If a token is found:
          //  Biometric authentication is attempted (if available).
            //If successful, you are logged in automatically.
            //If biometric authentication fails or is unavailable, it will prompt for credentials.
