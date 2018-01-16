Return-Path: <lyude@redhat.com>
Return-path: <lyude@redhat.com>
Message-ID: <1516133876.18904.18.camel@redhat.com>
Subject: Re: [01/12] watchdog: sp5100_tco: Always use
 SP5100_IO_PM_{INDEX_REG, DATA_REG}
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?=
	 <zboszor@pr.hu>
Date: Tue, 16 Jan 2018 15:17:56 -0500
In-Reply-To: <20180116201124.GA9484@roeck-us.net>
References: <1514149448-20214-2-git-send-email-linux@roeck-us.net>
	 <1516131259.18904.5.camel@redhat.com> <20180116201124.GA9484@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Oh has this patchset already been reviwed and pushed upstream? I checked
patchwork beforehand and it looked like it was still pending

On Tue, 2018-01-16 at 12:11 -0800, Guenter Roeck wrote:
> On Tue, Jan 16, 2018 at 02:34:19PM -0500, Lyude Paul wrote:
> > Sorry this review took so long! Just sent off a big patchset myself to
> > nouveau's mailing list.
> > 
> > Anyway, unfortunately it should be noted that as I've learned from this
> > thread
> > that I have no machines that i know of with an actual sp5100_tco. Might
> > double
> > check though to see if I'm wrong, but for now this is all solely review.
> > 
> > Overall, nice patch! I'm glad to see ugly corners of the kernel being
> > cleaned
> > up like this :). Some comments below
> > 
> > On Sun, 2017-12-24 at 13:03 -0800, Guenter Roeck wrote:
> > > SP5100_IO_PM_INDEX_REG and SB800_IO_PM_INDEX_REG are used inconsistently
> > > and define the same value. Just use SP5100_IO_PM_INDEX_REG throughout.
> > > Do the same for SP5100_IO_PM_DATA_REG and SB800_IO_PM_DATA_REG.
> > > Use helper functions to access the indexed registers.
> > > 
> > > Cc: Zoltán Böszörményi <zboszor@pr.hu>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/watchdog/sp5100_tco.c | 94 ++++++++++++++++++++++------------
> > > ----
> > > -----
> > >  drivers/watchdog/sp5100_tco.h |  7 +---
> > >  2 files changed, 51 insertions(+), 50 deletions(-)
> > > 
> > > diff --git a/drivers/watchdog/sp5100_tco.c
> > > b/drivers/watchdog/sp5100_tco.c
> > > index 028618c5eeba..05f9d27a306a 100644
> > > --- a/drivers/watchdog/sp5100_tco.c
> > > +++ b/drivers/watchdog/sp5100_tco.c
> > > @@ -48,7 +48,6 @@
> > >  static u32 tcobase_phys;
> > >  static u32 tco_wdt_fired;
> > >  static void __iomem *tcobase;
> > > -static unsigned int pm_iobase;
> > >  static DEFINE_SPINLOCK(tco_lock);	/* Guards the hardware */
> > >  static unsigned long timer_alive;
> > >  static char tco_expect_close;
> > > @@ -132,25 +131,38 @@ static int tco_timer_set_heartbeat(int t)
> > >  	return 0;
> > >  }
> > >  
> > > -static void tco_timer_enable(void)
> > > +static u8 sp5100_tco_read_pm_reg8(u8 index)
> > > +{
> > > +	outb(index, SP5100_IO_PM_INDEX_REG);
> > > +	return inb(SP5100_IO_PM_DATA_REG);
> > > +}
> > > +
> > > +static void sp5100_tco_update_pm_reg8(u8 index, u8 reset, u8 set)
> > >  {
> > > -	int val;
> > > +	u8 val;
> > >  
> > > +	outb(index, SP5100_IO_PM_INDEX_REG);
> > > +	val = inb(SP5100_IO_PM_DATA_REG);
> > > +	val &= reset;
> > > +	val |= set;
> > > +	outb(val, SP5100_IO_PM_DATA_REG);
> > > +}
> > > +
> > > +static void tco_timer_enable(void)
> > > +{
> > >  	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
> > >  		/* For SB800 or later */
> > >  		/* Set the Watchdog timer resolution to 1 sec */
> > > -		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
> > > -		val = inb(SB800_IO_PM_DATA_REG);
> > > -		val |= SB800_PM_WATCHDOG_SECOND_RES;
> > > -		outb(val, SB800_IO_PM_DATA_REG);
> > > +		sp5100_tco_update_pm_reg8(SB800_PM_WATCHDOG_CONFIG,
> > > +					  0xff,
> > > SB800_PM_WATCHDOG_SECOND_RES);
> > >  
> > >  		/* Enable watchdog decode bit and watchdog timer */
> > > -		outb(SB800_PM_WATCHDOG_CONTROL, SB800_IO_PM_INDEX_REG);
> > > -		val = inb(SB800_IO_PM_DATA_REG);
> > > -		val |= SB800_PCI_WATCHDOG_DECODE_EN;
> > > -		val &= ~SB800_PM_WATCHDOG_DISABLE;
> > > -		outb(val, SB800_IO_PM_DATA_REG);
> > > +		sp5100_tco_update_pm_reg8(SB800_PM_WATCHDOG_CONTROL,
> > > +					  ~SB800_PM_WATCHDOG_DISABLE,
> > > +					  SB800_PCI_WATCHDOG_DECODE_EN)
> > > ;
> > >  	} else {
> > > +		u32 val;
> > > +
> > >  		/* For SP5100 or SB7x0 */
> > >  		/* Enable watchdog decode bit */
> > >  		pci_read_config_dword(sp5100_tco_pci,
> > > @@ -164,11 +176,9 @@ static void tco_timer_enable(void)
> > >  				       val);
> > >  
> > >  		/* Enable Watchdog timer and set the resolution to 1
> > > sec */
> > > -		outb(SP5100_PM_WATCHDOG_CONTROL,
> > > SP5100_IO_PM_INDEX_REG);
> > > -		val = inb(SP5100_IO_PM_DATA_REG);
> > > -		val |= SP5100_PM_WATCHDOG_SECOND_RES;
> > > -		val &= ~SP5100_PM_WATCHDOG_DISABLE;
> > > -		outb(val, SP5100_IO_PM_DATA_REG);
> > > +		sp5100_tco_update_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
> > > +					  ~SP5100_PM_WATCHDOG_DISABLE,
> > > +					  SP5100_PM_WATCHDOG_SECOND_RES
> > > );
> > >  	}
> > >  }
> > >  
> > > @@ -321,6 +331,17 @@ static const struct pci_device_id
> > > sp5100_tco_pci_tbl[]
> > > = {
> > >  };
> > >  MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
> > >  
> > > +static u8 sp5100_tco_read_pm_reg32(u8 index)
> > > +{
> > > +	u32 val = 0;
> > > +	int i;
> > > +
> > > +	for (i = 3; i >= 0; i--)
> > > +		val = (val << 8) + sp5100_tco_read_pm_reg8(index + i);
> > > +
> > > +	return val;
> > > +}
> > > +
> > >  /*
> > >   * Init & exit routines
> > >   */
> > > @@ -329,7 +350,7 @@ static unsigned char sp5100_tco_setupdevice(void)
> > >  	struct pci_dev *dev = NULL;
> > >  	const char *dev_name = NULL;
> > >  	u32 val;
> > > -	u32 index_reg, data_reg, base_addr;
> > > +	u8 base_addr;
> > >  
> > >  	/* Match the PCI device */
> > >  	for_each_pci_dev(dev) {
> > > @@ -351,35 +372,25 @@ static unsigned char sp5100_tco_setupdevice(void)
> > >  	 */
> > >  	if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
> > >  		dev_name = SP5100_DEVNAME;
> > > -		index_reg = SP5100_IO_PM_INDEX_REG;
> > > -		data_reg = SP5100_IO_PM_DATA_REG;
> > >  		base_addr = SP5100_PM_WATCHDOG_BASE;
> > >  	} else {
> > >  		dev_name = SB800_DEVNAME;
> > > -		index_reg = SB800_IO_PM_INDEX_REG;
> > > -		data_reg = SB800_IO_PM_DATA_REG;
> > >  		base_addr = SB800_PM_WATCHDOG_BASE;
> > >  	}
> > >  
> > >  	/* Request the IO ports used by this driver */
> > > -	pm_iobase = SP5100_IO_PM_INDEX_REG;
> > > -	if (!request_region(pm_iobase, SP5100_PM_IOPORTS_SIZE,
> > > dev_name)) {
> > > -		pr_err("I/O address 0x%04x already in use\n",
> > > pm_iobase);
> > > +	if (!request_region(SP5100_IO_PM_INDEX_REG,
> > > SP5100_PM_IOPORTS_SIZE,
> > > +			    dev_name)) {
> > > +		pr_err("I/O address 0x%04x already in use\n",
> > > +		       SP5100_IO_PM_INDEX_REG);
> > 
> > It's good we're printing an error here, but I also don't think (since this
> > has
> > happened a couple times already even just on this thread) we should simply
> > leave the user with the impression that the driver actually failed if the
> > real
> > situation is that the user is supposed to use w83627hf_wdt or some other
> > watchdog driver. Maybe leave a suggestion in this message to the user to
> > try
> > another driver, or see if we could improve this module's ability to
> > realize
> > that it's not actually supported on the system it's being loaded on?
> 
> Keep in mind that this is not the only driver in the system which doesn't
> apply for a given hardware. We would end up with an endless amount of
> messages if we were to do that.
> 
> > >  		goto exit;
> > >  	}
> > >  
> > >  	/*
> > >  	 * First, Find the watchdog timer MMIO address from indirect
> > > I/O.
> > > +	 * Low three bits of BASE are reserved.
> > >  	 */
> > > -	outb(base_addr+3, index_reg);
> > > -	val = inb(data_reg);
> > > -	outb(base_addr+2, index_reg);
> > > -	val = val << 8 | inb(data_reg);
> > > -	outb(base_addr+1, index_reg);
> > > -	val = val << 8 | inb(data_reg);
> > > -	outb(base_addr+0, index_reg);
> > > -	/* Low three bits of BASE are reserved */
> > > -	val = val << 8 | (inb(data_reg) & 0xf8);
> > > +	val = sp5100_tco_read_pm_reg32(base_addr) & 0xfffffff8;
> > >  
> > >  	pr_debug("Got 0x%04x from indirect I/O\n", val);
> > >  
> > > @@ -400,14 +411,7 @@ static unsigned char sp5100_tco_setupdevice(void)
> > >  				      SP5100_SB_RESOURCE_MMIO_BASE,
> > > &val);
> > >  	} else {
> > >  		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
> > > -		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
> > > -		val = inb(SB800_IO_PM_DATA_REG);
> > > -		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
> > > -		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
> > > -		outb(SB800_PM_ACPI_MMIO_EN+1, SB800_IO_PM_INDEX_REG);
> > > -		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
> > > -		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
> > > -		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
> > > +		val = sp5100_tco_read_pm_reg32(SB800_PM_ACPI_MMIO_EN);
> > >  	}
> > >  
> > >  	/* The SBResource_MMIO is enabled and mapped memory space? */
> > > @@ -470,7 +474,7 @@ static unsigned char sp5100_tco_setupdevice(void)
> > >  unreg_mem_region:
> > >  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> > >  unreg_region:
> > > -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
> > > +	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
> > >  exit:
> > >  	return 0;
> > >  }
> > > @@ -517,7 +521,7 @@ static int sp5100_tco_init(struct platform_device
> > > *dev)
> > >  exit:
> > >  	iounmap(tcobase);
> > >  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> > > -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
> > > +	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
> > >  	return ret;
> > >  }
> > >  
> > > @@ -531,7 +535,7 @@ static void sp5100_tco_cleanup(void)
> > >  	misc_deregister(&sp5100_tco_miscdev);
> > >  	iounmap(tcobase);
> > >  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> > > -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
> > > +	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
> > >  }
> > >  
> > >  static int sp5100_tco_remove(struct platform_device *dev)
> > > diff --git a/drivers/watchdog/sp5100_tco.h
> > > b/drivers/watchdog/sp5100_tco.h
> > > index 1af4dee71337..f495fe03887a 100644
> > > --- a/drivers/watchdog/sp5100_tco.h
> > > +++ b/drivers/watchdog/sp5100_tco.h
> > > @@ -24,10 +24,11 @@
> > >   * read them from a register.
> > >   */
> > >  
> > > -/*  For SP5100/SB7x0 chipset */
> > > +/*  For SP5100/SB7x0/SB8x0 chipset */
> > >  #define SP5100_IO_PM_INDEX_REG		0xCD6
> > >  #define SP5100_IO_PM_DATA_REG		0xCD7
> > >  
> > > +/* For SP5100/SB7x0 chipset */
> > >  #define SP5100_SB_RESOURCE_MMIO_BASE	0x9C
> > >  
> > >  #define SP5100_PM_WATCHDOG_CONTROL	0x69
> > > @@ -44,11 +45,7 @@
> > >  
> > >  #define SP5100_DEVNAME			"SP5100 TCO"
> > >  
> > > -
> > >  /*  For SB8x0(or later) chipset */
> > > -#define SB800_IO_PM_INDEX_REG		0xCD6
> > > -#define SB800_IO_PM_DATA_REG		0xCD7
> > > -
> > 
> > IMO I would leave these macro definitions as SB800. For DRM drivers at
> > least,
> > we usually take the route of naming commonly used registers/methods after
> > the
> > first generation they appeared in, not the last.
> > 
> 
> That may apply if there is only one set of defines. We have two
> sets here. Agreed, I could have removed SP5100 instead.
> As it is, I'd rather have the series applied to v4.16 instead
> of making cosmetic changes. I'll consider your suggestion if the
> series does not make it into 4.16.
> 
> Thanks,
> Guenter
> 
> > >  #define SB800_PM_ACPI_MMIO_EN		0x24
> > >  #define SB800_PM_WATCHDOG_CONTROL	0x48
> > >  #define SB800_PM_WATCHDOG_BASE		0x48
> > 
> > -- 
> > Cheers,
> > 	Lyude Paul
-- 
Cheers,
	Lyude Paul
