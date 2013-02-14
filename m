Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43845 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311Ab3BNIfk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Feb 2013 03:35:40 -0500
Date: Thu, 14 Feb 2013 09:35:34 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Congatec CGEB base, i2c and watchdog driver support
Message-ID: <20130214083534.GC25672@pengutronix.de>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
 <CAH9NwWfSQKW2c1LvLQkojPiKA_r7+_6OmgoVHrBNRHUEFNYvJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWfSQKW2c1LvLQkojPiKA_r7+_6OmgoVHrBNRHUEFNYvJg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 13, 2013 at 03:57:02PM +0100, Christian Gmeiner wrote:
> 2013/2/12 Sascha Hauer <s.hauer@pengutronix.de>:
> > I'd like to come back to this topic. I have sent patches last year
> > already, changes to the last time I posted this is mainly that
> > I moved the CGEB base support from drivers/mfd/ to arch/x86/platform/
> > like suggested by Samuel Ortiz back then.
> >
> > The following series adds support for the Congatec CGEB interface
> > found on some Congatec x86 boards. The CGEB interface is a BIOS
> > interface which provides access to onboard peripherals like I2C
> > busses and watchdogs. It works by mapping BIOS code and searching
> > for magic values which specify the entry points to the CGEB call.
> > The CGEB call is an API provided by the BIOS which provides access
> > to the functions in an ioctl like fashion.
> >
> > For more information about the CGEB API have a look at:
> >
> > http://www.congatec.com/single_news+M5d58c9cd155.html
> >
> > This document only describes the C API, unfortunately not the
> > underlying BIOS interface.
> >
> > Also added are two users of this interface, a i2c master driver
> > and a watchdog driver.
> >
> > Comments very appreciated.
> 
> Hi Sascha,
> 
> against what version is this patch set? Would like to try it out but it fails
> to apply to 3.8-rc7.

I made it against 3.8-rc6, but I just checked the patches apply to
3.8-rc7 aswell

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
