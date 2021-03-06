<body>

<h1 align="center">RNGD</h1>

<a href="#NAME">NAME</a><br>
<a href="#SYNOPSIS">SYNOPSIS</a><br>
<a href="#DESCRIPTION">DESCRIPTION</a><br>
<a href="#OPTIONS">OPTIONS</a><br>
<a href="#AUTHORS">AUTHORS</a><br>

<hr>


<h2>NAME
<a name="NAME"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">rngd &minus;
Check and feed random data from hardware device to kernel
random device</p>

<h2>SYNOPSIS
<a name="SYNOPSIS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>rngd</b>
[<b>&minus;b</b>, <b>&minus;&minus;background</b>]
[<b>&minus;f</b>, <b>&minus;&minus;foreground</b>]
[<b>&minus;o</b>,
<b>&minus;&minus;random-device=</b><i>file</i>]
[<b>&minus;p</b>, <b>&minus;&minus;pid-file=</b><i>file</i>]
[<b>&minus;r</b>,
<b>&minus;&minus;rng-device=</b><i>file</i>]
[<b>&minus;s</b>,
<b>&minus;&minus;random-step=</b><i>nnn</i>]
[<b>&minus;W</b>,
<b>&minus;&minus;fill-watermark=</b><i>nnn</i>]
[<b>&minus;d</b>, <b>&minus;&minus;no-drng=</b><i>1|0</i>]
[<b>&minus;n</b>, <b>&minus;&minus;no-tpm=</b><i>1|0</i>]
[<b>&minus;q</b>, <b>&minus;&minus;quiet</b>]
[<b>&minus;v</b>, <b>&minus;&minus;verbose</b>]
[<b>&minus;?</b>, <b>&minus;&minus;help</b>]
[<b>&minus;V</b>, <b>&minus;&minus;version</b>]</p>

<h2>DESCRIPTION
<a name="DESCRIPTION"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">This daemon
feeds data from a random number generator to the
kernel&rsquo;s random number entropy pool, after first
checking the data to ensure that it is properly random.</p>

<p style="margin-left:11%; margin-top: 1em">The
<b>&minus;f</b> or <b>&minus;&minus;foreground</b> options
can be used to tell <b>rngd</b> to avoid forking on startup.
This is typically used for debugging. The <b>&minus;b</b> or
<b>&minus;&minus;background</b> options, which fork and put
<b>rngd</b> into the background automatically, are the
default.</p>

<p style="margin-left:11%; margin-top: 1em">The
<b>&minus;r</b> or <b>&minus;&minus;rng-device</b> options
can be used to select an alternate source of input, besides
the default /dev/hwrandom. The <b>&minus;o</b> or
<b>&minus;&minus;random-device</b> options can be used to
select an alternate entropy output device, besides the
default /dev/random. Note that this device must support the
Linux kernel /dev/random ioctl API.</p>

<h2>OPTIONS
<a name="OPTIONS"></a>
</h2>



<p style="margin-left:11%; margin-top: 1em"><b>&minus;b</b>,
<b>&minus;&minus;background</b></p>

<p style="margin-left:22%;">Become a daemon (default)</p>

<p style="margin-left:11%;"><b>&minus;f</b>,
<b>&minus;&minus;foreground</b></p>

<p style="margin-left:22%;">Do not fork and become a
daemon</p>

<p style="margin-left:11%;"><b>&minus;p</b> <i>file</i>,
<b>&minus;&minus;pid-file=</b><i>file</i></p>

<p style="margin-left:22%;">File used for recording daemon
PID, and multiple exclusion (default: /var/run/rngd.pid)</p>

<p style="margin-left:11%;"><b>&minus;o</b> <i>file</i>,
<b>&minus;&minus;random-device=</b><i>file</i></p>

<p style="margin-left:22%;">Kernel device used for random
number output (default: /dev/random)</p>

<p style="margin-left:11%;"><b>&minus;r</b> <i>file</i>,
<b>&minus;&minus;rng-device=</b><i>file</i></p>

<p style="margin-left:22%;">Kernel device used for random
number input (default: /dev/hwrandom)</p>

<p style="margin-left:11%;"><b>&minus;s</b> <i>nnn</i>,
<b>&minus;&minus;random-step=</b><i>nnn</i></p>

<p style="margin-left:22%;">Number of bytes written to
random-device at a time (default: 64)</p>

<p style="margin-left:11%;"><b>&minus;W</b> <i>n</i>,
<b>&minus;&minus;fill&minus;watermark=</b><i>nnn</i></p>

<p style="margin-left:22%;">Once we start doing it, feed
entropy to <i>random-device</i> until at least
<i>fill-watermark</i> bits of entropy are available in its
entropy pool (default: 2048). Setting this too high will
cause <i>rngd</i> to dominate the contents of the entropy
pool. Low values will hurt system performance during entropy
starves. Do not set <i>fill-watermark</i> above the size of
the entropy pool (usually 4096 bits).</p>

<p style="margin-left:11%;"><b>&minus;d</b> <i>1|0</i>,
<b>&minus;&minus;no-drng=</b><i>1|0</i></p>

<p style="margin-left:22%;">Do not use drng as a source of
random number input (default:0)</p>

<p style="margin-left:11%;"><b>&minus;n</b> <i>1|0</i>,
<b>&minus;&minus;no-tpm=</b><i>1|0</i></p>

<p style="margin-left:22%;">Do not use tpm as a source of
random number input (default:0)</p>

<p style="margin-left:11%;"><b>&minus;q</b>,
<b>&minus;&minus;quiet</b></p>

<p style="margin-left:22%;">Suppress error messages</p>

<p style="margin-left:11%;"><b>&minus;v</b>,
<b>&minus;&minus;verbose</b></p>

<p style="margin-left:22%;">Report available entropy
sources</p>

<p style="margin-left:11%;"><b>&minus;?</b>,
<b>&minus;&minus;help</b></p>

<p style="margin-left:22%;">Give a short summary of all
program options.</p>

<p style="margin-left:11%;"><b>&minus;V</b>,
<b>&minus;&minus;version</b></p>

<p style="margin-left:22%;">Print program version</p>

<h2>AUTHORS
<a name="AUTHORS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">Philipp Rumpf
<br>
Jeff Garzik &minus; jgarzik@pobox.com <br>
Matt Sottek <br>
Brad Hill</p>
<hr>
</body>
