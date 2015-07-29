Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:47177 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130AbbG2O4G (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 10:56:06 -0400
Date: Wed, 29 Jul 2015 09:52:51 -0500 (CDT)
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
Message-ID: <2115196252.256986.1438181571315.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <20150729073841.GF2284@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk> <20150728094643.GT14943@x1> <20150728110717.GH2492@codeblueprint.co.uk> <20150728113721.GU14943@x1> <72454140.319490.1438109162683.JavaMail.zimbra@xes-inc.com> <20150729073841.GF2284@x1>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> From: "Lee Jones" <lee.jones@linaro.org>
> Sent: Wednesday, July 29, 2015 2:38:41 AM
> 
> On Tue, 28 Jul 2015, Aaron Sierra wrote:
> 
> > > > > > @@ -933,7 +956,7 @@ gpe0_done:
> > > > > >  	lpc_chipset_info[priv->chipset].use_gpio = ret;
> > > > > >  	lpc_ich_enable_gpio_space(dev);
> > > > > >  
> > > > > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> > > > > > +	lpc_ich_finalize_gpio_cell(dev);
> > > > > >  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > > > > >  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
> > > > > >  
> > > > > > @@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev
> > > > > > *dev)
> > > > > >  		res->end = base_addr + ACPIBASE_PMC_END;
> > > > > >  	}
> > > > > >  
> > > > > > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> > > > > > +	ret = lpc_ich_finalize_wdt_cell(dev);
> > > > > > +	if (ret)
> > > > > > +		goto wdt_done;
> > > > > > +
> > > > > >  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> > > > > >  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
> > > > > 
> > > > > Why do you have an mfd_add_devices() call for each device?
> > > >  
> > > > Good question. This call has been present since March 2012 when support
> > > > was first added for iTCO_wdt in commit 887c8ec7219f ("watchdog: Convert
> > > > iTCO_wdt driver to mfd model").
> > > > 
> > > > There's no good reason that I can see. Aaron?
> > 
> > I chose to call mfd_add_devices() in each device init function
> > because I thought it was the easiest way to avoid registering an
> > incomplete/invalid MFD cell should an error occur during init.
> > 
> > That way device registration wouldn't be an all-or-nothing affair.
> > 
> > Doesn't mfd_add_devices() bail out after the first unsuccessful
> > mfd to platform device translation?
> 
> Right, as it should.
> 
> Under what circumstance would an error occur and you'd wish to carry
> on registering devices?

Lee,

The two devices that this driver is responsible for are conceptually
independent; they simply are lumped together in one PCI device. No
failure while preparing resources for the watchdog device should
prevent the GPIO device from being registered.

The most common real world circumstance that I experience is when a
BIOS reserves resources associated with the GPIO device, thus
preventing the GPIO resources (ICH_RES_GPE0 and/or ICH_RES_GPIO) from
being fully prepared.

I have not experienced issues with the watchdog device, but a similar
issue would exist if the RCBA were disabled in a "v2" device.

It seems like a dangerous change to simply attempt to register both
of these devices with a single call, when one or both of them could
be incomplete.

Perhaps your real issue with this driver structure is that these
cells are elements of a single lpc_ich_cells array for no clear
reason. If each had a dedicated mfd_cell variable, would that be
more acceptable to you?

-static struct mfd_cell lpc_ich_cells[] = {
+static struct mfd_cell lpc_ich_wdt_cell = {
...
+static struct mfd_cell lpc_ich_gpio_cell = {

That would eliminate the need for the lpc_cells enum, too.

-Aaron S.
