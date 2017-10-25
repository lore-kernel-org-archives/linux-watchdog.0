Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:56835 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdJYU5x (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Oct 2017 16:57:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id b85so836018pfj.13
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Oct 2017 13:57:53 -0700 (PDT)
Date: Wed, 25 Oct 2017 13:57:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 4/4] watchdog: i6300esb: bump version to 0.6
Message-ID: <20171025205751.GD30439@roeck-us.net>
References: <20171022170947.GA6997@roeck-us.net>
 <20171025153914.3467-4-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171025153914.3467-4-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 25, 2017 at 04:39:14PM +0100, Radu Rendec wrote:
> The new version incorporates two major changes:
> * Watchdog subsystem support - allows the driver to coexist with other
>   watchdog drivers; simplifies the code base
> * Multiple device support - supports multiple 6300ESB timer devices and
>   and exposes them as separate watchdogs
> 

Can you drop the version number instead ? It doesn't really serve a
useful purpose and ran out of favor upstream.

Thanks,
Guenter

> Signed-off-by: Radu Rendec <rrendec@arista.com>
> ---
>  drivers/watchdog/i6300esb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
> index 3f7f66513dfa..fba81fa2f1c1 100644
> --- a/drivers/watchdog/i6300esb.c
> +++ b/drivers/watchdog/i6300esb.c
> @@ -45,7 +45,7 @@
>  #include <linux/io.h>
>  
>  /* Module and version information */
> -#define ESB_VERSION "0.05"
> +#define ESB_VERSION "0.06"
>  #define ESB_MODULE_NAME "i6300ESB timer"
>  
>  /* PCI configuration registers */
> -- 
> 2.13.6
> 
