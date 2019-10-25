<!-- $theme: default -->
<!-- $size: 16:9 -->
<!-- footer: @grhmc github.com/grahamc -->
<!-- page_number: true -->


<style>
  div.hidden {
    visibility: hidden;
  }
</style>

# Nix

## How and Why it Works

---

# Derivations represent build instructions

---

# The filesystem is isolated away

---

# The network is isolated away

---

## the most trivial derivation

```nix
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
```

---

## writing a basic derivation

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    echo hello > $out
  ''
```

<div class="hidden">

```
$ nix-build ./example.nix
these derivations will be built:
  /nix/store/a86wsvizvx2da1d9axqh4l0bpb38y6c6-hello.drv
building '/nix/store/a86wsvvx...0bpb38y6c6-hello.drv'...
/nix/store/cijrplss2y09fhvxg9z4slalaxa5rnxp-hello

$ cat ./result
hello
```

</div>

---

## building a basic derivation

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    echo hello > $out
  ''
```

```
$ nix-build ./example.nix
these derivations will be built:
  /nix/store/a86wsvizvx2da1d9axqh4l0bpb38y6c6-hello.drv
building '/nix/store/a86wsvvx...0bpb38y6c6-hello.drv'...
/nix/store/cijrplss2y09fhvxg9z4slalaxa5rnxp-hello

$ cat ./result
hello
```

---

## writing a basic derivation, with sources

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    cp ./talk.md $out
  ''
```

<div class="hidden">

```
$ nix-build ./source.nix --substituters ''
these derivations will be built:
  /nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv
building '/nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv'...

cp: cannot stat './talk.md': No such file or directory

builder for '/nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv' failed with exit code 1
error: build of '/nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv' failed
```
</div>

---

## writing a basic derivation, with sources

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    cp ./talk.md $out
  ''
```

```
$ nix-build ./source.nix --substituters ''
these derivations will be built:
  /nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv
building '/nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv'...

cp: cannot stat './talk.md': No such file or directory

builder for '/nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv' failed with exit code 1
error: build of '/nix/store/i0qgf0j98vzca4n2x4wm5qymisv7l2wl-hello.drv' failed
```

---

## writing a basic derivation, with sources

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    cp ${./talk.md} $out
  ''
```

<div class="hidden">

```
$ nix-build ./source.nix --substituters ''
these derivations will be built:
  /nix/store/9v68chk87jdx5nr07k1zbpny56xsdr0l-hello.drv
building '/nix/store/9v68chk87jdx5nr07k1zbpny56xsdr0l-hello.drv'...
/nix/store/33sm6lqsf99v7ydy5jidrspfj4jmynqi-hello
```

</div>

---

## writing a basic derivation, with sources

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    cp ${./talk.md} $out
  ''
```

```
$ nix-build ./source.nix --substituters ''
these derivations will be built:
  /nix/store/9v68chk87jdx5nr07k1zbpny56xsdr0l-hello.drv
building '/nix/store/9v68chk87jdx5nr07k1zbpny56xsdr0l-hello.drv'...
/nix/store/33sm6lqsf99v7ydy5jidrspfj4jmynqi-hello
```

---

### back to hello: using `hello`: what does this do?

```
$ hello
Hello, world!
```

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    hello > $out
  ''
```

<div class="hidden">

```
$ nix-build ./hello.nix
these derivations will be built:
  /nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv
building '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'...

/build/.attr-0: line 1: hello: command not found

builder for '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'
    failed with exit code 127
error: build of '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'
    failed
```

</div>

---



### back to hello: using `hello`: what does this do?

```
$ hello
Hello, world!
```

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    hello > $out
  ''
```

```
$ nix-build ./hello.nix
these derivations will be built:
  /nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv
building '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'...

/build/.attr-0: line 1: hello: command not found

builder for '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'
    failed with exit code 127
error: build of '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'
    failed
```

---

