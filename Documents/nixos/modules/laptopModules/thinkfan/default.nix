{ ... }:
{
  systemd.services.thinkfan.preStart = "
  /run/current-system/sw/bin/modprobe  -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
";

  services = {
    thinkfan = {
      enable = true;
      levels = [
        [
          0
          0
          45
        ]
        [
          1
          43
          48
        ]
        [
          2
          46
          51
        ]
        [
          3
          49
          54
        ]
        [
          4
          51
          60
        ]
        [
          5
          58
          65
        ]
        [
          6
          63
          72
        ]
        [
          7
          70
          82
        ]
        [
          "level full-speed"
          77
          32767
        ]
      ];
    };
  };
}
