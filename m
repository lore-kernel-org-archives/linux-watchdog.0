Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45884 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcFKBRE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Jun 2016 21:17:04 -0400
Subject: Re: [PATCH] watchdog: drop redundant 'default n' option for
 WATCHDOG_SYSFS
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1465398975-11207-1-git-send-email-vladimir_zapolskiy@mentor.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <575B667E.6060404@roeck-us.net>
Date: Fri, 10 Jun 2016 18:16:46 -0700
MIME-Version: 1.0
In-Reply-To: <1465398975-11207-1-git-send-email-vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/08/2016 08:16 AM, Vladimir Zapolskiy wrote:
> The option 'default n' and its absence are equal for kbuild,
> which makes explicit 'default n' redundant.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b54f26c..8d38cb8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -48,7 +48,6 @@ config WATCHDOG_NOWAYOUT
>
>   config WATCHDOG_SYSFS
>   	bool "Read different watchdog information through sysfs"
> -	default n
>   	help
>   	  Say Y here if you want to enable watchdog device status read through
>   	  sysfs attributes.
>

