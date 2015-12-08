{CompositeDisposable} = require 'atom'
# improved version of http://underscorejs.org/ (by Atom developers)
_ = require 'underscore-plus'

module.exports = BugzillaNumber =
  subscriptions: null

  # see the grammar file ../grammars/bugzilla-number-grammar.cson
  supported_scopes: [ 'storage.type.class.bugzilla-number',
    'storage.type.class.gh-number', 'storage.type.class.cve-number'
  ]

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that open a bugzilla number
    @subscriptions.add atom.commands.add 'atom-workspace', 'bugzilla-number:open-link': => @open_link()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  open_link: ->
    return unless editor = atom.workspace.getActiveTextEditor()
    return unless position = editor.getCursorBufferPosition()

    return unless token = editor.tokenForBufferPosition(position)
    return unless scopes = token.scopes

    # boo#123
    # get the bugzilla scope at the cursor, using only the first item is safe,
    # the token cannot match more than a single regexp
    bugzilla_scope = _.intersection(scopes, @supported_scopes)[0]
    console.debug "Bugzilla scope at the cursor: #{bugzilla_scope}"

    return unless bugzilla_scope?

    console.log "Found bugzilla ID at cursor: #{token.value}"

    # TODO: get the URL for the bug ID

    # TODO: open the bug in browser
