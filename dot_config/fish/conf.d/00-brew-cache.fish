# Cache brew shellenv to speed up startup
# This runs before other configs that might need brew

if test (uname) = "Darwin"
    set -l brew_cache_file "$HOME/.cache/fish/brew_shellenv.fish"
    set -l brew_cache_dir (dirname $brew_cache_file)
    
    # Create cache directory if it doesn't exist
    test -d $brew_cache_dir || mkdir -p $brew_cache_dir
    
    # Check if cache is older than 24 hours or doesn't exist
    if test ! -f $brew_cache_file -o (find $brew_cache_file -mtime +1 2>/dev/null | count) -gt 0
        # Regenerate cache
        if test -d /opt/homebrew
            /opt/homebrew/bin/brew shellenv fish > $brew_cache_file
        else if test -d /usr/local/Homebrew
            /usr/local/bin/brew shellenv fish > $brew_cache_file
        end
    end
    
    # Source the cached file
    test -f $brew_cache_file && source $brew_cache_file
end