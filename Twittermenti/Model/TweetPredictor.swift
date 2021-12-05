
import Foundation
import CoreML

struct TweetPredictor {
    
   private let sentimentClassifier = try! TweetSentimentClassifier(configuration: MLModelConfiguration())
    
    func makePredictions(with tweets: [TweetSentimentClassifierInput]) -> Int {
        var sentimentScore = 0
        
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            for prediction in predictions {
                let sentiment = prediction.label
                if sentiment == "Pos" {
                    sentimentScore += 1
                } else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
            }
        } catch {
            print("Error with making a prediction, \(error)")
        }
        return sentimentScore
    }
}
