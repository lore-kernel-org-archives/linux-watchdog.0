Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60156 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933AbcB0Bpy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Feb 2016 20:45:54 -0500
Subject: Re: [PATCH] Rename "trigger" reset reason "hw watchdog"
To: Martyn Welch <martyn.welch@collabora.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1456502712-25965-1-git-send-email-martyn.welch@collabora.co.uk>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D0FFCF.5030707@roeck-us.net>
Date: Fri, 26 Feb 2016 17:45:51 -0800
MIME-Version: 1.0
In-Reply-To: <1456502712-25965-1-git-send-email-martyn.welch@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/26/2016 08:05 AM, Martyn Welch wrote:
> The Zodiac watchdog is implemented on a microcontoller. The reset reason
> currently labelled "trigger" is not to detect when the watchdog has
> triggered (as had been initially understood and suggested by the naming),
> but to inform the reader that the watchdog, which in fact has it's own
> hardware watchdog, has been reset because the hardware watchdog has
> triggered. Renaming to "hw watchdog".
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ziirave_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> index 0c7cb73..cbe373de 100644
> --- a/drivers/watchdog/ziirave_wdt.c
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -36,7 +36,7 @@
>   #define ZIIRAVE_STATE_OFF	0x1
>   #define ZIIRAVE_STATE_ON	0x2
>
> -static char *ziirave_reasons[] = {"power cycle", "triggered", NULL, NULL,
> +static char *ziirave_reasons[] = {"power cycle", "hw watchdog", NULL, NULL,
>   				  "host request", NULL, "illegal configuration",
>   				  "illegal instruction", "illegal trap",
>   				  "unknown"};
>

