Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43387 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbdGHPMw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Jul 2017 11:12:52 -0400
Date: Sat, 8 Jul 2017 08:12:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wim Van Sebroeck <wim@iguana.be>, Jonathan Corbet <corbet@lwn.net>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        esben.haabendal@gmail.com, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v6, 2/3] watchdog: introduce watchdog.open_timeout commandline
 parameter
Message-ID: <20170708151247.GA15051@roeck-us.net>
References: <1496134608-7375-3-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496134608-7375-3-git-send-email-rasmus.villemoes@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 30, 2017 at 10:56:46AM +0200, Rasmus Villemoes wrote:
> The watchdog framework takes care of feeding a hardware watchdog until
> userspace opens /dev/watchdogN. If that never happens for some reason
> (buggy init script, corrupt root filesystem or whatnot) but the kernel
> itself is fine, the machine stays up indefinitely. This patch allows
> setting an upper limit for how long the kernel will take care of the
> watchdog, thus ensuring that the watchdog will eventually reset the
> machine.
> 
> This is particularly useful for embedded devices where some fallback
> logic is implemented in the bootloader (e.g., use a different root
> partition, boot from network, ...).
> 
> The open timeout is also used as a maximum time for an application to
> re-open /dev/watchdogN after closing it.
> 
> A value of 0 (the default) means infinite timeout, preserving the
> current behaviour.
> 
> The unit is milliseconds rather than seconds because that covers more
> use cases. For example, one can effectively disable the kernel handling
> by setting the open_timeout to 1 ms. There are also customers with very
> strict requirements that may want to set the open_timeout to something
> like 4500 ms, which combined with a hardware watchdog that must be
> pinged every 250 ms ensures userspace is up no more than 5 seconds after
> the bootloader hands control to the kernel (250 ms until the driver gets
> registered and kernel handling starts, 4500 ms of kernel handling, and
> then up to 250 ms from the last ping until userspace takes over).
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

I finally found the time to look into this. It is sufficiently different
to handle_boot_enabled to keep it separate. I am mostly ok with the patch.
One comment below.

> ---
>  Documentation/watchdog/watchdog-parameters.txt |  8 ++++++++
>  drivers/watchdog/watchdog_dev.c                | 26 +++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 914518a..8577c27 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -8,6 +8,14 @@ See Documentation/admin-guide/kernel-parameters.rst for information on
>  providing kernel parameters for builtin drivers versus loadable
>  modules.
>  
> +The watchdog core parameter watchdog.open_timeout is the maximum time,
> +in milliseconds, for which the watchdog framework will take care of
> +pinging a hardware watchdog until userspace opens the corresponding
> +/dev/watchdogN device. A value of 0 (the default) means an infinite
> +timeout. Setting this to a non-zero value can be useful to ensure that
> +either userspace comes up properly, or the board gets reset and allows
> +fallback logic in the bootloader to try something else.
> +
>  
>  -------------------------------------------------
>  acquirewdt:
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index caa4b90..c807067 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -66,6 +66,7 @@ struct watchdog_core_data {
>  	struct mutex lock;
>  	unsigned long last_keepalive;
>  	unsigned long last_hw_keepalive;
> +	unsigned long open_deadline;
>  	struct delayed_work work;
>  	unsigned long status;		/* Internal status bits */
>  #define _WDOG_DEV_OPEN		0	/* Opened ? */
> @@ -80,6 +81,21 @@ static struct watchdog_core_data *old_wd_data;
>  
>  static struct workqueue_struct *watchdog_wq;
>  
> +static unsigned open_timeout;
> +module_param(open_timeout, uint, 0644);

MODULE_PARM_DESC is missing. I would also prefer to keep module_param()
and MODULE_PARM_DESC() together with the existing module parameter, ie at
the end of the file.

Thanks,
Guenter
