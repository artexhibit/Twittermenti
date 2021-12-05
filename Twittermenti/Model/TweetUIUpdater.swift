
import Foundation

struct TweetUIUpdater {
    
    func updateUI(with sentimentScore: Int) -> String {
        if sentimentScore > 20 {
            return "😍"
        } else if sentimentScore > 10 {
            return "😀"
        } else if sentimentScore > 0 {
            return "🙂"
        } else if sentimentScore == 0 {
            return "😐"
        } else if sentimentScore > -10 {
            return "😕"
        } else if sentimentScore > -20 {
            return "😡"
        } else {
            return "🤮"
        }
    }
}
