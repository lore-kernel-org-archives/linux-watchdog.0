Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46792 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdGHBod (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 21:44:33 -0400
Subject: Re: [PATCH] watchdog: ts72xx_wdt: constify watchdog_ops structure
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170708001840.GA8758@embeddedgus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ef62d519-2b18-816a-5253-89f5fc276332@roeck-us.net>
Date: Fri, 7 Jul 2017 18:44:30 -0700
MIME-Version: 1.0
In-Reply-To: <20170708001840.GA8758@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/07/2017 05:18 PM, Gustavo A. R. Silva wrote:
> Check for watchdog_ops structures that are only stored in the ops field of
> a watchdog_device structure. This field is declared const, so watchdog_ops
> structures that have this property can be declared as const also.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @r
> disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_ops i@p = { ... };
> 
> @ok@
> identifier r.i;
> struct watchdog_device e;
> position p;
> @@
> e.ops = &i@p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct watchdog_ops e;
> @@
> e@i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>   struct watchdog_ops i = { ... };
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ts72xx_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> index 17c25da..811e43c 100644
> --- a/drivers/watchdog/ts72xx_wdt.c
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -112,7 +112,7 @@ static const struct watchdog_info ts72xx_wdt_ident = {
>   	.identity		= "TS-72XX WDT",
>   };
>   
> -static struct watchdog_ops ts72xx_wdt_ops = {
> +static const struct watchdog_ops ts72xx_wdt_ops = {
>   	.owner		= THIS_MODULE,
>   	.start		= ts72xx_wdt_start,
>   	.stop		= ts72xx_wdt_stop,
> 

