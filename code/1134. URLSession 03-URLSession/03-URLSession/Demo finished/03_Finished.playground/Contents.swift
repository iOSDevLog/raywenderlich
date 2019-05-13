import Foundation

//: ## URL & URLComponents
//: ### URL from String
//: It's easy to create a `URL` object from a String:
let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=abba"
let url = URL(string: urlString)
//: Let's look at some of the properties of `url`:
url?.absoluteString
url?.scheme
url?.host
url?.path
url?.query
url?.baseURL
//: You can start with a `baseURL`, then add to it. 
//: This is useful for building REST API urls.
let baseURL = URL(string: "https://itunes.apple.com")
let relativeURL = URL(string: "search", relativeTo: baseURL)
relativeURL?.absoluteString
relativeURL?.scheme
relativeURL?.host
relativeURL?.path
relativeURL?.query
relativeURL?.baseURL
//: ### URLComponents
//: URLs sent over the Internet can only contain characters that are letters or digits 
//: on an English-language keyboard, plus a very few punctuation marks, like '-' and '_'.
//: Strings that represent URLs can contain many other characters, including other alphabets.
//: An app must URL-encode any "unsafe" characters before sending the URL.
//: This is also called *percent-encoding*, because unsafe characters are encoded as 
//: one or more pairs of hexadecimal digits, each preceded by '%'.
//: The space character is encoded as `%20` or +.
//: '%' itself is `%25`, and '+' is `%2B`.
//:
//: The easiest way to ensure your URLs are URL-encoded is to build them with `URLComponents`:
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?media=music&entity=song")
var queryItem = URLQueryItem(name: "term", value: "crowded house")
urlComponents?.queryItems?.append(queryItem)
urlComponents?.url
urlComponents?.string
urlComponents?.queryItems
//: You can even URL-encode an emoji, like "smiling cat face with heart-shaped eyes" —
//: it's `%F0%9F%98%BB`
queryItem = URLQueryItem(name: "emoji", value: "😻")
urlComponents?.queryItems?.append(queryItem)
urlComponents?.url
urlComponents?.string
urlComponents?.queryItems
