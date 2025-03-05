{pkgs, ...}: {
  programs.nixvim.plugins = {
    #Productivity
    hop.enable = true;
    illuminate.enable = true;
    # must-be
    telescope.enable = true;
    # tab view plugin
    barbar = {
      enable = true;
      settings = {
        animation = true;
        auto_hide = false;
        tabpages = true;
        clickable = true;
        sidebar_filetypes = {
          "neo-tree" = {
            event = "BufWipeout";
          };
        };
      };
    };
    indent-blankline.enable = true;

    treesitter = {
      enable = true;
      nixGrammars = true; # default:true
      folding = false;
      # settings.indent.enable = true;
    };
    lualine = {
      enable = true;
      settings.options.globalstatus = true;
    };
    luasnip.enable = true;

    mini = {
      enable = true;
      modules = {
        surround = {};
        indentscope = {
          symbol = "│";
          options = {
            try_as_border = true;
          };
        };
      };
    };

    noice.enable = true;
    notify = {
      enable = true;
      maxWidth = 50;
      maxHeight = 50;
    };
    nvim-autopairs.enable = true;
    nvim-colorizer.enable = true;

    vim-surround.enable = true;
    web-devicons.enable = true;
    # vim-nix
    nix = {
      enable = true;
    };

    # git
    lazygit.enable = true;
    fugitive = {
      enable = true;
    };

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
      projects = {
        # types: submodules
        #FIX: not seen on quick menu?

        "$HOME/Documents/nixos" = {
          marks = ["flake.nix"];
        };

        "$HOME/Documents/repository/my-unicorn" = {
          marks = ["main.py"];
        };

        "$HOME/Documents/repository/AutoTarCompress" = {
          marks = ["main.py"];
        };

        "$HOME/Documents/repository/cyber-syntax.github.io" = {
          marks = ["docusaurus.config.js"];
        };
      };
    };

    #terminal
    toggleterm = {
      enable = true;
      settings = {
        direction = "horizontal";
        float_opts = {
          border = "curved";
          height = 30;
          width = 130;
        };
        open_mapping = "[[<c-t>]]";
      };
    };

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
          hideHidden = true;
          hideByPattern = [
            # Making their color like comments but still show them.
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
            # delete from seeing completely. autoExpandWidth issue solve.
            # ".null-ls_*"
            "*sync-conflict*" # syncthing conflict files is to long. It's make so big neo-tree with autoExpandWidth
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
    # # # AI: currently copilot-vim
    # ollama = {
    #   enable = true;
    #   url = "http://127.0.0.1:11434";
    #   action = "display_insert";
    #   model = "qwen2.5-coder:3b-base-q4_0";
    #   prompts = {
    #     # "$HOME/Documents/nixos" = {
    #     #   marks = ["flake.nix"];
    #     # };
    #
    #     "Raw" = {
    #       prompt = "$input";
    #       # input_label = ">";
    #       model = "qwen2.5-coder:3b-base-q4_0";
    #       action = "display_insert";
    #     };
    #   };
    #
    #   # extraOptions = {
    #   # };
    #
    #   serve = {
    #     args = ["serve"];
    #     command = "ollama";
    #     onStart = false; #default
    #     stopArgs = [
    #       "-SIGTERM"
    #       "ollama"
    #     ];
    #     stopCommand = "pkill";
    #   };
    # };

    #NOTE: end so fast in 2 day when it's free :)
    copilot-vim = {
      enable = true;
      settings = {
        # node_command = "lib.getExe pkgs.nodejs-18_x"; # default: "lib.getExe pkgs.nodejs-18_x"
        filetypes = {
          "*" = true;
          # json = false;
        };
        # proxy = "localhost:3128"; # Default $HTTPS_PROXY
        proxy_strict_ssl = false;
        workspace_folders = [
          "~/Documents/repository/"
          "~/Documents/nixos/"
          # "~/Documents/repository/my-unicorn/"
          # "~/Documents/repository/AutoTarCompress/"
          # "~/Documents/repository/cyber-syntax.github.io/"
        ];
      };
    };
    #NOTE: Ollama models are not good like copilot because of 3b work only
    # cmp-ai = {
    #   enable = true;
    #   # autoLoad = true; # not came to 24.11 yet
    #   # lazyLoad.enable = false;
    #
    #   settings = {
    #     # ignored_file_types = {
    #     #   lua = true;
    #     # };
    #     max_lines = 100;
    #     notify = true;
    #     notify_callback = ''
    #       function(msg)
    #         vim.notify(msg)
    #       end
    #     '';
    #     provider = "Ollama";
    #     provider_options = {
    #       model = "qwen2.5-coder:7b-base-q5_K_M";
    #       auto_unload = false;
    #       prompt = {
    #         __raw = ''
    #           function(lines_before, lines_after)
    #             return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
    #           end
    #         '';
    #       };
    #     };
    #     run_on_every_keystroke = true;
    #   };
    # };

    # copilot-cmp = {
    #   enable = true;
    #   # luaConfig = { };
    #   settings = {
    #     event = [
    #       "InsertEnter"
    #       "LspAttach"
    #     ];
    #     fix_pairs = true; # prevent this `print('hello` to happen when you want `print('h')`
    #   };
    # };

    #NOTE: LLM not came to 24.11 yet.
    # llm = {
    #   enable = true;
    #   settings = {
    #     keys = {
    #       "Input:Cancel" = {
    #         key = "<C-c>";
    #         mode = "n";
    #       };
    #       "Input:Submit" = {
    #         key = "<cr>";
    #         mode = "n";
    #       };
    #     };
    #     max_history = 15;
    #     max_tokens = 1024;
    #     model = "deepseek-coder:6.7b-base-q4_0";
    #     prefix = {
    #       assistant = {
    #         hl = "Added";
    #         text = "⚡ ";
    #       };
    #       user = {
    #         hl = "Title";
    #         text = "😃 ";
    #       };
    #     };
    #     save_session = true;
    #     url = "http://127.0.0.1:11434";
    #   };
    # };

    # avante = {
    #   enable = true;
    #   settings = {
    #     ollama = {
    #       endpoint = "http://127.0.0.1:11434/v1";
    #       max_tokens = 4096;
    #       #FIX:
    #       model = "model-name-need-here";
    #       temperature = 0;
    #     };
    #     diff = {
    #       autojump = true;
    #       debug = false;
    #       list_opener = "copen";
    #     };
    #     highlights = {
    #       diff = {
    #         current = "DiffText";
    #         incoming = "DiffAdd";
    #       };
    #     };
    #     hints = {
    #       enabled = true;
    #     };
    #     mappings = {
    #       diff = {
    #         both = "cb";
    #         next = "]x";
    #         none = "c0";
    #         ours = "co";
    #         prev = "[x";
    #         theirs = "ct";
    #       };
    #     };
    #     provider = "ollama";
    #     windows = {
    #       sidebar_header = {
    #         align = "center";
    #         rounded = true;
    #       };
    #       width = 30;
    #       wrap = true;
    #     };
    #   };
    # };
    render-markdown = {
      enable = true;
      # latex.enable = false;
      settings = {
        bullet = {
          icons = [
            "◆ "
            "• "
            "• "
          ];
          right_pad = 1;
        };
        code = {
          above = " ";
          below = " ";
          border = "thick";
          language_pad = 2;
          left_pad = 2;
          position = "right";
          right_pad = 2;
          sign = false;
          width = "block";
        };
        heading = {
          border = true;
          icons = [
            "1 "
            "2 "
            "3 "
            "4 "
            "5 "
            "6 "
          ];
          position = "inline";
          sign = false;
          width = "full";
        };
        render_modes = true;
        signs = {
          enabled = false;
        };
      };
    };

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

    todo-comments = {
      enable = true;
      settings = {
        colors = {
          error = [
            "DiagnosticError"
            "ErrorMsg"
            "#DC2626"
          ];
        };
        #     colors = {
        # error = { "DiagnosticError", "ErrorMsg", "#DC2626" };
        # warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" };
        # info = { "DiagnosticInfo", "#2563EB" };
        # hint = { "DiagnosticHint", "#10B981" };
        # default = { "Identifier", "#7C3AED" };
        # test = { "Identifier", "#FF00FF" };
        #     };
        keywrods = {
          #FIX:
          FIX = {
            alt = [
              "FIXME"
              "BUG"
              "FIXIT"
              "ISSUE"
            ];
            color = "error";
            icon = " ";
          };
          #HACK:
          HACK = {
            alt = [
              "HACKY"
              "HACKED"
              "HACK"
              "WORKAROUND"
              "TEMP"
            ];
            color = "#7C3AED";
            icon = " ";
          };
          #NOTE:
          NOTE = {
            alt = [
              "INFO"
            ];
            color = "hint";
            icon = " ";
          };
          #PERF:
          PERF = {
            alt = [
              "OPTIM"
              "PERFORMANCE"
              "OPTIMIZE"
              "IMPROVE"
              "REFACTOR"
            ];
            color = "hint";
            icon = " ";
          };
          #TEST:
          TEST = {
            alt = [
              "TESTING"
              "PASSED"
              "FAILED"
            ];
            color = "#FBBF24";
            icon = "⏲ ";
          };
          #TODO:
          TODO = {
            color = "#10B981";
            icon = " ";
          };
          #LEARN:
          #LATER:
          WARN = {
            alt = [
              "WARNING"
              "XXX"
              "LEARN"
              "LATER"
            ];
            color = "hint";
            icon = " ";
          };
        };
      };
      keymaps = {
        todoTelescope = {
          key = "<leader>st";
          keywords = ["TODO"];
        };
        #TODO: need proper setup for those
        # testTelescope = {
        #   key = "<leader>se";
        #   keywords = ["TESTING"];
        # };
        # fixTelescope = {
        #   key = "<leader>sf";
        #   keywords = ["FIX"];
        # };
        #LATER: add jumping
        #       vim.keymap.set("n", "]t", function()
        #   require("todo-comments").jump_next()
        # end, { desc = "Next todo comment" })
        #
        # vim.keymap.set("n", "[t", function()
        #   require("todo-comments").jump_prev()
        # end, { desc = "Previous todo comment" })
        #
        # -- You can also specify a list of valid jump keywords
        #
        # vim.keymap.set("n", "]t", function()
        #   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
        # end, { desc = "Next error/warning todo comment" })
        #
      };
    };

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
          imgDirTxt = "/src/assets/img";
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
  };
}
