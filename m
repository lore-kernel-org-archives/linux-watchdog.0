Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36021 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdIJPRd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 10 Sep 2017 11:17:33 -0400
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: Add Realtek RTD1295
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20170904231602.29787-1-afaerber@suse.de>
 <20170904231602.29787-2-afaerber@suse.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e66bbc5-3907-d39d-8f2b-eda28269373e@roeck-us.net>
Date: Sun, 10 Sep 2017 08:17:30 -0700
MIME-Version: 1.0
In-Reply-To: <20170904231602.29787-2-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/04/2017 04:16 PM, Andreas Färber wrote:
> Add a binding for the Realtek RTD1295 watchdog.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas Färber <afaerber@suse.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   v1 -> v2: Unchanged
>   
>   .../devicetree/bindings/watchdog/realtek,rtd119x.txt    | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
> new file mode 100644
> index 000000000000..05653054bd5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
> @@ -0,0 +1,17 @@
> +Realtek RTD1295 Watchdog
> +========================
> +
> +Required properties:
> +
> +- compatible :  Should be "realtek,rtd1295-watchdog"
> +- reg        :  Specifies the physical base address and size of registers
> +- clocks     :  Specifies one clock input
> +
> +
> +Example:
> +
> +	watchdog@98007680 {
> +		compatible = "realtek,rtd1295-watchdog";
> +		reg = <0x98007680 0x100>;
> +		clocks = <&osc27M>;
> +	};
> 

