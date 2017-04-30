# rngtools-arm-asuswrt

### HOWTO: Compile Rng-tools for AsusWRT firmware
```
cd
git clone https://github.com/blackfuel/rngtools-arm-asuswrt.git
cd rngtools-arm-asuswrt
./rngtools.sh
```

### Usage: rngd
```
Usage: rngd [OPTION...]
Check and feed random data from hardware device to kernel entropy pool.

  -b, --background           Become a daemon (default)
  -d, --no-drng=1|0          Do not use drng as a source of random number input
                             (default: 0)
  -f, --foreground           Do not fork and become a daemon
  -n, --no-tpm=1|0           Do not use tpm as a source of random number input
                             (default: 0)
  -o, --random-device=file   Kernel device used for random number output
                             (default: /dev/random)
  -p, --pid-file=file        File used for recording daemon PID, and multiple
                             exclusion (default: /var/run/rngd.pid)
  -q, --quiet                Suppress error messages
  -r, --rng-device=file      Kernel device used for random number input
                             (default: /dev/hwrng)
  -s, --random-step=nnn      Number of bytes written to random-device at a time
                             (default: 64)
  -v, --verbose              Report available entropy sources
  -W, --fill-watermark=n     Do not stop feeding entropy to random-device until
                             at least n bits of entropy are available in the
                             pool (default: 2048), 0 <= n <= 4096
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

Report bugs to Jeff Garzik <jgarzik@pobox.com>.
```

### Usage: rngtest
```
Usage: rngtest [OPTION...]
Check the randomness of data using FIPS 140-2 RNG tests.

  -b, --blockstats=n         Dump statistics every n blocks (default: 0)
  -c, --blockcount=n         Exit after processing n blocks (default: 0)
  -p, --pipe                 Enable pipe mode: work silently, and echo to
                             stdout all good blocks
  -t, --timedstats=n         Dump statistics every n secods (default: 0)
  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Mandatory or optional arguments to long options are also mandatory or optional
for any corresponding short options.

FIPS tests operate on 20000-bit blocks.  Data is read from stdin.  Statistics
and messages are sent to stderr.

If no errors happen nor any blocks fail the FIPS tests, the program will return
exit status 0.  If any blocks fail the tests, the exit status will be 1.

Report bugs to Jeff Garzik <jgarzik@pobox.com>.
```

### Links
[Manpage for rngd](https://github.com/blackfuel/rngtools-arm-asuswrt/blob/master/rngd.md)  
[Manpage for rngtest](https://github.com/blackfuel/rngtools-arm-asuswrt/blob/master/rngtest.md)




