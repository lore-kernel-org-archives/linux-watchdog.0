Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:55739 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbdJXDUN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Oct 2017 23:20:13 -0400
Subject: Re: [PATCH v2 3/3] watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
 <8683001075d79d84212c94b6f361c9fb34062012.1508797127.git.jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <94180768-5f46-a110-8fcf-19213ce69dd7@roeck-us.net>
Date: Mon, 23 Oct 2017 20:20:09 -0700
MIME-Version: 1.0
In-Reply-To: <8683001075d79d84212c94b6f361c9fb34062012.1508797127.git.jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/23/2017 03:46 PM, Jerry Hoemann wrote:
> Add support for WDIOC_GETPRETIMEOUT ioctl so that user applications
> can determine when the NMI should arrive.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

I'll leave this for Wim to decide. My take is that we should not add functionality
to old-style drivers and convert those drivers to use the watchdog core instead.

Thanks,
Guenter

> ---
>   drivers/watchdog/hpwdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index e616583..b64ce43 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -50,6 +50,7 @@
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   static char expect_release;
>   static unsigned long hpwdt_is_open;
> +static const int pretimeout = 9;
>   
>   static void __iomem *pci_mem_addr;		/* the PCI-memory address */
>   static unsigned long __iomem *hpwdt_nmistat;
> @@ -631,6 +632,12 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
>   		}
>   		break;
>   
> +	case WDIOC_GETPRETIMEOUT:
> +		ret = copy_to_user(argp, &pretimeout, sizeof(pretimeout));
> +		if (ret)
> +			ret = -EFAULT;
> +		break;
> +
>   	case WDIOC_SETTIMEOUT:
>   		ret = get_user(new_margin, p);
>   		if (ret)
> 

