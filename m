Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49294 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbcCCE0U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2016 23:26:20 -0500
Date: Wed, 2 Mar 2016 20:26:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 6/6] watchdog: tangox_wdt: test clock rate to avoid
 division by 0
Message-ID: <20160303042618.GB4578@roeck-us.net>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
 <1456958018-7849-7-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456958018-7849-7-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 02, 2016 at 11:33:37PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The clk API may return 0 on clk_get_rate, so we should check the result before
> using it as a divisor.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Should go individually via subsystem tree.
> 
>  drivers/watchdog/tangox_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> index 709c1ed6fd79b9..cc702718ae4dbb 100644
> --- a/drivers/watchdog/tangox_wdt.c
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -139,6 +139,8 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>  		return err;
>  
>  	dev->clk_rate = clk_get_rate(dev->clk);
> +	if (!dev->clk_rate)
> +		return -EINVAL;

May be a nitpick, but clk_disable_unprepare() is missing.

Guenter

>  
>  	dev->wdt.parent = &pdev->dev;
>  	dev->wdt.info = &tangox_wdt_info;
> -- 
> 2.7.0
> 
