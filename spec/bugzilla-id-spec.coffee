# tests for converting a bug ID into the relevant bugzilla URL

BugzillaID = require("../lib/bugzilla-id")

describe "BugzillaID", ->
  describe ".bugUrl()", ->

    # empty or invalid input

    it "returns null for null", ->
      bug = new BugzillaID(null)
      expect(bug.bugUrl()).toEqual(null)

    it "returns null for undefined", ->
      bug = new BugzillaID(undefined)
      expect(bug.bugUrl()).toEqual(null)

    it "returns null for an empty string", ->
      bug = new BugzillaID("")
      expect(bug.bugUrl()).toEqual(null)

    # valid bug IDs

    it "returns a valid URL for a 'bsc#1234' bug", ->
      bug = new BugzillaID("bsc#1234")
      expect(bug.bugUrl()).toEqual("https://bugzilla.suse.com/show_bug.cgi?id=1234")

    it "returns a valid URL for a 'bsc[space]#1234' bug", ->
      bug = new BugzillaID("bsc #1234")
      expect(bug.bugUrl()).toEqual("https://bugzilla.suse.com/show_bug.cgi?id=1234")

    it "returns a valid URL for a 'BSC[SPACE]#1234' bug", ->
      bug = new BugzillaID("BSC #1234")
      expect(bug.bugUrl()).toEqual("https://bugzilla.suse.com/show_bug.cgi?id=1234")

    it "returns a valid URL for a 'rh#1234' bug", ->
      bug = new BugzillaID("rh#1234")
      expect(bug.bugUrl()).toEqual("https://bugzilla.redhat.com/show_bug.cgi?id=1234")

    # unknown bugzilla URL

    it "returns null for unknwon Bugzilla URL (e.g. 'Ximian#1234')", ->
      bug = new BugzillaID("Ximian#1234")
      expect(bug.bugUrl()).toEqual(null)

    # some specific bug formats

    it "returns a valid URL for a 'CVE-2015-0042' bug", ->
      bug = new BugzillaID("CVE-2015-0042")
      expect(bug.bugUrl()).toEqual("https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-0042")

    it "returns a valid URL for a 'gh#yast/yast-core#42' bug", ->
      bug = new BugzillaID("gh#yast/yast-core#42")
      expect(bug.bugUrl()).toEqual("https://github.com/yast/yast-core/issues/42")
