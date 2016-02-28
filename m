Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49972 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581AbcB1P45 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 10:56:57 -0500
Subject: Re: [PATCH for-4.5] watchdog/rc32434_wdt: fix ioctl error handling
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <1456674185-24670-1-git-send-email-mst@redhat.com>
Cc: stable@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D318C7.8070800@roeck-us.net>
Date: Sun, 28 Feb 2016 07:56:55 -0800
MIME-Version: 1.0
In-Reply-To: <1456674185-24670-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/28/2016 07:44 AM, Michael S. Tsirkin wrote:
> Calling return copy_to_user(...) in an ioctl will not do the right thing
> if there's a pagefault: copy_to_user returns the number of bytes not
> copied in this case.
>
> Fix up watchdog/rc32434_wdt to do
> 	return copy_to_user(...)) ?  -EFAULT : 0;
>
> instead.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
> Untested.
>
>   drivers/watchdog/rc32434_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
> index 71e78ef..3a75f3b 100644
> --- a/drivers/watchdog/rc32434_wdt.c
> +++ b/drivers/watchdog/rc32434_wdt.c
> @@ -237,7 +237,7 @@ static long rc32434_wdt_ioctl(struct file *file, unsigned int cmd,
>   			return -EINVAL;
>   		/* Fall through */
>   	case WDIOC_GETTIMEOUT:
> -		return copy_to_user(argp, &timeout, sizeof(int));
> +		return copy_to_user(argp, &timeout, sizeof(int)) ? -EFAULT : 0;
>   	default:
>   		return -ENOTTY;
>   	}
>

