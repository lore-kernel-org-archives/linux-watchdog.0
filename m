Return-path: <robherring2@gmail.com>
Date: Mon, 27 Feb 2017 19:12:40 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Kukjin Kim <kgene@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/8] watchdog: s3c2410: Fix infinite interrupt in soft
 mode
Message-ID: <20170228011240.yrucs7odq45xi4q5@rob-hp-laptop>
References: <20170224151122.12142-1-krzk@kernel.org>
 <20170224151122.12142-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170224151122.12142-3-krzk@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Feb 24, 2017 at 05:11:16PM +0200, Krzysztof Kozlowski wrote:
> In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> of an interrupt.  However the interrupt itself was not cleared thus on
> first hit, the system enters infinite interrupt handling loop.
> 
> On Odroid U3 (Exynos4412), when booted with s3c2410_wdt.soft_noboot=1
> argument the console is flooded:
> 	# killall -9 watchdog
> 	[   60.523760] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)
> 	[   60.536744] s3c2410-wdt 10060000.watchdog: watchdog timer expired (irq)
> 
> Fix this by writing something to the WTCLRINT register to clear the
> interrupt.  The register WTCLRINT however appeared in S3C6410 so a new
> watchdog quirk and flavor are needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> I was thinking about CC-ing stable, especially when I thought about
> adding unconditional WTCLRINT clear.  However it appears that S3C2410
> does not have the WTCLRINT register, this a new chip flavor has to be
> added.  This makes the fix spread over driver and DTS changes.
> 
> Worth adding:
> 	Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> ?
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt    |  9 +++++----

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/watchdog/s3c2410_wdt.c                      | 21 ++++++++++++++++++---
>  2 files changed, 23 insertions(+), 7 deletions(-)
