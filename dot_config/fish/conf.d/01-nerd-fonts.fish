# Nerd Fonts detection and icon helper
# OPTIMIZED VERSION - skips slow system_profiler check

# Fast check - assume nerd fonts are available on macOS with our setup
if test (uname) = "Darwin"
    set -gx NERD_FONT_AVAILABLE 1
else
    # On Linux, do a quick check for our known font
    if fc-list 2>/dev/null | grep -q "FiraCode.*Nerd" 2>/dev/null
        set -gx NERD_FONT_AVAILABLE 1
    else
        set -gx NERD_FONT_AVAILABLE 0
    end
end

# Icon helper function
function nf_icon -d "Display a Nerd Font icon with fallback"
    if test "$NERD_FONT_AVAILABLE" = "1"
        echo -n $argv[1]
    else if test (count $argv) -ge 2
        echo -n $argv[2]
    else
        echo -n ""
    end
end

# Export for child processes
set -x NERD_FONT_AVAILABLE