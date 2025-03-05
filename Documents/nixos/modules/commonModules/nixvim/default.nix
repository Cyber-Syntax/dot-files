{...}:
## Credits:
# Main setup from @fred-drake.
# https://github.com/fred-drake/neovim
#
# @Cyber-Syntax
# Changed to LazyVim like structure
# Changed folder setup more easy structure
{
  imports = [
    ./dashboard.nix
    ./debugging.nix
    ./keys.nix
    ./language.nix
    ./options.nix
    ./extra.nix
    ./plugins.nix
    ./python/language.nix
    ./python/debugging.nix
    ./javascript/debugging.nix
    ./javascript/language.nix
  ];

  programs.nixvim = {
    enable = true;

    diagnostics = {
      virtual_lines = {
        only_current_line = true;
      };
      virtual_text = true;
    };

    clipboard.register = "unnamedplus";
    clipboard.providers = {
      xclip.enable = true;
    };

    #TODO:
    # normal github nvim color plugin is coming to nixvim in the future:
    # https://github.com/nix-community/nixvim/issues/3006

    colorschemes = {
      # gruvbox = {
      #   enable = true;
      #   settings = {
      #     # palette_overrides = {
      #     # bright_green = "#990000",
      #     #   bright_blue = "#5476b2";
      #     #   bright_purple = "#fb4934";
      #     #   dark1 = "#323232";
      #     #   dark2 = "#383330";
      #     #   dark3 = "#323232";
      #     # };
      #     terminal_colors = true;
      #     undercurl = true;
      #     underline = true;
      #     bold = true;
      #     italic = {
      #       strings = true;
      #       emphasis = true;
      #       comments = true;
      #       operators = false;
      #       folds = true;
      #     };
      #     strikethrough = true;
      #     invert_selection = false;
      #     invert_signs = false;
      #     invert_tabline = false;
      #     invert_intend_guides = false;
      #     inverse = true;
      #     # contrast = ""; # hard, soft or empty
      #     palette_overrides = {};
      #     overrides = {};
      #     dim_inactive = false;
      #     transparent_mode = false;
      #   };
      # };

      vscode = {
        enable = true;
        settings = {
          disable_nvimtree_bg = false;
        };
      };

      # base16 = {
      #   enable = true;
      #   colorscheme = "tomorrow-night";
      #   settings = {
      #     dapui = true;
      #     illuminate = true;
      #     lsp_semantic = true;
      #     mini_completion = true;
      #     notify = true;
      #     telescope = true;
      #     ts_rainbow = true;
      #     indentblankline = true;
      #     telescope_borders = false;
      #   };
      # };

      # ayu = {
      #   enable = true;
      # };
      #onedark
      #catppuccin

      # nord = {
      #   enable = true;
      #   settings = {
      #     contrast = false;
      #     borders = true;
      #     disable_background = false;
      #     cursorline_transparent = false;
      #     enable_sidebar_background = false;
      #     uniform_diff_background = false;
      #     italic = true;
      #   };
      # }; # ./nord
    }; # ./ccolorschemes
  };
}
