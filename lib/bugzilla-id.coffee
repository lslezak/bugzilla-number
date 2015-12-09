
class BugzillaID
  # see https://en.opensuse.org/openSUSE:Packaging_Patches_guidelines#Current_set_of_abbreviations
  # %d is a placeholder for the bug ID
  BUGZILLA_URL =
    "boo"  : "https://bugzilla.opensuse.org/show_bug.cgi?id=%d"
    "bsc"  : "https://bugzilla.suse.com/show_bug.cgi?id=%d"
    "BSC"  : "https://bugzilla.suse.com/show_bug.cgi?id=%d"
    "bug"  : "https://bugzilla.suse.com/show_bug.cgi?id=%d"
    "BUG"  : "https://bugzilla.suse.com/show_bug.cgi?id=%d"
    "bnc": "https://bugzilla.novell.com/show_bug.cgi?id=%d"
    "BNC": "https://bugzilla.novell.com/show_bug.cgi?id=%d"
    "pr"   : "https://bz.apache.org/bugzilla/show_bug.cgi?id=%d"
    "boost": "https://svn.boost.org/trac/boost/ticket/%d"
    # "ceph": "" - does not exist? http://tracker.ceph.com/ is empty...
    "claws": "http://www.thewildbeast.co.uk/claws-mail/bugzilla/show_bug.cgi?id=%d"
    "CVE": "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-%d"
    "RT": "https://rt.cpan.org/Public/Bug/Display.html?id=%d"
    "deb": "https://bugs.debian.org/%d"
    "beo": "https://bugs.exim.org/show_bug.cgi?id=%d"
    "fate": "https://fate.suse.com/%d"
    "FATE": "https://fate.suse.com/%d"
    "fdo": "https://bugs.freedesktop.org/show_bug.cgi?id=%d"
    "gnu": "http://savannah.gnu.org/bugs/?%d"
    "GCC": "https://gcc.gnu.org/bugzilla/show_bug.cgi?id=%d"
    "bgo": "https://bugzilla.gnome.org/show_bug.cgi?id=%d"
    "gvz": "http://graphviz.org/mantisbt/view.php?id=%d"
    "bio": "https://bugzilla.icculus.org/show_bug.cgi?id=%d"
    "jenk": "https://issues.jenkins-ci.org/browse/JENKINS-%d"
    "kde": "https://bugs.kde.org/show_bug.cgi?id=%d"
    "bko": "https://bugzilla.kernel.org/show_bug.cgi?id=%d"
    "lp": "https://bugs.launchpad.net/bugs/%d"
    "lf": "https://developerbugs.linuxfoundation.org/show_bug.cgi?id=%d"
    # "MeeGo": "" - does not exist?
    # "Mono": "" -  does not exist?
    "bmo": "https://bugzilla.mozilla.org/show_bug.cgi?id=%d"
    "ITS": "http://www.openldap.org/its/index.cgi/Software%20Bugs?id=%d"
    "i": "https://bz.apache.org/ooo/show_bug.cgi?id=%d"
    "n": "https://bugzilla.novell.com/show_bug.cgi?id=%d"
    # "os-edu": "" - does not exist?
    "pidgin.im": "https://developer.pidgin.im/ticket/%d"
    "rh": "https://bugzilla.redhat.com/show_bug.cgi?id=%d"
    "bso": "https://bugzilla.samba.org/show_bug.cgi?id=%d"
    "sf": "http://sf.net/support/tracker.php?aid=%d"
    "swo": "https://sourceware.org/bugzilla/show_bug.cgi?id=%d"
    # "t3": "" - only for registered users?
    "webkit": "https://bugs.webkit.org/show_bug.cgi?id=%d"
    # "Ximian": "" - does not exist?
    "bxo": "https://bugzilla.xfce.org/show_bug.cgi?id=%d"
    "bxc": "https://bugzilla.xamarin.com/show_bug.cgi?id=%d"

  constructor: (id) ->
    match = /^(\w+)\s*(#|)\s*(\d+)$/.exec(id)
    
    [_all, @bugzilla, _separator, @bugid] = match if match?
    
    # try some special cases
    if !@bugzilla?
      # CVE
      match = /^(CVE)-(\d+-\d+)$/.exec(id)
      [_all, @bugzilla, @bugid] = match if match?
      
    if !@bugzilla?
      # GitHub issue
      match = /^(gh#\S+)#(\d+)$/.exec(id)
      [_all, @bugzilla, @bugid] = match if match?

  bugUrl: ->
    return null unless @bugzilla? && @bugid?

    urlTemplate = BUGZILLA_URL[@bugzilla]
    return urlTemplate.replace('%d', @bugid) if urlTemplate?
      
    # handle special cases
    ghPrefix = 'gh#'
    if @bugzilla.substr(0, ghPrefix.length) is ghPrefix
      project = /^gh#(\S+)$/.exec(@bugzilla)[1]
      return "https://github.com/#{project}/issues/#{@bugid}" if project?

    # not found
    null
    
module.exports = BugzillaID