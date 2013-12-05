Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Thu, 5 Dec 2013 00:15:11 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] sc1200_wdt: Fix oops
Message-ID: <20131205001511.6c8e9f60@alan.etchedpixels.co.uk>
In-Reply-To: <20131204163118.GA1299@roeck-us.net>
References: <20131204153135.32175.35874.stgit@alan.etchedpixels.co.uk>
	<20131204163118.GA1299@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, 4 Dec 2013 08:31:18 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Dec 04, 2013 at 03:31:52PM +0000, Alan wrote:
> > If loaded with isapnp = 0 the driver explodes. This is catching
> > people out now and then. What should happen in the working case is
> > a complete mystery and the code appears terminally confused, but we
> 
> Looks like it uses the pnp infrastructure only to auto-detect the
> "io" address, and assumes that pnp_register_driver() calls the
> pnp probe function immediately. Afterwards it unregisters and
> works (or is supposed to work) outside the pnp subsystem. Brr.
> 
> > can at least make the error path work properly.
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > Partially-Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=53991
> 
> Actually, I think it fully resolves it, because the other part (sc520 driver
> not working on SC1100 CPU) isn't a bug. It isn't working on an ARM or PPC CPU
> either, nor on any Intel CPU.

As far as I can tell the fact it fails on the sc1100 is also a bug - but
the mess of idefs around PNP is impossible to figure out without some
actual docs, time and real hardware.

Alan
