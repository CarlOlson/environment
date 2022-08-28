if string match -qr WSL2 (cat /proc/version)
    # Windows Subsystem for Linux 2

    # Remove windows paths
    set --local TEMP_PATH ""
    for p in $PATH
        if string match -qrv '^/mnt/c/' $p
            set TEMP_PATH $TEMP_PATH $p
        end
    end

    # Possible directories to add back:
    ## /mnt/c/windows
    ## /mnt/c/windows/System32
    ## /mnt/c/windows/System32/OpenSSH/
    ## /mnt/c/windows/System32/WindowsPowerShell/v1.0/
    set -gx PATH $TEMP_PATH
    
    # Start Docker if installed and not running
    if type -fq docker
        if test -z (pgrep dockerd)
            sudo dockerd > /dev/null 2>&1 &
            disown
        end
    end

    alias wsl=/mnt/c/windows/System32/wsl.exe
    abbr --add shutdown wsl -t "$WSL_DISTRO_NAME"
    alias code '/mnt/c/Users/Carl/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
end
