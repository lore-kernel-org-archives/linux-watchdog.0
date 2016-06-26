Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33944 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbcFZCa6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Jun 2016 22:30:58 -0400
Subject: Re: [PATCH v2 2/2] fs: compat_ioctl: add pretimeout functions for
 watchdogs
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Gong <b38343@freescale.com>
References: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1466902865-14354-3-git-send-email-vladimir_zapolskiy@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <576F3E55.3080604@roeck-us.net>
Date: Sat, 25 Jun 2016 19:30:45 -0700
MIME-Version: 1.0
In-Reply-To: <1466902865-14354-3-git-send-email-vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/25/2016 06:01 PM, Vladimir Zapolskiy wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Watchdog core now handles those ioctls centrally, so we want 64 bit
> support, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes from v1 to v2:
> * none
>
>   fs/compat_ioctl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
> index bd01b92..914bfc5 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -1208,6 +1208,8 @@ COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
>   COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
>   COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
>   COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
> +COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
> +COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
>   /* Big R */
>   COMPATIBLE_IOCTL(RNDGETENTCNT)
>   COMPATIBLE_IOCTL(RNDADDTOENTCNT)
>

