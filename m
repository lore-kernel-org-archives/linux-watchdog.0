Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:54953 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdJVRfR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:35:17 -0400
Received: by mail-pf0-f194.google.com with SMTP id n89so15438851pfk.11
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:35:17 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:35:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, lee.jones@linaro.org,
        support.opensource@diasemi.com, wim@iguana.be,
        kernel@pengutronix.de, Stefan Christ <s.christ@phytec.de>
Subject: Re: [2/6] mfd: da9062: make register CONFIG_I writable
Message-ID: <20171022173515.GA19932@roeck-us.net>
References: <20171017153027.24665-3-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017153027.24665-3-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 17, 2017 at 05:30:23PM +0200, Michael Grzeschik wrote:
> From: Stefan Christ <s.christ@phytec.de>
> 
> Make the config register CONFIG_I writable to change the watchdog mode.
> The datasheet does not mention exactly whether these registers should be
> read-only or writeable. But writing to those registers works at runtime.
> Only on reset they are reseted.
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/mfd/da9062-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index fe1811523e4a7..f5c7bd9dc32d5 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -727,6 +727,10 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
>  		.range_min = DA9062AA_BBAT_CONT,
>  		.range_max = DA9062AA_BBAT_CONT,
>  	}, {
> +		/* CONFIG_I must be writable to set WATCHDOG_SD */
> +		.range_min = DA9062AA_CONFIG_I,
> +		.range_max = DA9062AA_CONFIG_I,
> +	}, {
>  		.range_min = DA9062AA_GP_ID_0,
>  		.range_max = DA9062AA_GP_ID_19,
>  	},
