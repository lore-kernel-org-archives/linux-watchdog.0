Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39142 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeGJPrV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 11:47:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so7800132plq.6
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Jul 2018 08:47:21 -0700 (PDT)
Date: Tue, 10 Jul 2018 08:47:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        festevam@gmail.com
Subject: Re: [PATCH 2/2] watchdog: imx2_wdt: Switch to SPDX identifier
Message-ID: <20180710154719.GA10635@roeck-us.net>
References: <1531232412-28889-1-git-send-email-fabio.estevam@nxp.com>
 <1531232412-28889-2-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531232412-28889-2-git-send-email-fabio.estevam@nxp.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wrong subject.

Guenter

On Tue, Jul 10, 2018 at 11:20:12AM -0300, Fabio Estevam wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/watchdog/stmp3xxx_rtc_wdt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> index d8b11eb..994c54c 100644
> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Watchdog driver for the RTC based watchdog in STMP3xxx and i.MX23/28
>   *
>   * Author: Wolfram Sang <kernel@pengutronix.de>
>   *
>   * Copyright (C) 2011-12 Wolfram Sang, Pengutronix
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -- 
> 2.7.4
> 
