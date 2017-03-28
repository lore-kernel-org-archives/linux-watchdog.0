Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44086 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754899AbdC1JM3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 05:12:29 -0400
Date: Tue, 28 Mar 2017 02:12:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        wim@iguana.be, sathyaosid@gmail.com, david.e.box@linux.intel.com,
        rajneesh.bhardwaj@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [v3,3/5] watchdog: iTCO_wdt: Add PMC specific noreboot update api
Message-ID: <20170328091218.GA15828@roeck-us.net>
References: <08193e33a1114de5401eb135691dea93dc9ec2a7.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08193e33a1114de5401eb135691dea93dc9ec2a7.1489801590.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 17, 2017 at 07:06:20PM -0700, Kuppuswamy Sathyanarayanan wrote:
> In some SOCs, setting noreboot bit needs modification to
> PMC GC registers. But not all PMC drivers allow other drivers
> to memory map their GC region. This could create mem request
> conflict in watchdog driver. So this patch adds facility to allow
> PMC drivers to pass noreboot update function to watchdog
> drivers via platform data.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Not entirely happy, but I don't have a better idea either.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/iTCO_wdt.c            | 28 +++++++++++++++++++---------
>  include/linux/platform_data/itco_wdt.h |  1 +
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> Changes since v2: 
>  * Removed use of PMC API's directly in watchdog driver.
>  * Added update_noreboot_flag to handle no IPC PMC compatibility
>    issue mentioned by Guenter.
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 3d0abc0..7c34259 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -100,6 +100,8 @@ struct iTCO_wdt_private {
>  	 */
>  	struct resource *gcs_pmc_res;
>  	unsigned long __iomem *gcs_pmc;
> +	/* pmc specific api to update noreboot flag */
> +	int (*update_noreboot_flag)(bool status);
>  	/* the lock for io operations */
>  	spinlock_t io_lock;
>  	/* the PCI-device */
> @@ -176,9 +178,13 @@ static void iTCO_wdt_set_NO_REBOOT_bit(struct iTCO_wdt_private *p)
>  
>  	/* Set the NO_REBOOT bit: this disables reboots */
>  	if (p->iTCO_version >= 2) {
> -		val32 = readl(p->gcs_pmc);
> -		val32 |= no_reboot_bit(p);
> -		writel(val32, p->gcs_pmc);
> +		if (p->update_noreboot_flag)
> +			p->update_noreboot_flag(1);
> +		else {
> +			val32 = readl(p->gcs_pmc);
> +			val32 |= no_reboot_bit(p);
> +			writel(val32, p->gcs_pmc);
> +		}
>  	} else if (p->iTCO_version == 1) {
>  		pci_read_config_dword(p->pci_dev, 0xd4, &val32);
>  		val32 |= no_reboot_bit(p);
> @@ -193,11 +199,14 @@ static int iTCO_wdt_unset_NO_REBOOT_bit(struct iTCO_wdt_private *p)
>  
>  	/* Unset the NO_REBOOT bit: this enables reboots */
>  	if (p->iTCO_version >= 2) {
> -		val32 = readl(p->gcs_pmc);
> -		val32 &= ~enable_bit;
> -		writel(val32, p->gcs_pmc);
> -
> -		val32 = readl(p->gcs_pmc);
> +		if (p->update_noreboot_flag)
> +			return p->update_noreboot_flag(0);
> +		else {
> +			val32 = readl(p->gcs_pmc);
> +			val32 &= ~enable_bit;
> +			writel(val32, p->gcs_pmc);
> +			val32 = readl(p->gcs_pmc);
> +		}
>  	} else if (p->iTCO_version == 1) {
>  		pci_read_config_dword(p->pci_dev, 0xd4, &val32);
>  		val32 &= ~enable_bit;
> @@ -426,13 +435,14 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	p->iTCO_version = pdata->version;
> +	p->update_noreboot_flag = pdata->update_noreboot_flag;
>  	p->pci_dev = to_pci_dev(dev->parent);
>  
>  	/*
>  	 * Get the Memory-Mapped GCS or PMC register, we need it for the
>  	 * NO_REBOOT flag (TCO v2 and v3).
>  	 */
> -	if (p->iTCO_version >= 2) {
> +	if (p->iTCO_version >= 2 && !p->update_noreboot_flag) {
>  		p->gcs_pmc_res = platform_get_resource(pdev,
>  						       IORESOURCE_MEM,
>  						       ICH_RES_MEM_GCS_PMC);
> diff --git a/include/linux/platform_data/itco_wdt.h b/include/linux/platform_data/itco_wdt.h
> index f16542c..ea1efb7 100644
> --- a/include/linux/platform_data/itco_wdt.h
> +++ b/include/linux/platform_data/itco_wdt.h
> @@ -14,6 +14,7 @@
>  struct itco_wdt_platform_data {
>  	char name[32];
>  	unsigned int version;
> +	int (*update_noreboot_flag)(bool status);
>  };
>  
>  #endif /* _ITCO_WDT_H_ */
