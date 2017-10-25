Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44309 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdJYUz6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Oct 2017 16:55:58 -0400
Received: by mail-pg0-f66.google.com with SMTP id j3so929243pga.1
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Oct 2017 13:55:58 -0700 (PDT)
Date: Wed, 25 Oct 2017 13:55:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/4] watchdog: i6300esb: support multiple devices
Message-ID: <20171025205557.GB30439@roeck-us.net>
References: <20171022170947.GA6997@roeck-us.net>
 <20171025153914.3467-2-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171025153914.3467-2-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 25, 2017 at 04:39:12PM +0100, Radu Rendec wrote:
> Support multiple i6300esb devices simultaneously, by removing the single
> device restriction in the original design and leveraging the multiple
> device support of the watchdog subsystem.
> 
> This patch replaces the global definitions of watchdog device data with
> a dynamically allocated structure. This structure is allocated during
> device probe, so multiple independent structures can be allocated if
> multiple devices are probed.
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>
> ---
>  drivers/watchdog/i6300esb.c | 189 +++++++++++++++++++++++---------------------
>  1 file changed, 100 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index 6e8578dd5dab..0b4489661a82 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -23,6 +23,7 @@
>   *	Ported driver to kernel 2.6
>   *  20171016 Radu Rendec <rrendec@arista.com>
>   *	Change driver to use the watchdog subsystem
> + *	Add support for multiple 6300ESB devices
>   */
>  
>  /*
> @@ -52,10 +53,10 @@
>  #define ESB_LOCK_REG    0x68            /* WDT lock register                 */
>  
>  /* Memory mapped registers */
> -#define ESB_TIMER1_REG (BASEADDR + 0x00)/* Timer1 value after each reset     */
> -#define ESB_TIMER2_REG (BASEADDR + 0x04)/* Timer2 value after each reset     */
> -#define ESB_GINTSR_REG (BASEADDR + 0x08)/* General Interrupt Status Register */
> -#define ESB_RELOAD_REG (BASEADDR + 0x0c)/* Reload register                   */
> +#define ESB_TIMER1_REG(w) ((w)->base + 0x00)/* Timer1 value after each reset */
> +#define ESB_TIMER2_REG(w) ((w)->base + 0x04)/* Timer2 value after each reset */
> +#define ESB_GINTSR_REG(w) ((w)->base + 0x08)/* General Interrupt Status Reg  */
> +#define ESB_RELOAD_REG(w) ((w)->base + 0x0c)/* Reload register               */
>  
>  /* Lock register bits */
>  #define ESB_WDT_FUNC    (0x01 << 2)   /* Watchdog functionality            */
> @@ -75,12 +76,7 @@
>  #define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
>  #define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
>  
> -/* internal variables */
> -static void __iomem *BASEADDR;
> -static DEFINE_SPINLOCK(esb_lock); /* Guards the hardware */
> -static struct pci_dev *esb_pci;
> -
> -/* We can only use 1 card due to the /dev/watchdog restriction */
> +/* Probed devices counter; used only for printing the initial info message */
>  static int cards_found;

Now unnecessary.

