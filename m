Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60965 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbbLRRFc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 18 Dec 2015 12:05:32 -0500
Subject: Re: [char-misc-next v2 7/7] watchdog: mei_wdt: re-register device on
 event
To: Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
 <1450363780-30008-8-git-send-email-tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56743CD9.3000708@roeck-us.net>
Date: Fri, 18 Dec 2015 09:05:29 -0800
MIME-Version: 1.0
In-Reply-To: <1450363780-30008-8-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/17/2015 06:49 AM, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>
> For Intel SKL platform the ME device can inform the host via
> asynchronous notification that the watchdog feature was activated
> on the device. The activation doesn't require reboot.
> In that case the driver registers the watchdog device with the kernel.
> In the same manner the feature can be deactivated without reboot
> in that case the watchdog device should be unregistered.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---

I am not really happy about the watchdog device appearing and disappearing
dynamically. This wreaks havoc with any standard watchdog application.

Isn't there a better way to handle this ? How about just registering the
watchdog device and return an error in the access functions if it is disabled ?

Thanks,
Guenter

> V2: rework un/registration in runtime
>
>   drivers/watchdog/mei_wdt.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> index 00d1b8e630b7..cd79920c473b 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
> @@ -87,6 +87,7 @@ static const char *mei_wdt_state_str(enum mei_wdt_state state)
>    * @state: watchdog internal state
>    * @resp_required: ping required response
>    * @response: ping response
> + * @unregister: unregister worker
>    * @timeout: watchdog current timeout
>    *
>    * @dbgfs_dir: debugfs dir entry
> @@ -101,6 +102,7 @@ struct mei_wdt {
>   	enum mei_wdt_state state;
>   	bool resp_required;
>   	struct completion response;
> +	struct work_struct unregister;
>   	u16 timeout;
>
>   #if IS_ENABLED(CONFIG_DEBUG_FS)
> @@ -237,6 +239,13 @@ static void mei_wdt_unregister(struct mei_wdt *wdt)
>   	mutex_unlock(&wdt->reg_lock);
>   }
>
> +static void mei_wdt_unregister_work(struct work_struct *work)
> +{
> +	struct mei_wdt *wdt = container_of(work, struct mei_wdt, unregister);
> +
> +	mei_wdt_unregister(wdt);
> +}
> +
>   /**
>    * mei_wdt_register - register with the watchdog subsystem
>    *
> @@ -350,8 +359,13 @@ static void mei_wdt_event_rx(struct mei_cl_device *cldev)
>   		return;
>   	}
>
> -	if (wdt->state == MEI_WDT_RUNNING)
> +	if (wdt->state == MEI_WDT_RUNNING) {
> +		if (res.wdstate & MEI_WDT_WDSTATE_NOT_REQUIRED) {
> +			wdt->state = MEI_WDT_NOT_REQUIRED;
> +			schedule_work(&wdt->unregister);
> +		}
>   		goto out;
> +	}
>
>   	if (wdt->state == MEI_WDT_PROBE) {
>   		if (res.wdstate & MEI_WDT_WDSTATE_NOT_REQUIRED) {
> @@ -372,6 +386,21 @@ out:
>   		complete(&wdt->response);
>   }
>
> +/*
> + * mei_wdt_notify_event - callback for event notification
> + *
> + * @cldev: bus device
> + */
> +static void mei_wdt_notify_event(struct mei_cl_device *cldev)
> +{
> +	struct mei_wdt *wdt = mei_cldev_get_drvdata(cldev);
> +
> +	if (wdt->state != MEI_WDT_NOT_REQUIRED)
> +		return;
> +	wdt->state = MEI_WDT_IDLE;
> +	mei_wdt_register(wdt);
> +}
> +
>   /**
>    * mei_wdt_event - callback for event receive
>    *
> @@ -384,6 +413,9 @@ static void mei_wdt_event(struct mei_cl_device *cldev,
>   {
>   	if (events & BIT(MEI_CL_EVENT_RX))
>   		mei_wdt_event_rx(cldev);
> +
> +	if (events & BIT(MEI_CL_EVENT_NOTIF))
> +		mei_wdt_notify_event(cldev);
>   }
>
>   /**
> @@ -543,6 +575,7 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
>   	wdt->resp_required = mei_cldev_ver(cldev) > 0x1;
>   	mutex_init(&wdt->reg_lock);
>   	wdt->is_registered = false;
> +	INIT_WORK(&wdt->unregister, mei_wdt_unregister_work);
>   	init_completion(&wdt->response);
>
>   	mei_cldev_set_drvdata(cldev, wdt);
> @@ -553,9 +586,13 @@ static int mei_wdt_probe(struct mei_cl_device *cldev,
>   		goto err_out;
>   	}
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
> @@ -599,6 +636,8 @@ static int mei_wdt_remove(struct mei_cl_device *cldev)
>   	if (!completion_done(&wdt->response))
>   		complete(&wdt->response);
>
> +	cancel_work_sync(&wdt->unregister);
> +
>   	mei_wdt_unregister(wdt);
>
>   	kref_put(&wdt->refcnt, mei_wdt_release);
>

