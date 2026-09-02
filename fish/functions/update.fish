function update --wraps='paru -Syu' --description 'alias update=paru -Syu'
    paru -Syu --noconfirm $argv
end
