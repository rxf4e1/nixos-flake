{ ... }:

{
  imports = [
    ./editor
    ./git
    ./security
    ./terminal
    ./utils
  ];

  modules.git.enable = true;
}
