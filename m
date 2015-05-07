Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35746 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbbEGOSL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 10:18:11 -0400
Received: by wgyo15 with SMTP id o15so45135983wgy.2
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 07:18:10 -0700 (PDT)
Date: Thu, 7 May 2015 15:18:05 +0100
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH 06/12] watchdog: bindings: Supply
 knowledge of a third supported device - clocksource
Message-ID: <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

On Thu, 07 May 2015, Lee Jones wrote:

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> index 388c88a..0b1a784 100644
> --- a/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/st_lpc_wdt.txt
> @@ -1,20 +1,23 @@
>  STMicroelectronics Low Power Controller (LPC) - Watchdog
>  ========================================================
>  
> -LPC currently supports Watchdog OR Real Time Clock functionality.
> +LPC currently supports Watchdog OR Real Time Clock OR Clocksource
> +functionality.
>  
>  [See: ../rtc/rtc-st-lpc.txt for RTC options]
> +[See: ../timer/st,stih407-lpc for Clocksource options]
>  
>  Required properties
>  
> -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> -				  "st,stih415-lpc" "st,stid127-lpc"
> +- compatible 	: Must be one of: "st,stih407-lpc"

The same comment as the RTC DT patch, you are removing the compatibles
documentation for the other supported platforms like stih416-lpc.
AFAIK they are required in the driver to get the correct sysconfig register.

regards,

Peter.
