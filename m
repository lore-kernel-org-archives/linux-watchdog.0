Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60717 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdFUPJp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Jun 2017 11:09:45 -0400
Date: Wed, 21 Jun 2017 08:09:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>, kernel@ekass.net, wim@iguana.be,
        jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info
Subject: Re: [PATCH 5/5] watchdog: sp5100_tco: Use
 request_declared_muxed_region()
Message-ID: <20170621150940.GA21312@roeck-us.net>
References: <20170403075133.12343-1-zboszor@pr.hu>
 <20170621035349.4125-1-zboszor@pr.hu>
 <20170621035349.4125-6-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170621035349.4125-6-zboszor@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 21, 2017 at 05:53:49AM +0200, Zoltán Böszörményi wrote:
> Use the new request_declared_muxed_region() macro to synchronize
> accesses to the SB800 I/O port pair (0xcd6 / 0xcd7) with the
> PCI quirk for isochronous USB transfers and with the i2c-piix4
> driver.
> 
> At the same time, remove the long lifetime request_region() call
> to reserve these I/O ports, similarly to i2c-piix4 so the code is
> now uniform across the three drivers.
> 
> Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
> ---
>  drivers/watchdog/sp5100_tco.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 028618c..9bb3bcb 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -48,7 +48,6 @@
>  static u32 tcobase_phys;
>  static u32 tco_wdt_fired;
>  static void __iomem *tcobase;
> -static unsigned int pm_iobase;
>  static DEFINE_SPINLOCK(tco_lock);	/* Guards the hardware */
>  static unsigned long timer_alive;
>  static char tco_expect_close;
> @@ -134,11 +133,13 @@ static int tco_timer_set_heartbeat(int t)
>  
>  static void tco_timer_enable(void)
>  {
> +	struct resource res = DEFINE_RES_IO_NAMED(SB800_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE, TCO_MODULE_NAME);

Is it necessary to have this as a local variable ?
If not, please declare as static variable.

Either case, please run our patches through checkpatch and address 
any problems it reports.

>  	int val;
>  
>  	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
>  		/* For SB800 or later */
>  		/* Set the Watchdog timer resolution to 1 sec */
> +		request_declared_muxed_region(&res);
>  		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
>  		val = inb(SB800_IO_PM_DATA_REG);
>  		val |= SB800_PM_WATCHDOG_SECOND_RES;
> @@ -150,6 +151,7 @@ static void tco_timer_enable(void)
>  		val |= SB800_PCI_WATCHDOG_DECODE_EN;
>  		val &= ~SB800_PM_WATCHDOG_DISABLE;
>  		outb(val, SB800_IO_PM_DATA_REG);
> +		release_region(SB800_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>  	} else {
>  		/* For SP5100 or SB7x0 */
>  		/* Enable watchdog decode bit */
> @@ -164,11 +166,13 @@ static void tco_timer_enable(void)
>  				       val);
>  
>  		/* Enable Watchdog timer and set the resolution to 1 sec */
> +		request_declared_muxed_region(&res);
>  		outb(SP5100_PM_WATCHDOG_CONTROL, SP5100_IO_PM_INDEX_REG);
>  		val = inb(SP5100_IO_PM_DATA_REG);
>  		val |= SP5100_PM_WATCHDOG_SECOND_RES;
>  		val &= ~SP5100_PM_WATCHDOG_DISABLE;
>  		outb(val, SP5100_IO_PM_DATA_REG);
> +		release_region(SB800_IO_PM_INDEX_REG, 2);
>  	}
>  }
>  
> @@ -326,6 +330,7 @@ MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
>   */
>  static unsigned char sp5100_tco_setupdevice(void)
>  {
> +	struct resource res = DEFINE_RES_IO_NAMED(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE, TCO_MODULE_NAME);
>  	struct pci_dev *dev = NULL;
>  	const char *dev_name = NULL;
>  	u32 val;
> @@ -361,16 +366,10 @@ static unsigned char sp5100_tco_setupdevice(void)
>  		base_addr = SB800_PM_WATCHDOG_BASE;
>  	}
>  
> -	/* Request the IO ports used by this driver */
> -	pm_iobase = SP5100_IO_PM_INDEX_REG;
> -	if (!request_region(pm_iobase, SP5100_PM_IOPORTS_SIZE, dev_name)) {
> -		pr_err("I/O address 0x%04x already in use\n", pm_iobase);
> -		goto exit;
> -	}
> -
>  	/*
>  	 * First, Find the watchdog timer MMIO address from indirect I/O.
>  	 */
> +	request_declared_muxed_region(&res);
>  	outb(base_addr+3, index_reg);
>  	val = inb(data_reg);
>  	outb(base_addr+2, index_reg);
> @@ -380,6 +379,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>  	outb(base_addr+0, index_reg);
>  	/* Low three bits of BASE are reserved */
>  	val = val << 8 | (inb(data_reg) & 0xf8);
> +	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>  
>  	pr_debug("Got 0x%04x from indirect I/O\n", val);
>  
> @@ -400,6 +400,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>  				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
>  	} else {
>  		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
> +		request_declared_muxed_region(&res);
>  		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
>  		val = inb(SB800_IO_PM_DATA_REG);
>  		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
> @@ -408,6 +409,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>  		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
>  		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
>  		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
> +		release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>  	}
>  
>  	/* The SBResource_MMIO is enabled and mapped memory space? */
> @@ -429,7 +431,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>  		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
>  
>  	pr_notice("failed to find MMIO address, giving up.\n");
> -	goto  unreg_region;
> +	goto  exit;
>  
>  setup_wdt:
>  	tcobase_phys = val;
> @@ -469,8 +471,6 @@ static unsigned char sp5100_tco_setupdevice(void)
>  
>  unreg_mem_region:
>  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -unreg_region:
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
>  exit:
>  	return 0;
>  }
> @@ -517,7 +517,7 @@ static int sp5100_tco_init(struct platform_device *dev)
>  exit:
>  	iounmap(tcobase);
>  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
> +	release_region(SB800_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>  	return ret;
>  }
>  
> @@ -531,7 +531,6 @@ static void sp5100_tco_cleanup(void)
>  	misc_deregister(&sp5100_tco_miscdev);
>  	iounmap(tcobase);
>  	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
>  }
>  
>  static int sp5100_tco_remove(struct platform_device *dev)
> -- 
> 2.9.4
> 
