Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35977 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdIOWmW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 15 Sep 2017 18:42:22 -0400
Date: Fri, 15 Sep 2017 15:42:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mathieu Malaterre <malat@debian.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] watchdog: jz4740: Add support for the watchdog in
 jz4780 SoC
Message-ID: <20170915224220.GB3420@roeck-us.net>
References: <20170915192020.27717-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915192020.27717-1-malat@debian.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 15, 2017 at 09:20:19PM +0200, Mathieu Malaterre wrote:
> The watchdog unit present in the JZ4780 works the same as the one in the
> JZ4740.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> Changes in v2:
> * do not re-use the compatible string for different SoC (Paul Cercueil)

I thought that was one of the specific features of compatible statements,
to avoid having to change the driver each time a new chip comes along.
Did that change recently ?

Guenter

> 
>  drivers/watchdog/jz4740_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 20627f22baf6..aafbeb96561b 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -146,6 +146,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>  #ifdef CONFIG_OF
>  static const struct of_device_id jz4740_wdt_of_matches[] = {
>  	{ .compatible = "ingenic,jz4740-watchdog", },
> +	{ .compatible = "ingenic,jz4780-watchdog", },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
> -- 
> 2.11.0
> 
