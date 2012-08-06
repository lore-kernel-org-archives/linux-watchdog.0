Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58728 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab2HFDQ3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 5 Aug 2012 23:16:29 -0400
Message-ID: <501F35C2.6090005@windriver.com>
Date: Mon, 6 Aug 2012 11:10:58 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
CC: <linuxppc-dev@ozlabs.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return
 path
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/30/2012 04:15 PM, Tiejun Chen wrote:
> We miss that correct WDIOC_GETSUPPORT return path when perform
> copy_to_user() properly.

Any comments?

Thanks
Tiejun

> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  drivers/watchdog/booke_wdt.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 3fe82d0..2be7f29 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -162,12 +162,13 @@ static long booke_wdt_ioctl(struct file *file,
>  				unsigned int cmd, unsigned long arg)
>  {
>  	u32 tmp = 0;
> -	u32 __user *p = (u32 __user *)arg;
> +	void __user *argp = (u32 __user *)arg;
> +	u32 __user *p = argp;
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> -		if (copy_to_user((void *)arg, &ident, sizeof(ident)))
> -			return -EFAULT;
> +		return copy_to_user(argp, &ident,
> +				sizeof(ident)) ? -EFAULT : 0;
>  	case WDIOC_GETSTATUS:
>  		return put_user(0, p);
>  	case WDIOC_GETBOOTSTATUS:
> 

