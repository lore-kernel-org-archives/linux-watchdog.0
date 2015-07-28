Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:55899 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbbG1TRk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 15:17:40 -0400
Date: Tue, 28 Jul 2015 13:46:02 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <72454140.319490.1438109162683.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20150728113721.GU14943@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk> <20150728094643.GT14943@x1> <20150728110717.GH2492@codeblueprint.co.uk> <20150728113721.GU14943@x1>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > > > @@ -933,7 +956,7 @@ gpe0_done:
> > > >  	lpc_chipset_info[priv->chipset].use_gpio = ret;
> > > >  	lpc_ich_enable_gpio_space(dev);
> > > >  
> > > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> > > > +	lpc_ich_finalize_gpio_cell(dev);
> > > >  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > > >  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
> > > >  
> > > > @@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
> > > >  		res->end = base_addr + ACPIBASE_PMC_END;
> > > >  	}
> > > >  
> > > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> > > > +	ret = lpc_ich_finalize_wdt_cell(dev);
> > > > +	if (ret)
> > > > +		goto wdt_done;
> > > > +
> > > >  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > > >  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
> > > 
> > > Why do you have an mfd_add_devices() call for each device?
> >  
> > Good question. This call has been present since March 2012 when support
> > was first added for iTCO_wdt in commit 887c8ec7219f ("watchdog: Convert
> > iTCO_wdt driver to mfd model").
> > 
> > There's no good reason that I can see. Aaron?

I chose to call mfd_add_devices() in each device init function
because I thought it was the easiest way to avoid registering an
incomplete/invalid MFD cell should an error occur during init.

That way device registration wouldn't be an all-or-nothing affair.

Doesn't mfd_add_devices() bail out after the first unsuccessful
mfd to platform device translation?

-Aaron S.
