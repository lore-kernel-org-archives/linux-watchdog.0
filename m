Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51813 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbHXDcb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 23 Aug 2015 23:32:31 -0400
Message-ID: <55DA9045.2060107@roeck-us.net>
Date: Sun, 23 Aug 2015 20:32:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Justin Chen <justinpopo6@gmail.com>, linux-kernel@vger.kernel.org
CC: feedback-list@broadcom.com, devicetree@vger.kernel.org,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: bcm7038: add device tree binding documentation
References: <1440092486-16905-1-git-send-email-justinpopo6@gmail.com> <1440092486-16905-2-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1440092486-16905-2-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Justin,

On 08/20/2015 10:41 AM, Justin Chen wrote:
> Add device tree binding docmentation for the watchdog hardware block
> on bcm7038 and newer SoCs.
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>   .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> new file mode 100644
> index 0000000..adb8260
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> @@ -0,0 +1,19 @@
> +BCM7038 Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm7038-wdt"
> +- reg : Specifies base physical address and size of the registers.
> +
> +Optional properties:
> +
> +- clocks: the clock running the watchdog
> +- clock-frequency: the rate of the clock

Is 'clock-frequency' really needed (and useful), or would it make more sense
to expect the user to configure a fixed clock if nothing else is available ?
How do other drivers handle this ?

Thanks,
Guenter

> +
> +Example:
> +
> +watchdog {
> +	compatible = "brcm,bcm7038-wdt";
> +	clocks = <&upg_fixed>;
> +	reg = <0xf040a7e8 0x16>;
> +};
>

