# Warp terminal alias with proxy support
# This ensures Warp can connect through corporate proxy for sign-in and updates

alias warp='ALL_PROXY="http://localhost:3128" open -a Warp'

# Additional Warp-related aliases
alias warp-no-proxy='open -a Warp'  # Open without proxy if needed