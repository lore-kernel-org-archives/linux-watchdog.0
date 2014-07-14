Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1blp0183.outbound.protection.outlook.com ([207.46.163.183]:35380
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755068AbaGNNfa (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Jul 2014 09:35:30 -0400
Date: Mon, 14 Jul 2014 15:35:13 +0200
From: Michal Simek <michal.simek@xilinx.com>
MIME-Version: 1.0
To: Harini Katakam <harini.katakam@xilinx.com>, <wim@iguana.be>,
	<grant.likely@linaro.org>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rob@landley.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<harinikatakamlinux@gmail.com>, Harini Katakam <harinik@xilinx.com>
Subject: Re: [PATCH v3 2/2] devicetree: Add Cadence WDT devicetree bindings
 documentation
References: <1405340169-2820-1-git-send-email-harinik@xilinx.com>
 <1405340169-2820-2-git-send-email-harinik@xilinx.com>
In-Reply-To: <1405340169-2820-2-git-send-email-harinik@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <5af08174-4601-43dc-89f6-45ff57501df0@BN1BFFO11FD045.protection.gbl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/14/2014 02:16 PM, Harini Katakam wrote:
> Add cadence-wdt bindings documentation.
> 
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
> 
> v3 changes:
> - Change reset property type and improve description.
> - Improve description of clocks and interrupts.
> - Use watchdog@ in the example.
> - Use only cdns compatible string for now.
> 
> v2:
> No changes
> 
> ---
>  .../devicetree/bindings/watchdog/cadence-wdt.txt   |   27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/cadence-wdt.txt b/Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
> new file mode 100644
> index 0000000..ab23e38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
> @@ -0,0 +1,27 @@
> +Zynq Watchdog Device Tree Bindings
> +-------------------------------------------
> +
> +Required properties:
> +- compatible		: Should be "cdns,wdt-r1p2".
> +- clocks		: Input clock specifier. This should be the ref clk.
> +- reg			: Physical base address and size of WDT registers map.
> +- interrupts		: Property with a value describing the interrupt
> +			  number. This interrupt is used for indication
> +			  when the watchdog times out.
> +- interrupt-parent	: Must be core interrupt controller.
> +
> +Optional properties
> +- reset			: If this property exists, then a reset is done
> +			  when watchdog times out.
> +- timeout-sec		: Watchdog timeout value (in seconds).
> +
> +Example:
> +	watchdog@f8005000 {
> +		compatible = "xlnx,zynq-wdt-r1p2";

According to description above - you should use cdns compatible string here too.

Thanks,
Michal

