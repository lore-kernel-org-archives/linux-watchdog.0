Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42453 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPK3q (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 16 Nov 2018 05:29:46 -0500
Date: Thu, 15 Nov 2018 16:19:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Tao Ren <taoren@fb.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Message-ID: <20181116001938.GA16009@roeck-us.net>
References: <20181115234413.27009-1-taoren@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115234413.27009-1-taoren@fb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 15, 2018 at 11:44:26PM +0000, Tao Ren wrote:
> Currently "watchdog did not stop!" message is printed when the watchdog
> timer is not stopped at close. For example, people may see the message
> when rebooting the system, or the message will be logged to console
> periodically if watchdog is kicked by a scirpt which runs "echo k >
> /dev/watchdog" command.
> 
> Given a critical message usually indicates a serious hardware/software
> failure, this message could easily lead to confusion, so it's better to
> just delete the message.
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

NACK. This message is displayed if/when the watchdog application
exits without stopping the watchdog and/or without closing properly.
This _is_ critical since it will reboot the system after the next
timeout period.

If userspace triggers this message on purpose (eg by the mentioned
script, which does not exit properly), userspace is at fault,
not the kernel.

Guenter

> ---
>  drivers/watchdog/watchdog_dev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index f6c24b22b37c..65e9ebbd8759 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -879,7 +879,6 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  
>  	/* If the watchdog was not stopped, send a keepalive ping */
>  	if (err < 0) {
> -		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
>  		watchdog_ping(wdd);
>  	}
>  
> -- 
> 2.17.1
> 
