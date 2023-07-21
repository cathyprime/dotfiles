collect_service=$(
	cat <<EOCS
[Unit]
Description=Run nix-collect-garbage for user

[Service]
ExecStart=/bin/bash $HOME/.config/systemd-scripts/garbage.sh
EOCS
)

collect_timer=$(
	cat <<EOCT
[Unit]
Description=Run nix-collect-garbage for user

[Timer]
OnCalendar=weekly
OnCalendar=Sun *-*-* 15:00:00
Persistent=true
Unit=collect-garbage.service

[Install]
WantedBy=default.target
EOCT
)

link_service=$(
	cat <<EOLS
[Unit]
Description=Update home-manager files

[Service]
ExecStart=/bin/bash $HOME/.config/systemd-scripts/update.sh
EOLS
)

link_path=$(
	cat <<EOLP
[Unit]
Description=Update home-manager files

[Path]
Unit=homemngr-update.service
PathChanged=$(pwd)/home-manager

[Install]
WantedBy=default.target
EOLP
)

echo -e "$collect_service" >$HOME/.config/systemd/user/collect-garbage.service
echo -e "$collect_timer" >$HOME/.config/systemd/user/collect-garbage.timer
echo -e "$link_service" >$HOME/.config/systemd/user/homemngr-update.service
echo -e "$link_path" >$HOME/.config/systemd/user/homemngr-update.path
