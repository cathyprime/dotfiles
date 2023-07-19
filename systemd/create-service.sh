service=$(
	cat <<EOS
[Unit]
Description=Run nix-collect-garbage for user

[Service]
ExecStart=/bin/bash $HOME/.config/systemd-scripts/garbage.sh
EOS
)

timer=$(
	cat <<EOT
[Unit]
Description=Run nix-collect-garbage for user

[Timer]
OnCalendar=weekly
OnCalendar=Sun *-*-* 15:00:00
Persistent=true
Unit=collect-garbage.service

[Install]
WantedBy=default.target
EOT
)

echo -e "$service" >$HOME/.config/systemd/user/collect-garbage.service
echo -e "$timer" >$HOME/.config/systemd/user/collect-garbage.timer
