Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33383 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbcAQRNK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jan 2016 12:13:10 -0500
Date: Sun, 17 Jan 2016 09:13:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next, v4, 5/7] watchdog: mei_wdt: register wd device
 only if required
Message-ID: <20160117171308.GA10264@roeck-us.net>
References: <1452206967-1144-6-git-send-email-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452206967-1144-6-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomas,

On Fri, Jan 08, 2016 at 12:49:25AM +0200, Winkler, Tomas wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> For Intel Broadwell and newer platforms, the ME device can inform
> the host whether the watchdog functionality is activated or not.
> If the watchdog functionality is not activated then the watchdog interface
> can be not registered and eliminate unnecessary pings and hence lower the
> power consumption by avoiding waking up the device.
> The feature can be deactivated also without reboot
> in that case the watchdog device should be unregistered at runtime.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2: rework unregistration
> V3: rebase; implement unregistraion also at runtime
> V4: Rebase the code over patchset : "watchdog: Replace driver based refcounting"
> 
>  drivers/watchdog/mei_wdt.c | 196 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 187 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> index e7e3f144f2b0..85b27fc5d4ec 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
>  
[ ... ]

> +static void mei_wdt_unregister_work(struct work_struct *work)
> +{
> +	struct mei_wdt *wdt = container_of(work, struct mei_wdt, unregister);
> +
> +	mei_wdt_unregister(wdt);
> +}

Registration is synchronous, unregistration is asynchronous.

Assuming that is on purpose, I think it warrants an explanation.

Thanks,
Guenter
