{...}: {
  services = {
    syncthing = {
      enable = true;
      user = "developer";
      #group = "developer";
      #dataDir = "/home/developer/.local/share/syncthing";
      configDir = "/home/developer/.config/syncthing";
    };

    borgbackup.jobs."home-backup" = {
      paths = "/home/developer/";
      exclude = [
        ".cache"
        "*/cache2" # firefox
        "*/Cache"
        ".config/Slack/logs"
        ".config/Code/CachedData"
        ".container-diff"
        ".npm/_cacache"
        "*/node_modules"
        "*/bower_components"
        "*/_build"
        "*/.tox"
        "*/venv"
        "*/.venv"
        "~/Downloads"
      ];
      encryption.mode = "none";
      repo = "/mnt/backups/borgbackup/home-nixos";
      compression = "zstd,15";
      prune.keep = {
        # prune and keep only 13 backups
        daily = 7;
        weekly = 4;
        monthly = 2;
      };
      persistentTimer = true; # similar anacron, if missed the last start time, start backup
      startAt = ["*-*-* 10:00 Europe/Istanbul"];
    };
  };
}
