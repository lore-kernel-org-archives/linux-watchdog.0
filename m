Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45621 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdBEAFY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Feb 2017 19:05:24 -0500
Subject: Re: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller driver
 to ARM ZTE architecture
To: Baoyou Xie <baoyou.xie@linaro.org>, jun.nie@linaro.org,
        wim@iguana.be, robh+dt@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
 <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
Date: Sat, 4 Feb 2017 16:05:21 -0800
MIME-Version: 1.0
In-Reply-To: <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/03/2017 05:34 PM, Baoyou Xie wrote:
> Add the zx2967 watchdog controller driver as maintained by ARM ZTE
> architecture maintainers, as they're parts of the core IP.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I assume you'll submit this patch through the arm tree ?

Guenter

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edfdea3..275c434 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1990,11 +1990,13 @@ F:	drivers/clk/zte/
>  F:	drivers/reset/reset-zx2967.c
>  F:	drivers/soc/zte/
>  F:	drivers/thermal/zx*
> +F:	drivers/watchdog/zx2967_wdt.c
>  F:	Documentation/devicetree/bindings/arm/zte.txt
>  F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
>  F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
>  F:	Documentation/devicetree/bindings/soc/zte/
>  F:	Documentation/devicetree/bindings/thermal/zx*
> +F:	Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
>  F:	include/dt-bindings/soc/zx*.h
>
>  ARM/ZYNQ ARCHITECTURE
>

