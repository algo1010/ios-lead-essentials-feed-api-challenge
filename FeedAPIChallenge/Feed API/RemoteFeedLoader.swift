//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
	
	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}
	
	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		client.get(from: url) { result in
			switch result {
			case .success((let data, let response)):
				guard response.statusCode == 200 else {
					completion(.failure(Error.invalidData))
					return
				}
				do {
					guard let json = try JSONSerialization.jsonObject(with: data) as? [String : Any],
						  let items = json["items"] as? [[String : Any]]
					else {
						completion(.failure(Error.invalidData))
						return
					}
					
				} catch {
					completion(.failure(Error.invalidData))
				}
			case .failure(_):
				completion(.failure(Error.connectivity))
			}
		}
	}
}
