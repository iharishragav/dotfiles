function showmem
    set path (test -n "$argv[1]"; and echo $argv[1]; or echo ".")
    du -h --max-depth=1 $path 2>/dev/null | sort -h
end
