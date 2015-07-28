Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38037 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbbG1LHW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 07:07:22 -0400
Received: by wibxm9 with SMTP id xm9so155215844wib.1
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 04:07:20 -0700 (PDT)
Date: Tue, 28 Jul 2015 12:07:17 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150728110717.GH2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150728094643.GT14943@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul, at 10:46:43AM, Lee Jones wrote:
> On Mon, 27 Jul 2015, Matt Fleming wrote:
> 
> > From: Matt Fleming <matt.fleming@intel.com>
> > 
> > Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible across
> > the SMBus, unlike previous generations of PCH/ICH where it was on the
> > LPC bus. Because it's on the SMBus, it doesn't make sense to pass around
> > a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
> > watchdog driver is kind of backwards anyway.
> > 
> > This change introduces a new 'struct iTCO_wdt_platform_data' for use
> > inside the iTCO watchdog driver and by the upcoming Intel Sunrisepoint
> > code, which neatly avoids having to include lpc_ich headers in the i801
> > i2c driver.
> > 
> > A simple translation layer is provided for converting from the existing
> > 'struct lpc_ich_info' inside the lpc_ich mfd driver.
> > 
> > Cc: Peter Tyser <ptyser@xes-inc.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> > ---
> >  drivers/mfd/lpc_ich.c                  | 32 +++++++++++++++++++++++++++++---
> >  drivers/watchdog/Kconfig               |  2 +-
> >  drivers/watchdog/iTCO_wdt.c            | 11 +++++------
> >  include/linux/mfd/lpc_ich.h            |  6 ------
> >  include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
> >  5 files changed, 53 insertions(+), 16 deletions(-)
> >  create mode 100644 include/linux/platform_data/iTCO_wdt.h
> > 
> > diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> > index 8de34398abc0..d190b74a6321 100644
> > --- a/drivers/mfd/lpc_ich.c
> > +++ b/drivers/mfd/lpc_ich.c
> > @@ -66,6 +66,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/lpc_ich.h>
> > +#include <linux/platform_data/iTCO_wdt.h>
> 
> Lowercase please.
 
Even though the driver is called iTCO_wdt? It seemed to me to be more
confusing to start mixing cases rather than sticking with the ugly upper
case. Especially since when you look in the iTCO_wdt driver all the
function and type names are written that way.

> >  #define ACPIBASE		0x40
> >  #define ACPIBASE_GPE_OFF	0x28
> > @@ -835,9 +836,31 @@ static void lpc_ich_enable_pmc_space(struct pci_dev *dev)
> >  	priv->actrl_pbase_save = reg_save;
> >  }
> >  
> > -static void lpc_ich_finalize_cell(struct pci_dev *dev, struct mfd_cell *cell)
> > +static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
> >  {
> > +	struct iTCO_wdt_platform_data *pdata;
> 
> Lowercase please.
 
See above.

> >  	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> > +	struct lpc_ich_info *info;
> > +	struct mfd_cell *cell = &lpc_ich_cells[LPC_WDT];
> > +
> > +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return -ENOMEM;
> 
> Where is this freed?
> 
> Better to use devm_*
 
Yeah, Guenter caught this too. devm_* would definitely be better.

> > +	info = &lpc_chipset_info[priv->chipset];
> > +
> > +	pdata->iTCO_version = info->iTCO_version;
> 
> Lowercase please.

Hmm... but then this line will read,

	pdata->itco_version = info->iTCO_version;

I'm not sure that's an improvement.

> 
> > +	strcpy(pdata->name, info->name);
> 
> strncpy() is safer.
 
OK, I'll update this. Though it's worth pointing out that the name[]
declarations are of identical size in these two objects (but I guess
that could change in the future).

> > +	cell->platform_data = pdata;
> > +	cell->pdata_size = sizeof(*pdata);
> > +	return 0;
> > +}
> > +
> > +static void lpc_ich_finalize_gpio_cell(struct pci_dev *dev)
> > +{
> > +	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> > +	struct mfd_cell *cell = &lpc_ich_cells[LPC_GPIO];
> >  
> >  	cell->platform_data = &lpc_chipset_info[priv->chipset];
> >  	cell->pdata_size = sizeof(struct lpc_ich_info);
> 
> It's pretty hard to tell from the patch without applying it, but what
> are the actual similarities and differences between the two finalise
> functions?  They looks like they share enough lines for it to make
> sense to have one function call and do different things in say a
> switch statement, no?
 
For LPC_WDT we dynamically allocate the platform data, and for LPC_GPIO
we use the static lpc_chipsec_info array.

I'm just personally not a fan of performing memory allocations from
within switch statement bodies, which is why I implemented this as two
separate finalize functions.

> > @@ -933,7 +956,7 @@ gpe0_done:
> >  	lpc_chipset_info[priv->chipset].use_gpio = ret;
> >  	lpc_ich_enable_gpio_space(dev);
> >  
> > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
> > +	lpc_ich_finalize_gpio_cell(dev);
> >  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> >  			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
> >  
> > @@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
> >  		res->end = base_addr + ACPIBASE_PMC_END;
> >  	}
> >  
> > -	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
> > +	ret = lpc_ich_finalize_wdt_cell(dev);
> > +	if (ret)
> > +		goto wdt_done;
> > +
> >  	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> >  			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
> 
> Why do you have an mfd_add_devices() call for each device?
 
Good question. This call has been present since March 2012 when support
was first added for iTCO_wdt in commit 887c8ec7219f ("watchdog: Convert
iTCO_wdt driver to mfd model").

There's no good reason that I can see. Aaron?

-- 
Matt Fleming, Intel Open Source Technology Center
