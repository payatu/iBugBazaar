//
//  postview.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 05/05/23.
//

//A new @State property called submittedReviews is added to store the submitted reviews as an array of strings.

//A new Button is added below the TextEditor to allow the user to submit their review. The submitReview() function is called when the button is tapped.

//Inside the submitReview() function, the reviewText is checked for emptiness. If it's not empty, the current review text is appended to the submittedReviews array, and the reviewText is cleared for the next review.

//A new VStack is added to display the submitted reviews. The reviews are shown using a ScrollView and a ForEach loop that iterates over the submittedReviews array. Each review is displayed as a Text view.

import SwiftUI

struct PostView: View {
    @State private var reviewText = ""
    @State private var submittedReviews: [String] = []
    @State private var isShowingReviewList = false
    
    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                    .shadow(radius: 20)
                
                VStack(spacing: 20) {
                    Image(systemName: "pencil")
                        .font(.system(size: 25))
                        .frame(width: 60, height: 60)
                        .foregroundColor(.red)
                        .overlay(RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 2))
                    
                    Text("Write Your Review")
                        .font(.headline)
                        .frame(width: 210, height: 40)
                        .padding(.horizontal)
                    
                    TextField("Please Write Your Review", text: $reviewText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(height: 100)
                        .padding(.horizontal)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .font(.body)
                
                    
                    Button(action: {
                        submitReview()
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: ReviewListView(reviews: submittedReviews), isActive: $isShowingReviewList) {
                        EmptyView()
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationBarTitle("")
            .navigationBarItems(trailing: Button(action: {
                isShowingReviewList = true
            }) {
                Text("Reviews")
            })
        }
    }
    
    private func submitReview() {
        guard !reviewText.isEmpty else {
            return
        }
        
        submittedReviews.append(reviewText)
        reviewText = ""
    }
}

struct ReviewListView: View {
    let reviews: [String]
    
    var body: some View {
        List(reviews, id: \.self) { review in
            Text(review)
        }
        .navigationBarTitle("Submitted Reviews")
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
