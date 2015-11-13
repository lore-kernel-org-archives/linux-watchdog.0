Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37001 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbbKMTwd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Nov 2015 14:52:33 -0500
Subject: Re: [PATCH] watchdog: tegra: Stop watchdog first if restarting
To: Andrew Chew <achew@nvidia.com>, linux-watchdog@vger.kernel.org
References: <1447114298-5516-1-git-send-email-achew@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	abrestic@chromium.org, treding@nvidia.com, swarren@nvidia.com,
	jimmzhang@nvidia.com, wim@iguana.be
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56463F7E.8040008@roeck-us.net>
Date: Fri, 13 Nov 2015 11:52:30 -0800
MIME-Version: 1.0
In-Reply-To: <1447114298-5516-1-git-send-email-achew@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/09/2015 04:11 PM, Andrew Chew wrote:
> If we need to restart the watchdog due to someone changing the timeout
> interval, stop the watchdog before restarting it.  Otherwise, the new
> timeout doesn't seem to take.
>
> Signed-off-by: Andrew Chew <achew@nvidia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Some feedback from the maintainers would be helpful, though,
especially if there is some other means to change the timeout
without stopping the watchdog.

Guenter

> ---
>   drivers/watchdog/tegra_wdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> index 7f97cdd..9ec5760 100644
> --- a/drivers/watchdog/tegra_wdt.c
> +++ b/drivers/watchdog/tegra_wdt.c
> @@ -140,8 +140,10 @@ static int tegra_wdt_set_timeout(struct watchdog_device *wdd,
>   {
>   	wdd->timeout = timeout;
>
> -	if (watchdog_active(wdd))
> +	if (watchdog_active(wdd)) {
> +		tegra_wdt_stop(wdd);
>   		return tegra_wdt_start(wdd);
> +	}
>
>   	return 0;
>   }
>

