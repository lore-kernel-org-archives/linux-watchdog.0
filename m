Return-Path: <lyude@redhat.com>
Return-path: <lyude@redhat.com>
Message-ID: <1516132807.18904.14.camel@redhat.com>
Subject: Re: [07/12] watchdog: sp5100_tco: Use dev_ print functions where
 possible
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?=
	 <zboszor@pr.hu>
Date: Tue, 16 Jan 2018 15:00:07 -0500
In-Reply-To: <1514149457-20273-8-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-8-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2017-12-24 at 13:04 -0800, Guenter Roeck wrote:
> Use dev_ instead of pr_ functions where possible.
> 
> Cc: Zoltán Böszörményi <zboszor@pr.hu>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/sp5100_tco.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 5868c6b6bf17..ff240e5be833 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -326,7 +326,7 @@ static u8 sp5100_tco_read_pm_reg32(u8 index)
>  /*
>   * Init & exit routines
>   */
> -static int sp5100_tco_setupdevice(void)
> +static int sp5100_tco_setupdevice(struct device *dev)
>  {
>  	const char *dev_name = NULL;
>  	u32 val;
> @@ -347,8 +347,8 @@ static int sp5100_tco_setupdevice(void)
>  	/* Request the IO ports used by this driver */
>  	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
>  				  SP5100_PM_IOPORTS_SIZE, dev_name)) {
> -		pr_err("I/O address 0x%04x already in use\n",
> -		       SP5100_IO_PM_INDEX_REG);
> +		dev_err(dev, "I/O address 0x%04x already in use\n",
> +			SP5100_IO_PM_INDEX_REG);
>  		return -EBUSY;
>  	}
>  
> @@ -358,12 +358,12 @@ static int sp5100_tco_setupdevice(void)
>  	 */
>  	val = sp5100_tco_read_pm_reg32(base_addr) & 0xfffffff8;
>  
> -	pr_debug("Got 0x%04x from indirect I/O\n", val);
> +	dev_dbg(dev, "Got 0x%04x from indirect I/O\n", val);
>  
>  	/* Check MMIO address conflict */
>  	if (!request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
>  					  dev_name)) {
> -		pr_debug("MMIO address 0x%04x already in use\n", val);
> +		dev_dbg(dev, "MMIO address 0x%04x already in use\n", val);
>  		/*
>  		 * Secondly, Find the watchdog timer MMIO address
>  		 * from SBResource_MMIO register.
> @@ -381,7 +381,8 @@ static int sp5100_tco_setupdevice(void)
>  		/* The SBResource_MMIO is enabled and mapped memory space?
> */
>  		if ((val & (SB800_ACPI_MMIO_DECODE_EN |
> SB800_ACPI_MMIO_SEL)) !=
>  						  SB800_ACPI_MMIO_DECODE_EN
> ) {
> -			pr_notice("failed to find MMIO address, giving
> up.\n");
> +			dev_notice(dev,
> +				   "failed to find MMIO address, giving
> up.\n");
>  			ret = -ENODEV;
>  			goto unreg_region;
>  		}
> @@ -392,23 +393,24 @@ static int sp5100_tco_setupdevice(void)
>  		/* Check MMIO address conflict */
>  		if (!request_mem_region_exclusive(val,
> SP5100_WDT_MEM_MAP_SIZE,
>  						  dev_name)) {
> -			pr_debug("MMIO address 0x%04x already in use\n",
> val);
> +			dev_dbg(dev, "MMIO address 0x%04x already in
> use\n",
> +				val);
>  			ret = -EBUSY;
>  			goto unreg_region;
>  		}
> -		pr_debug("Got 0x%04x from SBResource_MMIO register\n",
> val);
> +		dev_dbg(dev, "Got 0x%04x from SBResource_MMIO register\n",
> val);
>  	}
>  
>  	tcobase_phys = val;
>  
>  	tcobase = ioremap(val, SP5100_WDT_MEM_MAP_SIZE);
>  	if (!tcobase) {
> -		pr_err("failed to get tcobase address\n");
> +		dev_err(dev, "failed to get tcobase address\n");
>  		ret = -ENOMEM;
>  		goto unreg_mem_region;
>  	}
>  
> -	pr_info("Using 0x%04x for watchdog MMIO address\n", val);
> +	dev_info(dev, "Using 0x%04x for watchdog MMIO address\n", val);
>  
>  	/* Setup the watchdog timer */
>  	tco_timer_enable();
> @@ -443,21 +445,22 @@ static int sp5100_tco_setupdevice(void)
>  	return ret;
>  }
>  
> -static int sp5100_tco_init(struct platform_device *dev)
> +static int sp5100_tco_init(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  
>  	/*
>  	 * Check whether or not the hardware watchdog is there. If found,
> then
>  	 * set it up.
>  	 */
> -	ret = sp5100_tco_setupdevice();
> +	ret = sp5100_tco_setupdevice(dev);
>  	if (ret)
>  		return ret;
>  
>  	/* Check to see if last reboot was due to watchdog timeout */
> -	pr_info("Last reboot was %striggered by watchdog.\n",
> -		tco_wdt_fired ? "" : "not ");
> +	dev_info(dev, "Last reboot was %striggered by watchdog.\n",
> +		 tco_wdt_fired ? "" : "not ");
>  
>  	/*
>  	 * Check that the heartbeat value is within it's range.
> @@ -470,16 +473,16 @@ static int sp5100_tco_init(struct platform_device
> *dev)
>  
>  	ret = misc_register(&sp5100_tco_miscdev);
>  	if (ret != 0) {
> -		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
> -		       WATCHDOG_MINOR, ret);
> +		dev_err(dev, "cannot register miscdev on minor=%d
> (err=%d)\n",
> +			WATCHDOG_MINOR, ret);
>  		goto exit;
>  	}
>  
>  	clear_bit(0, &timer_alive);
>  
>  	/* Show module parameters */
> -	pr_info("initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
> -		tcobase, heartbeat, nowayout);
> +	dev_info(dev, "initialized (0x%p). heartbeat=%d sec
> (nowayout=%d)\n",
> +		 tcobase, heartbeat, nowayout);
>  
>  	return 0;
>  
> @@ -581,7 +584,6 @@ static void __exit sp5100_tco_cleanup_module(void)
>  {
>  	platform_device_unregister(sp5100_tco_platform_device);
>  	platform_driver_unregister(&sp5100_tco_driver);
> -	pr_info("SP5100/SB800 TCO Watchdog Module Unloaded\n");
>  }
>  
>  module_init(sp5100_tco_init_module);
-- 
Cheers,
	Lyude Paul
