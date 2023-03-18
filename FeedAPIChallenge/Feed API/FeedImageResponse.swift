//
//  FeedImageResponse.swift
//  FeedAPIChallenge
//
//  Created by Dat on 18/03/2023.
//  Copyright © 2023 Essential Developer Ltd. All rights reserved.
//

import Foundation

struct FeedImageResponse: Decodable {
	let items: [FeedImage]
}
