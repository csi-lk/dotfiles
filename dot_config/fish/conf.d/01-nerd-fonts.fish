# Nerd Fonts detection and configuration

# Cache file location for font detection result
set -l cache_file "$HOME/.cache/fish/nerd-fonts-detected"
set -l cache_dir (dirname $cache_file)

# Create cache directory if it doesn't exist
if not test -d $cache_dir
    mkdir -p $cache_dir
end

# Function to check if Nerd Fonts are available (without cache)
function __check_nerd_fonts_uncached
    switch (uname)
        case Darwin
            # macOS: Check using system_profiler (slow but accurate)
            system_profiler SPFontsDataType 2>/dev/null | grep -q "Nerd Font"
        case Linux
            # Linux: Check using fc-list
            fc-list 2>/dev/null | grep -q "Nerd Font"
        case '*'
            # Unknown system, assume no Nerd Fonts
            return 1
    end
end

# Function to check if Nerd Fonts are available (with caching)
function __has_nerd_fonts
    # Check if cache exists and is less than 7 days old
    if test -f $cache_file
        set -l cache_age (math (date +%s) - (stat -f %m $cache_file 2>/dev/null || stat -c %Y $cache_file 2>/dev/null || echo 0))
        if test $cache_age -lt 604800  # 7 days in seconds
            # Use cached result
            if test (cat $cache_file) = "1"
                return 0
            else
                return 1
            end
        end
    end
    
    # Cache miss or expired, check and update cache
    if __check_nerd_fonts_uncached
        echo "1" > $cache_file
        return 0
    else
        echo "0" > $cache_file
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

# Function to refresh the Nerd Fonts cache
function refresh-nerd-fonts-cache --description "Force refresh the Nerd Fonts detection cache"
    set -l cache_file "$HOME/.cache/fish/nerd-fonts-detected"
    rm -f $cache_file
    echo "Refreshing Nerd Fonts cache..."
    if __has_nerd_fonts
        echo "Nerd Fonts detected and cached."
    else
        echo "No Nerd Fonts detected."
    end
end