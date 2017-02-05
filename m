Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56258 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbdBEAEb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Feb 2017 19:04:31 -0500
Subject: Re: [PATCH v9 1/3] dt: bindings: add documentation for zx2967 family
 watchdog controller
To: Baoyou Xie <baoyou.xie@linaro.org>, jun.nie@linaro.org,
        wim@iguana.be, robh+dt@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <015a7f32-e0dd-223f-a15b-dd0972e8391c@roeck-us.net>
Date: Sat, 4 Feb 2017 16:04:26 -0800
MIME-Version: 1.0
In-Reply-To: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/03/2017 05:34 PM, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family
> watchdog controller.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../bindings/watchdog/zte,zx2967-wdt.txt           | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
> new file mode 100644
> index 0000000..06ce677
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
> @@ -0,0 +1,32 @@
> +ZTE zx2967 Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be one of the following.
> +       * zte,zx296718-wdt
> +- reg : Specifies base physical address and size of the registers.
> +- clocks : Pairs of phandle and specifier referencing the controller's clocks.
> +- resets : Reference to the reset controller controlling the watchdog
> +           controller.
> +
> +Optional properties:
> +
> +- timeout-sec : Contains the watchdog timeout in seconds.
> +- zte,wdt-reset-sysctrl : Directs how to reset system by the watchdog.
> +	if we don't want to restart system when watchdog been triggered,
> +	it's not required, vice versa.
> +	It should include following fields.
> +	  * phandle of aon-sysctrl.
> +	  * offset of register that be written, should be 0xb0.
> +	  * configure value that be written to aon-sysctrl.
> +	  * bit mask, corresponding bits will be affected.
> +
> +Example:
> +
> +wdt: watchdog@1465000 {
> +	compatible = "zte,zx296718-wdt";
> +	reg = <0x1465000 0x1000>;
> +	clocks = <&topcrm WDT_WCLK>;
> +	resets = <&toprst 35>;
> +	zte,wdt-reset-sysctrl = <&aon_sysctrl 0xb0 1 0x115>;
> +};
>

