function freemem
    echo -e "\nBefore:"
    free -h
    echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
    echo -e "\nAfter:"
    free -h
end
