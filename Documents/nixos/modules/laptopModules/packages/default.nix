{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cbatticon # battery icon
    acpilight
    #TESTING:
    #FIX: kernel: warning: `ThreadPoolForeg' uses wireless extensions which will stop working for Wi-Fi 7 use nl80211
    iw # wifi 7
  ];
}
