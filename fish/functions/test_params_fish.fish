function test_params_fish
    argparse 'f=param_file' -- $argv
    or set param_file anytask_params_final.txt
    
    if test (count $argv) -gt 0
        set param_file $argv[1]
    else
        set param_file anytask_params_final.txt
    end
    
    if not test -f $param_file
        echo "❌ $param_file not found. Creating quick test list..."
        echo -e "id\nuser_id\ntask_id\nstatus\nrole\nadmin\namount" > $param_file
    end
    
    echo "🚀 HPP Test: https://anytask.com (params from $param_file)"
    echo "───────────────────────────────────────────────"
    
    cat $param_file | while read -l line
        set param (string trim $line)
        # Skip empty & comments
        if test -z "$param" -o (string match -q "*#*" $param)
            continue
        end
        
        set result (curl -s -w "HTTP:%{http_code}|SIZE:%{size_download}|URL:$param\n" \
                            --max-time 8 --compressed "https://anytask.com/?$param=123&$param=admin")
        
        echo $result
    end
end
