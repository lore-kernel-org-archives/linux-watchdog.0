Return-Path: <aaro.koskinen@iki.fi>
Date: Tue, 11 Feb 2014 22:58:06 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] watchdog: omap_wdt: Use devm_ioremap_resource()
Message-ID: <20140211205806.GH573@drone.musicnaut.iki.fi>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
 <000f01cf2726$f7500210$e5f00630$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01cf2726$f7500210$e5f00630$%han@samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Feb 11, 2014 at 09:44:12PM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and remove 'struct resource *mem' from 'struct omap_wdt_dev'
> and omap_wdt_probe(), resplectively. because the 'mem' variables
> are not used anymore. Also the redundant return value check of
> platform_get_resource() is removed, because the value is checked
> by devm_ioremap_resource().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
