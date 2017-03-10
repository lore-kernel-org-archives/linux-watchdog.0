Return-path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1489163292.20145.194.camel@linux.intel.com>
Subject: Re: [PATCH v1] watchdog: intel-mid_wdt: Keep watchdog running
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Fri, 10 Mar 2017 18:28:12 +0200
In-Reply-To: <20170308191652.GB4486@roeck-us.net>
References: <20170308111029.60744-1-andriy.shevchenko@linux.intel.com>
	 <846f18ec-e41c-364e-c867-fa6b3dbc18d4@roeck-us.net>
	 <1488985870.20145.137.camel@linux.intel.com>
	 <20170308191652.GB4486@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, 2017-03-08 at 11:16 -0800, Guenter Roeck wrote:
> On Wed, Mar 08, 2017 at 05:11:10PM +0200, Andy Shevchenko wrote:
> > On Wed, 2017-03-08 at 06:21 -0800, Guenter Roeck wrote:
> > > On 03/08/2017 03:10 AM, Andy Shevchenko wrote:
> > > > Firmware followed by bootloader leaves watchdog running.

> > > Is that always the case ?
> > 
> > Yes if no-one patched boot loader specifically to avoid this.
> > 
> > >  If not, does it hurt if the watchdog is pinged
> > > while not active ?
> > > 
> > > Also, this assumes that its default timeout is in the default
> > > range
> > > configured by the driver, ie not (much) lower than 30 seconds.
> > 
> > Correct. It is hard coded in SCU firmware (60 seconds IIRC). U-Boot
> > for
> > now doesn't change it.
> > 
> > > Not objecting, but it would help to have comments in the code
> > > explaining
> > > the context in some more detail.
> > 
> > Last time you were not satisfied by the line which stops the running
> > watchdog [1]. I found a way how to keep it running gracefully, which
> > I
> > proposed to do at that time (assuming boot loader doesn't stop it)
> > [2].
> > 
> > I'm confused now what is preferable way to do the things?
> > 
> 
> The suggested patch is ok. I was just asking for additional comments,
> along the line of 1) the SCU firmware sets the timeout to 60s, the
> default
> timeout of 30s is therefore safe, and 2) that the watchdog is by
> default
> enabled in the SCU firmware (and, if appropriate, that it doesn't get
> a
> hiccup if it is pinged if it should have been disabled for some
> unspecified
> / unknown reason).

Okay, I will send v2 with additional comments.

Thanks for clarifying!

P.S. It looks like we have to add some lines in the driver for U-Boot to
make developer pay attention to the potential asynchronization.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
