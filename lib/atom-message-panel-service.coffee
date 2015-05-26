AtomMessagePanelServiceView = require './atom-message-panel-service-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomMessagePanelService =
  atomMessagePanelServiceView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomMessagePanelServiceView = new AtomMessagePanelServiceView(state.atomMessagePanelServiceViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomMessagePanelServiceView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-message-panel-service:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomMessagePanelServiceView.destroy()

  serialize: ->
    atomMessagePanelServiceViewState: @atomMessagePanelServiceView.serialize()

  toggle: ->
    console.log 'AtomMessagePanelService was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
