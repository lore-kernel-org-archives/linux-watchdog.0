Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45637 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbbFTBuh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Jun 2015 21:50:37 -0400
Message-ID: <5584C6EB.9030804@roeck-us.net>
Date: Fri, 19 Jun 2015 18:50:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	"Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
Subject: Re: [PATCH] watchdog: hpwdt: Add support for WDIOC_SETOPTIONS
References: <20150619170125.7634f6e2@endymion.delvare>
In-Reply-To: <20150619170125.7634f6e2@endymion.delvare>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean,

On 06/19/2015 08:01 AM, Jean Delvare wrote:
> WDIOC_SETOPTIONS makes it possible to disable and re-enable the
> watchdog timer while the hpwdt driver is loaded.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
> Untested. It would be great if someone at HP (or anyone with the
> hardware, I guess) could test and review this patch. Thanks.
>

Any chance you can convert the driver to a new style watchdog driver
instead ?

>   drivers/watchdog/hpwdt.c |   19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> --- linux-4.1-rc8.orig/drivers/watchdog/hpwdt.c	2015-06-19 11:40:15.885626732 +0200
> +++ linux-4.1-rc8/drivers/watchdog/hpwdt.c	2015-06-19 11:52:14.375776480 +0200
> @@ -588,7 +588,7 @@ static long hpwdt_ioctl(struct file *fil
>   {
>   	void __user *argp = (void __user *)arg;
>   	int __user *p = argp;
> -	int new_margin;
> +	int new_margin, options;
>   	int ret = -ENOTTY;
>
>   	switch (cmd) {
> @@ -608,6 +608,23 @@ static long hpwdt_ioctl(struct file *fil
>   		ret = 0;
>   		break;
>
> +	case WDIOC_SETOPTIONS:
> +		ret = get_user(options, p);
> +		if (ret)
> +			break;
> +
> +		if (options & WDIOS_DISABLECARD) {
> +			hpwdt_stop();
> +			ret = 0;

ret is already 0 here.

> +		}
> +
> +		if (options & WDIOS_ENABLECARD) {
> +			hpwdt_start();
> +			hpwdt_ping();
> +			ret = 0;

Same here.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