>  
>  /* module parameters */
> @@ -98,6 +94,16 @@ MODULE_PARM_DESC(nowayout,
>  		"Watchdog cannot be stopped once started (default="
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +/* internal variables */
> +struct esb_dev {
> +	struct watchdog_device wdd;
> +	void __iomem *base;
> +	spinlock_t lock;

Unnecessary - see patch 1.

> +	struct pci_dev *pdev;
> +};
> +
> +#define to_esb_dev(wptr) container_of(wptr, struct esb_dev, wdd)
> +
>  /*
>   * Some i6300ESB specific functions
>   */
> @@ -108,39 +114,41 @@ MODULE_PARM_DESC(nowayout,
>   * reload register. After this the appropriate registers can be written
>   * to once before they need to be unlocked again.
>   */
> -static inline void esb_unlock_registers(void)
> +static inline void esb_unlock_registers(struct esb_dev *edev)
>  {
> -	writew(ESB_UNLOCK1, ESB_RELOAD_REG);
> -	writew(ESB_UNLOCK2, ESB_RELOAD_REG);
> +	writew(ESB_UNLOCK1, ESB_RELOAD_REG(edev));
> +	writew(ESB_UNLOCK2, ESB_RELOAD_REG(edev));
>  }
>  
>  static int esb_timer_start(struct watchdog_device *wdd)
>  {
> +	struct esb_dev *edev = to_esb_dev(wdd);
>  	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &wdd->status);
>  	u8 val;
>  
> -	spin_lock(&esb_lock);
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	spin_lock(&edev->lock);
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>  	/* Enable or Enable + Lock? */
>  	val = ESB_WDT_ENABLE | (_wdd_nowayout ? ESB_WDT_LOCK : 0x00);
> -	pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
> -	spin_unlock(&esb_lock);
> +	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, val);
> +	spin_unlock(&edev->lock);
>  	return 0;
>  }
>  
>  static int esb_timer_stop(struct watchdog_device *wdd)
>  {
> +	struct esb_dev *edev = to_esb_dev(wdd);
>  	u8 val;
>  
> -	spin_lock(&esb_lock);
> +	spin_lock(&edev->lock);
>  	/* First, reset timers as suggested by the docs */
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>  	/* Then disable the WDT */
> -	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x0);
> -	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val);
> -	spin_unlock(&esb_lock);
> +	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x0);
> +	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val);
> +	spin_unlock(&edev->lock);
>  
>  	/* Returns 0 if the timer was disabled, non-zero otherwise */
>  	return val & ESB_WDT_ENABLE;
> @@ -148,20 +156,23 @@ static int esb_timer_stop(struct watchdog_device *wdd)
>  
>  static int esb_timer_keepalive(struct watchdog_device *wdd)
>  {
> -	spin_lock(&esb_lock);
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	struct esb_dev *edev = to_esb_dev(wdd);
> +
> +	spin_lock(&edev->lock);
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>  	/* FIXME: Do we need to flush anything here? */
> -	spin_unlock(&esb_lock);
> +	spin_unlock(&edev->lock);
>  	return 0;
>  }
>  
>  static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
>  		unsigned int time)
>  {
> +	struct esb_dev *edev = to_esb_dev(wdd);
>  	u32 val;
>  
> -	spin_lock(&esb_lock);
> +	spin_lock(&edev->lock);
>  
>  	/* We shift by 9, so if we are passed a value of 1 sec,
>  	 * val will be 1 << 9 = 512, then write that to two
> @@ -170,22 +181,22 @@ static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
>  	val = time << 9;
>  
>  	/* Write timer 1 */
> -	esb_unlock_registers();
> -	writel(val, ESB_TIMER1_REG);
> +	esb_unlock_registers(edev);
> +	writel(val, ESB_TIMER1_REG(edev));
>  
>  	/* Write timer 2 */
> -	esb_unlock_registers();
> -	writel(val, ESB_TIMER2_REG);
> +	esb_unlock_registers(edev);
> +	writel(val, ESB_TIMER2_REG(edev));
>  
>  	/* Reload */
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>  
>  	/* FIXME: Do we need to flush everything out? */
>  
>  	/* Done */
>  	wdd->timeout = time;
> -	spin_unlock(&esb_lock);
> +	spin_unlock(&edev->lock);
>  	return 0;
>  }
>  
> @@ -206,14 +217,6 @@ static const struct watchdog_ops esb_ops = {
>  	.ping = esb_timer_keepalive,
>  };
>  
> -static struct watchdog_device esb_dev = {
> -	.info = &esb_info,
> -	.ops = &esb_ops,
> -	.min_timeout = 1,
> -	.max_timeout = 2 * 0x03ff,
> -	.timeout = WATCHDOG_HEARTBEAT,
> -};
> -
>  /*
>   * Data for PCI driver interface
>   */
> @@ -227,38 +230,38 @@ MODULE_DEVICE_TABLE(pci, esb_pci_tbl);
>   *      Init & exit routines
>   */
>  
> -static unsigned char esb_getdevice(struct pci_dev *pdev)
> +static unsigned char esb_getdevice(struct esb_dev *edev)
>  {
> -	if (pci_enable_device(pdev)) {
> -		dev_err(&pdev->dev, "failed to enable device\n");
> +	if (pci_enable_device(edev->pdev)) {
> +		dev_err(&edev->pdev->dev, "failed to enable device\n");
>  		goto err_devput;
>  	}
>  
> -	if (pci_request_region(pdev, 0, ESB_MODULE_NAME)) {
> -		dev_err(&pdev->dev, "failed to request region\n");
> +	if (pci_request_region(edev->pdev, 0, ESB_MODULE_NAME)) {
> +		dev_err(&edev->pdev->dev, "failed to request region\n");
>  		goto err_disable;
>  	}
>  
> -	BASEADDR = pci_ioremap_bar(pdev, 0);
> -	if (BASEADDR == NULL) {
> +	edev->base = pci_ioremap_bar(edev->pdev, 0);
> +	if (edev->base == NULL) {
>  		/* Something's wrong here, BASEADDR has to be set */
> -		dev_err(&pdev->dev, "failed to get BASEADDR\n");
> +		dev_err(&edev->pdev->dev, "failed to get BASEADDR\n");
>  		goto err_release;
>  	}
>  
>  	/* Done */
> -	esb_pci = pdev;
> +	dev_set_drvdata(&edev->pdev->dev, edev);
>  	return 1;
>  
>  err_release:
> -	pci_release_region(pdev, 0);
> +	pci_release_region(edev->pdev, 0);
>  err_disable:
> -	pci_disable_device(pdev);
> +	pci_disable_device(edev->pdev);
>  err_devput:
>  	return 0;
>  }
>  
> -static void esb_initdevice(void)
> +static void esb_initdevice(struct esb_dev *edev)
>  {
>  	u8 val1;
>  	u16 val2;
> @@ -275,33 +278,34 @@ static void esb_initdevice(void)
>  	 * any interrupts as there is not much we can do with it
>  	 * right now.
>  	 */
> -	pci_write_config_word(esb_pci, ESB_CONFIG_REG, 0x0003);
> +	pci_write_config_word(edev->pdev, ESB_CONFIG_REG, 0x0003);
>  
>  	/* Check that the WDT isn't already locked */
> -	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val1);
> +	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val1);
>  	if (val1 & ESB_WDT_LOCK)
> -		dev_warn(&esb_pci->dev, "nowayout already set\n");
> +		dev_warn(&edev->pdev->dev, "nowayout already set\n");
>  
>  	/* Set the timer to watchdog mode and disable it for now */
> -	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x00);
> +	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x00);
>  
>  	/* Check if the watchdog was previously triggered */
> -	esb_unlock_registers();
> -	val2 = readw(ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	val2 = readw(ESB_RELOAD_REG(edev));
>  	if (val2 & ESB_WDT_TIMEOUT)
> -		esb_dev.bootstatus = WDIOF_CARDRESET;
> +		edev->wdd.bootstatus = WDIOF_CARDRESET;
>  
>  	/* Reset WDT_TIMEOUT flag and timers */
> -	esb_unlock_registers();
> -	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG(edev));
>  
>  	/* And set the correct timeout value */
> -	esb_timer_set_heartbeat(&esb_dev, esb_dev.timeout);
> +	esb_timer_set_heartbeat(&edev->wdd, edev->wdd.timeout);
>  }
>  
>  static int esb_probe(struct pci_dev *pdev,
>  		const struct pci_device_id *ent)
>  {
> +	struct esb_dev *edev;
>  	int ret;
>  
>  	cards_found++;

Now unnecessary.

> @@ -309,26 +313,33 @@ static int esb_probe(struct pci_dev *pdev,
>  		pr_info("Intel 6300ESB WatchDog Timer Driver v%s\n",
>  			ESB_VERSION);
>  
> -	if (cards_found > 1) {
> -		pr_err("This driver only supports 1 device\n");
> -		return -ENODEV;
> -	}
> +	edev = devm_kzalloc(&pdev->dev, sizeof(*edev), GFP_KERNEL);
> +	if (!edev)
> +		return -ENOMEM;
>  
>  	/* Check whether or not the hardware watchdog is there */
> -	if (!esb_getdevice(pdev) || esb_pci == NULL)
> +	spin_lock_init(&edev->lock);
> +	edev->pdev = pdev;
> +	if (!esb_getdevice(edev))
>  		return -ENODEV;
>  
>  	/* Initialize the watchdog and make sure it does not run */
> -	if (watchdog_init_timeout(&esb_dev, heartbeat, NULL))
> -		pr_info("heartbeat value must be 1<heartbeat<2046, using %u\n",
> -			esb_dev.timeout);
> -	watchdog_set_nowayout(&esb_dev, nowayout);
> -	watchdog_stop_on_reboot(&esb_dev);
> -	watchdog_stop_on_unregister(&esb_dev);
> -	esb_initdevice();
> +	edev->wdd.info = &esb_info;
> +	edev->wdd.ops = &esb_ops;
> +	edev->wdd.min_timeout = 1;
> +	edev->wdd.max_timeout = 2 * 0x03ff;
> +	edev->wdd.timeout = WATCHDOG_HEARTBEAT;
> +	if (watchdog_init_timeout(&edev->wdd, heartbeat, NULL))
> +		dev_info(&pdev->dev,
> +			"heartbeat value must be 1<heartbeat<2046, using %u\n",
> +			edev->wdd.timeout);
> +	watchdog_set_nowayout(&edev->wdd, nowayout);
> +	watchdog_stop_on_reboot(&edev->wdd);
> +	watchdog_stop_on_unregister(&edev->wdd);
> +	esb_initdevice(edev);
>  
>  	/* Register the watchdog so that userspace has access to it */
> -	ret = watchdog_register_device(&esb_dev);
> +	ret = watchdog_register_device(&edev->wdd);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev,
>  			"cannot register watchdog device (err=%d)\n", ret);
> @@ -336,24 +347,24 @@ static int esb_probe(struct pci_dev *pdev,
>  	}
>  	dev_info(&pdev->dev,
>  		"initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
> -		BASEADDR, esb_dev.timeout, nowayout);
> +		edev->base, edev->wdd.timeout, nowayout);
>  	return 0;
>  
>  err_unmap:
> -	iounmap(BASEADDR);
> -	pci_release_region(esb_pci, 0);
> -	pci_disable_device(esb_pci);
> -	esb_pci = NULL;
> +	iounmap(edev->base);
> +	pci_release_region(edev->pdev, 0);
> +	pci_disable_device(edev->pdev);
>  	return ret;
>  }
>  
>  static void esb_remove(struct pci_dev *pdev)
>  {
> -	watchdog_unregister_device(&esb_dev);
> -	iounmap(BASEADDR);
> -	pci_release_region(esb_pci, 0);
> -	pci_disable_device(esb_pci);
> -	esb_pci = NULL;
> +	struct esb_dev *edev = dev_get_drvdata(&pdev->dev);
> +
> +	watchdog_unregister_device(&edev->wdd);
> +	iounmap(edev->base);
> +	pci_release_region(edev->pdev, 0);
> +	pci_disable_device(edev->pdev);
>  }
>  
>  static struct pci_driver esb_driver = {
> -- 
> 2.13.6
> 
