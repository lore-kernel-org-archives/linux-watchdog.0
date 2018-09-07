Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34309 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeIHAXU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Sep 2018 20:23:20 -0400
Date: Fri, 7 Sep 2018 12:40:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: renesas_wdt: convert to SPDX identifiers
Message-ID: <20180907194053.GB3515@roeck-us.net>
References: <87y3ceoygh.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3ceoygh.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 07, 2018 at 02:10:58AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/renesas_wdt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 88d81fe..84bb9d3 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Watchdog driver for Renesas WDT watchdog
>   *
>   * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
>   * Copyright (C) 2015-17 Renesas Electronics Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
>   */
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> -- 
> 2.7.4
> 
