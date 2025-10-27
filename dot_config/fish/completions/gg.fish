# Fish completions for gg (git goodies)
# https://github.com/csi-lk/gg

# Disable file completions by default for gg
complete -c gg -f

# Help
complete -c gg -s h -l help -d 'Display help menu'

# Core commands
complete -c gg -n __fish_use_subcommand -a i -d 'Initialize repository'
complete -c gg -n __fish_use_subcommand -a init -d 'Initialize repository'
complete -c gg -n __fish_use_subcommand -a s -d 'Display status'
complete -c gg -n __fish_use_subcommand -a status -d 'Display status'
complete -c gg -n __fish_use_subcommand -a f -d 'Fetch updates'
complete -c gg -n __fish_use_subcommand -a fetch -d 'Fetch updates'
complete -c gg -n __fish_use_subcommand -a a -d 'Stage all changes'
complete -c gg -n __fish_use_subcommand -a add -d 'Stage all changes'

# Commit commands
complete -c gg -n __fish_use_subcommand -a c -d 'Commit with conventional format'
complete -c gg -n __fish_use_subcommand -a commit -d 'Commit with conventional format'
complete -c gg -n __fish_use_subcommand -a ca -d 'Amend last commit'
complete -c gg -n __fish_use_subcommand -a commit_amend -d 'Amend last commit'
complete -c gg -n __fish_use_subcommand -a can -d 'Amend without editing message'
complete -c gg -n __fish_use_subcommand -a commit_amend_no_edit -d 'Amend without editing message'
complete -c gg -n __fish_use_subcommand -a cf -d 'Create fixup commit'
complete -c gg -n __fish_use_subcommand -a fix -d 'Create fixup commit'
complete -c gg -n __fish_use_subcommand -a fixup -d 'Create fixup commit'

# Checkout commands
complete -c gg -n __fish_use_subcommand -a ch -d 'Checkout branch or file'
complete -c gg -n __fish_use_subcommand -a checkout -d 'Checkout branch or file'
complete -c gg -n __fish_use_subcommand -a cm -d 'Switch to default branch (main/master)'
complete -c gg -n __fish_use_subcommand -a checkout_main -d 'Switch to default branch (main/master)'
complete -c gg -n __fish_use_subcommand -a checkout_master -d 'Switch to default branch (main/master)'

# Push/Pull operations
complete -c gg -n __fish_use_subcommand -a pl -d 'Pull changes'
complete -c gg -n __fish_use_subcommand -a pull -d 'Pull changes'
complete -c gg -n __fish_use_subcommand -a cpr -d 'Fetch and rebase on default branch'
complete -c gg -n __fish_use_subcommand -a fetch_rebase_master -d 'Fetch and rebase on default branch'
complete -c gg -n __fish_use_subcommand -a p -d 'Push commits'
complete -c gg -n __fish_use_subcommand -a push -d 'Push commits'
complete -c gg -n __fish_use_subcommand -a pf -d 'Force push'
complete -c gg -n __fish_use_subcommand -a fp -d 'Force push'
complete -c gg -n __fish_use_subcommand -a force -d 'Force push'
complete -c gg -n __fish_use_subcommand -a pushforce -d 'Force push'

# History & logging
complete -c gg -n __fish_use_subcommand -a l -d 'View commit history'
complete -c gg -n __fish_use_subcommand -a log -d 'View commit history'
complete -c gg -n __fish_use_subcommand -a hist -d 'View commit history'
complete -c gg -n __fish_use_subcommand -a history -d 'View commit history'
complete -c gg -n __fish_use_subcommand -a lc -d 'Display latest commit'
complete -c gg -n __fish_use_subcommand -a latest -d 'Display latest commit'
complete -c gg -n __fish_use_subcommand -a latest_commit -d 'Display latest commit'

# Rebasing
complete -c gg -n __fish_use_subcommand -a r -d 'Interactive rebase (specify commit count)'
complete -c gg -n __fish_use_subcommand -a rebase -d 'Interactive rebase (specify commit count)'
complete -c gg -n __fish_use_subcommand -a rc -d 'Continue rebase'
complete -c gg -n __fish_use_subcommand -a continue -d 'Continue rebase'
complete -c gg -n __fish_use_subcommand -a rr -d 'Reset to remote state'
complete -c gg -n __fish_use_subcommand -a reset_remote -d 'Reset to remote state'
complete -c gg -n __fish_use_subcommand -a reset_to_remote -d 'Reset to remote state'

# Branch management
complete -c gg -n __fish_use_subcommand -a b -d 'Create/checkout branch'
complete -c gg -n __fish_use_subcommand -a branch -d 'Create/checkout branch'
complete -c gg -n __fish_use_subcommand -a bd -d 'Delete branch'
complete -c gg -n __fish_use_subcommand -a branch_delete -d 'Delete branch'
complete -c gg -n __fish_use_subcommand -a clean -d 'Remove merged branches'
complete -c gg -n __fish_use_subcommand -a cleanup -d 'Remove merged branches'

# Stashing
complete -c gg -n __fish_use_subcommand -a st -d 'Stash all changes'
complete -c gg -n __fish_use_subcommand -a stash -d 'Stash all changes'
complete -c gg -n __fish_use_subcommand -a stp -d 'Pop stashed changes'
complete -c gg -n __fish_use_subcommand -a stashpop -d 'Pop stashed changes'

# Tagging
complete -c gg -n __fish_use_subcommand -a t -d 'Create/list tags'
complete -c gg -n __fish_use_subcommand -a tag -d 'Create/list tags'
complete -c gg -n __fish_use_subcommand -a td -d 'Delete tag'
complete -c gg -n __fish_use_subcommand -a tagdelete -d 'Delete tag'

# GitHub integration
complete -c gg -n __fish_use_subcommand -a pr -d 'Open pull request'
complete -c gg -n __fish_use_subcommand -a pullrequest -d 'Open pull request'
complete -c gg -n __fish_use_subcommand -a prl -d 'Format PR log for clipboard'
complete -c gg -n __fish_use_subcommand -a pullrequestlog -d 'Format PR log for clipboard'
complete -c gg -n __fish_use_subcommand -a o -d 'Open repository URL'
complete -c gg -n __fish_use_subcommand -a open -d 'Open repository URL'

# Advanced
complete -c gg -n __fish_use_subcommand -a z -d 'Chain multiple commands'
complete -c gg -n __fish_use_subcommand -a combo -d 'Chain multiple commands'

# Branch name completions for checkout and delete
function __fish_gg_branches
    command git branch 2>/dev/null | string replace -r '^\*?\s*' ''
end

# For checkout commands, suggest branches
complete -c gg -n '__fish_seen_subcommand_from ch checkout' -a '(__fish_gg_branches)' -d 'Branch'

# For branch delete, suggest branches
complete -c gg -n '__fish_seen_subcommand_from bd branch_delete' -a '(__fish_gg_branches)' -d 'Branch to delete'

# For tag delete, suggest tags
complete -c gg -n '__fish_seen_subcommand_from td tagdelete' -a '(command git tag 2>/dev/null)' -d 'Tag'
