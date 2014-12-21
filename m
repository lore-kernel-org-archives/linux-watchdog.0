Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34994 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaLUKw0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 21 Dec 2014 05:52:26 -0500
Date: Sun, 21 Dec 2014 19:52:20 +0900
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: shmobile: koelsch: Add DA9063 PMIC device node
 for system restart
Message-ID: <20141221105133.GA30697@verge.net.au>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
 <1418124169-7123-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418124169-7123-4-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 09, 2014 at 12:22:48PM +0100, Geert Uytterhoeven wrote:
> Add a minimal device node for the DA9063 PMIC, which is connected to i2c6.
> This allows the system to be restarted when the watchdog timer times
> out, or when a system restart is requested.
> 
> Regulator support is not yet included, as no DT support code nor DT
> binding documentation exists for the regulator functionality.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org

Hi,

I had this queued up for v3.20, however, when rebasing on top
of v3.19-rca (previous base was v3.18) I noticed that this patch
appears to cause booting koelsch with shmobile_defconfig to
stop at:

rcar_sound ec500000.rcar_sound: can't get dma channel
rcar_sound ec500000.rcar_sound: src[3] (Gen2) failed
rcar_sound ec500000.rcar_sound: ssi[1] fallback to PIO mode
rcar_sound ec500000.rcar_sound: probed
TCP: cubic registered
NET: Registered protocol family 10
da9063 6-0058: Failed to read IRQ status: -6
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
random: nonblocking pool is initialized

I have (hopefully temporarily) dropped this patch accordingly.

> ---
> Restart by watchdog timeout is working now.
> Manual system restart depends on "[PATCH 1/4] watchdog: da9063: Add restart
> handler support".
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 6938377d3798644b..a400c27a813f1a8b 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -524,6 +524,13 @@
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	pmic@58 {
> +		compatible = "dlg,da9063";
> +		reg = <0x58>;
> +		interrupt-parent = <&irqc0>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +	};
>  };
>  
>  &pci0 {
> -- 
> 1.9.1
> 
