{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    # auto-save.enable = true;
    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.xclip; # X11
      default = {
        affix = "<\n  %s\n>";
        #   affix = "![]({img_path})"; # used markdown, default: "{img_path}"
        imgDir = "img";
        #   imgDirTxt = "img";
        imgName = {
          __raw = "function() return os.date('%Y-%m-%d-%H-%M-%S') end";
        };
        # imgHandler =
      };
      #NOTE: Current commented options not work for clipboard-image, probably writing something wrong because default seems work.
      filetypes = {
        markdown = {
          # affix = "![]({img_path})";
          imgDir = [
            "src"
            "assets"
            "img"
          ];
          imgDirTxt = "/assets/img";
          # imgName = {
          #   __raw = "function() return os.date('%Y-%m-%d-%H-%M-%S') end";
          # };
          # imgHandler = ''
          #   function(img)
          #     local script = string.format('./image_compressor.sh "%s"', img.path)
          #     os.execute(script)
          #   end
          # '';
        };
      };
      # default = {
      #   img_dir = "images",
      #   img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
      # },

    };
    barbar.enable = true; # this is for tab view for buffers

    indent-blankline.enable = true;

    # vim-nix
    nix = {
      enable = true;
      # package = pkgs.vimplugins.vim-nix; # default
    };

    # # Lazyvim default tab view like vscode
    # bufferline = {
    #   enable = true;
    #   settings = {
    #     options = {
    #       always_show_bufferline = false;
    #       buffer_close_icon = "";
    #       diagnostics = "nvim_lsp";
    #     };
    #   };
    # };

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "eol";
        };
        signcolumn = true;
        signs = {
          add = {
            text = "│";
          };
          change = {
            text = "│";
          };
          changedelete = {
            text = "~";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          untracked = {
            text = "┆";
          };
        };
        watch_gitdir = {
          follow_files = true;
        };
      };
    };

    harpoon = {
      enable = true;
      saveOnToggle = true;
      saveOnChange = true;
      enterOnSendcmd = false;
      markBranch = true;
    };

    hop.enable = true;
    illuminate.enable = true;
    lazygit.enable = true;
    nvim-lightbulb.enable = true;
    lualine = {
      enable = true;
      settings.options.globalstatus = true;
    };
    luasnip.enable = true;

    mini = {
      enable = true;
      modules = {
        surround = { };
        indentscope = {
          symbol = "│";
          options = {
            try_as_border = true;
          };
        };
      };
    };

    noice.enable = true;
    #TESTING: 
    notify = {
      enable = true;
      maxWidth = 50;
      maxHeight = 50;
    };
    nvim-autopairs.enable = true;
    nvim-colorizer.enable = true;
    neo-tree = {
      enable = true; # File explorer
      filesystem = {
        followCurrentFile.enabled = true; # This will find and focus the file in the active buffer every time
        bindToCwd = false;
        useLibuvFileWatcher = true; # This will use the OS level file watchers to detect changes
        #To see hidden files:
        filteredItems = {
          visible = true;
          hideDotfiles = false;
          hideGitignored = false;
          hideHidden = false;
          hideByPattern = [
            #"*.meta"
            # "*/src/*/tsconfig.json"
          ];
          alwaysShow = [
            ".gitignore"
          ];
          # files/folders never show
          neverShow = [
            # example
            #".DS_Store" 
            # "thumbs.db"
          ];
          neverShowByPattern = [
            # ".null-ls_*"
          ];
          forceVisibleInEmptyFolder = false; # default:false
        };
      };
      defaultComponentConfigs.indent.withExpanders = true; # default:null, if nil and file nesting is enabled, will enable expanders
      window.width = 30;
      window.popup.size.width = "50%";
      window.popup.size.height = "80%";
      window.popup.position = "80%"; # 50% means center it
      window.autoExpandWidth = true; # false defualt
      # extraOptions = {
      #
      # };
    };
    # oil = {
    #   enable = true;
    #   settings = {
    #     columns = [
    #       "icons"
    #       "permissions"
    #       "size"
    #       "mtime"
    #     ];
    #     default_file_explorer = true;
    #     delete_to_trash = true;
    #     skip_confirmation_for_simple_edits = true;
    #   };
    # };
    render-markdown.enable = true;

    treesitter = {
      enable = true;

      nixGrammars = true; # default:true
      folding = false;
      # settings.indent.enable = true;
    };

    vim-surround.enable = true;
    web-devicons.enable = true;

    ### Find ### 
    fzf-lua = {
      enable = true;
      keymaps = {
        "<leader>/" = {
          action = "live_grep";
          options.desc = "Live Grep";
        };
        "<leader>," = {
          action = "buffers";
          options.desc = "Switch Buffer";
          settings = {
            sort_mru = true;
            sort_lastused = true;
          };
        };
        "<leader>gc" = {
          action = "git_commits";
          options.desc = "Git Commits";
        };
        "<leader>gs" = {
          action = "git_status";
          options.desc = "Git Status";
        };
        "<leader>s\"" = {
          action = "registers";
          options.desc = "Registers";
        };
        "<leader>sd" = {
          action = "diagnostics_document";
          options.desc = "Document Diagnostics";
        };
        "<leader>sD" = {
          action = "diagnostics_workspace";
          options.desc = "Workspace Diagnostics";
        };
        "<leader>sh" = {
          action = "help_tags";
          options.desc = "Help Pages";
        };
        "<leader>sk" = {
          action = "keymaps";
          options.desc = "Key Maps";
        };
      };
    };
    telescope.enable = true;
    todo-comments = {
      enable = true;
      keymaps = {
        todoTelescope = {
          key = "<leader>st";
          keywords = [ "TODO" ];
        };
      };
    };

  };
}
