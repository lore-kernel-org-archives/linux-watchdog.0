Return-Path: <wimvs@spo001.leaseweb.com>
Date: Sun, 2 Mar 2014 12:51:58 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Chew <achew@nvidia.com>
Cc: linux@roeck-us.net, rob@landley.net, swarren@wwwdotorg.org,
	thierry.reding@gmail.com, grant.likely@linaro.org,
	robh+dt@kernel.org, abrestic@chromium.org, dgreid@chromium.org,
	katierh@chromium.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/1] watchdog: Add tegra watchdog
Message-ID: <20140302115158.GT1484@spo001.leaseweb.com>
References: <1392408185-15387-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392408185-15387-1-git-send-email-achew@nvidia.com>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Andrew,

> Add a driver for the hardware watchdogs in NVIDIA Tegra SoCs (Tegra30 and
> later).  This driver will configure one watchdog timer that will reset the
> system in the case of a watchdog timeout.
> 
> This driver binds to the nvidia,tegra30-timer device node and gets its
> register base from there.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changes from v6:
> 
> Removed kref stuff.  We can't think of why it's needed here.
> 
> Changes from v5:
> 
> Changed license to GPL v2 per Stephen Warren's guidance.
> 
> Changes from v4:
> 
> Skip the error check from the platform_get_resources() call, because
> devm_ioremap_resource() correctly handles the case when res is NULL.
> 
> Changes from v3:
> 
> Applied Cuenter Roeck <linux@roeck-us.net>'s comments.  In particular,
> since tegra_wdt_start() and tegra_wdt_stop() always return success, skip
> error checking for these calls.  Also, removed some unnecessarily verbose
> logging around which watchdog and timer ID is being used.  Fixed typo
> regarding the ref and unref callback setup.  Removed miscdev stuff.
> 
> Cuenter was right in that the watchdog doesn't need to be stopped prior
> to changing the timeout.  It is sufficient to just reprogram the watchdog
> with the new timeout.
> 
> Tested on T124.
> 
> To do a simple test, "echo 0 > /dev/watchdog0".  The target will reset when
> two minutes (the default heartbeat interval) have expired since the last
> write to /dev/watchdog0.
> 
>  Documentation/watchdog/watchdog-parameters.txt |   5 +
>  drivers/watchdog/Kconfig                       |  11 +
>  drivers/watchdog/Makefile                      |   1 +
>  drivers/watchdog/tegra_wdt.c                   | 302 +++++++++++++++++++++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 drivers/watchdog/tegra_wdt.c
> 

Patch added to linux-watchdog-next.

Kind regards,
Wim.
