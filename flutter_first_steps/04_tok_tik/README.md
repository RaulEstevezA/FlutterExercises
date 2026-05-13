# Tok Tik

This project is a Flutter application inspired by TikTok. It displays a vertical feed of short videos with interaction buttons for likes, views, and playback.

## Overview

The application loads a local list of video posts through a simple layered flow and presents them in a full-screen scrollable experience. Each video is shown in a vertical `PageView`, allowing the user to swipe between posts just like in a short-video feed.

Each post includes:

- A local video asset
- A caption
- A likes counter
- A views counter
- Animated action buttons

This project is focused on understanding video playback, local assets, state management, repository/data source separation, model mapping, entity usage, and full-screen UI composition in Flutter.

## Demo

<p align="center">
  <video src="demo.mp4" controls width="320"></video>
</p>

## Screenshot

<p align="center">
  <img src="toktik.png" width="150">
</p>

## Key Concepts

- Provider for state management
- ChangeNotifier to update the UI
- Local video assets in Flutter
- Video playback with video_player
- Repository and data source abstractions
- Dependency injection from main.dart
- Mapping local data into Dart models
- Entity and model separation
- Vertical navigation using PageView.builder
- Full-screen stacked layouts with Stack and Positioned
- Number formatting with intl
- Simple animations with animate_do
- Custom Material 3 dark theme

## Features

- Display a feed of short videos
- Scroll vertically between videos
- Play local video assets in full screen
- Loop videos automatically
- Mute videos by default
- Show likes and views for each post
- Format large numbers into readable values
- Display animated action buttons
- Load video data through a Provider backed by a repository
- Custom dark Material 3 theme

## Video Data Flow

The video loading flow is separated by responsibility:

1. `shared/data/local_video_post.dart` keeps the raw local video data as a list of maps.
2. `LocalVideoDatasource` implements `VideoPostDataSource` and knows how to read that local data.
3. `LocalVideoModel` maps each local map into a Dart model and converts it into the domain entity `VideoPost`.
4. `VideoPostsRepositoryImpl` implements `VideoPostRepository` and delegates video retrieval to the configured datasource.
5. `DiscoverProvider` depends only on `VideoPostRepository`, requests the next page of videos, updates the state, and notifies the UI.
6. `main.dart` wires the concrete dependencies by creating a `VideoPostsRepositoryImpl` with `LocalVideoDatasource` and injecting it into `DiscoverProvider`.

This keeps the presentation layer independent from the concrete data source. If the app later reads videos from an API instead of local data, the provider can keep using the same repository contract.

## Tech Stack

- Flutter
- Dart
- Provider
- video_player
- animate_do
- intl

## Purpose

This project builds upon previous Flutter exercises by introducing a more visual and media-focused application.

The focus is on connecting local data with the presentation layer through domain contracts, managing application state with Provider, reproducing local videos, and building a mobile-first full-screen experience similar to modern short-video apps.

## Navigation

- [Back to the repository overview](../../README_en.md)
