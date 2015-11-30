BugzillaNumberView = require './bugzilla-number-view'
{CompositeDisposable} = require 'atom'

module.exports = BugzillaNumber =
  # bugzillaNumberView: null
  # modalPanel: null
  subscriptions: null

  activate: (state) ->
    # @bugzillaNumberView = new BugzillaNumberView(state.bugzillaNumberViewState)
    # @modalPanel = atom.workspace.addModalPanel(item: @bugzillaNumberView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'bugzilla-number:toggle': => @toggle()

  deactivate: ->
    # @modalPanel.destroy()
    @subscriptions.dispose()
    # @bugzillaNumberView.destroy()

  serialize: ->
    # bugzillaNumberViewState: @bugzillaNumberView.serialize()

  toggle: ->
    console.log 'BugzillaNumber was toggled!'

    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   @modalPanel.show()
