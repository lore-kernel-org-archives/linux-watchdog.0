Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53122 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbCaTC6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 Mar 2015 15:02:58 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Yd1RB-002zwr-DS
	for linux-watchdog@vger.kernel.org; Tue, 31 Mar 2015 19:02:57 +0000
Message-ID: <551AEF56.4070504@roeck-us.net>
Date: Tue, 31 Mar 2015 12:02:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH 2/4] watchdog: imgpdc: Intialize timeout to default value
References: <1427827751-19705-1-git-send-email-abrestic@chromium.org> <1427827751-19705-2-git-send-email-abrestic@chromium.org>
In-Reply-To: <1427827751-19705-2-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/31/2015 11:49 AM, Andrew Bresticker wrote:
> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
>
> Currently the watchdog timeout is initialized to 0.  Initialize it to
> its default value instead.
>
> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>   drivers/watchdog/imgpdc_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> index c4151cd..f3f65ac 100644
> --- a/drivers/watchdog/imgpdc_wdt.c
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -42,7 +42,7 @@
>   #define PDC_WDT_MIN_TIMEOUT		1
>   #define PDC_WDT_DEF_TIMEOUT		64
>
> -static int heartbeat;
> +static int heartbeat = PDC_WDT_DEF_TIMEOUT;
>   module_param(heartbeat, int, 0);
>   MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
>   	"(default = " __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
>

The idea with watchdog_init_timeout() is that it can take the
timeout from devicetree unless the module parameter is provided.
By pre-initializing the module parameter, you defeat that and
make watchdog_init_timeout more or less a no-op. You might as well
set pdc_wdt->wdt_dev.timeout directly and not call watchdog_init_timeout
at all if that is what you want.

The "expected" solution would be to pre-initialize pdc_wdt->wdt_dev.timeout
but leave the module parameter alone.

Guenter

