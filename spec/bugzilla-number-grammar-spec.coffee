# tests for the bug ID grammar

describe 'Bugzilla-number grammar', ->
  grammar = null

  beforeEach ->
    promise = atom.packages.activatePackage('bugzilla-number')

    waitsForPromise ->
      promise

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.bugzilla-number')

  it 'parses the grammar', ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe 'text.bugzilla-number'

  it 'ignores whitespace around a bug', ->
    {tokens} = grammar.tokenizeLine('   bnc#13245   ')
    expect(tokens[1]).toEqual value : 'bnc#13245', scopes :
      ['text.bugzilla-number', 'storage.type.class.bugzilla-number']

  it 'ignores extra whitespace inside', ->
    {tokens} = grammar.tokenizeLine('bnc   #13245')
    expect(tokens[0]).toEqual value : 'bnc   #13245', scopes :
      ['text.bugzilla-number', 'storage.type.class.bugzilla-number']

  it 'allows missing hash mark', ->
    {tokens} = grammar.tokenizeLine('bnc 13245')
    expect(tokens[0]).toEqual value : 'bnc 13245', scopes :
      ['text.bugzilla-number', 'storage.type.class.bugzilla-number']

  it 'allows missing hash and no space', ->
    {tokens} = grammar.tokenizeLine('bnc13245')
    expect(tokens[0]).toEqual value : 'bnc13245', scopes :
      ['text.bugzilla-number', 'storage.type.class.bugzilla-number']

  it 'tokenizes a FATE feature', ->
    {tokens} = grammar.tokenizeLine('FATE#13245')
    expect(tokens[0]).toEqual value : 'FATE#13245', scopes :
      ['text.bugzilla-number', 'storage.type.class.bugzilla-number']

  it 'tokenizes a GitHub issue', ->
    {tokens} = grammar.tokenizeLine('gh#yast/yast-core#42')
    expect(tokens[0]).toEqual value : 'gh#yast/yast-core#42', scopes :
      ['text.bugzilla-number', 'storage.type.class.gh-number']

  it 'tokenizes a CVE vulnerabilty ID', ->
    {tokens} = grammar.tokenizeLine('CVE-2015-0042')
    expect(tokens[0]).toEqual value : 'CVE-2015-0042', scopes :
      ['text.bugzilla-number', 'storage.type.class.cve-number']

