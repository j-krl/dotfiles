setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{yellow}(%f%F{red}%b%f%F{yellow})%u%c%m %f'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '!'
zstyle ':vcs_info:git:*' stagedstr '?'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
	if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]] &&
		git status --porcelain | grep -m 1 '^??' &>/dev/null; then
		hook_com[misc]='*'
	fi
}
precmd() {
	vcs_info
}
PROMPT='%F{blue}%0~%f ${vcs_info_msg_0_}%F{green}%(!.#.>) %f'

export EDITOR=nvim
export BINDIR="$HOME/.local/bin"
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacadah
export GIT_PAGER="diff-highlight | less"

if command -v bat >/dev/null 2>&1; then
	alias less="bat"
	export BAT_STYLE=grid
	export MANPAGER=bat
fi

alias ga="gcloud auth login --update-adc"
alias co="copilot"
alias k="kubectl"
alias mux="cd && ~/dotfiles/tmux/tmux-session.sh"
alias nvs="nvim -S Session.vim"
alias vs="vim -S Session.vim"
alias prc="gh pr create --fill-first"
alias prd="gh pr create --fill-first --draft"

difftool() {
	nvim -c "let g:taboo_tab_format = \" %N %R \"" -c "Git difftool -y $1" \
		-c "set showtabline=2" -c "set tabclose=" -c "exe 'cd ' .. getcwd()" \
		-c "1tabcl"
}

ghclone() {
	git clone "https://github.com/$1.git"
}

export PATH="$PATH:$HOME/.local/bin"

autoload -U +X bashcompinit && bashcompinit

export TERM="xterm-256color"
[[ -n $TMUX ]] && export TERM="screen-256color"

bindkey \^U backward-kill-line
