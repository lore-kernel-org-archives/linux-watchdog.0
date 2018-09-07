Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAXi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Sep 2018 20:23:38 -0400
Date: Fri, 7 Sep 2018 12:41:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: rza_wdt: convert to SPDX identifiers
Message-ID: <20180907194112.GC3515@roeck-us.net>
References: <87woryoyfx.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woryoyfx.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 07, 2018 at 02:11:17AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rza_wdt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
> index e618218..c63ef03 100644
> --- a/drivers/watchdog/rza_wdt.c
> +++ b/drivers/watchdog/rza_wdt.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Renesas RZ/A Series WDT Driver
>   *
>   * Copyright (C) 2017 Renesas Electronics America, Inc.
>   * Copyright (C) 2017 Chris Brandt
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
>   */
>  
>  #include <linux/bitops.h>
> -- 
> 2.7.4
> 
