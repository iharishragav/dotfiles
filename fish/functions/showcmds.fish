function showcmds
    set VAULT "$HOME/ObsidianVault/Commands"
    
    # List all Markdown files (notes) in the Commands folder
    echo "Notes in $VAULT:"
    ls $VAULT/*.md
    
    # Ask user which note to display
    echo  "Enter note name to view (without .md):"
    read  note
    
    set NOTE_PATH "$VAULT/$note.md"
    
    if test -f "$NOTE_PATH"
        echo "Showing contents of $NOTE_PATH:"
        cat "$NOTE_PATH"
    else
        echo "Note $note.md does not exist in $VAULT"
    end
end
