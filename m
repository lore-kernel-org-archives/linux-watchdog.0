Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56840 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbcKIOrg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 9 Nov 2016 09:47:36 -0500
Subject: Re: [watchdog] watchdog: mei_wdt: request stop on reboot to prevent
 false positive event
To: Tomas Winkler <tomas.winkler@intel.com>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1478620552-30409-1-git-send-email-tomas.winkler@intel.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        stable@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f1d58ef7-66ec-acac-4a9d-dcb8b16b3110@roeck-us.net>
Date: Wed, 9 Nov 2016 06:47:31 -0800
MIME-Version: 1.0
In-Reply-To: <1478620552-30409-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/08/2016 07:55 AM, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>
> Systemd on reboot enables shutdown watchdog that leaves the watchdog
> device open to ensure that even if power down process get stuck the
> platform reboots nonetheless.
> The iamt_wdt is an alarm-only watchdog and can't reboot system, but the
> FW will generate an alarm event reboot was completed in time, as the
> watchdog is not automatically disabled during power cycle.
> So we should request stop watchdog on reboot to eliminate wrong alarm
> from the FW.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mei_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> index e0af52265511..40953fe4db86 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
> @@ -389,6 +389,8 @@ static int mei_wdt_register(struct mei_wdt *wdt)
>  	wdt->wdd.max_timeout = MEI_WDT_MAX_TIMEOUT;
>
>  	watchdog_set_drvdata(&wdt->wdd, wdt);
> +	watchdog_stop_on_reboot(&wdt->wdd);
> +
>  	ret = watchdog_register_device(&wdt->wdd);
>  	if (ret) {
>  		dev_err(dev, "unable to register watchdog device = %d.\n", ret);
>

