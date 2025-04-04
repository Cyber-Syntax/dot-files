{
  programs.nixvim.globals.mapleader = " ";

  programs.nixvim.plugins.which-key = {
    enable = true;
    settings = {
      spec = [
        # Settings groups
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
        }
        {
          __unkeyed-1 = "<leader><tab>";
          group = "Tabs";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "File / Find";
        }
        {
          __unkeyed-1 = "<leader>q";
          group = "Quit / Session";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Search";
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffer";
        }
        {
          __unkeyed-1 = "<leader>o";
          group = "SOPS";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "Debug";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "Code Actions";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>d/";
          group = "Search";
          icon = "";
        }
        {
          __unkeyed-1 = "<leader>D";
          group = "Database";
          icon = "";
        }
        # Keys with custom icons / labels
        {
          __unkeyed-1 = "<leader>e";
          icon = "󰏇";
          desc = "Neo-tree Toggle";
        }
        {
          __unkeyed-1 = "<leader>/";
          icon = "";
          desc = "Live Grep";
        }
        {
          __unkeyed-1 = "<leader>da";
          icon = "";
          desc = "Run with Args";
        }
        {
          __unkeyed-1 = "<leader>db";
          icon = "";
          desc = "Toggle Breakpoint";
        }
        {
          __unkeyed-1 = "<leader>dB";
          icon = "";
          desc = "Breakpoint Condition";
        }
        {
          __unkeyed-1 = "<leader>dc";
          icon = "";
          desc = "Continue";
        }
        {
          __unkeyed-1 = "<leader>dC";
          icon = "";
          desc = "Run to cursor";
        }
        {
          __unkeyed-1 = "<leader>de";
          icon = "󰫧";
          desc = "Eval";
        }
        {
          __unkeyed-1 = "<leader>dg";
          icon = "";
          desc = "Go to line (no execute)";
        }
        {
          __unkeyed-1 = "<leader>di";
          icon = "󰆹";
          desc = "Step into";
        }
        {
          __unkeyed-1 = "<leader>dj";
          icon = "";
          desc = "Down";
        }
        {
          __unkeyed-1 = "<leader>dk";
          icon = "";
          desc = "Up";
        }
        {
          __unkeyed-1 = "<leader>dl";
          icon = "";
          desc = "Run Last";
        }
        {
          __unkeyed-1 = "<leader>do";
          icon = "";
          desc = "Step Out";
        }
        {
          __unkeyed-1 = "<leader>dO";
          icon = "";
          desc = "Step Over";
        }
        {
          __unkeyed-1 = "<leader>dp";
          icon = "";
          desc = "Pause";
        }
        {
          __unkeyed-1 = "<leader>dt";
          icon = "";
          desc = "Terminate";
        }
        {
          __unkeyed-1 = "<leader>ca";
          icon = "󱐋";
          desc = "Code Actions";
        }
        {
          __unkeyed-1 = "<leader>cr";
          icon = "󰑕";
          desc = "Rename";
        }
        {
          __unkeyed-1 = "<leader>wa";
          icon = "󱑾";
          desc = "Add Workspace Folder";
        }
        {
          __unkeyed-1 = "<leader>wr";
          icon = "";
          desc = "Remove Workspace Folder";
        }
        {
          __unkeyed-1 = "<leader>wr";
          icon = "󰉓";
          desc = "List Workspace Folders";
        }
        {
          __unkeyed-1 = "<leader>h";
          icon = "󱡅";
          desc = "Harpoon";
        }
      ];
    };
  };

  programs.nixvim.keymaps = [
    # keymaps.*.mode =

    # Custom new keys
    ## indentination with keeping selected area in visual mode.(e.g easy to indent multiple time)
    {
      mode = "v";
      key = "<tab>";
      action = "<cmd>normal! > | gv<cr>";
      options.desc = "indent left";
    }
    {
      mode = "v";
      key = "<S-tab>";
      action = "<cmd>normal! < | gv<cr>";
      options.desc = "Indent right";
    }

    # Normal mode
    {
      mode = "n"; # old: i
      key = "<C-c>";
      action = "<CMD>%y<CR>";
      options.desc = "Copy all file";
    }

    {
      mode = "n"; # old: i
      key = "jk";
      action = "<CMD>noh<CR><ESC>";
      options.desc = "Normal mode and clear highlight";
    }
    {
      mode = "n"; # old: i
      key = "<ESC>";
      action = "<CMD>noh<CR><ESC>";
      options.desc = "Normal mode and clear highlight";
    }

    # useful quit neovim
    {
      mode = "n";
      key = "<leader>qq";
      action = "<CMD>quitall<CR>";
      options.desc = "Quit NeoVim";
    }

    # Neo-tree
    {
      mode = "n";
      key = "<leader>e";
      action = "<CMD>Neotree toggle<CR>";
      options.desc = "Neotree toggle";
      # options.remap = false; # prevent remapping key for others??
    }
    {
      mode = "n";
      key = "<leader>rr";
      action = "<CMD>Neotree focus<CR>";
      options.desc = "Neotree focus";
    }
    {
      mode = "n";
      key = "<leader>rb";
      action = "<CMD>Neotree buffers<CR>";
      options.desc = "Neotree reveal";
    }
    {
      mode = "n";
      key = "<leader>rg";
      action = "<CMD>Neotree git_status<CR>";
      options.desc = "Neotree reveal";
    }

    # Obsidian.nvim
    #TODO:

    #Changed for Neo-tree
    # {
    #   mode = "n";
    #   key = "<leader>e";
    #   action = "<CMD>Oil<CR>";
    #   options.desc = "Oil";
    # }

    # Hop command
    {
      mode = "n";
      key = "m";
      action = "<CMD>HopChar1<CR>";
      options.desc = "Hop Char 1";
    }

    # Add undo breakpoints
    {
      mode = "i";
      key = ",";
      action = ",<C-g>u";
      options.desc = "Undo breakpoint";
    }
    {
      mode = "i";
      key = ".";
      action = ".<C-g>u";
      options.desc = "Undo breakpoint";
    }
    {
      mode = "i";
      key = ";";
      action = ";<C-g>u";
      options.desc = "Undo breakpoint";
    }

    # Harpoon commands
    {
      mode = "n";
      key = "<leader>ha";
      action = "<CMD>lua require('harpoon.mark').add_file()<CR>";
      options.desc = "Add File";
    }
    {
      mode = "n";
      key = "<leader>hn";
      action = "<CMD>lua require('harpoon.ui').nav_next()<CR>";
      options.desc = "Next File";
    }
    {
      mode = "n";
      key = "<leader>hp";
      action = "<CMD>lua require('harpoon.ui').nav_prev()<CR>";
      options.desc = "Previous File";
    }
    {
      mode = "n";
      key = "<leader>hm";
      action = "<CMD>Telescope harpoon marks<CR>";
      options.desc = "Telescope Menu";
    }
    {
      mode = "n";
      key = "<leader>hq";
      action = "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>";
      options.desc = "Quick Menu";
    }

    # FZF-Lua custom commands -- I want to limit to current directory
    {
      mode = "n";
      key = "<leader>ff";
      action = "<CMD>lua require('fzf-lua').files({ cwd = vim.loop.cwd() })<CR>";
      options.desc = "Find files in CWD";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<CMD>lua require('fzf-lua').live_grep({ cwd = vim.loop.cwd() })<CR>";
      options.desc = "Live grep in CWD";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<CMD>lua require('fzf-lua').oldfiles({ cwd = vim.loop.cwd() })<CR>";
      options.desc = "Recent files in CWD";
    }

    # New recommended mappings
    {
      mode = "n";
      key = "<leader>fb";
      action = "<CMD>lua require('fzf-lua').buffers()<CR>";
      options.desc = "Find buffers";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<CMD>lua require('fzf-lua').help_tags()<CR>";
      options.desc = "Help tags";
    }
    {
      mode = "n";
      key = "<leader>fs";
      action = "<CMD>lua require('fzf-lua').git_status()<CR>";
      options.desc = "Git status";
    }
    {
      mode = "n";
      key = "<leader>fl";
      action = "<CMD>lua require('fzf-lua').blines()<CR>";
      options.desc = "Search lines in buffer";
    }
    {
      mode = "n";
      key = "<leader>fc";
      action = "<CMD>lua require('fzf-lua').commands()<CR>";
      options.desc = "Vim commands";
    }
    {
      mode = "n";
      key = "<leader>fm";
      action = "<CMD>lua require('fzf-lua').marks()<CR>";
      options.desc = "Vim marks";
    }
    {
      mode = "n";
      key = "<leader>fd";
      action = "<CMD>lua require('fzf-lua').lsp_document_symbols()<CR>";
      options.desc = "Document symbols";
    }

    # Database
    {
      mode = "n";
      key = "<leader>Du";
      action = "<CMD>DBUI<CR>";
      options.desc = "Show Database UI";
    }

    # LSP Actions
    {
      mode = "n";
      key = "gd";
      action = "<CMD>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<CR>";
      options.desc = "Goto Definition";
    }
    {
      mode = "n";
      key = "gr";
      action = "<CMD>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<CR>";
      options.desc = "References";
    }
    {
      mode = "n";
      key = "gI";
      action = "<CMD>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<CR>";
      options.desc = "Goto Implementation";
    }
    {
      mode = "n";
      key = "gy";
      action = "<CMD>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<CR>";
      options.desc = "Goto T[y]pe Definition";
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = "<CMD>lua vim.diagnostic.open_float()<CR>";
      options.desc = "Popup Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>cD";
      action = "<CMD>Trouble diagnostics toggle<CR>";
      options.desc = "List All Diagnostics";
    }

    # SOPS
    {
      mode = "n";
      key = "<leader>od";
      action = "<CMD>!sops -d -i %<CR><CR>";
      options.desc = "Decrypt SOPS File";
    }
    {
      mode = "n";
      key = "<leader>oe";
      action = "<CMD>!sops -e -i %<CR><CR>";
      options.desc = "Encrypt SOPS File";
    }

    # Git
    {
      mode = "n";
      key = "<leader>gg";
      action = "<CMD>LazyGit<CR>";
      options.desc = "LazyGit";
    }

    # # terminal
    # Ctrl + t
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-N>";
      options.desc = "Exit Terminal Mode";
      options.silent = true;
      #options.noremap = true;
    }

    # {
    #   mode = "n";
    #   key = "<leader>t";
    #   action = "<CMD>ToggleTerm<CR>";
    #   options.desc = "Terminal";
    # }

    # Windows
    #TESTING: window focus keys
    {
      key = "<C-a>";
      action = "<CMD>wincmd h<CR>";
      options.desc = "Navigate Window Left";
    }
    {
      key = "<C-d>";
      action = "<CMD>wincmd l<CR>";
      options.desc = "Navigate Window Right";
    }

    {
      key = "<C-s>";
      action = "<CMD>wincmd j<CR>";
      options.desc = "Navigate Window Down";
    }
    {
      key = "<C-k>";
      action = "<CMD>wincmd k<CR>";
      options.desc = "Navigate Window Up";
    }
    {
      mode = "n";
      key = "<leader>w";
      action = "<c-w>";
      options.desc = "Windows";
    }
    {
      mode = "n";
      key = "<leader>-";
      action = "<C-W>s";
      options.desc = "Split Window Below";
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<C-W>v";
      options.desc = "Split Window Right";
    }
    {
      mode = "n";
      key = "<leader>wd";
      action = "<C-W>c";
      options.desc = "Delete Window";
    }

    # Tabs
    {
      mode = "n";
      key = "<leader><tab>l";
      action = "<CMD>tablast<CR>";
      options.desc = "Last Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>o";
      action = "<CMD>tabonly<CR>";
      options.desc = "Close Other Tabs";
    }
    {
      mode = "n";
      key = "<leader><tab>f";
      action = "<CMD>tabfirst<CR>";
      options.desc = "First Tab";
    }
    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = "<CMD>tabnew<CR>";
      options.desc = "New Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>]";
      action = "<CMD>tabnext<CR>";
      options.desc = "Next Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>d";
      action = "<CMD>tabclose<CR>";
      options.desc = "Close Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>[";
      action = "<CMD>tabprevious<CR>";
      options.desc = "Previous Tab";
    }

    ## Barbar.nvim keymaps
    {
      mode = "n";
      key = "<leader>bd";
      action = "<CMD>BufferClose<CR>";
      options.desc = "Buffer Close";
    }
    {
      mode = "n";
      key = "<tab>";
      action = "<CMD>bnext<CR>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "<S-tab>";
      action = "<CMD>bprevious<CR>";
      options.desc = "Previous Buffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action = "<CMD>BufferCloseAllButCurrent<CR>";
      options.desc = "Delete Other Buffers";
    }
    {
      mode = "n";
      key = "<leader>br";
      action = "<CMD>BufferCloseBuffersRight<CR>";
      options.desc = "Delete Buffers to the Right";
    }
    {
      mode = "n";
      key = "<leader>bl";
      action = "<CMD>BufferCloseBuffersLeft<CR>";
      options.desc = "Delete Buffers to the Left";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<CMD>BufferPin<CR>";
      options.desc = "Toggle Pin";
    }
    {
      mode = "n";
      key = "<leader>bP";
      action = "<CMD>BufferCloseAllButCurrentOrPinned<CR>";
      options.desc = "Delete Non-Pinned Buffers and Keep current";
    }
    {
      mode = "n";
      key = "<leader>ba";
      action = "<CMD>BufferMovePrevious<CR>";
      options.desc = "Re-order previous";
    }
    {
      mode = "n";
      key = "<leader>bA";
      action = "<CMD>BufferMoveNext<CR>";
      options.desc = "Re-order next";
    }
    # -- Magic buffer-picking mode
    # map('n', '<C-p>',   '<Cmd>BufferPick<CR>', opts)
    # map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', opts)
    #
    # -- Sort automatically by...
    # map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
    # map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
    # map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
    # map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
    # map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
    #
    # DAP Telescope Actions
    {
      mode = "n";
      key = "<leader>d/c";
      action = "<CMD>Telescope dap commands<CR>";
      options.desc = "Search Commands";
    }
    {
      mode = "n";
      key = "<leader>d/b";
      action = "<CMD>Telescope dap list_breakpoints<CR>";
      options.desc = "Search Breakpoints";
    }
    {
      mode = "n";
      key = "<leader>d/v";
      action = "<CMD>Telescope dap variables<CR>";
      options.desc = "Search Variables";
    }
    {
      mode = "n";
      key = "<leader>d/f";
      action = "<CMD>Telescope dap frames<CR>";
      options.desc = "Search Frames";
    }
  ];
}
