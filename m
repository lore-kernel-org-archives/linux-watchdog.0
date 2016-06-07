Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44742 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897AbcFGUdL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 16:33:11 -0400
Date: Tue, 7 Jun 2016 13:32:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] watchdog: add set_pretimeout interface
Message-ID: <20160607203258.GA8033@roeck-us.net>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-2-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465321127-19522-2-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 07, 2016 at 08:38:42PM +0300, Vladimir Zapolskiy wrote:
> From: Robin Gong <b38343@freescale.com>
> 
> Add set_pretimeout since our watchdog driver has those interfaces and
> obviously, the new common watchdog framework didn't implement this
> interface.
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>
> [vzapolskiy: rebased, added an inline comment to describe new interface]
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> Changes from v2 to v3:
> * none, new change
> 
> Changes from v1 to v2:
> * none, new change
> 
>  include/linux/watchdog.h | 10 ++++++++++

Please also document the new API function and variable in
Documentation/watchdog/watchdog-kernel-api.txt.


>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 51732d6..e3d23d3 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -28,6 +28,7 @@ struct watchdog_core_data;
>   * @ping:	The routine that sends a keepalive ping to the watchdog device.
>   * @status:	The routine that shows the status of the watchdog device.
>   * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
> + * @set_pretimeout:The routine for setting the watchdog devices pretimeout (in seconds).
>   * @get_timeleft:The routine that gets the time left before a reset (in seconds).
>   * @restart:	The routine for restarting the machine.
>   * @ioctl:	The routines that handles extra ioctl calls.
> @@ -46,6 +47,7 @@ struct watchdog_ops {
>  	int (*ping)(struct watchdog_device *);
>  	unsigned int (*status)(struct watchdog_device *);
>  	int (*set_timeout)(struct watchdog_device *, unsigned int);
> +	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
>  	unsigned int (*get_timeleft)(struct watchdog_device *);
>  	int (*restart)(struct watchdog_device *, unsigned long, void *);
>  	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
> @@ -95,6 +97,7 @@ struct watchdog_device {
>  	const struct watchdog_ops *ops;
>  	unsigned int bootstatus;
>  	unsigned int timeout;
> +	unsigned int pretimeout;
>  	unsigned int min_timeout;
>  	unsigned int max_timeout;
>  	unsigned int min_hw_heartbeat_ms;
> @@ -162,6 +165,13 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
>  		 t > wdd->max_timeout);
>  }
>  
> +/* Use the following function to check if a pretimeout value is invalid */
> +static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
> +					       unsigned int t)
> +{
> +	return wdd->timeout && t >= wdd->timeout;
> +}

If no timeout is configured, this would happily accept timeout values larger
than the maximum supported timeout. Given that we can not evaluate true or false
if timeout is not set or not known, I think this will have to be something like
	return !wdd->timeout || t >= wdd->timeout;
(unless somone has a better idea).

I am missing a function to initialize the pretimeout from a driver, similar
to watchdog_init_timeout(). Is this an oversight or on purpose ?

Thanks,
Guenter
