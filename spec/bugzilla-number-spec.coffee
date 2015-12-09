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
      spyOn(shell, 'openExternal')
      editor = atom.workspace.getActiveTextEditor()
      editor.insertText('this fixes bug bsc#67890 in the manual mode')

  describe "when the bugzilla-number:open-link event is triggered in editor", ->
    it "opens the referenced bug in browser", ->
      # position the cursor at the bsc bug ID
      editor.setCursorBufferPosition([0, 18])
      atom.commands.dispatch workspaceElement, 'bugzilla-number:open-link'

      expect(shell.openExternal).toHaveBeenCalled()
      expect(shell.openExternal.mostRecentCall.args[0])
        .toEqual("https://bugzilla.suse.com/show_bug.cgi?id=67890")

    it "does nothing if the cursor is outside of a bug ID", ->
      # position the cursor at the beginning
      editor.setCursorBufferPosition([0, 1])
      atom.commands.dispatch workspaceElement, 'bugzilla-number:open-link'

      expect(shell.openExternal).not.toHaveBeenCalled()

