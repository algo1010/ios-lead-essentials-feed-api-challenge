//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

extension FeedImage {
	init(json: [String: Any]) throws {
		guard let id = json["image_id"] as? String,
			  let uuid = UUID(uuidString: id),
			  let urlString = json["image_url"] as? String,
			  let url = URL(string: urlString)
		else {
			throw NSError()
		}
		self.id = uuid
		self.description = json["image_desc"] as? String
		self.location = json["image_loc"] as? String
		self.url = url
	}
}

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
					let images = try items.map(FeedImage.init)
					completion(.success(images))
				} catch {
					completion(.failure(Error.invalidData))
				}
			case .failure(_):
				completion(.failure(Error.connectivity))
			}
		}
	}
}
