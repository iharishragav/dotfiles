function freeswap
  echo "Restarting swap..."
  sudo swapoff -a; and sudo swapon -a
end
