{
  inputs,
  pkgs,
  ...
}:
#TODO: Setup extensions with nur??
#TESTING: using inputs instead of nur first?
#NOTE: inputs already using nur?
#TODO: change firefox unstable package if not use unstable version
{
  home-manager.users.developer.programs.firefox = {
    enable = true;
    #NOTE: not available on 24.05??
    languagePacks = [
      "en-US"
    ];

    # nativeMessagingHosts = [
    #     #TODO: is setup needed for keepassxc-browser ??
    # ];

    profiles = {
      # programs.firefox.profiles.<name>.extensions
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          #"browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          #"browser.startup.homepage" = "https://search.brave.com/";
          # "browser.newtabpage.pinned" = [{ # maybe need to make blank
          #   title = "NixOS";
          #   url = "https://nixos.org";
          # }];
          "apz.overscroll.enabled" = true;
          "cookiebanners.service.mode" = 1;
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          "image.jxl.enabled" = true;
          "privacy.donottrackheader.enabled" = true;
          "privacy.fingerprintingProtection" = true;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.query_stripping.enabled.pbmode" = true;
          "privacy.webrtc.globalMuteToggles" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          # Disable because 2000 series turing not able to decode AV1
          "media.av1.enabled" = false;
          "gfx.x11-egl.force-enabled" = true;
          "widget.dmabuf.force-enabled" = true;
        };
        search = {
          force = true;
          default = "brave";
          order = [
            "brave"
            "Google"
          ];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };

        #TEST: nur extensions

        # ##inputs extension implement
        # # @firefox-addons = added nur-expressions inside flake.nix
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          # if cause issue try this
          #extensions = with pkgs.inputs.firefox-addons; [
          ublock-origin
          noscript
          keepassxc-browser
          libredirect
          privacy-badger
          darkreader
          multi-account-containers
          # vimium
          #cookie-autodelete # choose multi-account-containers or this
          #Linguist # not in nur-expressions
          #Bionify # not in nur-expressions
        ];

        ## nur version extension implement
        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        #     ublock-origin
        #     noscript
        #     libredirect
        #
        #
        # ];#./extensions

        containers = {
          dangerous = {
            color = "red"; # one of “blue”, “turquoise”, “green”, “yellow”, “orange”, “red”, “pink”, “purple”, “toolbar”
            icon = "circle"; # one of “briefcase”, “cart”, “circle”, “dollar”, “fence”, “fingerprint”, “gift”, “vacation”, “food”, “fruit”, “pet”, “tree”, “chill”
            id = 1;
          };
          personal = {
            color = "yellow";
            icon = "fingerprint";
            id = 2;
          };
          coding = {
            color = "green";
            icon = "tree";
            id = 3;
          };
          learn = {
            color = "blue";
            icon = "fence";
            id = 4;
          };
        };
      }; # default
    }; # ./profiles

    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        SanitizeOnShutdown = true; # delete all data after shutdown
        DefaultDownloadDirectory = "\${home}/Downloads";
        #PromptForDownloadLocation = true; # if you want to select custom download location.
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
        # Security
        HttpsOnlyMode = "enabled";
        DNSOverHTTPS = {
          Enabled = false;
        };
        # Productivity, non-used things
        UserMessaging = {
          ExtensionRecommendations = false;
          #FeatureRecommendations = false;
          #UrlbarInterventions = true;
          #SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = false;
          #Locked = true; #TODO: Learn
        };

        # ---- EXTENSIONS ----
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          # Linguist
          "{e5b6e4ac-ec96-44f5-b257-e4d3c8291b41}" = {
            installation_mode = "normal_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/linguist-translator/latest.xpi";
            updates_disabled = false;
            default_area = "navbar";
          };
          #   #NOTE: nur-expressions already has these
          #   "keepassxc-browser@keepassxc.org" = {
          #     installation_mode = "normal_installed";
          #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          #     updates_disabled = false;
          #     default_area = "navbar";
          #   };
          #   "jid1-MnnxcxisBPnSXQ@jetpack" = {
          #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          #     installation_mode = "force_installed";
          #   };
          #   "uBlock0@raymondhill.net" = {
          #     installation_mode = "normal_installed";
          #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          #     updates_disabled = false;
          #     default_area = "menubar";
          #   };
          #   "addon@darkreader.org" = {
          #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          #     installation_mode = "normal_installed";
          #   };
          #   "7esoorv3@alefvanoon.anonaddy.me" = {
          #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/libredirect/latest.xpi";
          #     installation_mode = "normal_installed";
          #   };
          # "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
          #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/noscript/latest.xpi";
          #   installation_mode = "normal_installed";
          # };
          #       # firefox containers
          # "@testpilot-containers" = {
          #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/testpilot-containers/latest.xpi";
          #   installation_mode = "normal_installed";
          # };
        }; # ./extensions #

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
          URL = "about:preferences#containers";
          Locked = false;
          StartPage = "homepage";
          # Additional = [
          # "about:newtab"
          # ];
        };
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;

        # ---- PREFERENCES ----
        # Check about:config for options.
        Preferences = {
          "browser.translations.automaticallyPopup" = false; # disable popup beta translation on firefox
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

          ##NOTE: Firefox already use xdg-desktop-portal out of the box.
          # "widget.use-xdg-desktop-portal.file-picker" = {
          #   Value = 1;
          #   Status = "default";
          # };
          # "widget.use-xdg-desktop-portal.location" = {
          #   Value = 1;
          #   Status = "default";
          # };
          # "widget.use-xdg-desktop-portal.mime-handler" = {
          #   Value = 1;
          #   Status = "default";
          # };
          # "widget.use-xdg-desktop-portal.open-uri" = {
          #   Value = 1;
          #   Status = "default";
          # };
          # "widget.use-xdg-desktop-portal.settings" = {
          #   Value = 1;
          #   Status = "default";
          # };

          # "widget.wayland.fractional-scale.enabled" = {
          #   Value = 1;
          #   Status = "default";
          # };
        }; # ./Preferences
      }; # ./eextraPolicies
    }; # ./package wrap
  }; # ./firefox home-manager
}
