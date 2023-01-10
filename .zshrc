# Constants
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.custom_scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/usr/local:$PATH"

# Read my aliases file
. ~/.aliases

# Persist pywal for new terminals
(cat ~/.cache/wal/sequences &)
. "${HOME}/.cache/wal/colors.sh"

# Command history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Vim mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!**/{build,.git,gen,.class,bin,coverage,node_modules}/**" 2> /dev/null'

# Automatically add fzf key bindings to .zshrc
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# PROMPT
source ~/.zsh_prompt

# zsh-syntax-highlighting must be at the bottom
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
