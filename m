Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47363 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933847AbdDFLmJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Apr 2017 07:42:09 -0400
Subject: Re: [PATCH v6 4/6] watchdog: iTCO_wdt: Add PMC specific noreboot
 update api
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>, andy@infradead.org,
        qipeng.zha@intel.com, dvhart@infradead.org
References: <3e7ca77c-2be5-5f89-f51f-faaca9f2d9ac@linux.intel.com>
 <686dfb634cc072d66080f6983900eefde8d85b5e.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: wim@iguana.be, sathyaosid@gmail.com, david.e.box@linux.intel.com,
        rajneesh.bhardwaj@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7c48df01-b641-40d9-95d3-8724d34f5c8d@roeck-us.net>
Date: Thu, 6 Apr 2017 04:42:04 -0700
MIME-Version: 1.0
In-Reply-To: <686dfb634cc072d66080f6983900eefde8d85b5e.1491428146.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/05/2017 03:54 PM, Kuppuswamy Sathyanarayanan wrote:
> In some SoCs, setting noreboot bit needs modification to
> PMC GC registers. But not all PMC drivers allow other drivers
> to memory map their GC region. This could create mem request
> conflict in watchdog driver. So this patch adds facility to allow
> PMC drivers to pass noreboot update function to watchdog
> drivers via platform data.
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/iTCO_wdt.c            | 20 ++++++++++++++------
>  include/linux/platform_data/itco_wdt.h |  4 ++++
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> Changes since v5:
>  * Added priv_data to pass private data to no_reboot_bit update function.
>  * Changed update_noreboot_flag() to update_no_reboot_bit
>
> Changes since v4:
>  * Fixed some style issues.
>  * used false for 0 and true for 1 in update_noreboot_flag function.
>
> Changes since v3:
>  * Rebased on top of latest.
>
> Changes since v2:
>  * Removed use of PMC API's directly in watchdog driver.
>  * Added update_noreboot_flag to handle no IPC PMC compatibility
>    issue mentioned by Guenter.
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index d8768a2..3f00029 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -106,6 +106,8 @@ struct iTCO_wdt_private {
>  	struct pci_dev *pci_dev;
>  	/* whether or not the watchdog has been suspended */
>  	bool suspended;
> +	/* no reboot API private data */
> +	void *no_reboot_priv;
>  	/* no reboot update function pointer */
>  	int (*update_no_reboot_bit)(void *p, bool set);
>  };
> @@ -225,6 +227,8 @@ void iTCO_wdt_no_reboot_bit_setup(struct iTCO_wdt_private *p)
>  		p->update_no_reboot_bit = update_no_reboot_bit_pci;
>  	else
>  		p->update_no_reboot_bit = update_no_reboot_bit_def;
> +
> +	p->no_reboot_priv = p;
>  }
>
>  static int iTCO_wdt_start(struct watchdog_device *wd_dev)
> @@ -237,7 +241,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  	iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
>
>  	/* disable chipset's NO_REBOOT bit */
> -	if (p->update_no_reboot_bit(p, false)) {
> +	if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
>  		spin_unlock(&p->io_lock);
>  		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
>  		return -EIO;
> @@ -278,7 +282,7 @@ static int iTCO_wdt_stop(struct watchdog_device *wd_dev)
>  	val = inw(TCO1_CNT(p));
>
>  	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
> -	p->update_no_reboot_bit(p, true);
> +	p->update_no_reboot_bit(p->no_reboot_priv, true);
>
>  	spin_unlock(&p->io_lock);
>
> @@ -442,14 +446,18 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>
>  	p->iTCO_version = pdata->version;
>  	p->pci_dev = to_pci_dev(dev->parent);
> +	p->no_reboot_priv = pdata->no_reboot_priv;
>

This is really only for the if case below, and would be wrong otherwise.

> -	iTCO_wdt_no_reboot_bit_setup(p);
> +	if (pdata->update_no_reboot_bit)
> +		p->update_no_reboot_bit = pdata->update_no_reboot_bit;

Can you move that initialization here ? Or, even better, pass pdata to
iTCO_wdt_no_reboot_bit_setup() and initialize it there.

> +	else
> +		iTCO_wdt_no_reboot_bit_setup(p);
>
>  	/*
>  	 * Get the Memory-Mapped GCS or PMC register, we need it for the
>  	 * NO_REBOOT flag (TCO v2 and v3).
>  	 */
> -	if (p->iTCO_version >= 2) {
> +	if (p->iTCO_version >= 2 && !pdata->update_no_reboot_bit) {
>  		p->gcs_pmc_res = platform_get_resource(pdev,
>  						       IORESOURCE_MEM,
>  						       ICH_RES_MEM_GCS_PMC);
> @@ -459,14 +467,14 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	}
>
>  	/* Check chipset's NO_REBOOT bit */
> -	if (p->update_no_reboot_bit(p, false) &&
> +	if (p->update_no_reboot_bit(p->no_reboot_priv, false) &&
>  	    iTCO_vendor_check_noreboot_on()) {
>  		pr_info("unable to reset NO_REBOOT flag, device disabled by hardware/BIOS\n");
>  		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
>  	}
>
>  	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
> -	p->update_no_reboot_bit(p, true);
> +	p->update_no_reboot_bit(p->no_reboot_priv, true);
>
>  	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
>  	if (!devm_request_region(dev, p->smi_res->start,
> diff --git a/include/linux/platform_data/itco_wdt.h b/include/linux/platform_data/itco_wdt.h
> index f16542c..0e95527 100644
> --- a/include/linux/platform_data/itco_wdt.h
> +++ b/include/linux/platform_data/itco_wdt.h
> @@ -14,6 +14,10 @@
>  struct itco_wdt_platform_data {
>  	char name[32];
>  	unsigned int version;
> +	/* private data to be passed to update_no_reboot_bit API */
> +	void *no_reboot_priv;
> +	/* pointer for platform specific no reboot update function */
> +	int (*update_no_reboot_bit)(void *priv, bool set);
>  };
>
>  #endif /* _ITCO_WDT_H_ */
>

