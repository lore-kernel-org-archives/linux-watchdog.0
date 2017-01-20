Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754013AbdATByK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Jan 2017 20:54:10 -0500
Date: Fri, 20 Jan 2017 09:53:39 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: jun.nie@linaro.org, wim@iguana.be, linux@roeck-us.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xie.baoyou@zte.com.cn,
        chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Subject: Re: [PATCH v2 1/3] dt: bindings: add documentation for zx2967 family
 watchdog controller
Message-ID: <20170120015337.GA17299@dragon>
References: <1484791192-31674-1-git-send-email-baoyou.xie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484791192-31674-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jan 19, 2017 at 09:59:50AM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zx2967 family
> watchdog controller.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

It seems that the comments I put on v1 remains unresolved.

> ---
>  .../bindings/watchdog/zte,zx2967-wdt.txt           | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt b/Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
> new file mode 100644
> index 0000000..6e35ce7
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
> +- clock-names: "wdtclk" for the watchdog clock.
> +- resets : Reference to the reset controller controlling the watchdog
> +           controller.
> +- reset-names : Must include the following entries:
> +       * wdtrst

I do not think clock-names and reset-names are really necessary, since
there is only one clock and reset signal.

> +
> +Optional properties:
> +
> +- wdt-reset-sysctrl : should include following fields.

We need a vendor prefix for vendor specific property.

> +	* phandle of aon-sysctrl.
> +	* configuare value that be wrote to aon-sysctrl.

s/configuare/configure, s/wrote/written

> +	* bit mask, corresponding bits will be affected.

I think we need some comments for bindings users to understand the
different role between "resets" and "wdt-reset-sysctrl".  Also, why is
wdt-reset-sysctrl is optional?  Does it still work well without this
property.

FYI. I have a similar bindings for TVENC below, which you may find
useful.

http://www.spinics.net/lists/devicetree/msg159668.html

> +
> +Example:
> +
> +wdt_ares: watchdog@1465000 {

What does the suffix "ares" mean?  I guess "wdt" is good enough as the
label name.

Shawn

> +	compatible = "zte,zx296718-wdt";
> +	reg = <0x1465000 0x1000>;
> +	clocks = <&topcrm WDT_WCLK>;
> +	clock-names = "wdtclk";
> +	resets = <&toprst 35>;
> +	reset-names = "wdtrst";
> +	wdt-reset-sysctrl = <&aon_sysctrl 1 0x115>;
> +};
> -- 
> 2.7.4
> 
