Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [213.199.154.205] ([213.199.154.205]:40794 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757061Ab2HFX2e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Aug 2012 19:28:34 -0400
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
CC: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"galak@kernel.crashing.org" <galak@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return
 path
Date: Mon, 6 Aug 2012 23:27:18 +0000
Message-ID: <CAOZdJXWftkUSw57-Qbe9JFP9NwodkHprKr6_1xi6ZzzLN8A4wA@mail.gmail.com>
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
Content-Language: en-US
Content-Type: text/plain; charset=US-ASCII
Content-ID: <73B6686F3E30E942812D5875B7D5542C@mgd.freescale.com>
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 30, 2012 at 3:15 AM, Tiejun Chen <tiejun.chen@windriver.com> wrote:
> We miss that correct WDIOC_GETSUPPORT return path when perform
> copy_to_user() properly.

Thanks for catching this.  I'm amazed that this driver still has bugs like this.

> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 3fe82d0..2be7f29 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -162,12 +162,13 @@ static long booke_wdt_ioctl(struct file *file,
>                                 unsigned int cmd, unsigned long arg)
>  {
>         u32 tmp = 0;
> -       u32 __user *p = (u32 __user *)arg;
> +       void __user *argp = (u32 __user *)arg;
> +       u32 __user *p = argp;

You don't need to create 'argp'.  The existing 'p' variable will work
in the copy_to_user() call.

> +               return copy_to_user(argp, &ident,
> +                               sizeof(ident)) ? -EFAULT : 0;

This can fit in one line, especially if you use 'p' instead of 'argp'.

-- 
Timur Tabi
Linux kernel developer at Freescale
