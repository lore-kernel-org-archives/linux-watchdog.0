Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46978 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbdGHBou (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 21:44:50 -0400
Subject: Re: [PATCH] watchdog: it87_wdt: constify watchdog_ops structure
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170708002321.GA10649@embeddedgus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1de9db10-3adb-ca7c-c737-d31553d087de@roeck-us.net>
Date: Fri, 7 Jul 2017 18:44:48 -0700
MIME-Version: 1.0
In-Reply-To: <20170708002321.GA10649@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/07/2017 05:23 PM, Gustavo A. R. Silva wrote:
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
>   drivers/watchdog/it87_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
> index dd1e7ea..e96faea 100644
> --- a/drivers/watchdog/it87_wdt.c
> +++ b/drivers/watchdog/it87_wdt.c
> @@ -253,7 +253,7 @@ static const struct watchdog_info ident = {
>   	.identity = WATCHDOG_NAME,
>   };
>   
> -static struct watchdog_ops wdt_ops = {
> +static const struct watchdog_ops wdt_ops = {
>   	.owner = THIS_MODULE,
>   	.start = wdt_start,
>   	.stop = wdt_stop,
> 

