
import Foundation
import Swifter

struct TweetFetcher {
    
    private let tweetCount = 100
    private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
    private let apiSecret = Bundle.main.infoDictionary?["API_SECRET"] as! String
    
    func fetchTweets(with searchText: String, completion: @escaping ([TweetSentimentClassifierInput]?, Error?) -> ()) {
        let swifter = Swifter(consumerKey: apiKey, consumerSecret: apiSecret)
        swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended) {(results, searchMetadata) in
            var tweets = [TweetSentimentClassifierInput]()
            let data = results.description.data(using: .utf8)
            do {
                let decodedData = try JSONDecoder().decode([TweetData].self, from: data!)
                
                for tweet in decodedData {
                    let tweetForClassification = TweetSentimentClassifierInput(text: tweet.full_text)
                    tweets.append(tweetForClassification)
                }
                completion(tweets, nil)
            } catch {
                print("Error with decoding, \(error)")
                completion(nil, error)
            }
        } failure: { (error) in
            print("Error with the Twitter API request, \(error)")
            completion(nil, error)
        }
    }
}

