function servethis
    set port ( test -n "$argv[1]" ; and echo "$argv[1]" ;or  echo "8000")
    python3 -m http.server $port
end
