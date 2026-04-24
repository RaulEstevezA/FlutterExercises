# Tok Tik

This project is a Flutter application inspired by TikTok. It displays a vertical feed of short videos with interaction buttons for likes, views, and playback.

## Overview

The application loads a local list of video posts and presents them in a full-screen scrollable experience. Each video is shown in a vertical `PageView`, allowing the user to swipe between posts just like in a short-video feed.

Each post includes:

- A local video asset
- A caption
- A likes counter
- A views counter
- Animated action buttons

This project is focused on understanding video playback, local assets, state management, model mapping, and full-screen UI composition in Flutter.

## Screenshot

<p align="center">
  <img src="toktik.png" width="150">
</p>

## Key Concepts

- Provider for state management
- ChangeNotifier to update the UI
- Local video assets in Flutter
- Video playback with video_player
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
- Load video data through a Provider
- Custom dark Material 3 theme

## Tech Stack

- Flutter
- Dart
- Provider
- video_player
- animate_do
- intl

## Purpose

This project builds upon previous Flutter exercises by introducing a more visual and media-focused application.

The focus is on connecting local data with the presentation layer, managing application state with Provider, reproducing local videos, and building a mobile-first full-screen experience similar to modern short-video apps.
