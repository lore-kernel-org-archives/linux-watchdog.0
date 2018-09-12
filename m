Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38394 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILVS5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Sep 2018 17:18:57 -0400
Date: Wed, 12 Sep 2018 09:13:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jagdish Tirumala <t.jag587@gmail.com>
Cc: wim@linux-watchdog.org, yamada.masahiro@socionext.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WATCHDOG: DIAG288_WDT: Fixed error POINTER_LOCATION
Message-ID: <20180912161342.GB3300@roeck-us.net>
References: <20180912155632.8060-1-t.jag587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912155632.8060-1-t.jag587@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 12, 2018 at 08:56:32AM -0700, Jagdish Tirumala wrote:
> Fixed ERROR:POINTER_LOCATION: "foo * bar" should be "foo *bar" in
> file drivers/watchdog/diag288_wdt.c
> 

Same as before.

Guenter

> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
> ---
>  drivers/watchdog/diag288_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index 806a04a676b7..046333d1beb2 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -199,7 +199,7 @@ static int wdt_ping(struct watchdog_device *dev)
>  	return ret;
>  }
>  
> -static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
> +static int wdt_set_timeout(struct watchdog_device *dev, unsigned int new_to)
>  {
>  	dev->timeout = new_to;
>  	return wdt_ping(dev);
> -- 
> 2.17.1
> 
