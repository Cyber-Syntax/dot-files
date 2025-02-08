{
  services = {
    libinput = {
      enable = true; # for syncaptics touchpads

      touchpad = {
        #tappingButtonMap = "lmr"; # left middle right, this probably not compatible with tapping: "Set the button mapping for 1/2/3-finger taps"
        accelProfile = "adaptive"; # default work for thinkpad for now
        tapping = true;
        #naturalScrolling = true;
        # defualt:true,, pressing the left and right buttons simultaneously produces a middle mouse button click.
        middleEmulation = false;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
        sendEventsMode = "disabled-on-external-mouse";
        tappingDragLock = true; # default, tap and drag like shift behavior on keyboards but this will make it with two tap
        #clickMethod = "buttonareas"; #default: "buttonareas" other: "clickfinger"
      };
    };

  };
}
