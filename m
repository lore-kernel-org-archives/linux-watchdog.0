Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:34541 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab3IOSwR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 15 Sep 2013 14:52:17 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so1595928eek.15
        for <linux-watchdog@vger.kernel.org>; Sun, 15 Sep 2013 11:52:16 -0700 (PDT)
Date: Sun, 15 Sep 2013 20:52:21 +0200
From: Domenico Andreoli <cavokz@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Domenico Andreoli <domenico.andreoli@linux.com>,
	Olof Johansson <olof@lixom.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
Message-ID: <20130915185220.GA32054@glitch>
References: <20130914152032.401907974@gmail.com>
 <20130914152124.317379835@gmail.com>
 <201309152009.26462.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201309152009.26462.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Sep 15, 2013 at 08:09:26PM +0200, Arnd Bergmann wrote:
> On Saturday 14 September 2013, Domenico Andreoli wrote:
> > +
> > +static int __init bcm4760_wdt_init(void)
> > +{
> > +	struct device_node *node;
> > +
> > +	node = of_find_matching_node(NULL, bcm4760_pm_wdt_match);
> > +	if (!node) {
> > +		pr_info("No bcm4760 watchdog node\n");
> > +		return -1;
> > +	}
> > +
> > +	wdt_regs = of_iomap(node, 0);
> > +	of_node_put(node);
> 
> Since this is now in the drivers directory and initialized at regular
> module_init level, I'd ask you to register it as a proper platform_driver
> and move the initialization into the probe() callback. You also need to
> put Wim as the watchdog subsystem maintainer on Cc (I did in this reply)
> and ask him to merge the driver.
> 
> I assume that Wim will ask you to add a watchdog_register_device() call
> and a set of watchdog_ops to make this a functional driver. From the
> platform perspective, I don't care, but it is certainly a logical step.

issue here is that there is already a proper watchdog driver, the sp805.

so I guess now the task shifts to adding restart hook support to it, right?

Kind regards,
Domenico
