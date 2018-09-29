Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41285 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3AsZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 29 Sep 2018 20:48:25 -0400
Date: Sat, 29 Sep 2018 11:18:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [v3,2/3] watchdog: mpc8xxx: provide boot status
Message-ID: <20180929181858.GA5758@roeck-us.net>
References: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 17, 2018 at 06:22:50AM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver supports the following platforms:
> - mpc8xx
> - mpc83xx
> - mpc86xx
> 
> Those three platforms have a 32 bits register which provides the
> reason of the last boot, including whether it was caused by the
> watchdog.
> 
> mpc8xx: Register RSR, bit SWRS (bit 3)
> mpc83xx: Register RSR, bit SWRS (bit 28)
> mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)
> 
> This patch maps the register as defined in the device tree and updates
> wdt.bootstatus based on the value of the watchdog related bit. Then
> the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.
> 
> Hereunder is an example of devicetree for mpc8xx,
> the Reset Status Register being at offset 0x288:
> 
> 		WDT: watchdog@0 {
> 			compatible = "fsl,mpc823-wdt";
> 			reg = <0x0 0x10 0x288 0x4>;
> 		};
> 
> On the mpc83xx, RSR is at offset 0x910
> On the mpc86xx, RSTRSCR is at offset 0xe0094
> 
> Suggested-by: Radu Rendec <radu.rendec@gmail.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 1dcf5f10cdd9..069072e6747d 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
>  struct mpc8xxx_wdt_type {
>  	int prescaler;
>  	bool hw_enabled;
> +	u32 rsr_mask;
>  };
>  
>  struct mpc8xxx_wdt_ddata {
> @@ -159,6 +160,24 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  		return -ENODEV;
>  	}
>  
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		bool status;
> +		u32 __iomem *rsr = ioremap(res->start, resource_size(res));
> +
> +		if (!rsr)
> +			return -ENOMEM;
> +
> +		status = in_be32(rsr) & wdt_type->rsr_mask;
> +		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
> +		 /* clear reset status bits related to watchdog timer */
> +		out_be32(rsr, wdt_type->rsr_mask);
> +		iounmap(rsr);
> +
> +		dev_info(dev, "Last boot was %scaused by watchdog\n",
> +			 status ? "" : "not ");
> +	}
> +
>  	spin_lock_init(&ddata->lock);
>  
>  	ddata->wdd.info = &mpc8xxx_wdt_info,
> @@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.compatible = "mpc83xx_wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
> +			.rsr_mask = BIT(3), /* RSR Bit SWRS */
>  		},
>  	},
>  	{
> @@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
>  		},
>  	},
>  	{
> @@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x800,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(28), /* RSR Bit SWRS */
>  		},
>  	},
>  	{},