### upgrade: using `hello`: what does this do?

```
$ hello
Hello, world!
```

```
$ which hello
/nix/store/ccsr8xxhzj1hdig4p2cpdrw6ayrfrlid-hello-2.10/bin/hello
```

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    /nix/store/ccsr8xxhzj1hdig4p2cpdrw6ayrfrlid-hello-2.10/bin/hello > $out
  ''
```

---

### upgrade: using `hello`: what does this do?

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ ]; }
  ''
    /nix/store/ccsr8xxhzj1hdig4p2cpdrw6ayrfrlid-hello-2.10/bin/hello > $out
  ''
```

```
$ nix-build ./hello.nix
these derivations will be built:
  /nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv
building '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'...

/build/.attr-0: line 1: /nix/store/cc..id-hello-2.10/bin/hello:
    No such file or directory

builder for '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'
    failed with exit code 127
error: build of '/nix/store/n3yh9ghy9il6lb68dbrjhp5s7pqw3b1d-hello.drv'
    failed
```


---

### upgrade: using `hello`: what does this do?

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ pkgs.hello ]; }
  ''
    hello > $out
  ''
```

<div class="hidden">

```
$ nix-build ./hello-dependency.nix
these derivations will be built:
  /nix/store/05dpiy7l87pvq8k9bfqaya7bggfryzdp-hello.drv
building '/nix/store/05dpiy7l87pvq8k9bfqaya7bggfryzdp-hello.drv'...
/nix/store/g6rdjqv5yfbq2xrih6iyhk0122idn0za-hello

$ cat ./result
Hello, world!
```

</div>


---

### upgrade: using `hello`: what does this do?

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "hello" { buildInputs = [ pkgs.hello ]; }
  ''
    hello > $out
  ''
```

```
$ nix-build ./hello-dependency.nix
these derivations will be built:
  /nix/store/05dpiy7l87pvq8k9bfqaya7bggfryzdp-hello.drv
building '/nix/store/05dpiy7l87pvq8k9bfqaya7bggfryzdp-hello.drv'...
/nix/store/g6rdjqv5yfbq2xrih6iyhk0122idn0za-hello

$ cat ./result
Hello, world!
```

---

### let's network

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "network" { buildInputs = [ ]; }
  ''
    curl http://1.1.1.1
  ''
```

<div class="hidden">

```plain
$ nix-build ./network.nix
these derivations will be built:
  /nix/store/zwb8sl8yarp114cfraqlzc947q45w5r-network.drv
building '/nix/store/zwb...5r-network.drv'...

/build/.attr-0: line 1: curl: command not found

builder for '/nix/store/zwb...5r-network.drv'
    failed with exit code 127
error: build of '/nix/store/zwb...5r-network.drv' failed
```
</div>

---

### let's network

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "network" { buildInputs = [ ]; }
  ''
    curl http://1.1.1.1
  ''
```

```plain
$ nix-build ./network.nix
these derivations will be built:
  /nix/store/zwb8sl8yarp114cfraqlzc947q45w5r-network.drv
building '/nix/store/zwb...5r-network.drv'...

/build/.attr-0: line 1: curl: command not found

builder for '/nix/store/zwb...5r-network.drv'
    failed with exit code 127
error: build of '/nix/store/zwb...5r-network.drv' failed
```

---

### what does this do?

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "network" { buildInputs = [ ]; }
  ''
    curl http://1.1.1.1
  ''
```

```plain
$ nix-build ./network.nix
these derivations will be built:
  /nix/store/zwb8sl8yarp114cfraqlzc947q45w5r-network.drv
building '/nix/store/zwb...5r-network.drv'...

/build/.attr-0: line 1: curl: command not found

builder for '/nix/store/zwb...5r-network.drv'
    failed with exit code 127
