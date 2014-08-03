Vim Stay Fresh
==============
This is a Vim plugin which simply makes a silent `curl` request to
`localhost:7700/reload` whenever Vim emits a `BufWritePost` `autocmd` event.
The idea is that you can then install the corresponding Chrome extension,
[chrome-stay-fresh](https://github.com/ahw/chrome-stay-fresh), which listens
for those requests and triggers a reload in whichever Chrome tabs are
configured to respond.

For those interested, the [vim-hooks](https://github.com/ahw/vim-hooks)
plugin generalizes on this concept and allows you to hook _any_ script into
_any_ Vim `autocmd` event. A one-line script which simply ran  `curl
localhost:7700/reload` on `BufWritePost` events is one specific example
that would be functionally the same as installing this plugin, though you can
no doubt imagine many other sorts of scripts, or sets of scripts, which
could be used to achieve more complicated ends.

Installation
------------
If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone https://github.com/ahw/vim-stay-fresh.git

Of course in order for anything interesting to happen, you must also install
[chrome-stay-fresh](https://github.com/ahw/chrome-stay-fresh), and detailed
instructions on how to do so are available at that link.

Local Use
---------
**vim-stay-fresh** just makes HTTP requests to **localhost:7700**, which the
native host process is already listening to. So, no further set up is
required. Click the extension's icon in the browser toolbar to toggle
whether or not that tab reacts to reload requests.

Remote Use (SSH)
----------------
The command `ssh your.server.com -R 7700:localhost:7700` will enable remote
port forwarding, which means that all requests made to port 7700 on
**your.server.com** will be sent through an SSH tunnel to your client
machine, which will then just forward that request to the _client's_
**localhost:7700**. Voila. You can set up your `~/.ssh/config` file as
follows in order to avoid having to remember to add the remote port
forwarding argument all the time.

```
Host your.server.com
  HostName 12.34.56.78
  User sarah
  RemoteForward 7700 localhost:7700
```
