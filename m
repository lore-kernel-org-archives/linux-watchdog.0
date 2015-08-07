Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47370 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbbHGP1L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 11:27:11 -0400
Message-ID: <55C4CE49.3080700@roeck-us.net>
Date: Fri, 07 Aug 2015 08:27:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wenyou Yang <wenyou.yang@atmel.com>, wim@iguana.be,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
CC: sylvain.rochet@finsecur.com, nicolas.ferre@atmel.com,
	boris.brezillon@free-electrons.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v6 2/2] Documentation: dt: binding: atmel-sama5d4-wdt:
 for SAMA5D4 watchdog driver
References: <1438856146-2459-1-git-send-email-wenyou.yang@atmel.com> <1438856225-2540-1-git-send-email-wenyou.yang@atmel.com>
In-Reply-To: <1438856225-2540-1-git-send-email-wenyou.yang@atmel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/06/2015 03:17 AM, Wenyou Yang wrote:
> The compatible "atmel,sama5d4-wdt" supports the SAMA5D4 watchdog driver
> and the watchdog's WDT_MR register can be written more than once.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../bindings/watchdog/atmel-sama5d4-wdt.txt        |   35 ++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
> new file mode 100644
> index 0000000..f7cc7c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
> @@ -0,0 +1,35 @@
> +* Atmel SAMA5D4 Watchdog Timer (WDT) Controller
> +
> +Required properties:
> +- compatible: "atmel,sama5d4-wdt"
> +- reg: base physical address and length of memory mapped region.
> +
> +Optional properties:
> +- timeout-sec: watchdog timeout value (in seconds).
> +- interrupts: interrupt number to the CPU.
> +- atmel,watchdog-type: should be "hardware" or "software".
> +	"hardware": enable watchdog fault reset. A watchdog fault triggers
> +		    watchdog reset.
> +	"software": enable watchdog fault interrupt. A watchdog fault asserts
> +		    watchdog interrupt.
> +- atmel,idle-halt: present if you want to stop the watchdog when the CPU is
> +		   in idle state.
> +	CAUTION: This property should be used with care, it actually makes the
> +	watchdog not counting when the CPU is in idle state, therefore the
> +	watchdog reset time depends on mean CPU usage and will not reset at all
> +	if the CPU stop working while it is in idle state, which is probably
> +	not what you want.
> +- atmel,dbg-halt: present if you want to stop the watchdog when the CPU is
> +		  in debug state.
> +
> +Example:
> +	watchdog@fc068640 {
> +		compatible = "atmel,sama5d4-wdt";
> +		reg = <0xfc068640 0x10>;
> +		interrupts = <4 IRQ_TYPE_LEVEL_HIGH 5>;
> +		timeout-sec = <10>;
> +		atmel,watchdog-type = "hardware";
> +		atmel,dbg-halt;
> +		atmel,idle-halt;
> +		status = "okay";
> +	};
>

