Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35592 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947678AbcBSVYx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Feb 2016 16:24:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id g62so9705797wme.2
        for <linux-watchdog@vger.kernel.org>; Fri, 19 Feb 2016 13:24:52 -0800 (PST)
From: "Sylvain Lemieux" <slemieux.tyco@gmail.com>
To: "'Joachim  Eastwood'" <manabian@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
	"'Roland Stigge'" <stigge@antcom.de>,
	"'Vladimir Zapolskiy'" <vz@mleia.com>,
	<linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH 0/2] arm: lpc32xx: restart: add support for soft reset
Date: Fri, 19 Feb 2016 16:24:47 -0500
Message-ID: <002701d16b5b$f78c7b70$e6a57250$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-ca
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Joachim,

> From: Joachim Eastwood [mailto:manabian@gmail.com]
> Sent: 18-Feb-16 5:08 PM
> To: slemieux.tyco@gmail.com
> 
> Hi Sylvain,
> 
> On 18 February 2016 at 22:35,  <slemieux.tyco@gmail.com> wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> >
> > The LPC32xx provide the capability to perform a soft or hard reset;
> > a soft reset will no reset the external peripheral
> > (i.e. RESOUT_N output not asserted).
> >
> > The default behavior (i.e. hard reset) remain unchanged.
> >
> > Sylvain Lemieux (2):
> >   arm: lpc32xx: restart: add support for soft reset
> >   arm: lpc32xx: restart: support "cmd" from userspace
> >
> >  arch/arm/mach-lpc32xx/common.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> Instead of adding more code to mach-lpc32xx could this code be moved
> to the watchdog driver (pnx4008_wdt.c) ?
> See register_restart_handler() and how it's used in other watchdog drivers.
> 
> Then maybe the restart hook in phy3250.c could be removed all together.

Thanks for the feedback;

It is possible to remove the "lpc23xx_restart" function from "mach-lpc32xx"
and add the functionality to the pnx4008 watchdog driver.
The restart hook in phy3250.c can be remove.

I will submit a new revision of the patch on Monday.

> 
I need to add a new functionality to the pnx4008 driver to 
keep the driver disable and only provide the restart hook.

I am planning to add the functionality using a module parameter;
this is the way the pnx833x & s3c2410 driver are doing it.

Do you have any feedback before a submit a patch for this change.

Sylvain Lemieux
> 
> regards,
> Joachim Eastwood

