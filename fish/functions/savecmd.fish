function __savecmd_detect_vault_root
    if set -q SAVECMD_VAULT_ROOT; and test -d "$SAVECMD_VAULT_ROOT"
        echo "$SAVECMD_VAULT_ROOT"
        return 0
    end

    if set -q SAVECMD_VAULT; and test -d "$SAVECMD_VAULT"
        if string match -qr '/Commands/?$' -- "$SAVECMD_VAULT"
            echo (string replace -r '/Commands/?$' '' -- "$SAVECMD_VAULT")
            return 0
        end
        if test -d "$SAVECMD_VAULT/Commands"
            echo "$SAVECMD_VAULT"
            return 0
        end
    end

    for candidate in "$HOME/obsidianvault" "$HOME/ObsidianVault"
        if test -d "$candidate"
            echo "$candidate"
            return 0
        end
    end

    echo "$HOME/obsidianvault"
end

function __savecmd_detect_commands_dir -a vault_root
    if set -q SAVECMD_COMMANDS_DIR; and test -d "$SAVECMD_COMMANDS_DIR"
        echo "$SAVECMD_COMMANDS_DIR"
        return 0
    end

    if set -q SAVECMD_VAULT; and test -d "$SAVECMD_VAULT"; and string match -qr '/Commands/?$' -- "$SAVECMD_VAULT"
        echo "$SAVECMD_VAULT"
        return 0
    end

    if test -d "$vault_root/Commands"
        echo "$vault_root/Commands"
        return 0
    end

    set found (find "$vault_root" -mindepth 1 -maxdepth 2 -type d \( -iname 'commands' -o -iname '*commands*' \) 2>/dev/null | head -n 1)
    if test -n "$found"
        echo "$found"
        return 0
    end

    echo "$vault_root/Commands"
end

function __savecmd_titlecase -a raw
    set first (string upper (string sub -s 1 -l 1 -- "$raw"))
    set rest (string sub -s 2 -- "$raw")
    echo "$first$rest"
end

function __savecmd_map_note -a cmd_name
    switch $cmd_name
        case ls cd pwd mkdir rm cp mv chmod chown touch
            echo "Linux Basics"
        case nano vim nvim code
            echo "Editor Commands"
        case ping curl wget ifconfig ip nmap nmcli iw
            echo "Networking Commands"
        case '*'
            set pretty (__savecmd_titlecase "$cmd_name")
            echo "$pretty Commands"
    end
end

function __savecmd_category_heuristic -a cmd_name
    switch $cmd_name
        case subfinder amass assetfinder waybackurls katana httpx ffuf
            echo "Bug Bounty & Reconnaissance"
        case adb apktool apksigner jarsigner keytool zipalign
            echo "Android & Mobile Security"
        case msfvenom
            echo "Exploitation"
        case ping curl wget ifconfig ip nmap nmcli iw
            echo "Networking"
        case git docker aws kubectl helm terraform
            echo "Cloud & DevOps"
        case systemctl journalctl paru pipx stat find grep rg cat du ln
            echo "System & Linux"
        case busctl starship
            echo "System Services"
        case kde update-desktop-database
            echo "Desktop Environment"
        case '*'
            echo "Utilities"
    end
end

