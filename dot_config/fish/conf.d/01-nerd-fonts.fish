# Nerd Fonts detection - FAST VERSION
# Skip slow system_profiler on macOS and use simple detection

# On macOS, assume nerd fonts are installed
# On Linux, do a quick check
if test (uname) = "Darwin"
    set -gx NERD_FONT_AVAILABLE 1
else
    # Quick check for common nerd fonts
    if command -q fc-list; and fc-list 2>/dev/null | grep -q "Nerd Font"
        set -gx NERD_FONT_AVAILABLE 1
    else
        set -gx NERD_FONT_AVAILABLE 0
    end
end

# Set environment variables for compatibility
if test "$NERD_FONT_AVAILABLE" = "1"
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

# Export for child processes
set -x NERD_FONT_AVAILABLE