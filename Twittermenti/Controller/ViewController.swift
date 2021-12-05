
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    var tweetFetcher = TweetFetcher()
    var tweetPredictor = TweetPredictor()
    var tweetUIUpdater = TweetUIUpdater()
    
    override func viewDidLoad() {
        textField.delegate = self
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        if textField.text != "" {
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
        } else {
            textField.placeholder = "Type a word with @ or #"
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
