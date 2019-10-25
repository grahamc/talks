derivation {
  name = "hello";
  builder = "/bin/sh";
  args = [
    "-c"
    ''
      echo hello! > $out
    ''
  ];
  system = "x86_64-linux";
}
