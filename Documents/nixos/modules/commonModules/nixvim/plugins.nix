{pkgs, ...}: {
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

    #Productivity
    hop.enable = true;
    illuminate.enable = true;
    # auto-save.enable = true;

    # # AI
    cmp-ai = {
      enable = true;
      # autoLoad = true; # not came to 24.11 yet
      # lazyLoad.enable = false;
      settings = {
        # ignored_file_types = {
        #   lua = true;
        # };
        max_lines = 100;
        notify = true;
        notify_callback = ''
          function(msg)
            vim.notify(msg)
          end
        '';
        provider = "Ollama";
        provider_options = {
          model = "qwen2.5-coder:7b-base-q5_K_M";
          prompt = ''
            function(lines_before, lines_after)
              return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
            end
          '';
        };
        run_on_every_keystroke = true;
      };
    };

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

    # others
    nvim-lightbulb = {
      enable = true;
      settings = {
        autocmd = {
          enabled = true;
          updatetime = 200;
        };
        float = {
          enabled = false;
          text = " 󰌶 ";
          win_opts = {
            border = "rounded";
          };
        };
        line = {
          enabled = false;
        };
        number = {
          enabled = false;
        };
        sign = {
          enabled = false;
          text = "󰌶";
        };
        status_text = {
          enabled = false;
          text = " 󰌶 ";
        };
        virtual_text = {
          enabled = true;
          text = "󰌶";
        };
      };
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
          keywords = ["TODO"];
        };
      };
    };
  };
}
