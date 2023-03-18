//
//  DecodableExtension.swift
//  FeedAPIChallenge
//
//  Created by Dat on 18/03/2023.
//  Copyright © 2023 Essential Developer Ltd. All rights reserved.
//

import Foundation

extension Decodable {
	static func decode(from data: Data) throws -> Self {
		return try JSONDecoder().decode(Self.self, from: data)
	}
	
	static func decode<T>(from data: Data, keyPath: KeyPath<Self, T>) throws -> T {
		return try Self.decode(from: data)[keyPath: keyPath]
	}
}
