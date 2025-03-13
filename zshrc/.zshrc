# Add Homebrew to PATH
export PATH="/opt/homebrew/bin:$PATH"

# Language environment
export LANG=en_US.UTF-8

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Java (example: OpenJDK 23)
export JAVA_HOME="$(brew --prefix openjdk@23)/libexec/openjdk.jdk/Contents/Home"

# Initialize Conda
eval "$(/opt/homebrew/anaconda3/bin/conda shell.zsh hook)"

# Add your local scripts folder to PATH
export PATH="$HOME/.local/bin:$PATH"

# Source any custom environment variables
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
