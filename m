Return-Path: <swarren@wwwdotorg.org>
Message-ID: <52FBC2EF.4020000@wwwdotorg.org>
Date: Wed, 12 Feb 2014 11:52:31 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>, linux@roeck-us.net, wim@iguana.be,
 rob@landley.net, thierry.reding@gmail.com, grant.likely@linaro.org,
 robh+dt@kernel.org, abrestic@chromium.org, dgreid@chromium.org,
 katierh@chromium.org
CC: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/1] watchdog: Add tegra watchdog
References: <1391738086-29142-1-git-send-email-achew@nvidia.com>
In-Reply-To: <1391738086-29142-1-git-send-email-achew@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 02/06/2014 06:54 PM, Andrew Chew wrote:
> Add a driver for the hardware watchdogs in NVIDIA Tegra SoCs (Tegra30 and
> later).  This driver will configure one watchdog timer that will reset the
> system in the case of a watchdog timeout.
> 
> This driver binds to the nvidia,tegra30-timer device node and gets its
> register base from there.

Tested-by: Stephen Warren <swarren@nvidia.com>

Briefly,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

Just a couple small comments though.

> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c

> +static void tegra_wdt_ref(struct watchdog_device *wdd)
> +{
> +	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	kref_get(&wdt->kref);
> +}
> +
> +static void tegra_wdt_unref(struct watchdog_device *wdd)
> +{
> +	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
> +
> +	kref_put(&wdt->kref, tegra_wdt_release_resources);
> +}

I forget why these were needed; they seem to do nothing.

> +MODULE_LICENSE("GPL");

That should be "GPL v2" according to the license header in the file.
