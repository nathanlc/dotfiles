Copy the example configuration into your home directory and make the scripts executable:
```sh
  mkdir -p ~/.config/sketchybar/plugins
  cp /opt/homebrew/opt/sketchybar/share/sketchybar/examples/sketchybarrc ~/.config/sketchybar/sketchybarrc
  cp -r /opt/homebrew/opt/sketchybar/share/sketchybar/examples/plugins/ ~/.config/sketchybar/plugins/
  chmod +x ~/.config/sketchybar/plugins/*
```

To start felixkratz/formulae/sketchybar now and restart at login:
```sh
  brew services start felixkratz/formulae/sketchybar
```
Or, if you don't want/need a background service you can just run:
```sh
  LANG="en_US.UTF-8" /opt/homebrew/opt/sketchybar/bin/sketchybar
```
