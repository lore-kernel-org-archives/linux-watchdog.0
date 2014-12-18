Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43893 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaLRQBO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Dec 2014 11:01:14 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y1dVq-002n7y-HT
	for linux-watchdog@vger.kernel.org; Thu, 18 Dec 2014 16:01:14 +0000
Date: Thu, 18 Dec 2014 08:00:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@stlinux.com, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	arnd@arndb.de, David Paris <david.paris@st.com>
Subject: Re: [PATCH 6/8] watchdog: st_wdt: Add new driver for ST's LPC
 Watchdog
Message-ID: <20141218160014.GA16015@roeck-us.net>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <1418834727-1602-7-git-send-email-lee.jones@linaro.org>
 <20141217180251.GA29914@roeck-us.net>
 <20141218082652.GP13885@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141218082652.GP13885@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Dec 18, 2014 at 08:26:52AM +0000, Lee Jones wrote:
> On Wed, 17 Dec 2014, Guenter Roeck wrote:
> > On Wed, Dec 17, 2014 at 04:45:25PM +0000, Lee Jones wrote:
> > > Signed-off-by: David Paris <david.paris@st.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Hi Lee and David,
> > 
> > I still have a couple of comments below. Sorry I didn't catch those earlier.
> > 
> > Thanks,
> > Guenter
> > 
> > > ---
> > >  drivers/watchdog/Kconfig  |  13 ++
> > >  drivers/watchdog/Makefile |   1 +
> > >  drivers/watchdog/st_wdt.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 337 insertions(+)
> > >  create mode 100644 drivers/watchdog/st_wdt.c
> 
> Chopping all the crud.
> 
> [...]
> 
> > > +static struct of_device_id st_wdog_match[] = {
> > > +	{
> > > +		.compatible = "st,stih407-lpc",
> > > +		.data = (void *)&stih407_syscfg,
> > 
> > Nitpick: typecast to and from void * is not necessary.
> 
> Actually that's not true, but it is superfluous in this case.
> 
Point taken. Would you agree to a more detailed "typecasting a pointer
to and from void * is not necessary" ?

Guenter
