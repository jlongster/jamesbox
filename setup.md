Set up this new VM to match my current development box as closely as possible.

Assume the target machine may be a fresh Linux VM. Detect the distro first. If it is Arch-based, use `pacman`. If it is Debian/Ubuntu-based, use `apt` plus official install scripts where needed. Prefer idempotent commands and do not overwrite existing user data without backing it up.

Organize the work into the sections below. After each section, verify the installed tool/version where possible.

## 1. Base System Packages

Install common development/system tools:

- `git`
- `curl`
- `openssh`
- `base-devel` / `build-essential`
- `tmux`
- `htop`
- `fzf`
- `emacs`
- `nodejs`
- `npm`
- `tailscale`, if available for the distro

On Arch, the current box has:

- `emacs 30.2`
- `fzf 0.73.1`
- `git 2.55`
- `htop 3.5`
- `nodejs 26.4`
- `npm 11.16`
- `openssh`
- `tailscale`
- `tmux 3.7`
- `base-devel`
- `curl`

Use the package manager versions unless there is a good reason to use another source.

## 2. Home Directory Layout

Create these directories if they do not exist:

```bash
mkdir -p ~/projects
mkdir -p ~/archive
```

The main workspace should be `~/projects`.

## 3. Shell Setup

Use Bash as the shell.

Add this to `~/.bashrc`, preserving existing content:

```bash
export PATH="$HOME/.opencode/bin:$PATH"

# Prompt: host:path(branch)%  e.g. james-6:~/projects/opencode(v2)%
__git_branch() {
    local b
    b=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [ -n "$b" ] && printf '(%s)' "$b"
}
PS1='\h:\w$(__git_branch)% '

alias b='git branch --show-current'
alias s='git status'
alias d='git diff'
```

Add this to `~/.bash_profile`, preserving existing content and avoiding duplicates:

```bash
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

Reload the shell config after editing:

```bash
source ~/.bash_profile
```

## 4. Emacs

Install Emacs.

Configure it by symlinking to the .emacs.d folder in the jamesbox repo that you cloned.

If `~/.emacs.d` already exists, delete it before symlinking.

Tell Emacs to install the `solarized-theme` packages. After it installed, set the theme to `solarized-selenized-black`.

## 5. fzf

Install `fzf`.

Verify:

```bash
fzf --version
which fzf
```

Make sure Emacs knows where `fzf` is. In my current Emacs config this is set as:

```elisp
'(fzf/executable "/bin/fzf")
```

If `fzf` is installed somewhere else on the new VM, update that Emacs custom setting to the real path from:

```bash
command -v fzf
```

## 6. Node.js and npm

Install Node.js and npm.

Current versions on this box:

```bash
node --version   # v26.4.0
npm --version    # 11.16.0
```

Use the distro package if it gives a recent Node. If not, install a modern Node version using an appropriate official method.

## 7. Bun

Install Bun using the official installer:

```bash
curl -fsSL https://bun.sh/install | bash
```

Ensure this is in `~/.bash_profile`:

```bash
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

## 8. opencode

Install opencode with the official installer:

```bash
curl -fsSL https://opencode.ai/install | bash
```

Ensure this is in `~/.bashrc`:

```bash
export PATH="$HOME/.opencode/bin:$PATH"
```

Also install the next CLI globally with Bun:

```bash
bun install -g @opencode-ai/cli@next
```

## 9. opencode Config

Create the opencode config directory:

```bash
mkdir -p ~/.config/opencode
```

Create `~/.config/opencode/opencode.jsonc`:

```jsonc
{
  "$schema": "https://opencode.ai/config.json"
}
```

Create `~/.config/opencode/package.json`:

```json
{
  "dependencies": {
    "@opencode-ai/plugin": "1.17.11"
  }
}
```

Create `~/.config/opencode/AGENTS.md` with:

```markdown
The user's notes are available at /mnt/laptop. If they ask to write something down to their notes, find the latest weekly note in there (latest changed file with the title "Week of X" where X is the start of the week) and write in in there.

Always keep keep track of your work in a table at the bottom of the weekly note file. When you are tasked with making a complex change, start by adding an entry to that table, and when you are finished, update the row to mark it as finished and with a short description of what happened.
```

Do not copy service auth files like `service.json` or `service-local.json`; those should be recreated by logging in.

At the end of this, tell the user to login to opencode. Don't run this, just output this:

```bash
opencode console login https://console.opencode.ai
opencode providers login
```

## 10. GitHub CLI

Install GitHub CLI if available for the distro.

Verify:

```bash
gh --version
```

At the end of this, tell the user to login to gh. Don't run this, just output it:

```bash
gh auth login
```

## 11. SSH

Ensure OpenSSH client is installed.

If there is no SSH key, create an Ed25519 key:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
fi

chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

Do not copy private keys from another machine unless I explicitly provide them.

Print the public key so I can add it to GitHub or other services. Show this key at the end:

```bash
cat ~/.ssh/id_ed25519.pub
```

## 12. Tailnet / Tailscale / Laptop Mount

Install Tailscale and `sshfs` if they are not already installed.

Enable and authenticate Tailscale.

For systemd machines:

```bash
sudo systemctl enable --now tailscaled
sudo tailscale up
```

Create the laptop mount point:

```bash
sudo mkdir -p /mnt/laptop
sudo chown "$USER":"$USER" /mnt/laptop
```

Mount my laptop files over the tailnet using `sshfs`. Ask me for the laptop tailnet hostname and remote path if they are not known. Do not guess private hostnames.

Use this shape:

```bash
sshfs <laptop-tailnet-hostname>:<remote-path> /mnt/laptop \
  -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3
```

After mounting, verify:

```bash
mount | grep /mnt/laptop || true
ls /mnt/laptop
```

Skip Tailscale setup if the VM does not support it, but still report that `/mnt/laptop` could not be mounted without tailnet access.

## 13. tmux

Install tmux and verify:

```bash
tmux -V
```

I commonly use:

```bash
tmux -CC new -A -s main
tmux ls
```

No special tmux config is required unless one already exists.

## 14. Projects

Create `~/projects`.

Clone or set up project directories only if I provide repo URLs. My current machine has projects like:

- `~/projects/experiments`
- `~/projects/opencode-latest`

Do not invent repository URLs. Ask me for any private repo URLs that are needed.

## 15. Final Verification

Run and report output for:

```bash
git --version
emacs --version | head -n 1
fzf --version
node --version
npm --version
bun --version
opencode --version
gh --version | head -n 1
tmux -V
htop --version | head -n 1
```

Also verify these directories/files exist:

```bash
test -d ~/projects && echo "~/projects exists"
test -d ~/.emacs.d && echo "~/.emacs.d exists"
test -f ~/.emacs.d/init.el && echo "Emacs init exists"
test -f ~/.bashrc && echo "~/.bashrc exists"
test -f ~/.bash_profile && echo "~/.bash_profile exists"
test -f ~/.config/opencode/opencode.jsonc && echo "opencode config exists"
```

At the end, summarize what was installed, what still needs manual login/auth, and anything that could not be completed.
