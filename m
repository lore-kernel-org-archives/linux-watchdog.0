Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60792 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751403AbbCETrl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Mar 2015 14:47:41 -0500
Date: Thu, 5 Mar 2015 20:47:39 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/9] ARM: at91: time: move the system timer driver to
 drivers/clocksource
Message-ID: <20150305194739.GZ3989@piout.net>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425570594-13124-7-git-send-email-alexandre.belloni@free-electrons.com>
 <1425584493.24292.236.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425584493.24292.236.camel@x220>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/03/2015 at 20:41:33 +0100, Paul Bolle wrote :
> On Thu, 2015-03-05 at 16:49 +0100, Alexandre Belloni wrote:
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 1c2506f68122..d1d15985a4ec 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -138,6 +138,10 @@ config ATMEL_PIT
> >  	select CLKSRC_OF if OF
> >  	def_bool SOC_AT91SAM9 || SOC_SAMA5
> >  
> > +config ATMEL_ST
> > +	select CLKSRC_OF if OF
> > +	def_bool SOC_AT91RM9200
> 
> If you swap these two lines you'll make the set of people that probably
> only includes me a bit happier.
> 

I'm all for making you happier ;)

I'll respin next week, hopefully after getting more comments.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
