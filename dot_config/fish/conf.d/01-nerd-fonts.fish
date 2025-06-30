# Nerd Fonts detection and configuration

# Function to check if Nerd Fonts are available
function __has_nerd_fonts
    switch (uname)
        case Darwin
            # macOS: Check using system_profiler (faster than parsing all fonts)
            system_profiler SPFontsDataType 2>/dev/null | grep -q "Nerd Font"
        case Linux
            # Linux: Check using fc-list
            fc-list 2>/dev/null | grep -q "Nerd Font"
        case '*'
            # Unknown system, assume no Nerd Fonts
            return 1
    end
end

# Set environment variable for other tools to check
if __has_nerd_fonts
    set -gx NERD_FONT 1
    set -gx NERD_FONT_AVAILABLE true
else
    set -gx NERD_FONT 0
    set -gx NERD_FONT_AVAILABLE false
    
    # In Codespaces, we might not have Nerd Fonts but we can still use Unicode
    if set -q CODESPACES
        set -gx USE_UNICODE_ICONS true
    end
end

# Function to get appropriate icon based on Nerd Font availability
function nf_icon --description "Get icon with fallback for non-Nerd Font environments"
    set -l nerd_icon $argv[1]
    set -l fallback $argv[2]
    
    if test "$NERD_FONT_AVAILABLE" = "true"
        echo -n $nerd_icon
    else if test -n "$fallback"
        echo -n $fallback
    else
        echo -n ""
    end
end

# Export the function for use in prompts and scripts
funcsave nf_icon >/dev/null 2>&1