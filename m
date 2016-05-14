Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34830 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbcENSf4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:35:56 -0400
Date: Sat, 14 May 2016 20:35:54 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add ebc-c384_wdt watchdog-parameters.txt entry
Message-ID: <20160514183554.GH21026@spo001.leaseweb.nl>
References: <20160511124746.GA5314@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160511124746.GA5314@sophia>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi William

> The WinSystems EBC-C384 watchdog timer driver supports two module
> parameters: timeout and nowayout. These parameters should be documented
> in the watchdog-parameters.txt file.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  Documentation/watchdog/watchdog-parameters.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index c161399..a8d3642 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -86,6 +86,10 @@ nowayout: Watchdog cannot be stopped once started
>  davinci_wdt:
>  heartbeat: Watchdog heartbeat period in seconds from 1 to 600, default 60
>  -------------------------------------------------
> +ebc-c384_wdt:
> +timeout: Watchdog timeout in seconds. (1<=timeout<=15300, default=60)
> +nowayout: Watchdog cannot be stopped once started
> +-------------------------------------------------
>  ep93xx_wdt:
>  nowayout: Watchdog cannot be stopped once started
>  timeout: Watchdog timeout in seconds. (1<=timeout<=3600, default=TBD)
> -- 
> 2.7.3
> 

This patch was added to linux-watchdog-next.

Kind Regards,
Wim.

