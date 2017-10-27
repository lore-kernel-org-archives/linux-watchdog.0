Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44797 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbdJ0BCR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Oct 2017 21:02:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id j3so4035545pga.1
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Oct 2017 18:02:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] watchdog: i6300esb: support multiple devices
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
References: <2edc54c2-f3d9-6b54-7ff9-79365b03946c@roeck-us.net>
 <20171026161016.3198-2-rrendec@arista.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7dc9ee42-1a80-ba08-e591-2552bc8c9c1c@roeck-us.net>
Date: Thu, 26 Oct 2017 18:02:15 -0700
MIME-Version: 1.0
In-Reply-To: <20171026161016.3198-2-rrendec@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/26/2017 09:10 AM, Radu Rendec wrote:
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
>   drivers/watchdog/i6300esb.c | 170 +++++++++++++++++++++++---------------------
>   1 file changed, 90 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index 4f4287d83c21..147462f431de 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -23,6 +23,7 @@
>    *	Ported driver to kernel 2.6
>    *  20171016 Radu Rendec <rrendec@arista.com>
>    *	Change driver to use the watchdog subsystem
> + *	Add support for multiple 6300ESB devices
>    */
>   
>   /*
> @@ -52,10 +53,10 @@
>   #define ESB_LOCK_REG    0x68            /* WDT lock register                 */
>   
>   /* Memory mapped registers */
> -#define ESB_TIMER1_REG (BASEADDR + 0x00)/* Timer1 value after each reset     */
> -#define ESB_TIMER2_REG (BASEADDR + 0x04)/* Timer2 value after each reset     */
> -#define ESB_GINTSR_REG (BASEADDR + 0x08)/* General Interrupt Status Register */
> -#define ESB_RELOAD_REG (BASEADDR + 0x0c)/* Reload register                   */
> +#define ESB_TIMER1_REG(w) ((w)->base + 0x00)/* Timer1 value after each reset */
> +#define ESB_TIMER2_REG(w) ((w)->base + 0x04)/* Timer2 value after each reset */
> +#define ESB_GINTSR_REG(w) ((w)->base + 0x08)/* General Interrupt Status Reg  */
> +#define ESB_RELOAD_REG(w) ((w)->base + 0x0c)/* Reload register               */
>   
>   /* Lock register bits */
>   #define ESB_WDT_FUNC    (0x01 << 2)   /* Watchdog functionality            */
> @@ -75,11 +76,7 @@
>   #define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
>   #define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
>   
> -/* internal variables */
> -static void __iomem *BASEADDR;
> -static struct pci_dev *esb_pci;
> -
> -/* We can only use 1 card due to the /dev/watchdog restriction */
> +/* Probed devices counter; used only for printing the initial info message */
>   static int cards_found;
>   
Leftover ?

