module.exports =
  activate: ->
    console.log 'Atom Message Panel is activated!'

  provideMessagePanelView: ->
    MessagePanelView = require './message-panel-view'

  providePlainMessageView: ->
    PlainMessageView = require './plain-message-view'

  provideLineMessageView: ->
    LineMessageView = require './line-message-view'
