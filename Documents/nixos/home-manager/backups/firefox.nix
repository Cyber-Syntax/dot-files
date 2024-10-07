{ ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
    ];

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "apz.overscroll.enabled" = true;
          "cookiebanners.service.mode" = 1;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "image.jxl.enabled" = true;
          "privacy.donottrackheader.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.query_stripping.enabled.pbmode" = true;
          "privacy.webrtc.globalMuteToggles" = true;
        };
        search = {
          force = true;
          default = "Brave";
          order = [
            "Brave"
            "DuckDuckGo"
            "Google"
          ];
        };
      };
    };
      /* ---- POLICIES ---- */
      # Check about:policies#documentation for options.
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        #SocialTracking = true;
      };
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableAccounts = true;
      DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = false;
      };
        /* ---- EXTENSIONS ---- */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
      ExtensionSettings = {
        "keepassxc-browser@keepassxc.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          updates_disabled = false;
          default_area = "navbar";
        };
        # Privacy Badger:
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          updates_disabled = false;
          default_area = "menubar";
        };
# Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "normal_installed";
        };
# libredirect
        "7esoorv3@alefvanoon.anonaddy.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/libredirect/latest.xpi";
          installation_mode = "normal_installed";
        };
      # Linguist
      "{e5b6e4ac-ec96-44f5-b257-e4d3c8291b41}" = {
        installation_mode = "normal_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/linguist/latest.xpi";
        #updates_disabled = false;
        default_area = "navbar";
      };
# noscript
      "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/noscript/latest.xpi";
        installation_mode = "normal_installed";
      };
# firefox containers  
      "@testpilot-containers" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/testpilot-containers/latest.xpi";
        installation_mode = "normal_installed";
      };
 
      };
      # ./extensions #
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Locked = false;
      };
      FirefoxSuggest = {
        WebSuggestions = true;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = false;
      };
      HardwareAcceleration = true;
      Homepage = {
        URL = "about:addons";
        Locked = false;
        StartPage = "homepage";
      };
      NoDefaultBookmarks = true;
      PasswordManagerEnabled = false;


              /* ---- PREFERENCES ---- */
        # Check about:config for options.
      Preferences = {
        "extensions.pocket.enabled" = false;
        "extensions.screenshot.disabled" = true;
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "default";
        };
        "browser.ml.chat.enabled" = {
          Value = true;
          Status = "default";
        };
        "browser.tabs.cardPreview.enabled" = {
          Value = true;
          Status = "default";
        };
        "browser.theme.content-theme" = {
          Value = 2;
          Status = "default";
        };
        "browser.theme.toolbar-theme" = {
          Value = 2;
          Status = "default";
        };
        "widget.use-xdg-desktop-portal.file-picker" = {
          Value = 1;
          Status = "default";
        };
        "widget.use-xdg-desktop-portal.location" = {
          Value = 1;
          Status = "default";
        };
        "widget.use-xdg-desktop-portal.mime-handler" = {
          Value = 1;
          Status = "default";
        };
        "widget.use-xdg-desktop-portal.open-uri" = {
          Value = 1;
          Status = "default";
        };
        "widget.use-xdg-desktop-portal.settings" = {
          Value = 1;
          Status = "default";
        };
        # "widget.wayland.fractional-scale.enabled" = {
        #   Value = 1;
        #   Status = "default";
        # };
      };
    };
  };
}
