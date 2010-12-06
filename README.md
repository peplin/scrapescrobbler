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

For the moment, this requires a forked version of the lastfm gem. Install it
like so:

    $ git clone https://github.com/peplin/ruby-lastfm.git ruby-lastfm
    $ cd ruby-lastfm
    $ git checkout scrobblingv2
    $ rake install

## Running

Whenever you're listening to the radio, run scrapescrobbler with the name of the
station:

    $ ss listen wyep

The station must be in the list of supported stations. To see a list of
available stations, try this:

    $ ss stations

## Configuration & Authentication

Before using scrapescrobbler, you must authenticate it with your Last.fm
account. Running the `listen` command will warn you that you are not
authenticated and spit out a URL - visit that and give scrapescrobbler the
go-ahead, and things should work fine. If you need to re-authenticate for any
reason, just run:

    $ ss authenticate

## Contributing

Favorite station not in the list? Fork the repo on GitHub:

http://github.com/peplin/scrapescrobbler

Add a file in stations/ that provides the Station API and send a pull request.
