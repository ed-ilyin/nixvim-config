{ self, pkgs, system, ...  }:
{
  clipboard.register = "unnamedplus";
  colorschemes.catppuccin.enable = true;
  defaultEditor = true;
  editorconfig.enable = true;
  extraPlugins = [ pkgs.vimPlugins.vim-startuptime ];
  globals = {
    mapleader = " ";
    maplocalleader = " ";
    loaded_matchit = 1;
  };
  keymaps =
    let
      leader = key: action: desc: {
        mode = "n";
        key = "<leader>${key}";
        action = "<cmd>${action}<CR>";
        options = { silent = true; desc = desc; };
      };
    in
    [
      { key = ";"; action = ":"; }
      (leader "tl" "Telescope" "Open Telescope")
      (leader "qq" "q" "Quit Window")
      (leader "km" "Telescope keymaps" "Show Keymaps")
      (leader "gg" "LazyGit" "LazyGit")
      (leader "fs" "w" "Save File")
      (leader "fm" "lua vim.lsp.buf.format()" "Format")
      (leader "ff" "Telescope find_files" "Find files")
      (leader "fb" "Telescope file-browser" "File browser")
      (leader "bp" "bp" "Previous Buffer")
      (leader "bn" "bn" "Next Buffer")
      (leader "bd" "bd" "Close Buffer")
      (leader "bc" "b#" "Change Buffer")
      (leader "bb" "Telescope buffers" "List Buffers")
      (leader "/" "Telescope live_grep" "Live grep")
      (leader "?" "WhichKey" "Show Keymaps")
    ];
  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    termguicolors = true;
  };
  plugins = {
    auto-save.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        accept.auto_brackets.enabled = true;
        highlight.use_nvim_cmp_as_default = true;
        keymap = {
          preset = "enter";
          "<S-l>" = [ "select_and_accept" ];
          "<S-j>" = [ "select_next" "fallback" ];
          "<S-h>" = [ "hide" ];
          "<S-k>" = [ "select_prev" "fallback" ];
        };
        nerd_font_variant = "mono";
        trigger.signature_help.enabled = true;
        windows.documentation.auto_show = true;
        windows.documentation.treesitter_highlighting = true;
      };
    };
    bufferline.enable = true;
    copilot-lua = {
      enable = true;
      # suggestion.enabled = false;
      # panel.enabled = false;
    };
    lazygit.enable = true;
    lsp = {
      enable = true;
      servers = {
        # bicep.enable = true;
        dotls.enable = true;
        fsautocomplete.enable = true;
        nixd.enable = true;
        nixd.settings = {
          formatting.command = [ "nixfmt" ];
          nixpkgs.expr = "import (builtins.getFlake \"/Users/ed/dev/nix/main-flake\").inputs.nixpkgs { }";
          # nixpkgs.expr = "import <nixpkgs> { }";
          options = {
            nixos.expr = ''(builtins.getFlake "/Users/ed/dev/nix/main-flake").outputs.nixosConfigurations.nixos.options'';
            nix-darwin.expr = ''(builtins.getFlake "/Users/ed/dev/nix/main-flake").outputs.darwinConfigurations.Ed-MBP16.options'';
            home-manager.expr = ''(builtins.getFlake "/Users/ed/dev/nix/main-flake").outputs.homeConfigurations.ed.options'';
            nixvim.expr = ''(builtins.getFlake "${self}").packages.${system}.neovimNixvim.options'';
          };
        };
        nushell.enable = true;
        omnisharp.enable = true;
      };
    };
    lualine.enable = true;
    luasnip.enable = true;
    noice.enable = true;
    oil.enable = true;
    telescope = {
      enable = true;
      extensions.file-browser.enable = true;
    };
    tmux-navigator.enable = true;
    treesitter.enable = true;
    treesitter.settings.highlight.enable = true;
    vim-matchup.enable = true;
    vim-matchup.treesitterIntegration.enable = true;
    web-devicons.enable = true;
    which-key.enable = true;
  };
}
