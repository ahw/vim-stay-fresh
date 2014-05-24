Vim Stay Fresh
--------------

Overview
========
The plugin itself is very simple; it simply makes a silent `curl` request to
`localhost:7700/reload` whenever Vim emits a `BufWritePost` event. The idea
is that you can then install the corresponding Chrome extension and listener
process which reacts to those requests and triggers a reload in whichever
Chrome tabs are configured to listen for these events.

Installation
============
There are three components that need to be installed. *This plugin*, the
*Chrome extension*, and the *native host listener*. The "native host
listener" is just a Node.js HTTP server that listens for HTTP requests and
communicates on `stdio` to the Chrome extension. When the listener gets a
"reload" request from the Vim plugin (over HTTP), it tells the extension
(over `stdio`) to reload any tabs that are set up to listen for these
events.

1. I recommend installing the Vim plugin with
   [Pathogen](https://github.com/tpope/vim-pathogen).
2. Install the Chrome extension via the Chrome Web Store or load the
   unpacked version from a local checkout of the repository.
3. Install the native listening script [manually](https://developer.chrome.com/extensions/messaging#native-messaging).


Local Use
=========
The Vim plugin just makes an HTTP request to *localhost:7700*. which the
native host process is already listening to. In other words, no further set
up is required. Click the extension's icon in the browser toolbar to start
picking up reload requests.

Remote Use (SSH)
================
`ssh your.server.com -R 7700:localhost:7700` will enable remote port
forwarding. I.e., all requests made to port 7700 on *your.server.com* will
be sent through an SSH tunnel (we get encryption for free) to your client
machine, which will then just forward that request to the _client's_
*localhost:7700*. Voila. You can set up your `~/.ssh/config` file as
follows.

 Host your.server.com
     HostName 12.34.56.78
     User sarah
     RemoteForward 7700 localhost:7700