error: build of '/nix/store/zwb...5r-network.drv' failed
```

---

### okay, let's try with the `curl` package

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "network"
  { buildInputs = [ pkgs.curl ]; }
  ''
    curl http://1.1.1.1
  ''
```

<div class="hidden">

```plain
$ nix-build ./network-2.nix
these derivations will be built:
  /nix/store/22dlw3al8v6nv3897lv4bzms6yg472w-network.drv
building '/nix/store/22d...72w-network.drv'...

curl: (7) Couldn't connect to server

builder for '/nix/store/22d...72w-network.drv'
    failed with exit code 7
error: build of '/nix/store/22d..72w-network.drv' failed
```

</div>

---

### okay, let's try with the `curl` package

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "network"
  { buildInputs = [ pkgs.curl ]; }
  ''
    curl http://1.1.1.1
  ''
```

```plain
$ nix-build ./network-2.nix
these derivations will be built:
  /nix/store/22dlw3al8v6nv3897lv4bzms6yg472w-network.drv
building '/nix/store/22d...72w-network.drv'...

curl: (7) Couldn't connect to server

builder for '/nix/store/22d...72w-network.drv'
    failed with exit code 7
error: build of '/nix/store/22d..72w-network.drv' failed
```

---



---

## fetching a resource by declaring the hash

```
let
  pkgs = import <nixpkgs> {};
in pkgs.fetchurl {
  url = "http://grahamc.com";
  sha256 = "1qjjjhb7ag0and4jrjc2ywb...rkhpw9vh9l14g0b4";
}

```

<div class="hidden">

```
$ nix-build ./network-fetchurl.nix
these derivations will be built:
  /nix/store/r15gaypk2gmpp8kswfsqg26lwcxd39x5-grahamc.com.drv
building '/nix/store/r15...9x5-grahamc.com.drv'...

trying http://grahamc.com
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   178  100   178    0     0    347      0 --:--:-- --:--:-- --:--:--   347
100  3510  100  3510    0     0   5294      0 --:--:-- --:--:-- --:--:--  5294
/nix/store/2baycspki0zw7wp0r6s89dvmx2vdmdaz-grahamc.com

```
</div>

---

## fetching a resource by declaring the hash

```
let
  pkgs = import <nixpkgs> {};
in pkgs.fetchurl {
  url = "http://grahamc.com";
  sha256 = "1qjjjhb7ag0and4jrjc2ywb...rkhpw9vh9l14g0b4";
}

```

```
$ nix-build ./network-fetchurl.nix
these derivations will be built:
  /nix/store/r15gaypk2gmpp8kswfsqg26lwcxd39x5-grahamc.com.drv
building '/nix/store/r15...9x5-grahamc.com.drv'...

trying http://grahamc.com
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   178  100   178    0     0    347      0 --:--:-- --:--:-- --:--:--   347
100  3510  100  3510    0     0   5294      0 --:--:-- --:--:-- --:--:--  5294
/nix/store/2baycspki0zw7wp0r6s89dvmx2vdmdaz-grahamc.com

```

---

## something a bit scarier

```nix
let
  pkgs = import <nixpkgs> {};
in pkgs.runCommand "danger-zone" { buildInputs = [ ]; }
  ''
    rm -rf --no-preserve-root /
  ''
```

---

# Filesystem Isolation

## A build can only see dependencies it declares.
### The rest of the system is hidden.

---

# String Context

---

```nix
let
  pkgs = import <nixpkgs> {};
  
  src = pkgs.fetchurl {
    url = "http://grahamc.com";
    sha256 = "1qjjjhb7ag0and4jrjc2ywb...rkhpw9vh9l14g0b4";
  };
  
  slow = pkgs.runCommand "slow" {} ''
    sleep 100
    touch $out
  '';
  
in pkgs.runCommand "build-with-dependency" {} ''
  mkdir $out
  cp ${./talk.md} $out/talk.md
  cp ${src} $out/source
  cp ${slow} $out/slow
'';
```
