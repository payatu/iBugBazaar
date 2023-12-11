//
//  sidemenuoptionview.swift
//  Profile_and_list
//
//  Created by Kapil Gurav on 08/05/23.
//
import SwiftUI

        struct sidemenuoptionview: View {
            let viewmodule: viewmodule
            var body: some View {

                    ZStack{
                    
                            HStack(spacing: 20){
                                Image(systemName: viewmodule.imagename)
                                    .font(.system(size: 15))
                                    .font((.system(size: 24, weight: .semibold)))
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.red)
                                    .overlay(RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2))
                                            
                                VStack{
                                    Text(viewmodule.Title)
                                        .bold()
                                    
                                }
                                Spacer()
                                
                            }
                            .padding()
                        
                    
                    
                }
                }
        }

        struct sidemenuoptionview_Previews: PreviewProvider {
            static var previews: some View {
                sidemenuoptionview(viewmodule: viewmodule.profile)
            }
        }