>   /* module parameters */
> @@ -97,6 +94,15 @@ MODULE_PARM_DESC(nowayout,
>   		"Watchdog cannot be stopped once started (default="
>   				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>   
> +/* internal variables */
> +struct esb_dev {
> +	struct watchdog_device wdd;
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +};
> +
> +#define to_esb_dev(wptr) container_of(wptr, struct esb_dev, wdd)
> +
>   /*
>    * Some i6300ESB specific functions
>    */
> @@ -107,35 +113,37 @@ MODULE_PARM_DESC(nowayout,
>    * reload register. After this the appropriate registers can be written
>    * to once before they need to be unlocked again.
>    */
> -static inline void esb_unlock_registers(void)
> +static inline void esb_unlock_registers(struct esb_dev *edev)
>   {
> -	writew(ESB_UNLOCK1, ESB_RELOAD_REG);
> -	writew(ESB_UNLOCK2, ESB_RELOAD_REG);
> +	writew(ESB_UNLOCK1, ESB_RELOAD_REG(edev));
> +	writew(ESB_UNLOCK2, ESB_RELOAD_REG(edev));
>   }
>   
>   static int esb_timer_start(struct watchdog_device *wdd)
>   {
> +	struct esb_dev *edev = to_esb_dev(wdd);
>   	int _wdd_nowayout = test_bit(WDOG_NO_WAY_OUT, &wdd->status);
>   	u8 val;
>   
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>   	/* Enable or Enable + Lock? */
>   	val = ESB_WDT_ENABLE | (_wdd_nowayout ? ESB_WDT_LOCK : 0x00);
> -	pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
> +	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, val);
>   	return 0;
>   }
>   
>   static int esb_timer_stop(struct watchdog_device *wdd)
>   {
> +	struct esb_dev *edev = to_esb_dev(wdd);
>   	u8 val;
>   
>   	/* First, reset timers as suggested by the docs */
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>   	/* Then disable the WDT */
> -	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x0);
> -	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val);
> +	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x0);
> +	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val);
>   
>   	/* Returns 0 if the timer was disabled, non-zero otherwise */
>   	return val & ESB_WDT_ENABLE;
> @@ -143,8 +151,10 @@ static int esb_timer_stop(struct watchdog_device *wdd)
>   
>   static int esb_timer_keepalive(struct watchdog_device *wdd)
>   {
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	struct esb_dev *edev = to_esb_dev(wdd);
> +
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>   	/* FIXME: Do we need to flush anything here? */
>   	return 0;
>   }
> @@ -152,6 +162,7 @@ static int esb_timer_keepalive(struct watchdog_device *wdd)
>   static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
>   		unsigned int time)
>   {
> +	struct esb_dev *edev = to_esb_dev(wdd);
>   	u32 val;
>   
>   	/* We shift by 9, so if we are passed a value of 1 sec,
> @@ -161,16 +172,16 @@ static int esb_timer_set_heartbeat(struct watchdog_device *wdd,
>   	val = time << 9;
>   
>   	/* Write timer 1 */
> -	esb_unlock_registers();
> -	writel(val, ESB_TIMER1_REG);
> +	esb_unlock_registers(edev);
> +	writel(val, ESB_TIMER1_REG(edev));
>   
>   	/* Write timer 2 */
> -	esb_unlock_registers();
> -	writel(val, ESB_TIMER2_REG);
> +	esb_unlock_registers(edev);
> +	writel(val, ESB_TIMER2_REG(edev));
>   
>   	/* Reload */
> -	esb_unlock_registers();
> -	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(edev));
>   
>   	/* FIXME: Do we need to flush everything out? */
>   
> @@ -196,14 +207,6 @@ static const struct watchdog_ops esb_ops = {
>   	.ping = esb_timer_keepalive,
>   };
>   
> -static struct watchdog_device esb_dev = {
> -	.info = &esb_info,
> -	.ops = &esb_ops,
> -	.min_timeout = 1,
> -	.max_timeout = 2 * 0x03ff,
> -	.timeout = WATCHDOG_HEARTBEAT,
> -};
> -
>   /*
>    * Data for PCI driver interface
>    */
> @@ -217,38 +220,38 @@ MODULE_DEVICE_TABLE(pci, esb_pci_tbl);
>    *      Init & exit routines
>    */
>   
> -static unsigned char esb_getdevice(struct pci_dev *pdev)
> +static unsigned char esb_getdevice(struct esb_dev *edev)
>   {
> -	if (pci_enable_device(pdev)) {
> -		dev_err(&pdev->dev, "failed to enable device\n");
> +	if (pci_enable_device(edev->pdev)) {
> +		dev_err(&edev->pdev->dev, "failed to enable device\n");
>   		goto err_devput;
>   	}
>   
> -	if (pci_request_region(pdev, 0, ESB_MODULE_NAME)) {
> -		dev_err(&pdev->dev, "failed to request region\n");
> +	if (pci_request_region(edev->pdev, 0, ESB_MODULE_NAME)) {
> +		dev_err(&edev->pdev->dev, "failed to request region\n");
>   		goto err_disable;
>   	}
>   
> -	BASEADDR = pci_ioremap_bar(pdev, 0);
> -	if (BASEADDR == NULL) {
> +	edev->base = pci_ioremap_bar(edev->pdev, 0);
> +	if (edev->base == NULL) {
>   		/* Something's wrong here, BASEADDR has to be set */
> -		dev_err(&pdev->dev, "failed to get BASEADDR\n");
> +		dev_err(&edev->pdev->dev, "failed to get BASEADDR\n");
>   		goto err_release;
>   	}
>   
>   	/* Done */
> -	esb_pci = pdev;
> +	dev_set_drvdata(&edev->pdev->dev, edev);
>   	return 1;
>   
>   err_release:
> -	pci_release_region(pdev, 0);
> +	pci_release_region(edev->pdev, 0);
>   err_disable:
> -	pci_disable_device(pdev);
> +	pci_disable_device(edev->pdev);
>   err_devput:
>   	return 0;
>   }
>   
> -static void esb_initdevice(void)
> +static void esb_initdevice(struct esb_dev *edev)
>   {
>   	u8 val1;
>   	u16 val2;
> @@ -265,33 +268,34 @@ static void esb_initdevice(void)
>   	 * any interrupts as there is not much we can do with it
>   	 * right now.
>   	 */
> -	pci_write_config_word(esb_pci, ESB_CONFIG_REG, 0x0003);
> +	pci_write_config_word(edev->pdev, ESB_CONFIG_REG, 0x0003);
>   
>   	/* Check that the WDT isn't already locked */
> -	pci_read_config_byte(esb_pci, ESB_LOCK_REG, &val1);
> +	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val1);
>   	if (val1 & ESB_WDT_LOCK)
> -		dev_warn(&esb_pci->dev, "nowayout already set\n");
> +		dev_warn(&edev->pdev->dev, "nowayout already set\n");
>   
>   	/* Set the timer to watchdog mode and disable it for now */
> -	pci_write_config_byte(esb_pci, ESB_LOCK_REG, 0x00);
> +	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x00);
>   
>   	/* Check if the watchdog was previously triggered */
> -	esb_unlock_registers();
> -	val2 = readw(ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	val2 = readw(ESB_RELOAD_REG(edev));
>   	if (val2 & ESB_WDT_TIMEOUT)
> -		esb_dev.bootstatus = WDIOF_CARDRESET;
> +		edev->wdd.bootstatus = WDIOF_CARDRESET;
>   
>   	/* Reset WDT_TIMEOUT flag and timers */
> -	esb_unlock_registers();
> -	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG);
> +	esb_unlock_registers(edev);
> +	writew((ESB_WDT_TIMEOUT | ESB_WDT_RELOAD), ESB_RELOAD_REG(edev));
>   
>   	/* And set the correct timeout value */
> -	esb_timer_set_heartbeat(&esb_dev, esb_dev.timeout);
> +	esb_timer_set_heartbeat(&edev->wdd, edev->wdd.timeout);
>   }
>   
>   static int esb_probe(struct pci_dev *pdev,
>   		const struct pci_device_id *ent)
>   {
> +	struct esb_dev *edev;
>   	int ret;
>   
>   	cards_found++;

Leftover ?

> @@ -299,26 +303,32 @@ static int esb_probe(struct pci_dev *pdev,
>   		pr_info("Intel 6300ESB WatchDog Timer Driver v%s\n",
>   			ESB_VERSION);
>   
> -	if (cards_found > 1) {
> -		pr_err("This driver only supports 1 device\n");
> -		return -ENODEV;
> -	}
> +	edev = devm_kzalloc(&pdev->dev, sizeof(*edev), GFP_KERNEL);
> +	if (!edev)
> +		return -ENOMEM;
>   
>   	/* Check whether or not the hardware watchdog is there */
> -	if (!esb_getdevice(pdev) || esb_pci == NULL)
> +	edev->pdev = pdev;
> +	if (!esb_getdevice(edev))
>   		return -ENODEV;
>   
>   	/* Initialize the watchdog and make sure it does not run */
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
>   	/* Register the watchdog so that userspace has access to it */
> -	ret = watchdog_register_device(&esb_dev);
> +	ret = watchdog_register_device(&edev->wdd);
>   	if (ret != 0) {
>   		dev_err(&pdev->dev,
>   			"cannot register watchdog device (err=%d)\n", ret);
> @@ -326,24 +336,24 @@ static int esb_probe(struct pci_dev *pdev,
>   	}
>   	dev_info(&pdev->dev,
>   		"initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
> -		BASEADDR, esb_dev.timeout, nowayout);
> +		edev->base, edev->wdd.timeout, nowayout);
>   	return 0;
>   
>   err_unmap:
> -	iounmap(BASEADDR);
> -	pci_release_region(esb_pci, 0);
> -	pci_disable_device(esb_pci);
> -	esb_pci = NULL;
> +	iounmap(edev->base);
> +	pci_release_region(edev->pdev, 0);
> +	pci_disable_device(edev->pdev);
>   	return ret;
>   }
>   
>   static void esb_remove(struct pci_dev *pdev)
>   {
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
>   }
>   
>   static struct pci_driver esb_driver = {
> 

