function spiderfoot
    # Activate venv
    source /opt/venv/sf-311/bin/activate.fish
    
    # Move to correct project directory
    cd /opt/kamalesh-tools/spiderfoot-4.0
    
    # Start SpiderFoot in foreground (no &)
    python3 sf.py -l 127.0.0.1:5001
    
    # Cleanup
    cd -
    deactivate
end
