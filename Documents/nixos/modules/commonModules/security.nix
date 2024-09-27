{
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    
  #Increase password timeout for sudo
  # Allow access on other tty's
    sudo.extraConfig = ''
      Defaults timestamp_type=global
      Defaults env_reset,timestamp_timeout=10
    '';
  };
}
