      #NOTE: not good as nvim-cmp for now
      # blink-cmp = {
      #   enable = true;
      #   settings = {
      #     appearance = {
      #       nerd_font_variant = "normal";
      #       use_nvim_cmp_as_default = true;
      #     };
      #     completion = {
      #       accept = {
      #         auto_brackets = {
      #           enabled = true;
      #           semantic_token_resolution = {
      #             enabled = false;
      #           };
      #         };
      #       };
      #       documentation = {
      #         auto_show = true;
      #       };
      #     };
      #     keymap = {
      #       # preset = "enter";
      #       "<C-b>" = [
      #         "scroll_documentation_up"
      #         "fallback"
      #       ];
      #       "<C-e>" = [
      #         "hide"
      #       ];
      #       "<C-f>" = [
      #         "scroll_documentation_down"
      #         "fallback"
      #       ];
      #       "<C-n>" = [
      #         "select_next"
      #         "fallback"
      #       ];
      #       "<C-p>" = [
      #         "select_prev"
      #         "fallback"
      #       ];
      #       "<C-space>" = [
      #         "show"
      #         "show_documentation"
      #         "hide_documentation"
      #       ];
      #       "<Enter>" = [
      #         "select_and_accept"
      #       ];
      #       "<Down>" = [
      #         "select_next"
      #         "fallback"
      #       ];
      #       "<A-Left>" = [
      #         "snippet_backward"
      #         "fallback"
      #       ];
      #       "<A-Right>" = [
      #         "snippet_forward"
      #         "fallback"
      #       ];
      #       "<Up>" = [
      #         "select_prev"
      #         "fallback"
      #       ];
      #     };
      #     signature = {
      #       enabled = true;
      #     };
      #     sources = {
      #       default = [
      #         "lsp"
      #         "path"
      #         "snippets"
      #         "buffer"
      #         #TODO: later setup
      #         # "copilot"
      #         #NOTE: after those came to 24.11
      #         # "emoji"
      #         # "dictionary"
      #       ];
      #       cmdline = [];
      #       providers = {
      #         lsp = {
      #           name = "lsp";
      #           enabled = true;
      #           module = "blink.cmp.sources.lsp";
      #           kind = "LSP";
      #           fallbacks = [];
      #         };
      #         buffer = {
      #           name = "Buffer";
      #           enabled = true;
      #           max_items = 3;
      #           module = "blink.cmp.sources.buffer";
      #           min_keyword_lenght = 4;
      #           score_offset = 15; # the higher the number, the higher the priority
      #         };
      #         snippets = {
      #           name = "snippets";
      #           enabled = true;
      #           max_items = 15;
      #           min_keyword_length = 2;
      #           module = "blink.cmp.sources.snippets";
      #           score_offset = 85; # the higher the number, the higher the priority
      #         };
      #         # copilot = {
      #         #   name = "copilot";
      #         #   enabled = true;
      #         #   module = "blink-cmp-copilot";
      #         #   kind = "Copilot";
      #         #   min_keyword_length = 6;
      #         #   score_offset = -100; # the higher the number, the higher the priority
      #         #   async = true;
      #         # };
      #       };
      #     };
      #   };
      # };
      #Not on 24.11 yet.
      # blink-emoji.enable = true;
      # blink-cmp-dictionary.enable = true;

