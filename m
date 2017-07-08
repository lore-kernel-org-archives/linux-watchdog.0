Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47459 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbdGHBpf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 21:45:35 -0400
Subject: Re: [PATCH] watchdog: coh901327_wdt: constify watchdog_ops structure
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170708003330.GA15374@embeddedgus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <031cf1ab-7f1b-4e4d-adaf-efa6c3af8040@roeck-us.net>
Date: Fri, 7 Jul 2017 18:45:32 -0700
MIME-Version: 1.0
In-Reply-To: <20170708003330.GA15374@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/07/2017 05:33 PM, Gustavo A. R. Silva wrote:
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
>   drivers/watchdog/coh901327_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
> index 38dd60f0..4410337 100644
> --- a/drivers/watchdog/coh901327_wdt.c
> +++ b/drivers/watchdog/coh901327_wdt.c
> @@ -218,7 +218,7 @@ static const struct watchdog_info coh901327_ident = {
>   	.identity = DRV_NAME,
>   };
>   
> -static struct watchdog_ops coh901327_ops = {
> +static const struct watchdog_ops coh901327_ops = {
>   	.owner = THIS_MODULE,
>   	.start = coh901327_start,
>   	.stop = coh901327_stop,
> 

