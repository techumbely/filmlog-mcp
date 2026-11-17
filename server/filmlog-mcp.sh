#!/bin/sh
# Starts the MCP server that ships inside the Filmlog Mac app.
# This bundle contains no server of its own.
#
#   $1  location of Filmlog.app (optional; from the extension's settings)
#
# stdout carries MCP protocol frames only, so every message here goes to stderr.

HELPER="Contents/Helpers/FilmlogMCP.app/Contents/MacOS/FilmlogMCP"
BUNDLE_ID="com.simon-braun.filmlog"
DEFAULT_APP="/Applications/Filmlog.app"

app="$1"
# An unset setting can arrive empty or as the unreplaced placeholder.
case "$app" in
  ''|'${'*) app="$DEFAULT_APP" ;;
esac
# Tolerate a trailing slash.
app="${app%/}"

if [ ! -x "$app/$HELPER" ]; then
  # Not where we were told. Ask Launch Services, through Apple's documented
  # NSWorkspace lookup by bundle identifier, for every copy of Filmlog, best
  # match first, and take the first one that contains the MCP server.
  app=""
  candidates=$(/usr/bin/osascript -l JavaScript -e '
    ObjC.import("AppKit");
    var urls = $.NSWorkspace.sharedWorkspace.URLsForApplicationsWithBundleIdentifier("'"$BUNDLE_ID"'");
    var paths = [];
    for (var i = 0; i < urls.count; i++) paths.push(urls.objectAtIndex(i).path.js);
    paths.join("\n");' 2>/dev/null)
  old_ifs=$IFS
  IFS='
'
  for candidate in $candidates; do
    if [ -x "$candidate/$HELPER" ]; then app="$candidate"; break; fi
  done
  IFS=$old_ifs
fi

if [ -z "$app" ] || [ ! -x "$app/$HELPER" ]; then
  echo "Filmlog was not found on this Mac. Install Filmlog from the Mac App Store, or set its location in this extension's settings. The MCP server needs Filmlog 2026.9 or later." >&2
  exit 1
fi

exec "$app/$HELPER"
