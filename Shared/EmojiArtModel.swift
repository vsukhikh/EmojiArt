//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by Владимир Сухих on 27.09.2021.
//

import Foundation

struct EmojiArtModel: Codable {
    var background = Background.blank
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Hashable, Codable {
        let text: String
        var x: Int //offset of the center
        var y: Int //offset of the center
        var size: Int
        let id: Int
        
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    func json() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    init (json: Data) throws {
        self = try JSONDecoder().decode(EmojiArtModel.self, from: json)
    }
    
    init(url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try EmojiArtModel(json:data)
    }
    
    init() {}
    
    private var uniqueEmojiId = 0
    mutating func addEmojii (_ text: String, at location: (x: Int, y: Int), size: Int){
        uniqueEmojiId += 1
        emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: uniqueEmojiId))
    }
}
