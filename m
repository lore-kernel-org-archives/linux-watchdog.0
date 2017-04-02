Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:33290 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdDBOE7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 2 Apr 2017 10:04:59 -0400
MIME-Version: 1.0
In-Reply-To: <e36dcfd637dd0fff2c3133cea0a541bdd3712418.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <e537ff68732d86418982349624fd6de741bccc9b.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170331133728.GA23725@rajaneesh-OptiPlex-9010> <e36dcfd637dd0fff2c3133cea0a541bdd3712418.1491002056.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Apr 2017 17:04:57 +0300
Message-ID: <CAHp75VcDQoVrGkBvwb7wXwUwG_ew+XDGnBmvvraDBJ4Oy0SkOQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] watchdog: iTCO_wdt: Add PMC specific noreboot
 update api
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>, sathyaosid@gmail.com,
        David Box <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 1, 2017 at 2:27 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> In some SOCs, setting noreboot bit needs modification to

SoCs.

Perhaps you can create a wikipage to share with your team what style
issues usually needs to be addressed.
One of them is a proper capitalization in abbreviations / code names.

> PMC GC registers. But not all PMC drivers allow other drivers
> to memory map their GC region. This could create mem request
> conflict in watchdog driver. So this patch adds facility to allow
> PMC drivers to pass noreboot update function to watchdog
> drivers via platform data.

> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -100,6 +100,8 @@ struct iTCO_wdt_private {
>          */
>         struct resource *gcs_pmc_res;
>         unsigned long __iomem *gcs_pmc;

> +       /* pmc specific api to update noreboot flag */

PMC
API

> +       int (*update_noreboot_flag)(bool status);
>         /* the lock for io operations */
>         spinlock_t io_lock;
>         /* the PCI-device */
> @@ -176,9 +178,13 @@ static void iTCO_wdt_set_NO_REBOOT_bit(struct iTCO_wdt_private *p)
>
>         /* Set the NO_REBOOT bit: this disables reboots */
>         if (p->iTCO_version >= 2) {
> -               val32 = readl(p->gcs_pmc);
> -               val32 |= no_reboot_bit(p);
> -               writel(val32, p->gcs_pmc);
> +               if (p->update_noreboot_flag)

> +                       p->update_noreboot_flag(1);

1 -> true for sake of consistency.

> +               else {
> +                       val32 = readl(p->gcs_pmc);
> +                       val32 |= no_reboot_bit(p);
> +                       writel(val32, p->gcs_pmc);
> +               }
>         } else if (p->iTCO_version == 1) {
>                 pci_read_config_dword(p->pci_dev, 0xd4, &val32);
>                 val32 |= no_reboot_bit(p);
> @@ -193,11 +199,14 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(struct iTCO_wdt_private *p)
>
>         /* Unset the NO_REBOOT bit: this enables reboots */
>         if (p->iTCO_version >= 2) {
> -               val32 = readl(p->gcs_pmc);
> -               val32 &= ~enable_bit;
> -               writel(val32, p->gcs_pmc);
> -
> -               val32 = readl(p->gcs_pmc);
> +               if (p->update_noreboot_flag)

> +                       return p->update_noreboot_flag(0);

0 -> false.

> +               else {

> +                       val32 = readl(p->gcs_pmc);
> +                       val32 &= ~enable_bit;
> +                       writel(val32, p->gcs_pmc);
> +                       val32 = readl(p->gcs_pmc);

This and similar above code might be split to a helper and you may
assign it once. In such case you will not need a special flag anymore.

Helpers split might be done as a preparatory separate patch.

-- 
With Best Regards,
Andy Shevchenko
