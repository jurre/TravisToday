# Travis Today
Travis Today is an OSX Yosemite Today widget that displays build statuse for [travis-ci](https://travis-ci.

To use it right now you can:
- Clone this repository
- Add configs for the repositories that you want to see in your widget in `Today/Config.swift`.
For example: `REPOS = [RepoConfig(slug: 'jurre/dotfiles', access: .Private), RepoConfig(slug: 'travis-ci/travis-core', access: .Public)]`
Also set up a Github key here if you want to add private repos.
Check out Today/Config.swift.sample to get an idea.
- Run the Travis target once, you can close it now, the widget should be added to your today view (click `edit` on the bottom and you can add the travis widget)

Eventually you should be able to configure everything in the host app.

<img src="http://i.imgur.com/jH7lvFo.png?1" alt="TravisToday" width=300/>

### TODO
- Use keychain to store travis access token (right now it's in NSUserDefaults which isn't safe)
- Some sort of polling/hooking into Travis' Pusher service
- Notifications when builds fail
- A nice UI to configure your repos/keys
- Tests (the irony!)

## Contact
Jurre Stender

- https://github.com/jurre
- [@jurretweet](https://twitter.com/jurretweet)
