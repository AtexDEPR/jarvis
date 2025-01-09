#!/bin/bash

# Variables Globales
GITHUB_EMAIL=""
GITHUB_USERNAME=""
GITHUB_REPO=""                        
IMAGE_URL=""

# Variables para personalizar la terminal
BACKGROUND_COLOR="rgb(0,0,0)"        # Ingresa el color de fondo que quieres para tu terminal
BACKGROUND_TRANSPARENCY_PERCENT=15   # Ingresa el porcentaje de transparencia para el fondo de la terminal
FONT=""                              # Ingresa el estilo de letra
FOREGROUND_COLOR="rgb(255,255,255)"  # Ingresa el color de la letra


# Función para personalizar la terminal
customize_terminal() {

    PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    PROFILE_PATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

    # Background color
    gsettings set $PROFILE_PATH background-color "$BACKGROUND_COLOR"

    # Transparency
    gsettings set $PROFILE_PATH use-transparent-background true
    gsettings set $PROFILE_PATH background-transparency-percent $BACKGROUND_TRANSPARENCY_PERCENT

    # Cursor properties
    gsettings set $PROFILE_PATH cursor-shape 'block'
    gsettings set $PROFILE_PATH cursor-blink-mode 'on'

    # Theme and colors
    gsettings set $PROFILE_PATH use-theme-colors false

    # Font settings
    gsettings set $PROFILE_PATH use-system-font false
    gsettings set $PROFILE_PATH font "$FONT"
    gsettings set $PROFILE_PATH foreground-color "$FOREGROUND_COLOR"U    # Get default profile ID
    
    # File and directory colors (creates or modifies .bashrc entries)
    if ! grep -q 'Custom colors for files and directories' ~/.bashrc; then
        echo '
		# Custom colors for files and directories
		LS_COLORS="di=1;34:ln=1;36:ex=1;32:*.jpg=1;35:*.png=1;35:*.txt=0;37"
		export LS_COLORS

		# Enable color support
		alias ls="ls --color=auto"
		alias dir="dir --color=auto"
		alias grep="grep --color=auto"
		' >> ~/.bashrc
    fi

    # Add custom prompt colors
    if ! grep -q 'Custom colored prompt' ~/.bashrc; then
        echo '
		# Custom colored prompt
		RED='\''\[\033[0;31m\]'\''
		GREEN='\''\[\033[0;32m\]'\''
		YELLOW='\''\[\033[0;33m\]'\''
		BLUE='\''\[\033[0;34m\]'\''
		PURPLE='\''\[\033[0;35m\]'\''
		CYAN='\''\[\033[0;36m\]'\''
		RESET='\''\[\033[0m\]'\''
		PS1="${GREEN}\u${RESET}@${BLUE}\h${RESET}:${PURPLE}\w${RESET}\$ "
		' >> ~/.bashrc
    fi

    # Apply changes
    source ~/.bashrc
	reset
    echo "Terminal customization applied!"
}
