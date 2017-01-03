Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34540 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761590AbdACWoZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Jan 2017 17:44:25 -0500
MIME-Version: 1.0
In-Reply-To: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
References: <1483454364-28650-1-git-send-email-linux@roeck-us.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jan 2017 00:44:22 +0200
Message-ID: <CAHp75Vc=cQ2WEY7h98zEFV-W=kJxqom1NyDXXnRXpuh4J9r86g@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: iTCO_wdt: Use allocated data structures
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Fleming <matt.fleming@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 3, 2017 at 4:39 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Allocate private data and the watchdog device to to avoid having

'too to' ?

> to clear it on remove and to enable subsequent simplifications.

I doubt it will be more than one device per platform, but change is
good by itself to reduce amount of global module variables and a such.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/iTCO_wdt.c | 402 ++++++++++++++++++++++----------------------
>  1 file changed, 205 insertions(+), 197 deletions(-)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 06fcb6c8c917..a35a9164ccd0 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -72,22 +72,24 @@
>
>  /* Address definitions for the TCO */
>  /* TCO base address */
> -#define TCOBASE                (iTCO_wdt_private.tco_res->start)
> +#define TCOBASE(p)     ((p)->tco_res->start)
>  /* SMI Control and Enable Register */
> -#define SMI_EN         (iTCO_wdt_private.smi_res->start)
> -
> -#define TCO_RLD                (TCOBASE + 0x00) /* TCO Timer Reload and Curr. Value */
> -#define TCOv1_TMR      (TCOBASE + 0x01) /* TCOv1 Timer Initial Value   */
> -#define TCO_DAT_IN     (TCOBASE + 0x02) /* TCO Data In Register        */
> -#define TCO_DAT_OUT    (TCOBASE + 0x03) /* TCO Data Out Register       */
> -#define TCO1_STS       (TCOBASE + 0x04) /* TCO1 Status Register        */
> -#define TCO2_STS       (TCOBASE + 0x06) /* TCO2 Status Register        */
> -#define TCO1_CNT       (TCOBASE + 0x08) /* TCO1 Control Register       */
> -#define TCO2_CNT       (TCOBASE + 0x0a) /* TCO2 Control Register       */
> -#define TCOv2_TMR      (TCOBASE + 0x12) /* TCOv2 Timer Initial Value   */
> +#define SMI_EN(p)      ((p)->smi_res->start)
> +
> +#define TCO_RLD(p)     (TCOBASE(p) + 0x00) /* TCO Timer Reload/Curr. Value */
> +#define TCOv1_TMR(p)   (TCOBASE(p) + 0x01) /* TCOv1 Timer Initial Value*/
> +#define TCO_DAT_IN(p)  (TCOBASE(p) + 0x02) /* TCO Data In Register     */
> +#define TCO_DAT_OUT(p) (TCOBASE(p) + 0x03) /* TCO Data Out Register    */
> +#define TCO1_STS(p)    (TCOBASE(p) + 0x04) /* TCO1 Status Register     */
> +#define TCO2_STS(p)    (TCOBASE(p) + 0x06) /* TCO2 Status Register     */
> +#define TCO1_CNT(p)    (TCOBASE(p) + 0x08) /* TCO1 Control Register    */
> +#define TCO2_CNT(p)    (TCOBASE(p) + 0x0a) /* TCO2 Control Register    */
> +#define TCOv2_TMR(p)   (TCOBASE(p) + 0x12) /* TCOv2 Timer Initial Value*/
>
>  /* internal variables */
> -static struct {                /* this is private data for the iTCO_wdt device */
> +struct iTCO_wdt_private {
> +       struct watchdog_device wddev;
> +
>         /* TCO version/generation */
>         unsigned int iTCO_version;
>         struct resource *tco_res;
> @@ -105,7 +107,7 @@ static struct {             /* this is private data for the iTCO_wdt device */
>         struct pci_dev *pdev;
>         /* whether or not the watchdog has been suspended */
>         bool suspended;
> -} iTCO_wdt_private;
> +};
>
>  /* module parameters */
>  #define WATCHDOG_TIMEOUT 30    /* 30 sec default heartbeat */
> @@ -135,21 +137,23 @@ MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>   * every 0.6 seconds.  v3's internal timer is stored as seconds (some
>   * datasheets incorrectly state 0.6 seconds).
>   */
> -static inline unsigned int seconds_to_ticks(int secs)
> +static inline unsigned int seconds_to_ticks(struct iTCO_wdt_private *p,
> +                                           int secs)
>  {
> -       return iTCO_wdt_private.iTCO_version == 3 ? secs : (secs * 10) / 6;
> +       return p->iTCO_version == 3 ? secs : (secs * 10) / 6;
>  }
>
> -static inline unsigned int ticks_to_seconds(int ticks)
> +static inline unsigned int ticks_to_seconds(struct iTCO_wdt_private *p,
> +                                           int ticks)
>  {
> -       return iTCO_wdt_private.iTCO_version == 3 ? ticks : (ticks * 6) / 10;
> +       return p->iTCO_version == 3 ? ticks : (ticks * 6) / 10;
>  }
>
> -static inline u32 no_reboot_bit(void)
> +static inline u32 no_reboot_bit(struct iTCO_wdt_private *p)
>  {
>         u32 enable_bit;
>
> -       switch (iTCO_wdt_private.iTCO_version) {
> +       switch (p->iTCO_version) {
>         case 5:
>         case 3:
>                 enable_bit = 0x00000010;
> @@ -167,40 +171,40 @@ static inline u32 no_reboot_bit(void)
>         return enable_bit;
>  }
>
> -static void iTCO_wdt_set_NO_REBOOT_bit(void)
> +static void iTCO_wdt_set_NO_REBOOT_bit(struct iTCO_wdt_private *p)
>  {
>         u32 val32;
>
>         /* Set the NO_REBOOT bit: this disables reboots */
> -       if (iTCO_wdt_private.iTCO_version >= 2) {
> -               val32 = readl(iTCO_wdt_private.gcs_pmc);
> -               val32 |= no_reboot_bit();
> -               writel(val32, iTCO_wdt_private.gcs_pmc);
> -       } else if (iTCO_wdt_private.iTCO_version == 1) {
> -               pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> -               val32 |= no_reboot_bit();
> -               pci_write_config_dword(iTCO_wdt_private.pdev, 0xd4, val32);
> +       if (p->iTCO_version >= 2) {
> +               val32 = readl(p->gcs_pmc);
> +               val32 |= no_reboot_bit(p);
> +               writel(val32, p->gcs_pmc);
> +       } else if (p->iTCO_version == 1) {
> +               pci_read_config_dword(p->pdev, 0xd4, &val32);
> +               val32 |= no_reboot_bit(p);
> +               pci_write_config_dword(p->pdev, 0xd4, val32);
>         }
>  }
>
> -static int iTCO_wdt_unset_NO_REBOOT_bit(void)
> +static int iTCO_wdt_unset_NO_REBOOT_bit(struct iTCO_wdt_private *p)
>  {
> -       u32 enable_bit = no_reboot_bit();
> +       u32 enable_bit = no_reboot_bit(p);
>         u32 val32 = 0;
>
>         /* Unset the NO_REBOOT bit: this enables reboots */
> -       if (iTCO_wdt_private.iTCO_version >= 2) {
> -               val32 = readl(iTCO_wdt_private.gcs_pmc);
> +       if (p->iTCO_version >= 2) {
> +               val32 = readl(p->gcs_pmc);
>                 val32 &= ~enable_bit;
> -               writel(val32, iTCO_wdt_private.gcs_pmc);
> +               writel(val32, p->gcs_pmc);
>
> -               val32 = readl(iTCO_wdt_private.gcs_pmc);
> -       } else if (iTCO_wdt_private.iTCO_version == 1) {
> -               pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> +               val32 = readl(p->gcs_pmc);
> +       } else if (p->iTCO_version == 1) {
> +               pci_read_config_dword(p->pdev, 0xd4, &val32);
>                 val32 &= ~enable_bit;
> -               pci_write_config_dword(iTCO_wdt_private.pdev, 0xd4, val32);
> +               pci_write_config_dword(p->pdev, 0xd4, val32);
>
> -               pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> +               pci_read_config_dword(p->pdev, 0xd4, &val32);
>         }
>
>         if (val32 & enable_bit)
> @@ -211,32 +215,33 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>
>  static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  {
> +       struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>         unsigned int val;
>
> -       spin_lock(&iTCO_wdt_private.io_lock);
> +       spin_lock(&p->io_lock);
>
> -       iTCO_vendor_pre_start(iTCO_wdt_private.smi_res, wd_dev->timeout);
> +       iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
>
>         /* disable chipset's NO_REBOOT bit */
> -       if (iTCO_wdt_unset_NO_REBOOT_bit()) {
> -               spin_unlock(&iTCO_wdt_private.io_lock);
> +       if (iTCO_wdt_unset_NO_REBOOT_bit(p)) {
> +               spin_unlock(&p->io_lock);
>                 pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
>                 return -EIO;
>         }
>
>         /* Force the timer to its reload value by writing to the TCO_RLD
>            register */
> -       if (iTCO_wdt_private.iTCO_version >= 2)
> -               outw(0x01, TCO_RLD);
> -       else if (iTCO_wdt_private.iTCO_version == 1)
> -               outb(0x01, TCO_RLD);
> +       if (p->iTCO_version >= 2)
> +               outw(0x01, TCO_RLD(p));
> +       else if (p->iTCO_version == 1)
> +               outb(0x01, TCO_RLD(p));
>
>         /* Bit 11: TCO Timer Halt -> 0 = The TCO timer is enabled to count */
> -       val = inw(TCO1_CNT);
> +       val = inw(TCO1_CNT(p));
>         val &= 0xf7ff;
> -       outw(val, TCO1_CNT);
> -       val = inw(TCO1_CNT);
> -       spin_unlock(&iTCO_wdt_private.io_lock);
> +       outw(val, TCO1_CNT(p));
> +       val = inw(TCO1_CNT(p));
> +       spin_unlock(&p->io_lock);
>
>         if (val & 0x0800)
>                 return -1;
> @@ -245,22 +250,23 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>
>  static int iTCO_wdt_stop(struct watchdog_device *wd_dev)
>  {
> +       struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>         unsigned int val;
>
> -       spin_lock(&iTCO_wdt_private.io_lock);
> +       spin_lock(&p->io_lock);
>
> -       iTCO_vendor_pre_stop(iTCO_wdt_private.smi_res);
> +       iTCO_vendor_pre_stop(p->smi_res);
>
>         /* Bit 11: TCO Timer Halt -> 1 = The TCO timer is disabled */
> -       val = inw(TCO1_CNT);
> +       val = inw(TCO1_CNT(p));
>         val |= 0x0800;
> -       outw(val, TCO1_CNT);
> -       val = inw(TCO1_CNT);
> +       outw(val, TCO1_CNT(p));
> +       val = inw(TCO1_CNT(p));
>
>         /* Set the NO_REBOOT bit to prevent later reboots, just for sure */
> -       iTCO_wdt_set_NO_REBOOT_bit();
> +       iTCO_wdt_set_NO_REBOOT_bit(p);
>
> -       spin_unlock(&iTCO_wdt_private.io_lock);
> +       spin_unlock(&p->io_lock);
>
>         if ((val & 0x0800) == 0)
>                 return -1;
> @@ -269,67 +275,70 @@ static int iTCO_wdt_stop(struct watchdog_device *wd_dev)
>
>  static int iTCO_wdt_ping(struct watchdog_device *wd_dev)
>  {
> -       spin_lock(&iTCO_wdt_private.io_lock);
> +       struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>
> -       iTCO_vendor_pre_keepalive(iTCO_wdt_private.smi_res, wd_dev->timeout);
> +       spin_lock(&p->io_lock);
> +
> +       iTCO_vendor_pre_keepalive(p->smi_res, wd_dev->timeout);
>
>         /* Reload the timer by writing to the TCO Timer Counter register */
> -       if (iTCO_wdt_private.iTCO_version >= 2) {
> -               outw(0x01, TCO_RLD);
> -       } else if (iTCO_wdt_private.iTCO_version == 1) {
> +       if (p->iTCO_version >= 2) {
> +               outw(0x01, TCO_RLD(p));
> +       } else if (p->iTCO_version == 1) {
>                 /* Reset the timeout status bit so that the timer
>                  * needs to count down twice again before rebooting */
> -               outw(0x0008, TCO1_STS); /* write 1 to clear bit */
> +               outw(0x0008, TCO1_STS(p));      /* write 1 to clear bit */
>
> -               outb(0x01, TCO_RLD);
> +               outb(0x01, TCO_RLD(p));
>         }
>
> -       spin_unlock(&iTCO_wdt_private.io_lock);
> +       spin_unlock(&p->io_lock);
>         return 0;
>  }
>
>  static int iTCO_wdt_set_timeout(struct watchdog_device *wd_dev, unsigned int t)
>  {
> +       struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>         unsigned int val16;
>         unsigned char val8;
>         unsigned int tmrval;
>
> -       tmrval = seconds_to_ticks(t);
> +       tmrval = seconds_to_ticks(p, t);
>
>         /* For TCO v1 the timer counts down twice before rebooting */
> -       if (iTCO_wdt_private.iTCO_version == 1)
> +       if (p->iTCO_version == 1)
>                 tmrval /= 2;
>
>         /* from the specs: */
>         /* "Values of 0h-3h are ignored and should not be attempted" */
>         if (tmrval < 0x04)
>                 return -EINVAL;
> -       if (((iTCO_wdt_private.iTCO_version >= 2) && (tmrval > 0x3ff)) ||
> -           ((iTCO_wdt_private.iTCO_version == 1) && (tmrval > 0x03f)))
> +       if ((p->iTCO_version >= 2 && tmrval > 0x3ff) ||
> +           (p->iTCO_version == 1 && tmrval > 0x03f))
>                 return -EINVAL;
>
>         iTCO_vendor_pre_set_heartbeat(tmrval);
>
>         /* Write new heartbeat to watchdog */
> -       if (iTCO_wdt_private.iTCO_version >= 2) {
> -               spin_lock(&iTCO_wdt_private.io_lock);
> -               val16 = inw(TCOv2_TMR);
> +       if (p->iTCO_version >= 2) {
> +               spin_lock(&p->io_lock);
> +               val16 = inw(TCOv2_TMR(p));
>                 val16 &= 0xfc00;
>                 val16 |= tmrval;
> -               outw(val16, TCOv2_TMR);
> -               val16 = inw(TCOv2_TMR);
> -               spin_unlock(&iTCO_wdt_private.io_lock);
> +               outw(val16, TCOv2_TMR(p));
> +               val16 = inw(TCOv2_TMR(p));
> +               spin_unlock(&p->io_lock);
>
>                 if ((val16 & 0x3ff) != tmrval)
>                         return -EINVAL;
> -       } else if (iTCO_wdt_private.iTCO_version == 1) {
> -               spin_lock(&iTCO_wdt_private.io_lock);
> -               val8 = inb(TCOv1_TMR);
> +       } else if (p->iTCO_version == 1) {
> +               spin_lock(&p->io_lock);
> +               val8 = inb(TCOv1_TMR(p));
>                 val8 &= 0xc0;
>                 val8 |= (tmrval & 0xff);
> -               outb(val8, TCOv1_TMR);
> -               val8 = inb(TCOv1_TMR);
> -               spin_unlock(&iTCO_wdt_private.io_lock);
> +               outb(val8, TCOv1_TMR(p));
> +               val8 = inb(TCOv1_TMR(p));
> +               spin_unlock(&p->io_lock);
>
>                 if ((val8 & 0x3f) != tmrval)
>                         return -EINVAL;
> @@ -341,27 +350,28 @@ static int iTCO_wdt_set_timeout(struct watchdog_device *wd_dev, unsigned int t)
>
>  static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
>  {
> +       struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>         unsigned int val16;
>         unsigned char val8;
>         unsigned int time_left = 0;
>
>         /* read the TCO Timer */
> -       if (iTCO_wdt_private.iTCO_version >= 2) {
> -               spin_lock(&iTCO_wdt_private.io_lock);
> -               val16 = inw(TCO_RLD);
> +       if (p->iTCO_version >= 2) {
> +               spin_lock(&p->io_lock);
> +               val16 = inw(TCO_RLD(p));
>                 val16 &= 0x3ff;
> -               spin_unlock(&iTCO_wdt_private.io_lock);
> +               spin_unlock(&p->io_lock);
>
> -               time_left = ticks_to_seconds(val16);
> -       } else if (iTCO_wdt_private.iTCO_version == 1) {
> -               spin_lock(&iTCO_wdt_private.io_lock);
> -               val8 = inb(TCO_RLD);
> +               time_left = ticks_to_seconds(p, val16);
> +       } else if (p->iTCO_version == 1) {
> +               spin_lock(&p->io_lock);
> +               val8 = inb(TCO_RLD(p));
>                 val8 &= 0x3f;
> -               if (!(inw(TCO1_STS) & 0x0008))
> -                       val8 += (inb(TCOv1_TMR) & 0x3f);
> -               spin_unlock(&iTCO_wdt_private.io_lock);
> +               if (!(inw(TCO1_STS(p)) & 0x0008))
> +                       val8 += (inb(TCOv1_TMR(p)) & 0x3f);
> +               spin_unlock(&p->io_lock);
>
> -               time_left = ticks_to_seconds(val8);
> +               time_left = ticks_to_seconds(p, val8);
>         }
>         return time_left;
>  }
> @@ -387,166 +397,165 @@ static const struct watchdog_ops iTCO_wdt_ops = {
>         .get_timeleft =         iTCO_wdt_get_timeleft,
>  };
>
> -static struct watchdog_device iTCO_wdt_watchdog_dev = {
> -       .info =         &ident,
> -       .ops =          &iTCO_wdt_ops,
> -};
> -
>  /*
>   *     Init & exit routines
>   */
>
> -static void iTCO_wdt_cleanup(void)
> +static void iTCO_wdt_cleanup(struct iTCO_wdt_private *p)
>  {
>         /* Stop the timer before we leave */
>         if (!nowayout)
> -               iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);
> +               iTCO_wdt_stop(&p->wddev);
>
>         /* Deregister */
> -       watchdog_unregister_device(&iTCO_wdt_watchdog_dev);
> +       watchdog_unregister_device(&p->wddev);
>
>         /* release resources */
> -       release_region(iTCO_wdt_private.tco_res->start,
> -                       resource_size(iTCO_wdt_private.tco_res));
> -       release_region(iTCO_wdt_private.smi_res->start,
> -                       resource_size(iTCO_wdt_private.smi_res));
> -       if (iTCO_wdt_private.iTCO_version >= 2) {
> -               iounmap(iTCO_wdt_private.gcs_pmc);
> -               release_mem_region(iTCO_wdt_private.gcs_pmc_res->start,
> -                               resource_size(iTCO_wdt_private.gcs_pmc_res));
> +       release_region(p->tco_res->start,
> +                       resource_size(p->tco_res));
> +       release_region(p->smi_res->start,
> +                       resource_size(p->smi_res));
> +       if (p->iTCO_version >= 2) {
> +               iounmap(p->gcs_pmc);
> +               release_mem_region(p->gcs_pmc_res->start,
> +                               resource_size(p->gcs_pmc_res));
>         }
> -
> -       iTCO_wdt_private.tco_res = NULL;
> -       iTCO_wdt_private.smi_res = NULL;
> -       iTCO_wdt_private.gcs_pmc_res = NULL;
> -       iTCO_wdt_private.gcs_pmc = NULL;
>  }
>
>  static int iTCO_wdt_probe(struct platform_device *dev)
>  {
> -       int ret = -ENODEV;
> -       unsigned long val32;
>         struct itco_wdt_platform_data *pdata = dev_get_platdata(&dev->dev);
> +       struct iTCO_wdt_private *p;
> +       unsigned long val32;
> +       int ret;
>
>         if (!pdata)
> -               goto out;
> +               return -ENODEV;
>
> -       spin_lock_init(&iTCO_wdt_private.io_lock);
> +       p = devm_kzalloc(&dev->dev, sizeof(*p), GFP_KERNEL);
> +       if (!p)
> +               return -ENOMEM;
>
> -       iTCO_wdt_private.tco_res =
> -               platform_get_resource(dev, IORESOURCE_IO, ICH_RES_IO_TCO);
> -       if (!iTCO_wdt_private.tco_res)
> -               goto out;
> +       spin_lock_init(&p->io_lock);
>
> -       iTCO_wdt_private.smi_res =
> -               platform_get_resource(dev, IORESOURCE_IO, ICH_RES_IO_SMI);
> -       if (!iTCO_wdt_private.smi_res)
> -               goto out;
> +       p->tco_res = platform_get_resource(dev, IORESOURCE_IO, ICH_RES_IO_TCO);
> +       if (!p->tco_res)
> +               return -ENODEV;
>
> -       iTCO_wdt_private.iTCO_version = pdata->version;
> -       iTCO_wdt_private.dev = dev;
> -       iTCO_wdt_private.pdev = to_pci_dev(dev->dev.parent);
> +       p->smi_res = platform_get_resource(dev, IORESOURCE_IO, ICH_RES_IO_SMI);
> +       if (!p->smi_res)
> +               return -ENODEV;
> +
> +       p->iTCO_version = pdata->version;
> +       p->dev = dev;
> +       p->pdev = to_pci_dev(dev->dev.parent);
>
>         /*
>          * Get the Memory-Mapped GCS or PMC register, we need it for the
>          * NO_REBOOT flag (TCO v2 and v3).
>          */
> -       if (iTCO_wdt_private.iTCO_version >= 2) {
> -               iTCO_wdt_private.gcs_pmc_res = platform_get_resource(dev,
> -                                                       IORESOURCE_MEM,
> -                                                       ICH_RES_MEM_GCS_PMC);
> -
> -               if (!iTCO_wdt_private.gcs_pmc_res)
> -                       goto out;
> -
> -               if (!request_mem_region(iTCO_wdt_private.gcs_pmc_res->start,
> -                       resource_size(iTCO_wdt_private.gcs_pmc_res), dev->name)) {
> -                       ret = -EBUSY;
> -                       goto out;
> -               }
> -               iTCO_wdt_private.gcs_pmc = ioremap(iTCO_wdt_private.gcs_pmc_res->start,
> -                       resource_size(iTCO_wdt_private.gcs_pmc_res));
> -               if (!iTCO_wdt_private.gcs_pmc) {
> +       if (p->iTCO_version >= 2) {
> +               p->gcs_pmc_res = platform_get_resource(dev,
> +                                                      IORESOURCE_MEM,
> +                                                      ICH_RES_MEM_GCS_PMC);
> +
> +               if (!p->gcs_pmc_res)
> +                       return -ENODEV;
> +
> +               if (!request_mem_region(p->gcs_pmc_res->start,
> +                                       resource_size(p->gcs_pmc_res),
> +                                       dev->name))
> +                       return -EBUSY;
> +
> +               p->gcs_pmc = ioremap(p->gcs_pmc_res->start,
> +                                    resource_size(p->gcs_pmc_res));
> +               if (!p->gcs_pmc) {
>                         ret = -EIO;
>                         goto unreg_gcs_pmc;
>                 }
>         }
>
>         /* Check chipset's NO_REBOOT bit */
> -       if (iTCO_wdt_unset_NO_REBOOT_bit() && iTCO_vendor_check_noreboot_on()) {
> +       if (iTCO_wdt_unset_NO_REBOOT_bit(p) &&
> +           iTCO_vendor_check_noreboot_on()) {
>                 pr_info("unable to reset NO_REBOOT flag, device disabled by hardware/BIOS\n");
>                 ret = -ENODEV;  /* Cannot reset NO_REBOOT bit */
>                 goto unmap_gcs_pmc;
>         }
>
>         /* Set the NO_REBOOT bit to prevent later reboots, just for sure */
> -       iTCO_wdt_set_NO_REBOOT_bit();
> +       iTCO_wdt_set_NO_REBOOT_bit(p);
>
>         /* The TCO logic uses the TCO_EN bit in the SMI_EN register */
> -       if (!request_region(iTCO_wdt_private.smi_res->start,
> -                       resource_size(iTCO_wdt_private.smi_res), dev->name)) {
> +       if (!request_region(p->smi_res->start,
> +                           resource_size(p->smi_res), dev->name)) {
>                 pr_err("I/O address 0x%04llx already in use, device disabled\n",
> -                      (u64)SMI_EN);
> +                      (u64)SMI_EN(p));
>                 ret = -EBUSY;
>                 goto unmap_gcs_pmc;
>         }
> -       if (turn_SMI_watchdog_clear_off >= iTCO_wdt_private.iTCO_version) {
> +       if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
>                 /*
>                  * Bit 13: TCO_EN -> 0
>                  * Disables TCO logic generating an SMI#
>                  */
> -               val32 = inl(SMI_EN);
> +               val32 = inl(SMI_EN(p));
>                 val32 &= 0xffffdfff;    /* Turn off SMI clearing watchdog */
> -               outl(val32, SMI_EN);
> +               outl(val32, SMI_EN(p));
>         }
>
> -       if (!request_region(iTCO_wdt_private.tco_res->start,
> -                       resource_size(iTCO_wdt_private.tco_res), dev->name)) {
> +       if (!request_region(p->tco_res->start,
> +                           resource_size(p->tco_res), dev->name)) {
>                 pr_err("I/O address 0x%04llx already in use, device disabled\n",
> -                      (u64)TCOBASE);
> +                      (u64)TCOBASE(p));
>                 ret = -EBUSY;
>                 goto unreg_smi;
>         }
>
>         pr_info("Found a %s TCO device (Version=%d, TCOBASE=0x%04llx)\n",
> -               pdata->name, pdata->version, (u64)TCOBASE);
> +               pdata->name, pdata->version, (u64)TCOBASE(p));
>
>         /* Clear out the (probably old) status */
> -       switch (iTCO_wdt_private.iTCO_version) {
> +       switch (p->iTCO_version) {
>         case 5:
>         case 4:
> -               outw(0x0008, TCO1_STS); /* Clear the Time Out Status bit */
> -               outw(0x0002, TCO2_STS); /* Clear SECOND_TO_STS bit */
> +               outw(0x0008, TCO1_STS(p)); /* Clear the Time Out Status bit */
> +               outw(0x0002, TCO2_STS(p)); /* Clear SECOND_TO_STS bit */
>                 break;
>         case 3:
> -               outl(0x20008, TCO1_STS);
> +               outl(0x20008, TCO1_STS(p));
>                 break;
>         case 2:
>         case 1:
>         default:
> -               outw(0x0008, TCO1_STS); /* Clear the Time Out Status bit */
> -               outw(0x0002, TCO2_STS); /* Clear SECOND_TO_STS bit */
> -               outw(0x0004, TCO2_STS); /* Clear BOOT_STS bit */
> +               outw(0x0008, TCO1_STS(p)); /* Clear the Time Out Status bit */
> +               outw(0x0002, TCO2_STS(p)); /* Clear SECOND_TO_STS bit */
> +               outw(0x0004, TCO2_STS(p)); /* Clear BOOT_STS bit */
>                 break;
>         }
>
> -       iTCO_wdt_watchdog_dev.bootstatus = 0;
> -       iTCO_wdt_watchdog_dev.timeout = WATCHDOG_TIMEOUT;
> -       watchdog_set_nowayout(&iTCO_wdt_watchdog_dev, nowayout);
> -       iTCO_wdt_watchdog_dev.parent = &dev->dev;
> +       p->wddev.info = &ident,
> +       p->wddev.ops = &iTCO_wdt_ops,
> +       p->wddev.bootstatus = 0;
> +       p->wddev.timeout = WATCHDOG_TIMEOUT;
> +       watchdog_set_nowayout(&p->wddev, nowayout);
> +       p->wddev.parent = &dev->dev;
> +
> +       watchdog_set_drvdata(&p->wddev, p);
> +       platform_set_drvdata(dev, p);
>
>         /* Make sure the watchdog is not running */
> -       iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);
> +       iTCO_wdt_stop(&p->wddev);
>
>         /* Check that the heartbeat value is within it's range;
>            if not reset to the default */
> -       if (iTCO_wdt_set_timeout(&iTCO_wdt_watchdog_dev, heartbeat)) {
> -               iTCO_wdt_set_timeout(&iTCO_wdt_watchdog_dev, WATCHDOG_TIMEOUT);
> +       if (iTCO_wdt_set_timeout(&p->wddev, heartbeat)) {
> +               iTCO_wdt_set_timeout(&p->wddev, WATCHDOG_TIMEOUT);
>                 pr_info("timeout value out of range, using %d\n",
>                         WATCHDOG_TIMEOUT);
>         }
>
> -       ret = watchdog_register_device(&iTCO_wdt_watchdog_dev);
> +       ret = watchdog_register_device(&p->wddev);
>         if (ret != 0) {
>                 pr_err("cannot register watchdog device (err=%d)\n", ret);
>                 goto unreg_tco;
> @@ -558,38 +567,34 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>         return 0;
>
>  unreg_tco:
> -       release_region(iTCO_wdt_private.tco_res->start,
> -                       resource_size(iTCO_wdt_private.tco_res));
> +       release_region(p->tco_res->start, resource_size(p->tco_res));
>  unreg_smi:
> -       release_region(iTCO_wdt_private.smi_res->start,
> -                       resource_size(iTCO_wdt_private.smi_res));
> +       release_region(p->smi_res->start, resource_size(p->smi_res));
>  unmap_gcs_pmc:
> -       if (iTCO_wdt_private.iTCO_version >= 2)
> -               iounmap(iTCO_wdt_private.gcs_pmc);
> +       if (p->iTCO_version >= 2)
> +               iounmap(p->gcs_pmc);
>  unreg_gcs_pmc:
> -       if (iTCO_wdt_private.iTCO_version >= 2)
> -               release_mem_region(iTCO_wdt_private.gcs_pmc_res->start,
> -                               resource_size(iTCO_wdt_private.gcs_pmc_res));
> -out:
> -       iTCO_wdt_private.tco_res = NULL;
> -       iTCO_wdt_private.smi_res = NULL;
> -       iTCO_wdt_private.gcs_pmc_res = NULL;
> -       iTCO_wdt_private.gcs_pmc = NULL;
> -
> +       if (p->iTCO_version >= 2)
> +               release_mem_region(p->gcs_pmc_res->start,
> +                                  resource_size(p->gcs_pmc_res));
>         return ret;
>  }
>
>  static int iTCO_wdt_remove(struct platform_device *dev)
>  {
> -       if (iTCO_wdt_private.tco_res || iTCO_wdt_private.smi_res)
> -               iTCO_wdt_cleanup();
> +       struct iTCO_wdt_private *p = platform_get_drvdata(dev);
> +
> +       if (p->tco_res || p->smi_res)
> +               iTCO_wdt_cleanup(p);
>
>         return 0;
>  }
>
>  static void iTCO_wdt_shutdown(struct platform_device *dev)
>  {
> -       iTCO_wdt_stop(NULL);
> +       struct iTCO_wdt_private *p = platform_get_drvdata(dev);
> +
> +       iTCO_wdt_stop(&p->wddev);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> @@ -610,21 +615,24 @@ static inline bool need_suspend(void) { return true; }
>
>  static int iTCO_wdt_suspend_noirq(struct device *dev)
>  {
> +       struct iTCO_wdt_private *p = dev_get_drvdata(dev);
>         int ret = 0;
>
> -       iTCO_wdt_private.suspended = false;
> -       if (watchdog_active(&iTCO_wdt_watchdog_dev) && need_suspend()) {
> -               ret = iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);
> +       p->suspended = false;
> +       if (watchdog_active(&p->wddev) && need_suspend()) {
> +               ret = iTCO_wdt_stop(&p->wddev);
>                 if (!ret)
> -                       iTCO_wdt_private.suspended = true;
> +                       p->suspended = true;
>         }
>         return ret;
>  }
>
>  static int iTCO_wdt_resume_noirq(struct device *dev)
>  {
> -       if (iTCO_wdt_private.suspended)
> -               iTCO_wdt_start(&iTCO_wdt_watchdog_dev);
> +       struct iTCO_wdt_private *p = dev_get_drvdata(dev);
> +
> +       if (p->suspended)
> +               iTCO_wdt_start(&p->wddev);
>
>         return 0;
>  }
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
