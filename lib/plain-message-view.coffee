{View} = require 'space-pen'

module.exports =
class PlainMessageView extends View
  @content: ->
    @div class: 'amp-plain-message'

  initialize: (params) ->
    @message = params.message
    @raw = params.raw || false
    @className = params.className || undefined

    if @raw then this.html @message else this.text @message

    this.addClass @className if @className

  getSummary: ->
    summary: @message
    className: @className
    rawSummary: @raw
