//
//  FeedImageExtension.swift
//  FeedAPIChallenge
//
//  Created by Dat on 18/03/2023.
//  Copyright © 2023 Essential Developer Ltd. All rights reserved.
//

import Foundation

extension FeedImage: Decodable {
	enum Keys: String, CodingKey {
		case id = "image_id"
		case description = "image_desc"
		case location = "image_loc"
		case url = "image_url"
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Keys.self)
		self.id = try container.decode(UUID.self, forKey: .id)
		self.description = try container.decodeIfPresent(String.self, forKey: .description)
		self.location = try container.decodeIfPresent(String.self, forKey: .location)
		self.url = try container.decode(URL.self, forKey: .url)
	}
}
