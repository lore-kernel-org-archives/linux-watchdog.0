Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:52226 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdJVRoS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:44:18 -0400
Date: Sun, 22 Oct 2017 10:44:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: wim@iguana.be, maxime.ripard@free-electrons.com, wens@csie.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: watchdog: sunxi_wdt: use of_device_get_match_data
Message-ID: <20171022174416.GA21100@roeck-us.net>
References: <20171021174513.1653-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171021174513.1653-1-clabbe.montjoie@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Oct 21, 2017 at 07:45:13PM +0200, Corentin Labbe wrote:
> The usage of of_device_get_match_data reduce the code size a bit.
> Furthermore, it prevents an improbable dereference when
> of_match_device() return NULL.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sunxi_wdt.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index 9728fa32c357..802e31b1416d 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -234,7 +234,6 @@ MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
>  static int sunxi_wdt_probe(struct platform_device *pdev)
>  {
>  	struct sunxi_wdt_dev *sunxi_wdt;
> -	const struct of_device_id *device;
>  	struct resource *res;
>  	int err;
>  
> @@ -242,12 +241,10 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
>  	if (!sunxi_wdt)
>  		return -EINVAL;
>  
> -	device = of_match_device(sunxi_wdt_dt_ids, &pdev->dev);
> -	if (!device)
> +	sunxi_wdt->wdt_regs = of_device_get_match_data(&pdev->dev);
> +	if (!sunxi_wdt->wdt_regs)
>  		return -ENODEV;
>  
> -	sunxi_wdt->wdt_regs = device->data;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sunxi_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(sunxi_wdt->wdt_base))
