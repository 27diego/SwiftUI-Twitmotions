//
//  TwitMotions.swift
//  TweetEmotions
//
//  Created by Developer on 9/22/20.
//

import Foundation
import SwifteriOS
import CoreML
import SwiftyJSON

class TwitMotions: ObservableObject {
    let swifter: Swifter
    let sentimentClassifier: TweetSentimentClassifier
    var tweets: [String] = [String]()
    var happyEmojis: [String] = ["🙂","😋","😝","🤪","😜"]
    var angryEmojis: [String] = ["😠","😡","😡","🤬","👿"]
    
    @Published var mood: String = "😤"
    
    
    init(){
        swifter = Swifter(consumerKey: "IINoUzOJSKLXwr4PzMjEFbuH6", consumerSecret: "bwK1TAIeufmVjgLwVjKDd1JUTeHwiJAywfslxCgt7QgfBf4a8i")
        sentimentClassifier = TweetSentimentClassifier()
    }
    
    func getMood(for tweet: String){
        var temp = [TweetSentimentClassifierInput]()
        var positive = 0
        var negative = 0
        let neutral = 0
        
        swifter.searchTweet(using: tweet, lang: "en", count: 100, tweetMode: .extended) { (res, metadata) in
            for i in 0..<100 {
                if let tweet = res[i]["full_text"].string {
                    temp.append(TweetSentimentClassifierInput(text: tweet))
                }
            }
            
            do{
                let emotions = try self.sentimentClassifier.predictions(inputs: temp)
                
                for pre in emotions{
                    if pre.label == "Neg"{
                        negative+=1
                    }
                    else if pre.label == "Pos"{
                        positive+=1
                    }
                }
                
                let actual = max(neutral, negative, positive)
                print(neutral, negative, positive)
                
                if neutral == actual{
                    self.mood = "😕"
                }
                else if negative == actual {
                    self.mood = self.angryEmojis.randomElement()!
                }
                else{
                    self.mood = self.happyEmojis.randomElement()!
                }
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        failure: { err in
            print("error making request to api \(err.localizedDescription)")
        }
    }
    
}
