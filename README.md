# Atom bugzilla-number

[![Build Status](https://travis-ci.org/lslezak/bugzilla-number.svg)](https://travis-ci.org/lslezak/bugzilla-number)
![Version](https://img.shields.io/apm/v/bugzilla-number.svg)
![License MIT](https://img.shields.io/apm/l/bugzilla-number.svg)

This [Atom](https://atom.io) package highlights bug numbers in a text document
or in code comments. You can easily open the referenced bug in browser by a keyboard
shortcut.

## Features

- Syntax highlighting for bug IDs.
- Supports almost all [standard openSUSE bug IDs](
https://en.opensuse.org/openSUSE:Packaging_Patches_guidelines#Current_set_of_abbreviations),
  like `boo#123456`, `bnc#123456`, `FATE#13245` `rh#132456`. Also CVE
  (`CVE-2015-0042`) and GitHub isues (`gh#yast/yast-core#42`) are supported.
- The referenced bug can be opened in browser using the `Ctrl-Shift-B` keyboard shortcut.

![Screen cast](https://cloud.githubusercontent.com/assets/907998/11691025/86aa411e-9e99-11e5-94a5-eca67ba74485.gif)