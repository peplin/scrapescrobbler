scrapescrobbler -- A scrobbler for last.fm that scrapes radio station playlists
===============================================================================

## Description

Scrapescobbler is a tool to submit tracks you're listening to on an
old-fashioned radio station to last.fm.

Many radio stations offer almost real-time playlists online. For those of us who
still listen to them, scrapescrobbler will submit the tracks as they are publised
by the station to your last.fm feed. Start up scrapescrobbler when your radio is
on, and scrobble away.


## Installation

RubyGems is the preferred method of installation:

    $ [sudo] gem install scrapescrobbler

## Running

Whenever you're listening to the radio, run scrapescrobbler with the name of the
station:

    $ scrapescrobbler wyep

The station must be in the list of supported stations. To see a list of
available stations, try this:

    $ scrapescrobbler -h

## Contributing

Favorite station not in the list? Fork the repo on GitHub:

http://github.com/peplin/scrapescrobbler

Add a file in stations/ that provides the Station API and send a pull request.
