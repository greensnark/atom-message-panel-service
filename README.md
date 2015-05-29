# Atom Message Panel Service package

Original package: [atom-message-panel](https://github.com/tcarlsen/atom-message-panel)

## OBS!

This package is under development and is not stabel for production, but fill free to test it out and report issues and of course PR's are welcome any day! :smile:

## Basic use:
**This package is in  development and API can still change**

First thing first, you need to add the services to your `package.json`

```json
...
  "consumedServices": {
    "message-panel-view": {
      "versions": {
        "1.0.0": "consumeMessagePanelView"
      }
    },
    "plain-message-view": {
      "versions": {
        "1.0.0": "consumePlainMessageView"
      }
    },
    "line-message-view": {
      "versions": {
        "1.0.0": "consumeLineMessageView"
      }
    }
  }
...
```

Next thing is to activate the services in your package like this:

```coffeescript
consumeMessagePanelView: (service) ->
  @panel = new service
    title: "<span class=\"icon-bug\"></span> JSLint report"
    rawTitle: true
    closeMethod: "destroy"

consumePlainMessageView: (service) ->
  @plainMessage = service

consumeLineMessageView: (service) ->
  @lineMessage = service
```

Now your ready to send messages to the user:

```coffeescript
toggle: ->
  @panel.attach()

  @panel.add new @plainMessage
    message: "test"
    className: "text-success"

  @panel.add new @lineMessage
    message: "test"
    className: "text-error"
    line: 10
    character: 3
```

## API

See the API over at the original npm package [atom-message-panel#api](https://github.com/tcarlsen/atom-message-panel#api) for now.

Changes can/will come so check the source to verify the API call before creating an issue.

## License

[MIT](LICENSE.md) © tcarlsen
