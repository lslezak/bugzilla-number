# test the editor integration

shell = require 'shell'
BugzillaNumber = require '../lib/bugzilla-number'

describe "BugzillaNumber", ->
  workspaceElement = null
  editor = null

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    waitsForPromise -> atom.packages.activatePackage('bugzilla-number')
    waitsForPromise -> atom.workspace.open('test.txt')

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText('# fixes bug bsc#67890 in the manual mode')

  describe "when the bugzilla-number:open-link event is triggered in editor", ->
    it "opens the referenced bug in browser", ->
      url = null
      spyOn(shell, 'openExternal').andCallFake ->
        url = shell.openExternal.mostRecentCall.args[0]
      # position the cursor at the bsc bug ID
      editor.setCursorBufferPosition([0, 18])
      atom.commands.dispatch workspaceElement, 'bugzilla-number:open-link'

      expect(url).toEqual("https://bugzilla.suse.com/show_bug.cgi?id=67890")
      expect(shell.openExternal).toHaveBeenCalled()

    it "does nothing if the cursor is outside of a bug ID", ->
      spyOn(shell, 'openExternal')
      # position the cursor at the beginning
      editor.setCursorBufferPosition([0, 1])
      atom.commands.dispatch workspaceElement, 'bugzilla-number:open-link'

      expect(shell.openExternal).not.toHaveBeenCalled()

