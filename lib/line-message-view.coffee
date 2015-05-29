{View} = require 'space-pen'
Path = require 'path'

module.exports =
class LineMessageView extends View
  @content: ->
    @div class: 'amp-line-message', =>
      @div outlet: 'position', class: 'amp-line', click: 'goToLine'
      @span outlet: 'contents', class: 'amp-message'
      @pre outlet: 'code', class: 'amp-pre', click: 'goToLine'

  initialize: (params) ->
    @line = params.line;
    @character = params.character || undefined;
    @file = params.file || undefined;
    @message = params.message;
    @preview = params.preview || undefined;
    @className = params.className || undefined;

    message = 'at line ' + @line

    if @character != undefined
      message += ', character ' + @character

    if @file != undefined
      message += ', file ' + @file

    @position.text message
    @contents.text @message

    @contents.addClass @className if @className

    if @preview then @code.text @preview else @code.remove()

  goToLine: ->
    char = if @character != undefined then @character - 1 else 0
    activeFile = undefined
    activeEditor = atom.workspace.getActiveTextEditor()

    if activeEditor != undefined and activeEditor != null
      activeFile = Path.relative(atom.project.rootDirectories[0].path, activeEditor.getURI())

    if @file != undefined and @file != activeFile
      atom.workspace.open @file,
        initialLine: @line - 1
        initialColumn: char
    else
      atom.workspace.getActiveTextEditor().cursors[0].setBufferPosition [(@line - 1), char]

  getSummary: ->
    pos = @line

    if @character != undefined
      pos += ', ' + @character

    if @file != undefined
      pos += ', ' + @file

    return {
      summary: '<span>' + pos + '</span>: ' + @message
      rawSummary: true
      className: @className
      # handler: ((element) ->
      #   $('span', element).css('cursor', 'pointer').click @goToLine.bind(this)
      #   return
      # ).bind(this)
    }
