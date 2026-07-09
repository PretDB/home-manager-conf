{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # ./fcitx5
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pretdb";
  home.homeDirectory = "/home/pretdb";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # --- snacks.nvim image/math rendering dependencies ---
    imagemagickBig
    ghostscript
    poppler
    (texlive.combine {
      inherit (texlive) scheme-basic dvipng standalone varwidth preview xcolor mathtools;
    })

    bat
    cloc
    delta
    dnsutils # `dig` + `nslookup`
    dotnet-sdk
    # doxygen_gui
    fd
    file
    fzf # A command-line fuzzy finder
    gawk
    git-lfs
    glow # markdown previewer in terminal
    gnum4
    gnupg
    gnused
    gnutar
    go
    hugo # static site generator
    iotop # io monitoring
    ipcalc # it is a calculator for the IPv4/v6 addresses
    jq # A lightweight and flexible command-line JSON processor
    lazygit
    ldns # replacement of `dig`, it provide the command `drill`
    lsof # list open files
    lua-language-server
    lua51Packages.lua
    lua51Packages.luarocks-nix
    multimarkdown
    ncurses5
    nix-index
    nix-output-monitor
    nix-update
    nnn
    oh-my-zsh
    p7zip
    pandoc
    ripgrep
    sqlite
    tree
    tree-sitter
    universal-ctags
    unixtools.xxd
    unzip
    uv
    which
    xz
    yq-go
    zip
    # zlib
    zsh-powerlevel10k
    zstd
  ];

  # Force snacks.nvim Kitty graphics protocol (for WezTerm/kitten SSH)
  home.sessionVariables = {
    SNACKS_KITTY = "true";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".p10k.zsh".source = ./.p10k.zsh;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  fonts.fontconfig.enable = true; # Allow fontconfig to discover fonts in home.packages

  # LazyVim config: only source-controlled files, not lazy-lock.json
  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
    "nvim/lazyvim.json".source = ./nvim/lazyvim.json;
    "nvim/.neoconf.json".source = ./nvim/.neoconf.json;
    "nvim/stylua.toml".source = ./nvim/stylua.toml;
  };

  # WSL: we don't use fish, avoid completion conflicts with packages like delta
  programs.fish.enable = false;

  programs = {
    chromium = {
      enable = false;  # WSL: no need for browser via home-manager
    };

    # firefox = {
    #   enable = true;
    #   languagePacks = [
    #     "en-US"
    #     "zh-CN"
    #   ];
    #   package = pkgs.firefox-esr;
    # };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      settings = {
        core = {
          pager = "delta";
        };
        delta = {
          navigate = true;
          features = "zebra-dark";
          line-numbers = true;
          side-by-side = true;
          keep-plus-minus-mark = true;
        };
        diff = {
          colorMoved = true;
        };
        interactive = {
          diffFilter = "delta --color-only";
        };
        merge = {
          conflictstyle = "diff3";
        };
        user = {
          name = "PretDB";
          email = "pret-db@pret-page.com";
        };
      };
    };

    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    # kitty = {
    #   enable = true;
    #   settings = {
    #     confirm_os_window_close = 1;
    #     dynamic_background_opacity = true;
    #     enable_audio_bell = false;
    #     mouse_hide_wait = "-1.0";
    #     window_padding_width = 10;
    #     # background_opacity = "0.5";
    #     # background_blur = 5;
    #   };
    # };

    neovim = {
      enable = true;
      viAlias = false;
      vimAlias = false;
      withNodeJs = true;
    };

    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      extraConfig = ''
        # 开启 RGB 颜色支持（必须）
        set -g default-terminal "tmux-256color"
        set -ga terminal-overrides ",xterm-kitty:RGB"
        set -ga terminal-overrides ",*256col*:Tc"
        # 让 Tmux 允许传递包含图形的控制序列
        set -ga terminal-overrides ",*:Ss=\\E[%p1%d q:Se=\\E[2 q"
        set-environment -g COLORTERM "truecolor"
        set -gq allow-passthrough on
        set -g visual-activity off

        set -q -g status-utf8 on
        setw -q -g utf8 on

        # if you're running tmux within iTerm2
        #   - and tmux is 1.9 or 1.9a
        #   - and iTerm2 is configured to let option key act as +Esc
        #   - and iTerm2 is configured to send [1;9A -> [1;9D for option + arrow keys
        # then uncomment the following line to make Meta + arrow keys mapping work
        #set -ga terminal-overrides "*:kUP3=\e[1;9A,*:kDN3=\e[1;9B,*:kRIT3=\e[1;9C,*:kLFT3=\e[1;9D"

        # -- display -------------------------------------------------------------------

        set -g base-index 1           # start windows numbering at 1
        setw -g pane-base-index 1     # make pane numbering consistent with windows

        setw -g automatic-rename on   # rename window to reflect current program
        set -g renumber-windows on    # renumber windows when a window is closed

        set -g set-titles on          # set terminal title

        set -g display-panes-time 800 # slightly longer pane indicators display time
        set -g display-time 1000      # slightly longer status messages display time

        set -g status-interval 10     # redraw status line every 10 seconds

        # clear both screen and history
        # bind -n C-l send-keys C-l \; run 'sleep 0.1' \; clear-history

        # activity
        set -g monitor-activity on
        set -g visual-activity off


        # -- navigation ----------------------------------------------------------------

        # create session
        bind C-c new-session

        # find session
        bind C-f command-prompt -p find-session 'switch-client -t %%'

        # split current window horizontally
        bind - split-window -v
        # split current window vertically
        bind | split-window -h

        # pane navigation
        bind h select-pane -L  # move left
        bind j select-pane -D  # move down
        bind k select-pane -U  # move up
        bind l select-pane -R  # move right
        bind > swap-pane -D       # swap current pane with the next one
        bind < swap-pane -U       # swap current pane with the previous one

        # pane resizing
        bind -r H resize-pane -L 2
        bind -r J resize-pane -D 2
        bind -r K resize-pane -U 2
        bind -r L resize-pane -R 2

        # window navigation
        unbind n
        unbind p
        # bind-key -n C-h send-keys C-h  # select previous window
        # bind-key -n C-l send-keys C-l     # select next window
        unbind C-h
        # bind Tab last-window        # move to last active window

      '';
      escapeTime = 10;
      historyLimit = 10000;
      keyMode = "vi";
      mouse = false;
      prefix = "C-b";
      #shell = "${pkgs.zsh}/bin/zsh";
      shell = "/usr/bin/zsh";
      terminal = "tmux-256-color";
    };

    zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      completionInit = ''
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
      '';
      # defaultKeymap handled in initContent via bindkey -v instead,
      # because home-manager's bindkey -a prints keybindings to stdout.

      # [NOTE] this field seems to be useless.
      envExtra = ''
                SILICONFLOW_API_KEY="sk-vwacmoxntfytmglrmesxghsfsprwzlhmysozdretqqpxnrnm"
                TAVILY_API_KEY="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"
                TIMER_FORMAT='[%d]'
        	      TIMER_PRECISION=3
      '';

      history = {
        append = true;
        extended = true;
        save = 10000;
        size = 10000;
      };

      historySubstringSearch = {
        enable = true;
      };

      initContent = ''
        # Vi mode (replaces defaultKeymap="vicmd" which generates bindkey -a spam)
        bindkey -v

        source ~/.nix-profile/etc/profile.d/nix.sh
        autoload -U bashcompinit && bashcompinit
        autoload -U compinit && compinit
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

        export SILICONFLOW_API_KEY="sk-vwacmoxntfytmglrmesxghsfsprwzlhmysozdretqqpxnrnm"
        export TAVILY_API_KEY="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"
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme;

        # --- PATH (from legacy ~/.profile) ---
        export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

        # --- ROCm (AMD GPU) ---
        export LD_LIBRARY_PATH="/opt/rocm/lib:$LD_LIBRARY_PATH"

        # --- Rust / Cargo ---
        [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

        # --- Conda (Anaconda3, managed outside nix) ---
        if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
          . "$HOME/anaconda3/etc/profile.d/conda.sh"
        fi
      '';

      # With Oh-My-Zsh:
      oh-my-zsh = {
        enable = true;
        plugins = [
          "branch"
          "bundler"
          "catimg"
          "colored-man-pages"
          "colorize"
          "command-not-found"
          "conda"
          "copybuffer"
          "cp"
          "dirhistory"
          "docker"
          "docker-compose"
          "emoji"
          "emoji-clock"
          "encode64"
          "extract"
          "fzf"
          "git" # also requires `programs.git.enable = true;`
          "git-auto-fetch"
          "git-escape-magic"
          "git-extras"
          "gitfast"
          "git-flow"
          "git-flow-avh"
          "github"
          "git-hubflow"
          "git-lfs"
          "gitignore"
          "git-prompt"
          "gradle"
          "history"
          "history-substring-search"
          "httpie"
          "kate"
          "kops"
          "kubectl"
          "kube-ps1"
          "man"
          "mvn"
          "nmap"
          "node"
          "npm"
          "nvm"
          "pip"
          "python"
          "ruby"
          "rust"
          "sdk"
          "sudo"
          "systemd"
          "tmux"
          "ubuntu"
          "vi-mode"
          "web-search"
          "encode64"
          "urltools"
          "zsh-interactive-cd"
          "zsh-navigation-tools"
        ];
      };

      profileExtra = ''
        # # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';


      # promptInit = ''
      #   source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      #   '';

      setOptions = [
        "EXTENDED_HISTORY"
        "HIST_IGNORE_ALL_DUPS"
      ];
      shellAliases = {
        ls = "ls --color -lh";
        less = "less -RX";
        icat = "kitty +kitten icat";
      };

      syntaxHighlighting.enable = true;
    };
  };

  services.gpg-agent = {
    enable = false;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pretdb/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # LD_LIBRARY_PATH removed: nix binaries use RPATH and don't need it;
    # globally prepending nix gcc-lib breaks system tools (command-not-found
    # fails with GLIBC mismatch when apt_pkg picks up nix's libstdc++).
    LANG = "zh_CN.UTF-8";
    LC_ALL = "zh_CN.UTF-8";
  };
}
