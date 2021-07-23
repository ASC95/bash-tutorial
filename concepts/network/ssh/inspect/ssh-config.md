# Links
- https://linuxize.com/post/using-the-ssh-config-file/ - `config` file syntax
- https://www.ssh.com/ssh/config/ - more `config` file syntax
- https://serversforhackers.com/c/ssh-tricks - `ssh` good tips
- https://crypto.stackexchange.com/questions/60255/why-doesnt-ssh-use-tls
# Examples
## No HostName attribute
### File
#### `~/.ssh/config`
```
# Regular GitLab
Host gitlab*
Preferredauthentications publickey
IdentityFile <path to .key file>
```
### Command
```
$ ssh git@gitlab.com
```
- `ssh` reads the `Host gitlab*` stanza and sees that it matches the provided host "gitlab.com", so it applies the corresponding configuration to the
  connection
- No `HostName` attribute was specified in `config`. Therefore, `ssh` will use "gitlab.com" as typed in the terminal as the real host name to connect
  to
## HostName attribute
### File
#### `~/.ssh/config`
```
# Regular GitLab
Host gitl*
HostName gitlab.com
Preferredauthentications publickey
IdentityFile <path to .key file>
```
- The HostName is _not_ `https://gitlab.com/`
  - Why? HTTPS is just a protocol. It's not part of the actual host name. Also, `ssh` doesn't use TLS (see source)
### Command
```
$ ssh git@gitla
```
- `ssh` reads the `Host gitl*` stanza and sees that is matches the provided host "gitla", so it applies the corresponding configuration to the
  connection
- The `HostName` attribute was specified in `config`. Therefore, `ssh` will use that as the real host name to connect to instead of "gitla"
## GitLab clone with ssh
### File
#### `~/.ssh/config`
```
# Regular GitLab
Host gitlab*
HostName gitlab.com
Preferredauthentications publickey
IdentityFile <path to .key file>
```
- Notice how the `Host` field is "gitlab*" and not "gitlab"
  - Only "gitlab*" will match "gitlab.com:test-search-head/source-code.git"
### Command
```
$ git clone git@gitlab.com:test-search-head/source-code.git
```
# Purpose
- The server I'm connecting to must already have an existing public key that matches the private key that I'll use to connect
- The `~/.ssh/config` file is used to store configurations that will be read and used by the `ssh` command
- The file must have read + write permissions for the owner and none for everyone else
- Best pratice is it to set permission to 600 for all private/public key files
# Files
- The `config` file is by default expected to be located at `~/.ssh/config`
- The extension to a private key file is irrelevant, but ".key" is a common convention, as is no extension
  - Likewise, the extension to a public key file is irrelevant, but ".pub" is a common convention
# Syntax
- I don't think any of the attributes are technically required
  - `ssh` will apply some default configuration if no specific stanza matches the typed command
## Attributes
- Host: one or more whitespace-separated _patterns_ that the \<host> must match to have the configuration applied to it
  - "*" matches zero or more characters
    - E.g. `Host git*` matches `git`, `gitlab.com`, `github.com`, etc.
  - "?" matches exactly one character
    - E.g. `Host gitlab?com` matches `gitlab.com`, `gitlab+com`, etc.
  - "!" negates a pattern
    - E.g. `Host git* !github*` matches `gitlab.com` but not `gitub.com`
  - No special characters means the typed host must exactly match
    - E.g. `Host gitlab.com` only matches the host `gitlab.com`
- HostName: the real host name to connect to
- IdentityFile: the location of the private key to use
# Command workflow
- Entering the passphrase in the terminal to access a private key for an ssh connection is an entirely local process
  - The passphrase isn't submitted to the server or anything