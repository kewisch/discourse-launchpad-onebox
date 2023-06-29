# Launchpad Onebox Plugin for Discourse

This plugin provides a rich preview for certain URLs on launchpad.net. It is currently limited to
showing the members of a group, but contributions are welcome to add other launchpad previews.

## Installation

The following commands will install the plugin into your discourse instance:

```bash
rake plugin:install repo=https://github.com/kewisch/discourse-launchpad-onebox name=discourse-launchpad-onebox
rake posts:rebake # This will take a long time depending on how much content you have.
```

If you need to uninstall, remove the `plugins/discourse-launchpad-onebox` directory and optionally
rebake the posts again.
