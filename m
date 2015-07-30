Return-path: <lee.jones@linaro.org>
Date: Thu, 30 Jul 2015 09:51:29 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Aaron Sierra <asierra@xes-inc.com>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150730085129.GE9319@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <72454140.319490.1438109162683.JavaMail.zimbra@xes-inc.com>
 <20150729073841.GF2284@x1>
 <2115196252.256986.1438181571315.JavaMail.zimbra@xes-inc.com>
 <20150729153226.GB9319@x1>
 <55B8F6D7.6030005@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55B8F6D7.6030005@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, 29 Jul 2015, Guenter Roeck wrote:

> On 07/29/2015 08:32 AM, Lee Jones wrote:
> >On Wed, 29 Jul 2015, Aaron Sierra wrote:
> >
> >>>From: "Lee Jones" <lee.jones@linaro.org>
> >>>Sent: Wednesday, July 29, 2015 2:38:41 AM
> >>>
> >>>On Tue, 28 Jul 2015, Aaron Sierra wrote:
> >>>
> >>>>>>>>@@ -933,7 +956,7 @@ gpe0_done:
> >>>>>>>>  	lpc_chipset_info[priv->chipset].use_gpio = ret;
> >>>>>>>>  	lpc_ich_enable_gpio_space(dev);
> >>>>>>>>
> >>>>>>>>-	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> >>>>>>>>+	lpc_ich_finalize_gpio_cell(dev);
> >>>>>>>>  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> >>>>>>>>  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
> >>>>>>>>
> >>>>>>>>@@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev
> >>>>>>>>*dev)
> >>>>>>>>  		res->end = base_addr + ACPIBASE_PMC_END;
> >>>>>>>>  	}
> >>>>>>>>
> >>>>>>>>-	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> >>>>>>>>+	ret = lpc_ich_finalize_wdt_cell(dev);
> >>>>>>>>+	if (ret)
> >>>>>>>>+		goto wdt_done;
> >>>>>>>>+
> >>>>>>>>  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> >>>>>>>>  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
> >>>>>>>
> >>>>>>>Why do you have an mfd_add_devices() call for each device?
> >>>>>>
> >>>>>>Good question. This call has been present since March 2012 when support
> >>>>>>was first added for iTCO_wdt in commit 887c8ec7219f ("watchdog: Convert
> >>>>>>iTCO_wdt driver to mfd model").
> >>>>>>
> >>>>>>There's no good reason that I can see. Aaron?
> >>>>
> >>>>I chose to call mfd_add_devices() in each device init function
> >>>>because I thought it was the easiest way to avoid registering an
> >>>>incomplete/invalid MFD cell should an error occur during init.
> >>>>
> >>>>That way device registration wouldn't be an all-or-nothing affair.
> >>>>
> >>>>Doesn't mfd_add_devices() bail out after the first unsuccessful
> >>>>mfd to platform device translation?
> >>>
> >>>Right, as it should.
> >>>
> >>>Under what circumstance would an error occur and you'd wish to carry
> >>>on registering devices?
> >>
> >>Lee,
> >>
> >>The two devices that this driver is responsible for are conceptually
> >>independent; they simply are lumped together in one PCI device. No
> >>failure while preparing resources for the watchdog device should
> >>prevent the GPIO device from being registered.
> >
> >This makes me think that perhaps this isn't an MFD at all then?
> >
> >Perhaps I should invest some time to looking into that.
> >
> 
> The alternative, unless I am missing something, would be to
> bind two drivers to the same pci device, which is not currently
> possible in Linux. How would you suggest to do that if not with
> an mfd driver ?

As I said, I would need to look into it.  Perhaps this is the best way
we have of managing these devices in Linux.

Or perhaps I was just trying to provoke some thought/discussion. ;)

The MFD driver for this device looks fairly well written, so I'm not
offended that it's located there.  On the flip side, I am sensitive to
MFD becoming (more of?) a dumping ground for misfits that just don't
belong anywhere else.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
