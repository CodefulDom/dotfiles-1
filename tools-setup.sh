#!/bin/bash
# Package setup
if hash apt 2>/dev/null; then
    if ! dpkg -l | grep ^ii | grep -q cmake; then
        sudo apt install cmake libssl-dev pkg-config
    fi
fi

# Git and Vim setup.
if hash apt-cache 2>/dev/null; then
    if ! apt-cache policy | grep -q "git-core/ppa"; then
        sudo apt-add-repository ppa:git-core/ppa
        sudo apt update
        sudo apt install git
    fi
    if ! apt-cache policy | grep -q "jonathonf/vim"; then
        sudo add-apt-repository ppa:jonathonf/vim
        sudo apt update
        sudo apt install vim
    fi
fi

# Vim plugin setup.
if hash vim 2>/dev/null; then
    vim +PluginClean +PluginInstall! +qall
fi

# Rust toolchain setup.
if hash rustup 2>/dev/null; then
    rustup self update
    rustup set profile minimal

    # Stable.
    rustup toolchain add stable
    rustup component add clippy
    rustup component add rust-docs
    rustup component add rust-src
    rustup component add rustfmt

    # Nightly.
    rustup toolchain add nightly
    rustup component add clippy --toolchain nightly
    rustup component add rust-docs --toolchain nightly
    rustup component add rust-src --toolchain nightly
    rustup component add rustfmt --toolchain nightly

    # Completions
    rustup completions bash rustup > "$XDG_DATA_HOME/bash_completion/completions/rustup"
    rustup completions bash cargo > "$XDG_DATA_HOME/bash_completion/completions/cargo"
fi

# Rust tools setup.
if hash cargo 2>/dev/null; then
    if hash cmake 2>/dev/null; then
        if ! hash cargo-install-update 2>/dev/null; then
            cargo install cargo-update
        fi
        if ! hash ra_lsp_server 2>/dev/null; then
            git clone https://github.com/rust-analyzer/rust-analyzer.git cargo-update/ra_lsp_server
        fi

        cargo install-update -i \
            cargo-update \
            cargo-asm \
            cargo-expand \
            cargo-outdated \
            cargo-tree \
            ripgrep \
            tokei \
            xsv

        pushd cargo-update/ra_lsp_server
        git fat && git down && git submodule update --init
        cargo install-ra --server
        popd
    else
        echo "cargo install-update not installed (cmake missing)."
    fi
fi

# VSCode extension setup.
if ! grep -q Microsoft /proc/version && hash code 2>/dev/null; then
    if ! code --list-extensions | grep -q "bungcip.better-toml"; then
        code --install-extension bungcip.better-toml
    fi

    if ! code --list-extensions | grep -q "dotjoshjohnson.xml"; then
        code --install-extension dotjoshjohnson.xml
    fi

    if hash sqlcmd 2>/dev/null; then
        if ! code --list-extensions | grep -q "ms-mssql.mssql"; then
            code --install-extension ms-mssql.mssql
        fi
    fi

    if ! code --list-extensions | grep -q "ms-vscode.csharp"; then
        code --install-extension ms-vscode.csharp
    fi

    if ! code --list-extensions | grep -q "ms-vscode-remote.remote-wsl"; then
        code --install-extension ms-vscode-remote.remote-wsl
    fi

    if ! code --list-extensions | grep -q "ra-lsp"; then
        code --install-extension ra-lsp-0.0.1.vsix
    fi

    # if ! code --list-extensions | grep -q "slevesque.vscode-hexdump"; then
    #     code --install-extension slevesque.vscode-hexdump
    # fi

    if ! code --list-extensions | grep -q "vscodevim.vim"; then
        code --install-extension vscodevim.vim
    fi
fi
