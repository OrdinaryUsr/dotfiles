# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
