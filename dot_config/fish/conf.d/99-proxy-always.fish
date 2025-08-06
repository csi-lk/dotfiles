# Always load proxy configuration
# This file sources the disabled proxy file to ensure connectivity

if test -f ~/.config/fish/conf.d/99-local-proxy.fish.disabled
    source ~/.config/fish/conf.d/99-local-proxy.fish.disabled
end