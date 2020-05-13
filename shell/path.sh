#-------------------------------------------------------------
# GNU TOOLS (prepend to PATH)
#-------------------------------------------------------------
if [ -z "$GNUTOOLS_PATHS" ] || [ -z "$GNUTOOLS_MANS" ]; then
  gnu_tools='coreutils gnu-bin gnu-indent gnu-sed gnu-tar gnu-which gnutls'

  for gnu_tool in $(echo $gnu_tools); do
    GNUTOOLS_PATHS+=":$HOMEBREW_PREFIX/opt/$gnu_tool/libexec/gnubin"
    GNUTOOLS_MANS+="$HOMEBREW_PREFIX/opt/$gnu_tool/libexec/gnuman:"
  done
fi

#-------------------------------------------------------------
# MANPATH
#-------------------------------------------------------------
MANPATH="$GNUTOOLS_MANS"
MANPATH+="$HOMEBREW_PREFIX/opt/erlang/lib/erlang/man:"
MANPATH+="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:"
MANPATH+="$(manpath 2>/dev/null)"
export MANPATH

#-------------------------------------------------------------
# PATH
#-------------------------------------------------------------
PATH="$HOME/.bin"
PATH+=":$HOME/.local/bin"
PATH+=":$HOMEBREW_PREFIX/opt/gettext/bin"
PATH+=$GNUTOOLS_PATHS
PATH+=":$HOME/.asdf/shims"
PATH+=":$HOME/.gem/ruby/2.6.0/bin"
PATH+=":./node_modules/.bin"         # Project-local node binaries
PATH+=":$FZF_DIR/bin"
PATH+=":$HOME/.cargo/bin"            # Rust binary path
PATH+=":$GOPATH/bin"                 # Go binary path
PATH+=":$HOMEBREW_PREFIX/heroku/bin"
PATH+=":$HOMEBREW_PREFIX/bin"
PATH+=":$HOMEBREW_PREFIX/sbin"
PATH+=":/usr/local/opt/imagemagick@6/bin"
PATH+=":/usr/local/opt/findutils/libexec/gnubin"
PATH+=":/usr/local/bin"
PATH+=":/usr/local/sbin"
PATH+=":/usr/bin"
PATH+=":/usr/sbin"
PATH+=":/bin"
PATH+=":/sbin"
PATH+=":/opt/X11/bin"                # added by OSX
PATH+=":$HOME/Library/Android/sdk/tools/bin" # Android SDK CLT binaries
PATH+=":$HOMEBREW_PREFIX/share/git-core/contrib/diff-highlight"
PATH+=":/Library/TeX/texbin"
export PATH
