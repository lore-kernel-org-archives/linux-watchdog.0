Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32834 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdBXRje (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 12:39:34 -0500
Date: Fri, 24 Feb 2017 19:30:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/8] watchdog: s3c2410: Fix infinite interrupt in soft
 mode
Message-ID: <20170224173057.ezbefenrxjro72ck@kozik-lap>
References: <20170224151122.12142-1-krzk@kernel.org>
 <20170224151122.12142-3-krzk@kernel.org>
 <1348b7de-b485-832b-1743-8f810a174dd5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1348b7de-b485-832b-1743-8f810a174dd5@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 24, 2017 at 07:37:53AM -0800, Guenter Roeck wrote:
> On 02/24/2017 07:11 AM, Krzysztof Kozlowski wrote:
> > In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> > of an interrupt.  However the interrupt itself was not cleared thus on
> > first hit, the system enters infinite interrupt handling loop.
> > 
> > On Odroid U3 (Exynos4412), when booted with s3c2410_wdt.soft_noboot=1
> > argument the console is flooded:
> > 	# killall -9 watchdog
> > 	[   60.523760] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)
> > 	[   60.536744] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)
> > 
> > Fix this by writing something to the WTCLRINT register to clear the
> > interrupt.  The register WTCLRINT however appeared in S3C6410 so a new
> > watchdog quirk and flavor are needed.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> > 
> > ---
> > 
> > I was thinking about CC-ing stable, especially when I thought about
> > adding unconditional WTCLRINT clear.  However it appears that S3C2410
> > does not have the WTCLRINT register, this a new chip flavor has to be
> > added.  This makes the fix spread over driver and DTS changes.
> > 
> > Worth adding:
> > 	Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > ?
> 
> How would that be different to Cc: stable ?

I guess not much... except for the metrics that some bug was fixed.

Best regards,
Krzysztof
