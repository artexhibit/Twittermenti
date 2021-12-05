import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/igor/Developer/Twittermenti-iOS13/twitter-sanders-apple3.csv"))

//create training data and testing data which splits up our csv file as 80% for training and 20% for testing data
let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

// create an instance of MLTextClassifier which is going to create our machine learning model by passing in the training data.
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

// test our created machine learning model against our testing data, to evaluate how accurate it is
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

//then we can check an evaluation accuracy (the percentage that if got right)
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

//run the code
//after we can save the model. First create a metadata for the file
let metadata = MLModelMetadata(author: "Igor Volkov", shortDescription: "A model trained to classify sentiment on Tweets", version: "1.0")

//next we can extract it with above metadata into desired location. After the last slash type a name for the model
try sentimentClassifier.write(toFile: "/Users/igor/Developer/Twittermenti-iOS13/TweetSentimentClassifier.mlmodel", metadata: metadata)

//we can test the classifier
try sentimentClassifier.prediction(from: "@Apple is a bad company!")

