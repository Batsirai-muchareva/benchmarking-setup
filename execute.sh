#!/bin/zsh

# Define the repository URL
REPO_URL="https://github.com/GoogleChromeLabs/wpp-research.git"

# Define the target directoryh
TARGET_DIR="$HOME/wpp-research"

# Check if the directory already exists
if [ -d "$TARGET_DIR" ]; then
     # Check if node_modules directory exists (indicating npm install has been run)
      if [ -d "$TARGET_DIR/node_modules" ]; then
          echo "npm install has already been run in $TARGET_DIR"
      else
          # If node_modules directory doesn't exist, run npm install
          echo "Directory already exists, but npm install has not been run. Running npm install..."
          npm install --prefix "$TARGET_DIR"
      fi
else
    # If directory doesn't exist, clone the repository and then run npm install
    echo "Cloning repository..."
    git clone "$REPO_URL" "$TARGET_DIR"
    echo "Repository cloned. Running npm install..."
    cd "$TARGET_DIR"
    npm install
fi

# Define the alias command
RESEARCH_ALIAS="npm run --prefix $TARGET_DIR research"

# Check if the alias already exists in .zshrc
if ! grep -q "alias research='$RESEARCH_ALIAS'" $HOME/.zshrc; then
    # If alias doesn't exist, add it to .zshrc
    echo "Adding 'research' alias to .zshrc..."
    echo "alias research='$RESEARCH_ALIAS'" >> $HOME/.zshrc
    # Source the .zshrc file to apply the alias
    source ~/.zshrc

    echo "Alias 'research' added."
else
    # If alias already exists, notify the user
    echo "Alias 'research' already exists in .zshrc. Skipping addition."
fi

echo "Setup complete."
