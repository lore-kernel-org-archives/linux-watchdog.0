Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34010 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934068AbdERQ6n (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 18 May 2017 12:58:43 -0400
Date: Thu, 18 May 2017 09:58:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: gpio: Add "keep-armed-on-close" feature
Message-ID: <20170518165840.GB30223@roeck-us.net>
References: <20170314141111.24888-1-slemieux.tyco@gmail.com>
 <db6e6689-68e5-753e-c501-bb3e74407b69@roeck-us.net>
 <1490885209.26136.14.camel@gmail.com>
 <1495112471.12459.4.camel@gmail.com>
 <9edc91e9-2878-eab5-157f-8b74bd6ed267@roeck-us.net>
 <1495125563.14469.5.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495125563.14469.5.camel@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 18, 2017 at 12:39:23PM -0400, Sylvain Lemieux wrote:
> On Thu, 2017-05-18 at 06:50 -0700, Guenter Roeck wrote:
> > On 05/18/2017 06:01 AM, Sylvain Lemieux wrote:
> > > On Thu, 2017-03-30 at 10:46 -0400, Sylvain Lemieux wrote:
> > >> Hi,
> > >>
> > >> On Thu, 2017-03-30 at 06:11 -0700, Guenter Roeck wrote:
> > >>> On 03/14/2017 07:11 AM, Sylvain Lemieux wrote:
> > >>>> From: Sylvain Lemieux <slemieux@tycoint.com>
> > >>>>
> > >>>> There is a need to allow a grace period after the watchdog software
> > >>>> client has closed. It could be used for syncing the filesystem or
> > >>>> allow graceful termination while still providing a hardware reset
> > >>>> in case the system has hung.
> > >>>>
> > >>>> The "always-running" configuration from device-tree does not provide
> > >>>> this since it will automatically keep the hardware watchdog alive as
> > >>>> soon as the software client closes (i.e. keep toggling the GPIO line
> > >>>> regardless of the state of the soft part of the watchdog).
> > >>>>
> > >>>> The "keep-armed-on-close" member in the GPIO watchdog implementation
> > >>>> indicates if an expired timeout should cause a reset.
> > >>>>
> > >>>> This patch add a new "keep-armed-on-close" device-tree configuration
> > >>>> that will keep the watchdog "armed" until the next timeout period after
> > >>>> a close. During this period, the hardware watchdog is kept alive.
> > >>>> A software watchdog client that wants to provide a grace period before
> > >>>> a hard reset can set the timeout before properly closing.
> > >>>>
> > >>>
> > >>> The description doesn't match what the code actually does, at least from
> > >>> an infrastructure perspective. The infrastructure would just keep it running.
> > >>>
> > >> I will need to send a new version with an updated description;
> > >>
> > > I will submit v3 later today or tomorrow.
> > > 
> > >> I did not update the description after this patch was rebased on-top
> > >> of the "watchdog: gpio: keepalives" patch.
> > >>
> > >>> What you are really asking for is something the infrastructure should possibly
> > >>> do by itself automatically: To keep pinging a HW watchdog after close until
> > >>> the configured (software) timeout period expires. This would be in line with
> > >>> expectations.
> > >>>
> > > Do you want me to work on a generic version for this option?
> > > 
> > 
> > I am not sure I understand the value of the current version (as implemented)
> > in the first place. It seems to be similar to "always-running", with the exception
> > that it doesn't start the watchdog immediately when loading the module. That means
> > it protects the system against hard lockups, but only if the watchdog was opened
> > at least once. That just seems odd, and you'll have to explain the benefit over
> > "always-running", and why it would make sense to have such a selective protection.
> > 
> The only difference between this implementation and the "always-running"
> is the way the close operation is handle; when "keep_armed_on_close"
> option is selected, the watchdog will generate a timeout at the end
> of the grace period.
> 

Not as currently implemented, though.

> Regarding the loading of the module, we have a separate patch, that
> is apply to the GPIO watchdog to perform an early start (same way as
> "always-running"); this is not part of this change, as this change
> only modify the behavior of the driver on close.
> 
> > Note that devicetree property changes need to be Acked by DT maintainers.
> > 
> I will cc them on the new patch.
> 

There is no need for a devicetree property; this is a bug fix, not a feature
(user space can expect a watchdog to expire only after the configured grace
period expired).

> > Having said that, if what you want is what the description says, not what is
> > implemented, I'll be happy to accept a patch to change the infrastructure
> > accordingly.
> > 
> I will look into modifying the infrastructure to add the support
> for "keep_running_on_close"; this will replace this patch.
> 
> I will need to submit my other patch for this driver to allow
> an "early start" of the watchdog
> (same as what the "always-running" is doing).
> 
Confused. If the functionality is already there, what would this patch do ?

Thanks,
Guenter