function __savecmd_category_from_index -a commands_dir note
    set index_path "$commands_dir/Commands Index.md"
    if not test -f "$index_path"
        return 1
    end

    set category (awk -v note="$note" '
        BEGIN { category = "" }
        /^## / { category = substr($0, 4); next }
        {
            if (index($0, "[[" note "]]") || index($0, "[[Commands/" note "]]")) {
                print category
                exit
            }
        }
    ' "$index_path")

    if test -n "$category"
        echo "$category"
        return 0
    end

    return 1
end

function __savecmd_related_links -a vault_root category
    set links "[[Commands/Commands Index]]"

    switch "$category"
        case "System & Linux"
            if test -f "$vault_root/Resources/linux.md"
                set links "$links | [[Resources/linux]]"
            end
        case "Networking" "Bug Bounty & Reconnaissance"
            if test -f "$vault_root/Resources/bugbounty tools.md"
                set links "$links | [[Resources/bugbounty tools]]"
            end
            if test -f "$vault_root/Resources/linux.md"
                set links "$links | [[Resources/linux]]"
            end
        case "Cloud & DevOps"
            if test -f "$vault_root/Ops/Active/ACTIVE.md"
                set links "$links | [[Ops/Active/ACTIVE]]"
            end
    end

    echo "$links"
end

function __savecmd_sanitize_description -a text
    set sanitized (string replace -ra '\s+' ' ' -- "$text")
    set sanitized (string replace -ra '[`|]' '' -- "$sanitized")
    set sanitized (string trim -- "$sanitized")

    if test -z "$sanitized"
        set sanitized "Command usage"
    end

    if test (string length -- "$sanitized") -gt 140
        set sanitized (string sub -l 140 -- "$sanitized")
    end

    echo "$sanitized"
end

function __savecmd_update_frontmatter_tags -a note_path tags_csv
    if test -z "$tags_csv"
        return 0
    end

    if not grep -q '^tags: \[' "$note_path"
        return 0
    end

    set tmp_tags (mktemp)
    awk -v add_tags="$tags_csv" '
        BEGIN {
            in_frontmatter = 0
            replaced = 0
            n = split(add_tags, incoming, /,[[:space:]]*/)
            keep_count = 0
            for (i = 1; i <= n; i++) {
                t = incoming[i]
                gsub(/^[[:space:]]+|[[:space:]]+$/, "", t)
                if (t != "" && !(t in incoming_seen)) {
                    incoming_seen[t] = 1
                    incoming_order[++keep_count] = t
                }
            }
        }
        NR == 1 && $0 == "---" { in_frontmatter = 1; print; next }
        in_frontmatter && !replaced && $0 ~ /^tags:[[:space:]]*\[/ {
            line = $0
            sub(/^tags:[[:space:]]*\[/, "", line)
            sub(/\][[:space:]]*$/, "", line)
            m = split(line, current, /,[[:space:]]*/)
            out_count = 0
            for (i = 1; i <= m; i++) {
                t = current[i]
                gsub(/^[[:space:]]+|[[:space:]]+$/, "", t)
                if (t != "" && !(t in seen)) {
                    seen[t] = 1
                    out[++out_count] = t
                }
            }
            for (i = 1; i <= keep_count; i++) {
                t = incoming_order[i]
                if (!(t in seen)) {
                    seen[t] = 1
                    out[++out_count] = t
                }
            }
            tags_line = "tags: ["
            for (i = 1; i <= out_count; i++) {
                tags_line = tags_line out[i]
                if (i < out_count) {
                    tags_line = tags_line ", "
                }
            }
            tags_line = tags_line "]"
            print tags_line
            replaced = 1
            next
        }
        { print }
    ' "$note_path" > "$tmp_tags"
    mv "$tmp_tags" "$note_path"
end

function __savecmd_update_commands_index -a commands_dir note category description
    set index_path "$commands_dir/Commands Index.md"
    set safe_desc (__savecmd_sanitize_description "$description")
    set entry "- [[$note]] - $safe_desc"

    if not test -f "$index_path"
        printf '---\ntags: [commands, index, reference]\n---\n\n# Commands Index\n\nA comprehensive index of all command reference files in this vault.\n\n## %s\n%s\n\n---\n\nRelated: [[Resources]] | [[target]] | [[Ops/Active/ACTIVE]]\n' \
            "$category" "$entry" > "$index_path"
        return 0
    end

    if grep -Fq -- "[[$note]]" "$index_path"; or grep -Fq -- "[[Commands/$note]]" "$index_path"
        return 0
    end

    set tmp_file (mktemp)
    awk -v category="$category" -v entry="$entry" '
        BEGIN {
            in_cat = 0
            inserted = 0
            cat_header = "## " category
        }
        {
            if ($0 == cat_header) {
                print
                in_cat = 1
                next
            }

            if (in_cat && $0 ~ /^## /) {
                if (!inserted) {
                    print entry
                    inserted = 1
                }
                in_cat = 0
            }

            print
        }
        END {
            if (in_cat && !inserted) {
                print entry
                inserted = 1
            }
            if (!inserted) {
                print ""
                print cat_header
                print entry
            }
        }
    ' "$index_path" > "$tmp_file"
    mv "$tmp_file" "$index_path"
end

function __savecmd_command_exists -a note_path cmd
    awk -v cmd="$cmd" '
        BEGIN { found = 0 }
        $0 == "```bash" {
            if (getline line) {
                if (line == cmd) {
                    if (getline close_line) {
                        if (close_line == "```") {
                            found = 1
                            exit
                        }
                    }
                }
            }
        }
        END { exit(found ? 0 : 1) }
    ' "$note_path"
end

function __savecmd_analyze_structure -a vault_root commands_dir
    echo "Vault root: $vault_root"
    echo "Commands dir: $commands_dir"
    echo ""
    echo "Top-level folders:"
    find "$vault_root" -mindepth 1 -maxdepth 1 -type d | xargs -r -I{} basename "{}" | sort
    echo ""
    echo "Top-level markdown files:"
    find "$vault_root" -mindepth 1 -maxdepth 1 -type f -name '*.md' | xargs -r -I{} basename "{}" | sort
    echo ""
    if test -f "$commands_dir/Commands Index.md"
        echo "Detected category headings in Commands Index:"
        rg '^## ' "$commands_dir/Commands Index.md" -N
    else
        echo "Commands Index.md not found yet."
    end
end

function savecmd
    argparse 'c=' 'a/analyze' -- $argv
    or return 1

    set vault_root (__savecmd_detect_vault_root)
    set commands_dir (__savecmd_detect_commands_dir "$vault_root")
    mkdir -p "$commands_dir"

    if set -q _flag_analyze
        __savecmd_analyze_structure "$vault_root" "$commands_dir"
        return 0
    end

    if set -q _flag_c
        set cmd $_flag_c
    else
        set cmd (history | head -n 1)
    end

    set cmd (string trim -- "$cmd")
    if test -z "$cmd"
        echo "No command found to save."
        return 1
    end

    if string match -qr '^sudo\s+' -- "$cmd"
        set cmd (string replace -r '^sudo\s+' '' -- "$cmd")
    end

    set raw_cmd_name (string split ' ' -- "$cmd")[1]
    set cmd_name (string lower -- (path basename -- "$raw_cmd_name"))
    if test -z "$cmd_name"
        set cmd_name "command"
    end

    set note (__savecmd_map_note "$cmd_name")
    set category (__savecmd_category_from_index "$commands_dir" "$note")
    if test -z "$category"
        set category (__savecmd_category_heuristic "$cmd_name")
    end

    set note_path "$commands_dir/$note.md"
    set related_links (__savecmd_related_links "$vault_root" "$category")

    if not test -f "$note_path"
        printf '---\ntags: [commands]\n---\n\n# %s\n\nRelated: %s\n\n---\nCreated: %s\n---\n\n' \
            "$note" "$related_links" (date "+%Y-%m-%d %H:%M:%S") > "$note_path"
    end

    set description "Command usage"
    set usage ""
    set example ""
    set tags ""
    set ai_json ""
    set ai_script "$HOME/.local/bin/cmd_perplexity.py"
    set py_bin ""

    if test -x /opt/venv/zapzap/bin/python3
        set py_bin /opt/venv/zapzap/bin/python3
    else if type -q python3
        set py_bin (command -s python3)
    end

    if test -n "$py_bin"; and test -f "$ai_script"; and type -q jq
        set ai_json ($py_bin "$ai_script" "$cmd" 2>/dev/null)
        if test -n "$ai_json"
            set parsed_description (printf "%s" "$ai_json" | jq -r '.description // empty' 2>/dev/null)
            set parsed_usage (printf "%s" "$ai_json" | jq -r '.usage // empty' 2>/dev/null)
            set parsed_example (printf "%s" "$ai_json" | jq -r '.example // empty' 2>/dev/null)
            set parsed_tags (printf "%s" "$ai_json" | jq -r '.tags // [] | join(", ")' 2>/dev/null)

            if test -n "$parsed_description"
                set description "$parsed_description"
            end
            if test -n "$parsed_usage"
                set usage "$parsed_usage"
            end
            if test -n "$parsed_example"
                set example "$parsed_example"
            end
            if test -n "$parsed_tags"
                set tags "$parsed_tags"
            end
        end
    end

    set description (__savecmd_sanitize_description "$description")
    __savecmd_update_frontmatter_tags "$note_path" "$tags"

    if __savecmd_command_exists "$note_path" "$cmd"
        __savecmd_update_commands_index "$commands_dir" "$note" "$category" "$description"
        echo "Command already exists in note: $note_path"
        return 0
    end

    printf "### %s\n\n" "$description" >> "$note_path"
    if test -n "$usage"
        printf "- Usage: `%s`\n" "$usage" >> "$note_path"
    end
    if test -n "$example"
        printf "- Example: `%s`\n" "$example" >> "$note_path"
    end
    if test -n "$usage"; or test -n "$example"
        printf "\n" >> "$note_path"
    end
    printf "```bash\n%s\n```\n\n" "$cmd" >> "$note_path"

    __savecmd_update_commands_index "$commands_dir" "$note" "$category" "$description"
    echo "Saved to Obsidian: $note_path"
end
