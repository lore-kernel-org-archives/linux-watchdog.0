Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39952 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbK3RIT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Nov 2015 12:08:19 -0500
Subject: Re: [char-misc-next 6/6] mei: wd: re-register device on event
To: Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1448541081-11299-1-git-send-email-tomas.winkler@intel.com>
 <1448541081-11299-7-git-send-email-tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <565C8281.9070909@roeck-us.net>
Date: Mon, 30 Nov 2015 09:08:17 -0800
MIME-Version: 1.0
In-Reply-To: <1448541081-11299-7-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/26/2015 04:31 AM, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>
> For Intel SKL platform the ME device can inform the host via
> asynchronous notification that the watchdog feature was activated on the
> device. The activation doesn't require reboot.
> In that case the driver register the watchdog device with the kernel.
>

Can the watchdog device also be disabled on the fly ?

> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>   drivers/watchdog/mei_wdt.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> index 47f0dc2e822a..ee3b5d12b1b2 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
> @@ -279,6 +279,21 @@ out:
>   		complete(&wdt->response);
>   }
>
> +/*
> + * mei_wdt_event_notif - callback for notification
> + *
> + * @cldev: bus device
> + */
> +static void mei_wdt_event_notif(struct mei_cl_device *cldev)
> +{
> +	struct mei_wdt *wdt = mei_cldev_get_drvdata(cldev);
> +
> +	if (wdt->state == MEI_WDT_NOT_REQUIRED) {
> +		mei_wdt_register(wdt);
> +		wdt->state = MEI_WDT_IDLE;
> +	}
> +}
> +
>   /**
>    * mei_wdt_event - callback for event receive
>    *
> @@ -291,6 +306,9 @@ static void mei_wdt_event(struct mei_cl_device *cldev,
>   {
>   	if (events & BIT(MEI_CL_EVENT_RX))
>   		mei_wdt_event_rx(cldev);
> +
> +	if (events & BIT(MEI_CL_EVENT_NOTIF))
> +		mei_wdt_event_notif(cldev);
>   }
>
>   /**
> @@ -466,9 +484,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
>
>   	wd_info.firmware_version = mei_cldev_ver(cldev);
>
> -	ret = mei_cldev_register_event_cb(wdt->cldev, BIT(MEI_CL_EVENT_RX),
> +	ret = mei_cldev_register_event_cb(wdt->cldev,
> +					  BIT(MEI_CL_EVENT_RX) |
> +					  BIT(MEI_CL_EVENT_NOTIF),
>   					  mei_wdt_event, NULL);
> -	if (ret) {
> +
> +	/* on legacy devices notification is not supported */
> +	if (ret && ret != -EOPNOTSUPP) {
>   		dev_err(&cldev->dev, "Could not register event ret=%d\n", ret);
>   		goto err_disable;
>   	}
>
Doesn't that mean, though, that the RX event is not registered either,
even if it is supported ? If so, should you retry and register only
MEI_CL_EVENT_RX ?

Thanks,
Guenter

