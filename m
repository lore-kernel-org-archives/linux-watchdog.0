Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47189 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbdGHBpP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Jul 2017 21:45:15 -0400
Subject: Re: [PATCH] watchdog: stm32_iwdg: constify watchdog_ops structure
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20170708002857.GA12556@embeddedgus>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0082d827-3e07-ed28-a122-3dee8e438748@roeck-us.net>
Date: Fri, 7 Jul 2017 18:45:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170708002857.GA12556@embeddedgus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/07/2017 05:28 PM, Gustavo A. R. Silva wrote:
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
>   drivers/watchdog/stm32_iwdg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index 6c501b7..be64a86 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -140,7 +140,7 @@ static const struct watchdog_info stm32_iwdg_info = {
>   	.identity	= "STM32 Independent Watchdog",
>   };
>   
> -static struct watchdog_ops stm32_iwdg_ops = {
> +static const struct watchdog_ops stm32_iwdg_ops = {
>   	.owner		= THIS_MODULE,
>   	.start		= stm32_iwdg_start,
>   	.ping		= stm32_iwdg_ping,
> 

