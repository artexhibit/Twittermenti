
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
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        if textField.text != "" {
            textField.endEditing(true)
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

//MARK: - TextField delegate Methods

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

//MARK: - Keyboard Appearance Methods

extension ViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = 0 - keyboardHeight
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
}
