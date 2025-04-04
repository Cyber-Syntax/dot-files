let
  selectOpts = "{behavior = cmp.SelectBehavior.Select}";
in
  {pkgs, ...}: {
    programs.nixvim.plugins = {
      # none-ls formatting setup for languages
      #TODO: need to find alternative because none-ls null-ls is not develop anymore
      none-ls = {
        enable = true;
        sources.formatting = {
          alejandra.enable = true; # better
          prettier.enable = true;
          stylua.enable = true;
          yamlfmt.enable = true;
        };
        sources.diagnostics = {
          yamllint.enable = true;
          statix.enable = true; # Nix linting
        };
      };

      # Conform plugin for languages, formating on the save etc.
      conform-nvim = {
        enable = true;
        settings = {
          notify_no_formatters = true;
          format_on_save = {
            lsp_fallback = "fallback";
            timeout_ms = 500;
          };
          formatters = {
            alejandra = {
              command = "${pkgs.alejandra}/bin/alejandra";
              args = ["--quiet"];
            };
          };
          notify_on_error = true;

          formatters_by_ft = {
            css = ["prettier"];
            html = ["prettier"];
            json = ["prettier"];
            lua = ["stylua"];
            markdown = ["prettier"];
            nix = ["alejandra"]; # better than nixfmt
            yaml = ["yamlfmt"];
          };
        };
      };
      # issue show plugin
      trouble = {
        enable = true;
        settings = {
          auto_preview = true;
          indent_guides = true;
          multiline = true;
          useDiagnosticSigns = true;
          preview = {
            type = "main";
            # -- when a buffer is not yet loaded, the preview window will be created
            # -- in a scratch buffer with only syntax highlighting enabled.
            # -- Set to false, if you want the preview to always be a real loaded buffer.
            scratch = false;
          };
        };
      };
      #NOTE: General lsp for bash, nix(old nil_ls), json, markdown, yaml

      #Lazyload is not on 24.11 yet?
      # Lazyload
      # which-key.lazyLoad.settings.even = "VimEnter";
      lsp = {
        enable = true;
        # lazyLoad = {
        #   enable = true;
        #   settings = {
        #     ft = "markdown";
        #   };
        # };
        inlayHints = true;
        servers = {
          nixd = {
            enable = true;
            #HACK: rpc.lua error on highlighting
            #https://github.com/nix-community/nixvim/issues/2390#issuecomment-2408101568
            extraOptions = {
              offset_encoding = "utf-8";
            };
            settings = {
              formatting.command = ["alejandra"];
              #TESTING:
              # nixpkgs.expr = "import <nixpkgs> { }";
              # options = {
              #   #TODO: need to find out folders
              #   # nixos.expr = "(builtins.getFlake \"/home/developer/Documents/nixos\").nixosConfigurations.nixos.options";
              #   # nixvim.expr = "(builtins.getFlake \"/home/developer/Documents/nixos\").nixosConfigurations.nixos.options.programs.nixvim.type.getSubOptions []";
              #   # nixos.expr = "(builtins.getFlake \"github:pagedMov/nixos-config\").nixosConfigurations.xenon.options";
              #   # home_manager.expr = "";
              #
              #   # home_manager.expr = "(builtins.getFlake ('git+file://' + toString ./.)).homeConfigurations.'ruixi@k-on'.options";
              # };
            };
          };
          bashls = {
            enable = true;
          };
          yamlls.enable = true;
          jsonls.enable = true;
          marksman.enable = true; # markdown
        };
        keymaps = {
          diagnostic = {
            "<leader>E" = "open_float";
            "[" = "goto_prev";
            "]" = "goto_next";
            "<leader>do" = "setloclist";
          };
          lspBuf = {
            "K" = "hover";
            "gD" = "declaration";
            "gd" = "definition";
            "gr" = "references";
            "gI" = "implementation";
            "gy" = "type_definition";
            "<leader>ca" = "code_action";
            "<leader>cr" = "rename";
            "<leader>wl" = "list_workspace_folders";
            "<leader>wr" = "remove_workspace_folder";
            "<leader>wa" = "add_workspace_folder";
          };
        };
        preConfig = ''
          vim.diagnostic.config({
            virtual_text = true,
            virtual_text = {
              spacing = 4,
              source = "if_many",
              prefix = "●",
              -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
              -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
              -- prefix = "icons",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
              border = 'rounded',
              source = 'always',
            },
          })

          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            {border = 'rounded'}
          )

          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            {border = 'rounded'}
          )
        '';
        postConfig = ''
          local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
          for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
          end
        '';
      };
      dap.enable = true;

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;

      #TEST: later
      # cmp-dictionary.enable = true;

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          performance = {
            debounce = 150;
          };
          sources = [
            # {name = "cmp_ai";}
            {name = "path";}
            {
              name = "nvim_lsp";
              keywordLength = 1;
            }
            {
              name = "buffer";
              keywordLength = 3;
            }
          ];

          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          formatting = {
            fields = [
              "menu"
              "abbr"
              "kind"
            ];
            format = ''
              function(entry, item)
                local menu_icon = {
                  nvim_lsp = '[LSP]',
                  luasnip = '[SNIP]',
                  buffer = '[BUF]',
                  path = '[PATH]',
                }

                item.menu = menu_icon[entry.source.name]
                return item
              end
            '';
          };

          mapping = {
            # "<C-x>" = "cmp.mapping.confirm({select = true})";
            "<Up>" = "cmp.mapping.select_prev_item(${selectOpts})";
            "<Down>" = "cmp.mapping.select_next_item(${selectOpts})";
            "<C-p>" = "cmp.mapping.select_prev_item(${selectOpts})";
            "<C-n>" = "cmp.mapping.select_next_item(${selectOpts})";
            # "<C-u>" = "cmp.mapping.scroll_docs(-4)";
            # "<C-d>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-y>" = "cmp.mapping.confirm({select = true})";
            "<CR>" = "cmp.mapping.confirm({select = false})";

            "<C-f>" = ''
              cmp.mapping(
                function(fallback)
                  if luasnip.jumpable(1) then
                    luasnip.jump(1)
                  else
                    fallback()
                  end
                end,
                { "i", "s" }
              )
            '';
            "<C-b>" = ''
              cmp.mapping(
                function(fallback)
                  if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end,
                { "i", "s" }
              )
            '';
            "<C-Up>" = ''
              cmp.mapping(
                function(fallback)
                  local col = vim.fn.col('.') - 1

                  if cmp.visible() then
                    cmp.select_next_item(select_opts)
                  elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    fallback()
                  else
                    cmp.complete()
                  end
                end,
                { "i", "s" }
              )
            '';

            "<C-Down>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item(select_opts)
                  else
                    fallback()
                  end
                end,
                { "i", "s" }
              )
            '';
          };
          window = {
            completion = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
              zindex = 1001;
              scrolloff = 0;
              colOffset = 0;
              sidePadding = 1;
              scrollbar = true;
            };
            documentation = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
              zindex = 1001;
              maxHeight = 20;
            };
          };
        };
      };
    };
  }
