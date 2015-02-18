Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39287 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751711AbbBRNVw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Feb 2015 08:21:52 -0500
Date: Wed, 18 Feb 2015 14:21:50 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Timo Kokkonen <timo.kokkonen@offcode.fi>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150218142150.48bc2be4@bbrezillon>
In-Reply-To: <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
References: <54B53160.6060309@roeck-us.net>
	<cover.1424262664.git.timo.kokkonen@offcode.fi>
	<6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timo,

On Wed, 18 Feb 2015 14:57:22 +0200
Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:

> By default the driver will start a kernel timer which keeps on kicking
> the watchdog HW until user space has opened the watchdog
> device. Usually this is desirable as the watchdog HW is running by
> default and the user space may not have any watchdog daemon running at
> all.
> 
> However, on production systems it may be mandatory that also early
> crashes and lockups will lead to a watchdog reset, even if they happen
> before the user space has opened the watchdog device.
> 
> To resolve the issue, add a new device tree property
> "early-timeout-sec" which will let the kernel timer to ping the
> watchdog HW only as long as the specified timeout permits. The default
> is still to use kernel timer, but more strict behavior can be enabled
> via the device tree property.
> 
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> ---
>  Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
>  drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.txt b/Documentation/devicetree/bindings/watchdog/watchdog.txt
> index 7e3686c..32647cf 100644
> --- a/Documentation/devicetree/bindings/watchdog/watchdog.txt
> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.txt
> @@ -4,9 +4,16 @@ using these definitions.
>  
>  Optional properties:
>  - timeout-sec: Contains the watchdog timeout in seconds.
> +- early-timeout-sec: If present, specifies a timeout value in seconds
> +  that the driver keeps on ticking the watchdog HW on behalf of user
> +  space. Once this timeout expires watchdog is left to expire in
> +  timeout-sec seconds. If this propery is set to zero, watchdog is
> +  started (or left running) so that a reset occurs in timeout-sec
> +  since the watchdog was started.
>  
>  Example:
>  
>  watchdog {
>  	 timeout-sec = <60>;
> +	 early-timeout-sec = <120>;
>  };

IMHO the documentation update should be self-contained (it should be
done in a separate patch).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
