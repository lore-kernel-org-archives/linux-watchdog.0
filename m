Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34807 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbcBVOt6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 09:49:58 -0500
Received: by mail-ig0-f174.google.com with SMTP id g6so87998679igt.1
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 06:49:57 -0800 (PST)
Subject: Re: [PATCH 0/2] arm: lpc32xx: restart: add support for soft reset
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: Joachim Eastwood <manabian@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Roland Stigge <stigge@antcom.de>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-watchdog@vger.kernel.org
In-Reply-To: <CAGhQ9Vwr6H0YjRfaiBNaUrm8rHEVjh-NQbPZMdOZh2cJnMXmBA@mail.gmail.com>
References: <002701d16b5b$f78c7b70$e6a57250$@gmail.com>
	 <CAGhQ9Vwr6H0YjRfaiBNaUrm8rHEVjh-NQbPZMdOZh2cJnMXmBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Feb 2016 09:49:54 -0500
Message-ID: <1456152594.28296.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 2016-02-20 at 23:19 +0100, Joachim Eastwood wrote:
> On 19 February 2016 at 22:24, Sylvain Lemieux <slemieux.tyco@gmail.com> wrote:
> > Hi Joachim,
> >
> >> From: Joachim Eastwood [mailto:manabian@gmail.com]
> >> Sent: 18-Feb-16 5:08 PM
> >> To: slemieux.tyco@gmail.com
> >>
> >> Hi Sylvain,
> >>
> >> On 18 February 2016 at 22:35,  <slemieux.tyco@gmail.com> wrote:
> >> > From: Sylvain Lemieux <slemieux@tycoint.com>
> >> >
> >> > The LPC32xx provide the capability to perform a soft or hard reset;
> >> > a soft reset will no reset the external peripheral
> >> > (i.e. RESOUT_N output not asserted).
> >> >
> >> > The default behavior (i.e. hard reset) remain unchanged.
> >> >
> >> > Sylvain Lemieux (2):
> >> >   arm: lpc32xx: restart: add support for soft reset
> >> >   arm: lpc32xx: restart: support "cmd" from userspace
> >> >
> >> >  arch/arm/mach-lpc32xx/common.c | 26 +++++++++++++++++++++++---
> >> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >>
> >> Instead of adding more code to mach-lpc32xx could this code be moved
> >> to the watchdog driver (pnx4008_wdt.c) ?
> >> See register_restart_handler() and how it's used in other watchdog drivers.
> >>
> >> Then maybe the restart hook in phy3250.c could be removed all together.
> >
> > Thanks for the feedback;
> >
> > It is possible to remove the "lpc23xx_restart" function from "mach-lpc32xx"
> > and add the functionality to the pnx4008 watchdog driver.
> > The restart hook in phy3250.c can be remove.
> >
> > I will submit a new revision of the patch on Monday.
> >
> >>
> > I need to add a new functionality to the pnx4008 driver to
> > keep the driver disable and only provide the restart hook.
> 
> Why do you need to disable the driver?
> The watchdog is not enabled unless you don't explicitly do so, ie
> opening it and starting it.
> 
On our custom lpc32xx board, we are using an external gpio watchdog.
Prior to this change the pnx4008 driver was disable in the
device tree for our board.

I was trying to only have the restart functionality selected in
the pnx4008 driver and not disable the register operation; this will
provide a single watchdog under "/dev", in our case, the gpio watchdog.

I will work with the "linux-watchdog" maintainer to find a standard
way to provide an option for using a watchdog driver for the
restart capability only (i.e. do not register the driver).

> > I am planning to add the functionality using a module parameter;
> > this is the way the pnx833x & s3c2410 driver are doing it.
> 
> You should normally try to avoid module parameters if you can.
> 
> 
> > Do you have any feedback before a submit a patch for this change.
> 
> Take a look at:
> 2165bf524da5f5e496d - "watchdog: core: add restart handler support"

Thanks for pointing this.

I will submit a new revision of the patch later today.
> 
> Note that this will not give you the reboot_mode parameter. But maybe
> that could be added to the restart-callback function.
> 
> 
> regards,
> Joachim Eastwood


