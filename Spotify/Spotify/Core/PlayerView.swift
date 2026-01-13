//
//  PlayerView.swift
//  Spotify
//
//  Created by Jessica Meng on 1/13/26.
//

import SwiftUI

struct PlayerView: View {
    
    // Properties
    let song: Song
    var onDismiss: (() -> Void)? = nil
    
    // State
    @State private var isPlaying: Bool = false
    @State private var isFavorited: Bool = false
    @State private var isShuffleOn: Bool = false
    @State private var repeatMode: RepeatMode = .off
    @State private var progress: Double = 0.38
    
    enum RepeatMode {
        case off, all, one
        
        var iconName: String {
            switch self {
            case .off, .all: return "repeat"
            case .one: return "repeat.1"
            }
        }
        
        var isActive: Bool {
            self != .off
        }
        
        mutating func toggle() {
            switch self {
            case .off: self = .all
            case .all: self = .one
            case .one: self = .off
            }
        }
    }
    
    // Computed Properties
    private var currentTimeFormatted: String {
        let time = progress * song.duration
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return "\(minutes):\(String(format: "%02d", seconds))"
    }
    
    private var remainingTimeFormatted: String {
        let remaining = song.duration - (progress * song.duration)
        let minutes = Int(remaining) / 60
        let seconds = Int(remaining) % 60
        return "-\(minutes):\(String(format: "%02d", seconds))"
    }
    
    // Body
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerSection
                
                Spacer()
                
                albumArtSection
                
                Spacer()
                
                songInfoSection
                
                progressSection
                
                Spacer()
                
                controlsSection
                
                Spacer()
                
                bottomSection
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
    }
    
    // Header Section
    private var headerSection: some View {
        HStack {
            Button(action: { onDismiss?() }) {
                Image(systemName: "chevron.down")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            VStack(spacing: 2) {
                Text("PLAYING FROM ALBUM")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .tracking(1)
                    .opacity(0.7)
                
                Text(song.album.title)
                    .font(.callout)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .font(.title2)
            }
        }
        .padding(.top, 16)
    }
    
    // Album Art Section
    private var albumArtSection: some View {
        Image(song.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 350, maxHeight: 350)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
    
    // Song Info Section
    private var songInfoSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(song.artist.name)
                    .font(.body)
                    .opacity(0.7)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isFavorited.toggle()
                }
            }) {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundColor(isFavorited ? .spotifyPink : .white)
                    .scaleEffect(isFavorited ? 1.1 : 1.0)
            }
        }
        .padding(.bottom, 8)
    }
    
    // Progress Section
    private var progressSection: some View {
        VStack(spacing: 8) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 4)
                    
                    Capsule()
                        .fill(Color.spotifyPink)
                        .frame(width: geometry.size.width * progress, height: 4)
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            progress = min(max(value.location.x / geometry.size.width, 0), 1)
                        }
                )
            }
            .frame(height: 4)
            
            HStack {
                Text(currentTimeFormatted)
                    .font(.caption)
                    .opacity(0.7)
                    .monospacedDigit()
                
                Spacer()
                
                Text(remainingTimeFormatted)
                    .font(.caption)
                    .opacity(0.7)
                    .monospacedDigit()
            }
        }
    }
    
    // Controls Section
    private var controlsSection: some View {
        HStack(spacing: 0) {
            Button(action: {
                withAnimation { isShuffleOn.toggle() }
            }) {
                Image(systemName: "shuffle")
                    .font(.title3)
                    .foregroundColor(isShuffleOn ? .spotifyPink : .white)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {}) {
                Image(systemName: "backward.end.fill")
                    .font(.title)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPlaying.toggle()
                }
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 70))
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {}) {
                Image(systemName: "forward.end.fill")
                    .font(.title)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                withAnimation { repeatMode.toggle() }
            }) {
                Image(systemName: repeatMode.iconName)
                    .font(.title3)
                    .foregroundColor(repeatMode.isActive ? .spotifyPink : .white)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    // Bottom Section
    private var bottomSection: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "speaker.wave.2")
                    .font(.callout)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "list.bullet")
                    .font(.callout)
            }
        }
        .opacity(0.7)
        .padding(.bottom, 16)
    }
}

// Preview
#Preview {
    PlayerView(song: Song(
        title: "bad idea right?",
        album: Album(
            title: "GUTS",
            artist: Artist(name: "Olivia Rodrigo", imageName: nil),
            imageName: "guts_snoopy",
            releaseYear: 2023,
            accentColor: .purple
        ),
        duration: 186,
        trackNumber: 3
    ))
}
