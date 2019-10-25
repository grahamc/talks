import <nixpkgs> {
  overlays = [
    (self: super: {
      hello-example = self.hello;
    })
  ];
}
