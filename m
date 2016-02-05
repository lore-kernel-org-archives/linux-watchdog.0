Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0113.outbound.protection.outlook.com ([157.56.110.113]:27488
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755815AbcBEVNx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 16:13:53 -0500
Date: Fri, 5 Feb 2016 15:13:52 -0600
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: Josh Cartwright <joshc@ni.com>
CC: <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC 3/4] watchdog: ni9x3x_wdt: Add timeout_action sysfs
 attribute
Message-ID: <20160205211352.GC11390@senary>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-3-git-send-email-kyle.roeschley@ni.com>
 <20160205200803.GC9579@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20160205200803.GC9579@jcartwri.amer.corp.natinst.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 05, 2016 at 02:08:03PM -0600, Josh Cartwright wrote:
> On Thu, Feb 04, 2016 at 07:28:02PM -0600, Kyle Roeschley wrote:
> [..]
> > diff --git a/drivers/watchdog/ni9x3x_wdt.c b/drivers/watchdog/ni9x3x_wdt.c
> > index 13f5c10..1fce4d0 100644
> > --- a/drivers/watchdog/ni9x3x_wdt.c
> > +++ b/drivers/watchdog/ni9x3x_wdt.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > +#include <linux/sysfs.h>
> >  #include <linux/watchdog.h>
> >  
> >  #define NIWD_CONTROL	0x01
> > @@ -28,6 +29,7 @@
> >  #define NIWD_IO_SIZE	0x08
> >  
> >  #define NIWD_CONTROL_MODE		0x80
> > +#define NIWD_CONTROL_PROC_INTERRUPT	0x40
> >  #define NIWD_CONTROL_PROC_RESET		0x20
> >  #define NIWD_CONTROL_PET		0x10
> >  #define NIWD_CONTROL_RUNNING		0x08
> > @@ -48,6 +50,7 @@ struct ni9x3x_wdt {
> >  	struct acpi_device *acpi_device;
> >  	u16 io_base;
> >  	u16 io_size;
> > +	u32 irq;
> 
> Interrupts have type 'int'.
> 
> >  	spinlock_t lock;
> >  	struct watchdog_device wdog;
> >  };
> > @@ -101,6 +104,34 @@ static unsigned int ni9x3x_wdt_wdd_get_timeleft(struct watchdog_device *wdd)
> >  	return (unsigned int)((counter * (u64)NIWD_PERIOD_NS) / 1000000000);
> >  }
> >  
> > +static irqreturn_t ni9x3x_wdt_irq_handler(int irq, void *data)
> > +{
> > +	struct ni9x3x_wdt *wdt = data;
> > +	irqreturn_t ret = IRQ_NONE;
> > +	u8 control;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&wdt->lock, flags);
> 
> Interrupts are disabled already, so the _irqsave()/_irqrestore() is
> unnecessary.
> 
> > +
> > +	control = inb(wdt->io_base + NIWD_CONTROL);
> > +
> > +	if (!(NIWD_CONTROL_ALARM & control)) {
> > +		dev_err(&wdt->acpi_device->dev,
> > +			"Spurious watchdog interrupt, 0x%02X\n", control);
> 
> No need to print anything here, just return IRQ_NONE.  The irq core will
> print a much better (and rate-limited) error when/if this occurs.
> 
> > +		goto out_unlock;
> > +	}
> > +
> > +	/* Acknowledge the interrupt. */
> > +	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
> > +
> > +	ret = IRQ_HANDLED;
> > +
> > +out_unlock:
> > +	spin_unlock_irqrestore(&wdt->lock, flags);
> > +
> > +	return ret;
> > +}
> 
> This is...strange.  You're allowing a user to enable an interrupt reset
> action, but...there is no way that a user can actually _do_ anything
> when that action occurs.
> 
> I'm reminded of one of these:
> 
>   https://www.youtube.com/watch?v=aqAUmgE3WyM
> 
> (The only reason I can think of where this would be a legitimate thing
> to do was if we were relying on the watchdog interrupt to bring the CPU
> out of a low power state...but AFAIK that's not something we do).
> 
>   Josh

This is another reason (that I forgot to mention) for this being an RFC.
Ideally we'd poll or select the /dev/watchdogN file to wait on interrupt, but
this isn't supported by the watchdog core. My next instinct would be to have an
sysfs attribute named interrupt or event which a user could read/poll/select
to look for a 1 value indicating that an interrupt has occurred. Else, maybe
polling support could be added to the core, but I don't expect it would be very
useful.

Kyle
