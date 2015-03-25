Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56038 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbbCYN3W (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Mar 2015 09:29:22 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YalN4-000Lln-4n
	for linux-watchdog@vger.kernel.org; Wed, 25 Mar 2015 13:29:22 +0000
Message-ID: <5512B81B.9090306@roeck-us.net>
Date: Wed, 25 Mar 2015 06:28:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, wim@iguana.be,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	david.paris@st.com, a.zummo@towertech.it
CC: kernel@stlinux.com
Subject: Re: [PATCH v6 7/9] rtc: bindings: Provide ST bindings for ST's LPC
 RTC device
References: <1427189140-1935-1-git-send-email-lee.jones@linaro.org> <1427189140-1935-8-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1427189140-1935-8-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/24/2015 02:25 AM, Lee Jones wrote:
> On current ST platforms the LPC controls a number of functions including
> Watchdog and Real Time Clock.  This patch provides the bindings used to
> configure LPC in RTC mode.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   .../devicetree/bindings/rtc/rtc-st-lpc.txt         | 25 ++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
>
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> new file mode 100644
> index 0000000..aaf9855
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> @@ -0,0 +1,25 @@
> +STMicroelectronics Low Power Controller (LPC) - RTC
> +===================================================
> +
> +LPC currently supports Watchdog OR Real Time Clock functionality.
> +
> +[See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
> +
> +Required properties
> +
> +- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> +				  "st,stih415-lpc" "st,stid127-lpc"
> +- reg		: LPC registers base address + size
> +- interrupts    : LPC interrupt line number and associated flags
> +- clocks	: Clock used by LPC device (See: ../clock/clock-bindings.txt)
> +- st,lpc-mode	: The LPC can run either one of two modes ST_LPC_MODE_RTC [0] or
> +		  ST_LPC_MODE_WDT [1].  One (and only one) mode must be
> +		  selected.
> +
> +Example:
> +	lpc@fde05000 {
> +		compatible	= "st,stih416-lpc-watchdog";

Name mismatch here as well.

Guenter

> +		reg		= <0xfde05000 0x1000>;
> +		clocks 		= <&clk_s_d3_flexgen CLK_LPC_0>;
> +		st,lpc-mode	= <ST_LPC_MODE_RTC>;
> +	};
>

