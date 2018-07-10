Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42420 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbeGJVPP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 17:15:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id f4-v6so3960529plb.9
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Jul 2018 14:14:21 -0700 (PDT)
Date: Tue, 10 Jul 2018 14:14:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        festevam@gmail.com
Subject: Re: [PATCH v2 1/2] watchdog: imx2_wdt: Switch to SPDX identifier
Message-ID: <20180710211418.GA27827@roeck-us.net>
References: <1531232483-28950-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531232483-28950-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 10, 2018 at 11:21:22AM -0300, Fabio Estevam wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
> - None
> 
>  drivers/watchdog/imx2_wdt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index f07850d..2b52514 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Watchdog driver for IMX2 and later processors
>   *
> @@ -7,10 +8,6 @@
>   * some parts adapted by similar drivers from Darius Augulis and Vladimir
>   * Zapolskiy, additional improvements by Wim Van Sebroeck.
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - *
>   * NOTE: MX1 has a slightly different Watchdog than MX2 and later:
>   *
>   *			MX1:		MX2+:
> -- 
> 2.7.4
> 
