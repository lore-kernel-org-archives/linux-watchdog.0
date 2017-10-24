Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
Date: Tue, 24 Oct 2017 10:13:22 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT
Message-ID: <20171024161322.GA17325@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
 <fdb84d723278f8f198a59f79e31d8903870fb2a0.1508539271.git.jerry.hoemann@hpe.com>
 <a9e00af0-8239-d5cb-078c-06f3388810cf@roeck-us.net>
 <20171022014102.GA28641@anatevka.americas.hpqcorp.net>
 <9a67578e-5bb1-621e-4000-d25444228783@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a67578e-5bb1-621e-4000-d25444228783@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Oct 22, 2017 at 07:55:19AM -0700, Guenter Roeck wrote:
> On 10/21/2017 06:41 PM, Jerry Hoemann wrote:
> > On Fri, Oct 20, 2017 at 07:25:20PM -0700, Guenter Roeck wrote:
> > > On 10/20/2017 03:54 PM, Jerry Hoemann wrote:
> > > > Add support for WDIOC_GETPRETIMEOUT ioctl so that user applications
> > > > can determine when the NMI should arrive.
> > > > 
> > > > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > > > ---
> > > >    drivers/watchdog/hpwdt.c | 7 +++++++
> > > >    1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > > > index 67fbe35..ef54b03 100644
> > > > --- a/drivers/watchdog/hpwdt.c
> > > > +++ b/drivers/watchdog/hpwdt.c
> > > > @@ -50,6 +50,7 @@
> > > >    static bool nowayout = WATCHDOG_NOWAYOUT;
> > > >    static char expect_release;
> > > >    static unsigned long hpwdt_is_open;
> > > > +static const int pretimeout = 9;
> > > >    static void __iomem *pci_mem_addr;		/* the PCI-memory address */
> > > >    static unsigned long __iomem *hpwdt_timer_reg;
> > > > @@ -622,6 +623,12 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
> > > >    		}
> > > >    		break;
> > > > +	case WDIOC_GETPRETIMEOUT:
> > > > +		ret = copy_to_user(argp, &pretimeout, sizeof(pretimeout));
> > > > +		if (ret)
> > > > +			ret = -EFAULT;
> > > > +		break;
> > > > +
> > > >    	case WDIOC_SETTIMEOUT:
> > > >    		ret = get_user(new_margin, p);
> > > >    		if (ret)
> > > > 
> > > 
> > > Can you please convert the driver to use the watchdog subsystem instead ?
> > > If there are still improvements needed afterwards, they can still be
> > > implemented, but we really should not make improvements which are
> > > already supported by the watchdog core.
> > 
> > I will look into converting the driver, but would like to get this
> > fix in independently.
> > 
> 
> I don't see this patch as a fix. It adds functionality. the other two patches
> are fixes and should come first.
> 
> > SuSE brought https://bugzilla.novell.com/show_bug.cgi?id=1042933
> > to my attention earlier this summer.  The submitter was trying to
> > develop a watchdog test where the ping rate was set to be the
> > Timeout/2.
> > 
> > The test worked fine until (Timeout/2) < PreTimeout.  At this point
> > an NMI would be delivered to the system before the test could refresh
> > the timer.
> > 
> Yes, but I don't think that is fixed with this patch. That would be patch 3/3, no ?
> 
> Guenter

Oh, the test program had problems too.

While a pretimeout doesn't have to crash the system they can. hpwdt most
certainly does.

So, my read of how to safely handle a wdt is this:
Let Pretimeout == 0 for wdt that don't support a pre timeout.
A user space applications needs to ensure that:

   1. Timeout > Pretimeout
   2. Ping < Timeout - Pretimeout

The test application did neither.  But since hpwdt wasn't supplying
the pretimeout, even the corrected test application would have still
failed.

Am I missing something?  How should user space daemons take into
account pretimeouts?

thanks

Jerry

> 
> > I came to the view that a watchdog that implements a pre-timeout NMI
> > where the value of the pre-timeout is not known programmatically as having
> > a defect.
> > 
> > This problem has been around a long time and we could live with it, but
> > figured while I was in fixing other problems, I'd fix this one as well.
> > 
> > Thanks
> > 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
