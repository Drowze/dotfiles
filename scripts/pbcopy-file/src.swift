// Copy one or more files to the Mac OS clipboard, so that they can be pasted
// in e.g.: Finder or Slack
//
// compile with:
//   swiftc src.swift -o bin/pbcopy-file
//
// usage:
//   bin/pbcopy-file <file1> <file2> ...

import AppKit

let paths = CommandLine.arguments.dropFirst()
if paths.isEmpty { exit(0) }
let urls = paths.map { NSURL(fileURLWithPath: $0) }

let pb = NSPasteboard.general
pb.clearContents()

pb.writeObjects(urls)

// sleep 10ms; seems to be required to wait for the pasteboard to index the new items
usleep(10000)
