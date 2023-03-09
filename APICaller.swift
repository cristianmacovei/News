//
//  APICaller.swift
//  Stiri2
//
//  Created by Cristian Macovei on 08.03.2023.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=ro&apiKey=4b6345f420c34433b9447614bfbb9057")
    }
    
    private init() {
        
    }
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
       
        guard let url = Constants.topHeadlinesURL else {
            print("failed")
            return
        }
        print("APICaller getTopStories was a Success. Task about to be declared")
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            print("Started")
            if let error = error {
                print("Task error was found")
                completion(.failure(error))
            } else if let data = data {
                print("Fetch data from JSONDecoder")
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles found: \(result.articles.count)")
                } catch {
                    print("Error in fetching articles.")
                    completion(.failure(error))
                }
            }
        }
        print("Task being resumed")
        task.resume()
    }
    
}

//Models
struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
