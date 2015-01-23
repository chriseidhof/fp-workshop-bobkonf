// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

public class Box<T> {
    public let unbox: T
    public init(_ value: T) { self.unbox = value }
}


enum Result<A> {
    case Error(String)
    case Success(Box<A>)
}

func success<A>(x: A) -> Result<A> {
    return .Success(Box(x))
}

func loadData(url: NSURL) -> Result<NSData> {
    if let data = NSData(contentsOfURL: url) {
        return success(data)
    } else {
        return .Error("Couldn't load data")
    }
}

typealias JSONDictionary = [String:AnyObject]

func parseJSON(data: NSData) -> Result<JSONDictionary> {
    if let json = NSJSONSerialization.JSONObjectWithData(data,
        options: .allZeros, error: nil) as?  JSONDictionary {
        return success(json)
    } else {
        return .Error("Couldn't parse JSON")
    }
}

func flatMap<A,B>(r: Result<A>, f: A -> Result<B>) -> Result<B> {
    // TODO
    return .Error("TODO")
}

func avatarURL(json: JSONDictionary) -> Result<NSURL> {
    // TODO
    return .Error("TODO")
}

let json = flatMap(flatMap(loadData(NSURL(string: "https://api.github.com/users/apegroup")!), parseJSON), avatarURL)

// BONUS: define >>= as an operator that does the same thing as flatMap. Rewrite the above code

switch json {
case .Success(let x): println("Success: \(x.unbox)")
case .Error(let e): println("Error: \(e)")
}