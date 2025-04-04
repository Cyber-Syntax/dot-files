{pkgs, ...}: {
  programs.nixvim.plugins = {
    #NOTE: Python current setup: ruff + pyright
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft.python = ["ruff_format" "ruff_organize_imports"];
        formatters = {
          ruff = {
            command = "${pkgs.ruff}/bin/ruff";
            args = [
              "--config=/home/developer/Documents/nixos/modules/commonModules/nixvim/python/pyproject.toml"
              "format"
              "-"
              # "--fix"
              # "--stdin-filename"
              # "$FILENAME"
              # "-"
            ];
          };
        };
      };
    };

    lsp.servers = {
      pyright = {
        enable = true;
      };
      ruff = {
        enable = true;
      };
    };

    lint.lintersByFt.python = [
      "ruff"
    ];

    # lsp.servers.pylsp = {
    #   enable = true;
    #   settings.plugins = {
    #     ruff = {
    #       enabled = true;
    #     };
    #     # jedi.enabled = true;
    #     # mccabe.enabled = true;
    #     # pycodestyle.enabled = true;
    #     # pydocstyle.enabled = true;
    #     # pyflakes.enabled = true;
    #     # rope.enabled = true;
    #     black.enabled = true;
    #     # pylint.enabled = true;
    #     # yapf.enabled = true;
    #     # flake8.enabled = true;
    #     # isort.enabled = true;
    #   };
    # };
    # none-ls = {
    #   sources.formatting.black.enable = true;
    #   # sources.diagnostics.pylint.enable = true;
    # };
  };
}
