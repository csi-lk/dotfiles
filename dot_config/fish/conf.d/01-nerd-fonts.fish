# Nerd Fonts detection - FAST VERSION
# Skip slow system_profiler on macOS and use simple detection

# Cache file location for font detection result
set -g __nerd_fonts_cache_file "$HOME/.cache/fish/nerd-fonts-detected"
set -l cache_dir (dirname $__nerd_fonts_cache_file)

# Create cache directory if it doesn't exist
if not test -d $cache_dir
    mkdir -p $cache_dir
end

# Fast check - on macOS, check if cache exists and use it, otherwise assume installed
# This avoids the extremely slow system_profiler command
if test (uname) = "Darwin"
    if test -f $__nerd_fonts_cache_file
        set -l cached_value (command cat $__nerd_fonts_cache_file 2>/dev/null)
        if test -n "$cached_value" -a "$cached_value" = "1"
            set -gx NERD_FONT_AVAILABLE 1
        else
            set -gx NERD_FONT_AVAILABLE 0
        end
    else
        # On macOS, assume nerd fonts are installed and cache the result
        set -gx NERD_FONT_AVAILABLE 1
        echo "1" > $__nerd_fonts_cache_file
    end
else
    # Quick check for common nerd fonts on Linux
    if command -q fc-list; and fc-list 2>/dev/null | grep -q "Nerd Font"
        set -gx NERD_FONT_AVAILABLE 1
        echo "1" > $__nerd_fonts_cache_file
    else
        set -gx NERD_FONT_AVAILABLE 0
        echo "0" > $__nerd_fonts_cache_file
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

# Function to manually check for nerd fonts (using slow but accurate method)
function check-nerd-fonts --description "Manually check for Nerd Fonts installation"
    echo "Checking for Nerd Fonts..."
    switch (uname)
        case Darwin
            # Use the slow but accurate system_profiler
            if system_profiler SPFontsDataType 2>/dev/null | grep -q "Nerd Font"
                echo "Nerd Fonts detected!"
                echo "1" > $__nerd_fonts_cache_file
                set -gx NERD_FONT_AVAILABLE 1
                set -gx NERD_FONT 1
                set -gx NERD_FONT_AVAILABLE true
            else
                echo "No Nerd Fonts found."
                echo "0" > $__nerd_fonts_cache_file
                set -gx NERD_FONT_AVAILABLE 0
                set -gx NERD_FONT 0
                set -gx NERD_FONT_AVAILABLE false
            end
        case Linux
            if fc-list 2>/dev/null | grep -q "Nerd Font"
                echo "Nerd Fonts detected!"
                echo "1" > $__nerd_fonts_cache_file
                set -gx NERD_FONT_AVAILABLE 1
                set -gx NERD_FONT 1
                set -gx NERD_FONT_AVAILABLE true
            else
                echo "No Nerd Fonts found."
                echo "0" > $__nerd_fonts_cache_file
                set -gx NERD_FONT_AVAILABLE 0
                set -gx NERD_FONT 0
                set -gx NERD_FONT_AVAILABLE false
            end
    end
end