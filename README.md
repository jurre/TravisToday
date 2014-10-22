# Travis Today
Travis Today is an OSX Yosemite Today widget that displays build statuse for [travis-ci](https://travis-ci.com).

It can currently only display public projects, but private ones are coming soon!

To use it right now you can:
- Clone this repository
- Add the slugs of the repositories that you want to see in your widget in `Today/Config.swift`. (for example: `PUBLIC_REPOS = ["rails/rails", "travis-ci/travis-core"]`)
- Run the Travis target once, you can close it now, the widget should be added to your today view (click `edit` on the bottom and you can add the travis widget)

Eventually you should be able to configure everything in the host app.

### TODO
- Support for private repositories
- Some sort of polling/hooking into Travis' Pusher service
- A nice UI to configure your repos/keys
- Tests (the irony!)
