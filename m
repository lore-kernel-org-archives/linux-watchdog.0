Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57853 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbbA0Qa0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Jan 2015 11:30:26 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YG922-003w1z-J5
	for linux-watchdog@vger.kernel.org; Tue, 27 Jan 2015 16:30:26 +0000
Date: Tue, 27 Jan 2015 08:30:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: wim@iguana.be, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	paul@crapouillou.net
Subject: Re: [PATCH 1/2] dt: watchdog: Add DT binding documentation for
 jz47xx watchdog timer
Message-ID: <20150127163008.GA21459@roeck-us.net>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1422371490-44402-2-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422371490-44402-2-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 27, 2015 at 03:11:29PM +0000, Zubair Lutfullah Kakakhel wrote:
> Add binding for jz47xx watchdog timer. It is a simple watchdog timer.
> Needs rtc clock and register addresses
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> The jz4740 is platform only at the moment.
> 
> But DT support is being added
> 
> See http://patchwork.linux-mips.org/bundle/paulburton/ci20-v3.20/
> 
> jz47xx is used because jz4780 will also use this driver

Not a valid argument. Please use jz4740, per convention.

xx implies anything from 00 to 99, which is not necessarily correct.
If support for other chips is added, that information can be mentioned
in the file itself, as it is done for many other drivers.

> ---
>  .../devicetree/bindings/watchdog/ingenic,jz47xx-wdt.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz47xx-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz47xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz47xx-wdt.txt
> new file mode 100644
> index 0000000..bf4c404
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ingenic,jz47xx-wdt.txt
> @@ -0,0 +1,17 @@
> +Ingenic Watchdog Timer (WDT) Controller for JZ47XX
> +
> +Required properties:
> +compatible: "ingenic,jz4740-watchdog"
> +reg: Register address and length for watchdog registers
> +clocks: phandle to rtcclk
> +clock-names: must be "rtc"
> +
> +Example:
> +
> +watchdog: jz47xx-watchdog@0x10002000 {
> +	compatible = "ingenic,jz4780-watchdog";

"ingenic,jz4780-watchdog" is not listed as possible value above,
nor is it listed in the patch itself, so you can not use it here.

> +	reg = <0x10002000 0x100>;
> +
> +	clocks = <&rtclk>;
> +	clock-names = "rtc";
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
