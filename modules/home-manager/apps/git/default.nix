{ ... }:

# Git config is owned by Home-Manager (programs.git). Raw helper scripts
# (.git_func, gitemojis hooks) stay symlinked from symlinks.nix.
# See ../../../../docs/packaging.md for the config-source policy.
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user.name = "MorganKryze";
      user.email = "103436411+MorganKryze@users.noreply.github.com";

      core.editor = "code --wait";
      pull.rebase = true;
    };

    includes = [
      {
        condition = "gitdir:~/Documents/00-local/01-git/08-forgejo/";
        contents.user = {
          name = "morgan";
          email = "morgan@noreply.git.libresoftware.cloud";
        };
      }
    ];
  };
}
