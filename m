Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44519 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbdK1EJV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 27 Nov 2017 23:09:21 -0500
Subject: Re: [PATCH v7 1/2] dt-bindings: watchdog: Add Spreadtrum watchdog
 documentation
To: Eric Long <eric.long@spreadtrum.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: baolin.wang@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        huitao.yue@spreadtrum.com
References: <61f88b7f9c1ac8a2d4bd7dbab672ad913bd2707d.1511835645.git.eric.long@spreadtrum.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <445d1641-de20-860c-5448-4b1533426441@roeck-us.net>
Date: Mon, 27 Nov 2017 20:09:18 -0800
MIME-Version: 1.0
In-Reply-To: <61f88b7f9c1ac8a2d4bd7dbab672ad913bd2707d.1511835645.git.eric.long@spreadtrum.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/27/2017 06:18 PM, Eric Long wrote:
> This patch adds the documentation for Spreadtrum watchdog driver.
> 
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> Acked-by: Rob Herring <robh@kernel.org>

The patch series is in my tree, and will ultimately find its way into Wim's tree.
No need to resend it anymore.

In general, if a patch is available in
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-next
there is no need to resend it.

Thanks,
Guenter

> ---
> Changes since v6:
> - No updates.
> 
> Changes since v5:
> - No updates.
> 
> Changes since v4:
> - No updates.
> 
> Changes since v3:
> - No updates.
> 
> Changes since v2:
> - Add acked tag from Rob.
> 
> Changes since v1:
> - No updates.
> ---
>   .../devicetree/bindings/watchdog/sprd-wdt.txt         | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> new file mode 100644
> index 0000000..aeaf3e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> @@ -0,0 +1,19 @@
> +Spreadtrum SoCs Watchdog timer
> +
> +Required properties:
> +- compatible : Should be "sprd,sp9860-wdt".
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : Exactly one interrupt specifier.
> +- timeout-sec : Contain the default watchdog timeout in seconds.
> +- clock-names : Contain the input clock names.
> +- clocks : Phandles to input clocks.
> +
> +Example:
> +	watchdog: watchdog@40310000 {
> +		compatible = "sprd,sp9860-wdt";
> +		reg = <0 0x40310000 0 0x1000>;
> +		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +		timeout-sec = <12>;
> +		clock-names = "enable", "rtc_enable";
> +		clocks = <&clk_aon_apb_gates1 8>, <&clk_aon_apb_rtc_gates 9>;
> +	};
> 

