{View} = require 'space-pen'

module.exports =
class MessagePanelView extends View
  @content: ->
    @div tabIndex: -1, class: 'amp', =>
      @header class: 'amp-header', =>
        @span outlet: 'heading', class: 'amp-title'
        @div outlet: 'summary', class: 'amp-summary'
        @div class: 'pull-right', =>
          @button outlet: 'btnAutoScroll', class: 'amp-button icon-move-down', click: 'toggleAutoScroll'
          @button outlet: 'btnFold', class: 'amp-button icon-fold', click: 'toggle'
          @button outlet: 'btnClose', class: 'amp-button icon-x', click: 'close'

      @section outlet: 'body', class: 'amp-body'

  initialize: (params) ->
    @title = params.title
    @rawTitle = params.rawTitle || false
    @speed = params.speed || 'fast'
    @panel = undefined
    @maxHeight = params.maxHeight || '170px'
    @autoScroll = params.autoScroll || false
    @closeMethod = params.closeMethod || 'hide'
    @recentMessagesAtTop = params.recentMessagesAtTop || false
    @position = params.position || 'bottom'
    @messages = []

    @setTitle()
    @summary.hide()
    @toggleAutoScroll() if @autoScroll

  setTitle: ->
    if @rawTitle then @heading.html @title else @heading.text @title

  setSummary: (summary) ->
    message = summary.summary
    className = summary.className
    raw = summary.rawSummary or false
    handler = summary.handler or undefined

    if raw then @summary.html message else @summary.text message

    @summary.addClass className if className

    handler @summary if handler

  attach: ->
    if @panel is undefined
      if @position is 'bottom'
        @panel = atom.workspace.addBottomPanel(item: this)
      else if @position is 'top'
        @panel = atom.workspace.addTopPanel(item: this)

      @body.css({maxHeight: @maxHeight})

      if @btnAutoScroll.hasClass 'icon-move-up'
        @body.scrollTop 1e10
    else
      @panel.show()

  close: ->
    if @panel isnt undefined
      @panel[@closeMethod].call @panel

      if @closeMethod is 'destroy'
        @panel = undefined

  add: (view) ->
    if @messages.length == 0 and view.getSummary
      @setSummary view.getSummary()

    if @recentMessagesAtTop
      @body.prepend view
    else
      @body.append view

    @messages.push view

  clear: ->
    @messages = [];
    @body.empty()

  toggle: ->
    @btnFold.toggleClass 'icon-fold, icon-unfold'
    @body.toggle @speed

    if @summary.css('display') is 'none'
      @summary.css 'display', 'inline-block'
    else
      @summary.hide()

  updateScroll: ->
    if @btnAutoScroll.hasClass 'icon-move-up'
      @body.scrollTop 1e10
    else
      @body.scrollTop 0

  toggleAutoScroll: ->
    @btnAutoScroll.toggleClass 'icon-move-up'
    @updateScroll()
