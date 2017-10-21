Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45449 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdJUCZX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Oct 2017 22:25:23 -0400
Subject: Re: [PATCH 1/3] watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
 <fdb84d723278f8f198a59f79e31d8903870fb2a0.1508539271.git.jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a9e00af0-8239-d5cb-078c-06f3388810cf@roeck-us.net>
Date: Fri, 20 Oct 2017 19:25:20 -0700
MIME-Version: 1.0
In-Reply-To: <fdb84d723278f8f198a59f79e31d8903870fb2a0.1508539271.git.jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/20/2017 03:54 PM, Jerry Hoemann wrote:
> Add support for WDIOC_GETPRETIMEOUT ioctl so that user applications
> can determine when the NMI should arrive.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 67fbe35..ef54b03 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -50,6 +50,7 @@
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   static char expect_release;
>   static unsigned long hpwdt_is_open;
> +static const int pretimeout = 9;
>   
>   static void __iomem *pci_mem_addr;		/* the PCI-memory address */
>   static unsigned long __iomem *hpwdt_timer_reg;
> @@ -622,6 +623,12 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
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

Can you please convert the driver to use the watchdog subsystem instead ?
If there are still improvements needed afterwards, they can still be
implemented, but we really should not make improvements which are
already supported by the watchdog core.

Thanks,
Guenter
