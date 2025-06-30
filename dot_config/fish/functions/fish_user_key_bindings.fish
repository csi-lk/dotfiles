function fish_user_key_bindings
    # Enable vi mode if desired (comment out for default emacs mode)
    # fish_vi_key_bindings
    
    # fzf key bindings (if fzf.fish is installed)
    if type -q fzf_configure_bindings
        fzf_configure_bindings --directory=\ct --git_log=\cg --git_status=\cs --history=\cr --variables=\cv
    end
    
    # Custom key bindings
    bind \ce edit_command_buffer  # Ctrl+E to edit command in editor
    
    # macOS-specific window management bindings
    if test (uname) = "Darwin"
        # Ctrl+W for window focus finder
        bind \cw 'ff 2>/dev/null; commandline -f repaint'
        # Alt+W for workspace focus
        bind \ew 'fw 2>/dev/null; commandline -f repaint'
    end
end