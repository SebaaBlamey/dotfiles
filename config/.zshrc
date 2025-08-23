export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  sudo
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf-zsh-plugin
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

# alias for ls
alias ls='exa --icons'
alias l='exa -lah --color=always --group-directories-first --icons'
alias la='exa -al --color=always --group-directories-first --icons' 
alias ll='exa -l --color=always --group-directories-first --icons'
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing 

# alias for cat
alias cat='bat --theme=Nord'


# bun completions
[ -s "/home/seba/.bun/_bun" ] && source "/home/seba/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/home/seba/.local/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin

export GOOGLE_AI_APY_KEY="key"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
