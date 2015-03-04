Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50554 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932770AbbCDRta (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 12:49:30 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YTDQI-002MwA-0Y
	for linux-watchdog@vger.kernel.org; Wed, 04 Mar 2015 17:49:30 +0000
Date: Wed, 4 Mar 2015 09:48:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/9] watchdog: at91rm9200: use the system timer syscon
Message-ID: <20150304174826.GA5568@roeck-us.net>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-4-git-send-email-alexandre.belloni@free-electrons.com>
 <54F71C07.6070204@roeck-us.net>
 <20150304150815.GG3989@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150304150815.GG3989@piout.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 04, 2015 at 04:08:15PM +0100, Alexandre Belloni wrote:
> On 04/03/2015 at 06:51:51 -0800, Guenter Roeck wrote :
> > >@@ -267,7 +276,7 @@ static struct platform_driver at91wdt_driver = {
> > >  	.suspend	= at91wdt_suspend,
> > >  	.resume		= at91wdt_resume,
> > >  	.driver		= {
> > >-		.name	= "at91_wdt",
> > >+		.name	= "atmel_st_watchdog",
> > 
> > If you change the driver name you also need to change the MODULE_ALIAS
> > a few lines down.
> > 
> > But why change it in the first place ? Maybe that was discussed somewhere,
> > but not here where it belongs, and not in patch 0/9 either.
> > 
> 
> That's because it conflicts with drivers/watchdog/at91sam9_wdt.c
> 
You still have to update MODULE_ALIAS (or drop it if it is not needed anymore).

Guenter

> I'm not sure that is relevant anymore as they will only be probed using
> DT now.
> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
