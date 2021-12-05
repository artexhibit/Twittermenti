
import UIKit

class ViewController: UIViewController {
    
    var tweetFetcher = TweetFetcher()
    var tweetPredictor = TweetPredictor()
    var tweetUIUpdater = TweetUIUpdater()
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        if let searchText = textField.text {
            tweetFetcher.fetchTweets(with: searchText) { (tweets, error) in
                if error != nil {
                    print(error!)
                    return
                } else {
                    if let realTweets = tweets {
                        let sentimentScore = self.tweetPredictor.makePredictions(with: realTweets)
                        self.sentimentLabel.text = self.tweetUIUpdater.updateUI(with: sentimentScore)
                    }
                }
            }
        }
    }
}
