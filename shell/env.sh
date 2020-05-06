#!/usr/bin/env bash

uname_out="$(uname -s)"
case "${uname_out}" in
  Linux*)  machine=linux;;
  Darwin*) machine=mac;;
  CYGWIN*) machine=windows;;
  *)       machine="UNKNOWN:${uname_out}"
esac
export MACHINE="$machine"

#-------------------------------------------------------------
# Set HOMEBREW_PREFIX
#-------------------------------------------------------------
if [[ "$MACHINE" == "linux" ]]; then
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_PREFIX

#-------------------------------------------------------------
# Emacs
#-------------------------------------------------------------
if [ -n "$INSIDE_EMACS" ]; then
  export EDITOR=emacs
fi

#-------------------------------------------------------------
# GPG
#-------------------------------------------------------------
GPG_TTY=$(tty)
export GPG_TTY

#-------------------------------------------------------------
# Python
#-------------------------------------------------------------
export PYTHONDONTWRITEBYTECODE=1

# http://vi.stackexchange.com/a/7654
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

#-------------------------------------------------------------
# Elm
#-------------------------------------------------------------
export ELM_HOME="$HOME/.elm"

#-------------------------------------------------------------
# Erlang
#-------------------------------------------------------------
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_BUILD_DOCS=no
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac --disable-hipe"

#-------------------------------------------------------------
# Anaconda
# (symlink to asdf install directory)
#-------------------------------------------------------------
export ANACONDA_PREFIX="$HOME/.anaconda"
export ANACONDA_HOME="$HOME/.anaconda"

#-------------------------------------------------------------
# Go
#-------------------------------------------------------------
export GO_VERSION_DEFAULT=1.14.1
export GOROOT=~/.asdf/installs/golang/${GO_VERSION:-$GO_VERSION_DEFAULT}/go/
export GOPATH=~/.go

#-------------------------------------------------------------
# Use Ripgrep for FZF instead of find
#-------------------------------------------------------------
export FZF_DIR="$HOMEBREW_PREFIX/opt/fzf"
export FZF_DEFAULT_COMMAND='rg --files-with-matches "" 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--no-multi --tiebreak=index --bind='ctrl-f:preview-down' --bind='ctrl-b:preview-up'"

#-------------------------------------------------------------
# Android
#-------------------------------------------------------------
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export ANDROID_SDK="$ANDROID_SDK_ROOT"
export ANDROID_HOME="$ANDROID_SDK_ROOT"

#-------------------------------------------------------------
# JAVA
#-------------------------------------------------------------
JAVA_VERSION=adopt-openjdk-13.0.2+8
JAVA_HOME="$HOME/.asdf/installs/java/${JAVA_VERSION}"
export JAVA_HOME

if [[ "$MACHINE" == "mac" ]]; then
  launchctl setenv JAVA_HOME "$JAVA_HOME"
fi

#-------------------------------------------------------------
# DOCKER
#-------------------------------------------------------------
export DOCKER_HIDE_LEGACY_COMMANDS=true

#-------------------------------------------------------------
# GTAGS
#-------------------------------------------------------------
# Use default, which globalrc configures to fall back to pygments
export GTAGSLABEL=default
export GTAGSCONF=~/.globalrc

#-------------------------------------------------------------
# Compilation flags
#-------------------------------------------------------------
export CC=gcc
export CXX=g++

LDFLAGS="-L/usr/local/opt/gettext/lib"
LDFLAGS+=" -L/usr/local/opt/libffi/lib"
LDFLAGS+=" -L/usr/local/opt/libxml2/lib"
LDFLAGS+=" -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
LDFLAGS+=" -L/usr/local/opt/ncurses/lib"
LDFLAGS+=" -L/usr/local/opt/openssl/lib"
LDFLAGS+=" -L/usr/local/opt/icu4c/lib"
LDFLAGS+=" -L/usr/local/opt/readline/lib"
LDFLAGS+=" -L/usr/local/opt/zlib/lib"
LDFLAGS+=" -L/usr/local/opt/imagemagick@6/lib"
export LDFLAGS

CPPFLAGS="-I/usr/local/opt/gettext/include"
CPPFLAGS+=" -I/usr/local/opt/libxml2/include"
CPPFLAGS+=" -I/usr/local/opt/llvm/include"
CPPFLAGS+=" -I/usr/local/opt/ncurses/include"
CPPFLAGS+=" -I/usr/local/opt/openssl/include"
CPPFLAGS+=" -I/usr/local/opt/icu4c/include"
CPPFLAGS+=" -I/usr/local/opt/readline/include"
CPPFLAGS+=" -I/usr/local/opt/zlib/include"
CPPFLAGS+=" -I/usr/local/opt/imagemagick@6/include"
export CPPFLAGS

PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/libxml2/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/ncurses/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/openssl/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/icu4c/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/readline/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/zlib/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/imagemagick@6/lib/pkgconfig"
PKG_CONFIG_PATH+=":/usr/local/opt/imagemagick/lib/pkgconfig"
export PKG_CONFIG_PATH

RUBY_CONFIGURE_OPTS="--with-readline-dir=/usr/local/opt/readline"
RUBY_CONFIGURE_OPTS+=" --with-openssl-dir=/usr/local/opt/openssl"
RUBY_CONFIGURE_OPTS+=" --enable-shared"
RUBY_CONFIGURE_OPTS+=" --disable-libedit"
export RUBY_CONFIGURE_OPTS

export CFLAGS="-O3 -g -I/usr/local/opt/openssl/include"
export ARCHFLAGS="-arch x86_64"
export RUBY_CFLAGS="-march=native -Os"
export RUBY_GC_MALLOC_LIMIT=60000000
export RUBY_GC_HEAP_FREE_SLOTS=200000

#-------------------------------------------------------------
# Spring: Enable for parallel_tests
#-------------------------------------------------------------
export DISABLE_SPRING=0
