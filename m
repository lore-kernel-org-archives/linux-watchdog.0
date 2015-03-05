Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58743 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751824AbbCEPKJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Mar 2015 10:10:09 -0500
Date: Thu, 5 Mar 2015 16:09:56 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/9] power: reset: Add AT91RM9200 reset driver
Message-ID: <20150305150956.GT3989@piout.net>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20150304171758.GA8717@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150304171758.GA8717@earth>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/03/2015 at 18:17:58 +0100, Sebastian Reichel wrote :
> Hi,
> 
> On Wed, Mar 04, 2015 at 03:21:32PM +0100, Alexandre Belloni wrote:
> > AT91RM9200 uses the watchdog from the system timer to reset.
> > [...]
> > +	regmap_write(regmap_st, AT91_ST_WDMR,
> > +		     AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> > +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
> > +
> > +	mdelay(2000);
> 
> At pity that you have to write into two registers, otherwise you
> could have used the syscon-reboot driver.
> 

Exactly what I was thinking :)

> > [...]
> > +module_platform_driver(at91rm9200_reset_driver);
> 
> Apart from missing module metadata (MODULE_AUTHOR(),
> MODULE_LICENSE(), ...) the driver looks fine to me.
> 

I'll add those.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
