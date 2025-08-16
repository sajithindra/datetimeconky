#!/bin/bash

# Exit on error
set -e

echo "[+] Installing Conky..."
sudo apt update
sudo apt install -y conky-all

# Create config directory
mkdir -p ~/.config/conky

echo "[+] creating conky.conf file..."
# Create Conky config file
cat > ~/.config/conky/conky.conf << 'EOF'
conky.config = {
    background = true,
    update_interval = 1,
    cpu_avg_samples = 2,
    net_avg_samples = 2,
    temperature_unit = 'celsius',

    double_buffer = true,
    no_buffers = true,
    text_buffer_size = 2048,

    alignment = 'middle_middle',
    gap_x = 0,
    gap_y = 0,
    minimum_width = 900,
    minimum_height = 550,
    maximum_width = 900,

    own_window = true,
    own_window_type = 'normal',
    own_window_transparent = true,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    own_window_argb_visual = true,
    own_window_argb_value = 0,

    border_inner_margin = 0,
    border_outer_margin = 0,

    draw_shades = false,
    draw_outline = false,
    draw_borders = false,
    draw_graph_borders = false,

    override_utf8_locale = true,
    use_xft = true,
    font = 'Feena Casual:size=10',
    xftalpha = 1.0,
    uppercase = true,

    default_color = '#D6D5D4',
    own_window_colour = '#000000',
    use_spacer = 'none',
};

conky.text = [[
${alignc}${font Anurati:size=75}${color D6D5D4}${exec bash -c "date +%A | sed 's/./& /g'"}
${voffset 5}${alignc}${font Saira:size=35}${time %I:%M:%S %p}
${voffset 5}${alignc}${font Saira:size=16}${time %d %B %Y}
${voffset 10}${alignc}${font Saira:size=14}${exec hostname}
${alignc}${font Saira:size=12}${exec lsb_release -ds}
]];
EOF

echo "[+] Creating autostart entry..."
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/conky.desktop << 'EOF'
[Desktop Entry]
Type=Application
Exec=conky -c ~/.config/conky/conky.conf
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Conky
Comment=Start Conky on login
EOF

echo "[+] Setup complete. Starting Conky now..."
conky -c ~/.config/conky/conky.conf &

echo "[✓] Conky installed and configured successfully!"
