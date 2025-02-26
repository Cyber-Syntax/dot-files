{
  programs.nixvim.plugins = {
    lsp-format.enable = true;
    conform-nvim = {
      enable = true;
      # Add format-on-save functionality
      # formatOnSave = {
      #   lspFallback = true;
      #   timeoutMs = 500;
      # };
      settings = {
        formatters_by_ft.python = [
          "ruff" # Replaced black with ruff (handles formatting + isort)
          # "black"
        ];
      };
    };

    # Configure Ruff LSP properly
    lsp.servers.ruff = {
      enable = true;
      extraOptions = {
        initOptions.settings.args = [
          "--config=/home/developer/Documents/nixos/modules/commonModules/nixvim/python/ruff.toml"
        ];
      };
    };
    lint.lintersByFt.python = [
      "ruff"
    ];

    lsp.servers.pylsp = {
      enable = true;
      settings.plugins = {
        # Disable redundant linters now handled by ruff
        # flake8.enabled = false; # Covered by ruff
        # pycodestyle.enabled = false; # Covered by ruff
        # pyflakes.enabled = false; # Covered by ruff
        # mccabe.enabled = false; # Covered by ruff

        ruff.enabled = true;

        # Keep useful plugins
        jedi.enabled = true; # Good for completions
        # pylint.enabled = true; # Keep for deep code analysis
        rope.enabled = true; # Useful for refactoring

        # # Configure remaining plugins
        # black.enabled = false; # Disabled in favor of ruff
        # isort.enabled = false; # Handled by ruff's formatter
        # yapf.enabled = false; # Disabled in favor of ruff
      };
    };

    none-ls = {
      sources = {
        # formatting = {
        # };
        diagnostics = {
          mypy.enable = true; # Static type checking
          # Keep pylint for deeper analysis
          # pylint.enable = true;
        };
      };
    };
  };
}
