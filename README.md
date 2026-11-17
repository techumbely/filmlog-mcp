# Filmlog MCP server

Filmlog is a film diary for Mac, iPhone, iPad and Apple TV. The Mac app includes an MCP server, so an AI assistant can answer questions about your own library: what you watched and when, your watchlist, your challenges, your statistics. It can also propose changes, such as adding a film to your watchlist, which you approve in Filmlog.

This repository holds a small extension for Claude Desktop that starts that server. It contains no server of its own.

## Requirements

- A Mac with Filmlog 2026.9 or later, installed from the Mac App Store.
- Filmlog Plus. The MCP server is part of Filmlog Plus.
- Filmlog opened at least once, so your library is available to the server.

## Install in Claude Desktop

1. Download `filmlog.mcpb` from the latest release.
2. Double-click the file and confirm the installation.
3. If Filmlog is not in the Applications folder, set its location in the extension's settings.

The first time an assistant asks about your library, macOS asks whether the AI app may access data from Filmlog. Allow it, then ask again.

## Other MCP clients

Open Filmlog, go to Settings › Data › AI Assistants, and copy the configuration shown there into your client.

## How it works

The MCP server runs on your Mac and talks to the AI app over stdio. Filmlog answers on this Mac. What the server returns becomes part of your conversation with the assistant, like anything else you tell it.

Changes are off until you allow them in Filmlog, and by default Filmlog asks you before applying each one.

## Tools

Read: `queryWatchlist`, `querySeenFilms`, `queryFilmDetails`, `queryChallenges`, `queryStatistics`, `queryLibraryByFacet`, `queryFilmFacts`, `searchFilms`.

Write: `addToWatchlist`, `setFilmRating`, `setFilmFavorite`, `setPersonFollow`, `setCinemaPin`.

## Support

https://filmlog.cc
