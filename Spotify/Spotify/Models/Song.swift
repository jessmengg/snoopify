//
//  Song.swift
//  Spotify
//
//  Created by Jessica Meng on 1/13/26.
//

import SwiftUI

// Artist Model
struct Artist: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String?
    
    static let oliviaRodrigo = Artist(name: "Olivia Rodrigo", imageName: nil)
    static let gracieAbrams = Artist(name: "Gracie Abrams", imageName: nil)
}

// Album Model
struct Album: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let artist: Artist
    let imageName: String
    let releaseYear: Int
    let accentColor: Color
    
    static let guts = Album(
        title: "GUTS",
        artist: .oliviaRodrigo,
        imageName: "guts_snoopy",
        releaseYear: 2023,
        accentColor: Color(red: 0.6, green: 0.4, blue: 0.7) // Purple-ish for GUTS
    )
    
    static let minor = Album(
        title: "minor",
        artist: .gracieAbrams,
        imageName: "minor_snoopy",
        releaseYear: 2024,
        accentColor: Color(red: 0.4, green: 0.5, blue: 0.6) // Blue-gray for minor
    )
}

// Song Model
struct Song: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let album: Album
    let duration: TimeInterval // in seconds
    let trackNumber: Int
    
    var artist: Artist { album.artist }
    var imageName: String { album.imageName }
    
    // Format duration as "M:SS"
    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return "\(minutes):\(String(format: "%02d", seconds))"
    }
}

// Sample Data
extension Song {
    // GUTS tracks
    static let badIdeaRight = Song(title: "bad idea right?", album: .guts, duration: 186, trackNumber: 3)
    static let lacy = Song(title: "lacy", album: .guts, duration: 178, trackNumber: 6)
    static let loveIsEmbarrassing = Song(title: "love is embarrassing", album: .guts, duration: 194, trackNumber: 9)
    static let getHimBack = Song(title: "get him back!", album: .guts, duration: 211, trackNumber: 10)
    static let vampire = Song(title: "vampire", album: .guts, duration: 219, trackNumber: 1)
    static let allAmericanBitch = Song(title: "all-american bitch", album: .guts, duration: 165, trackNumber: 2)
    static let theGrudge = Song(title: "the grudge", album: .guts, duration: 295, trackNumber: 12)
    
    // minor tracks
    static let friend = Song(title: "Friend", album: .minor, duration: 201, trackNumber: 1)
    static let twentyOne = Song(title: "21", album: .minor, duration: 187, trackNumber: 2)
    static let iMissYouImSorry = Song(title: "I miss you, I'm sorry", album: .minor, duration: 224, trackNumber: 3)
    static let usAgain = Song(title: "us. (feat. Taylor Swift)", album: .minor, duration: 198, trackNumber: 4)
    static let closeToYou = Song(title: "Close To You", album: .minor, duration: 185, trackNumber: 5)
    static let freeNow = Song(title: "Free Now", album: .minor, duration: 192, trackNumber: 6)
    
    // Collections
    static let allSongs: [Song] = [
        .badIdeaRight, .lacy, .loveIsEmbarrassing, .getHimBack, .vampire, .allAmericanBitch, .theGrudge,
        .friend, .twentyOne, .iMissYouImSorry, .usAgain, .closeToYou, .freeNow
    ]
    
    static let gutsSongs: [Song] = [.vampire, .allAmericanBitch, .badIdeaRight, .lacy, .loveIsEmbarrassing, .getHimBack, .theGrudge]
    static let minorSongs: [Song] = [.friend, .twentyOne, .iMissYouImSorry, .usAgain, .closeToYou, .freeNow]
}
