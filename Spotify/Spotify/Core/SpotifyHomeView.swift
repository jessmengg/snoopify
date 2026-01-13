//
//  SpotifyHomeView.swift
//  Spotify
//
//  Created by Jessica Meng on 3/7/25.
//

import SwiftUI

struct SpotifyHomeView: View {
    
    @State private var selectedCategory: Category? = nil
    @State private var selectedSong: Song? = nil
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
    ]
    
    // Albums
    let gutsAlbum = Album(
        title: "GUTS",
        artist: Artist(name: "Olivia Rodrigo", imageName: nil),
        imageName: "guts_snoopy",
        releaseYear: 2023,
        accentColor: .purple
    )
    
    let minorAlbum = Album(
        title: "minor",
        artist: Artist(name: "Gracie Abrams", imageName: nil),
        imageName: "minor_snoopy",
        releaseYear: 2024,
        accentColor: .blue
    )
    
    // Songs (computed from albums)
    var recentSongs: [Song] {
        [
            Song(title: "Friend", album: minorAlbum, duration: 201, trackNumber: 1),
            Song(title: "bad idea right?", album: gutsAlbum, duration: 186, trackNumber: 3),
            Song(title: "lacy", album: gutsAlbum, duration: 178, trackNumber: 6),
            Song(title: "21", album: minorAlbum, duration: 187, trackNumber: 2),
            Song(title: "I miss you, I'm sorry", album: minorAlbum, duration: 224, trackNumber: 3),
            Song(title: "love is embarrassing", album: gutsAlbum, duration: 194, trackNumber: 9),
            Song(title: "get him back!", album: gutsAlbum, duration: 211, trackNumber: 10),
            Song(title: "vampire", album: gutsAlbum, duration: 219, trackNumber: 1),
        ]
    }
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 24) {
                            // Recents Grid
                            recentsGrid
                            
                            // New Release: GUTS
                            SpotifyNewReleaseCell(
                                imageName: gutsAlbum.imageName,
                                headline: "New Music",
                                subheadline: "Olivia Rodrigo",
                                title: "bad idea right?",
                                subtitle: gutsAlbum.title,
                                onAddToPlaylistPressed: {},
                                onPlayPressed: {
                                    selectedSong = Song(title: "bad idea right?", album: gutsAlbum, duration: 186, trackNumber: 3)
                                }
                            )
                            
                            // New Release: minor
                            SpotifyNewReleaseCell(
                                imageName: minorAlbum.imageName,
                                headline: "New Music",
                                subheadline: "Gracie Abrams",
                                title: "Friend",
                                subtitle: minorAlbum.title,
                                onAddToPlaylistPressed: {},
                                onPlayPressed: {
                                    selectedSong = Song(title: "Friend", album: minorAlbum, duration: 201, trackNumber: 1)
                                }
                            )
                        }
                        .padding(.horizontal, 16)
                    } header: {
                        header
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(item: $selectedSong) { song in
            PlayerView(song: song) {
                selectedSong = nil
            }
        }
    }
    
    // Recents Grid
    private var recentsGrid: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(recentSongs) { song in
                SpotifyRecentsCell(
                    imageName: song.imageName,
                    title: song.title
                )
                .onTapGesture {
                    selectedSong = song
                }
            }
        }
    }
    
    // Header
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                Image("axolotl_music")
                    .resizable()
                    .background(.spotifyWhite)
                    .clipShape(Circle())
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
}

#Preview {
    SpotifyHomeView()
}
