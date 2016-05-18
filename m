Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42607 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbcEROhU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 May 2016 10:37:20 -0400
Subject: Re: [PATCH 1/2] watchdog: iTCO-wdt handle 5th variation for Apollo
 Lake
To: "Yong, Jonathan" <jonathan.yong@intel.com>,
	linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1463541972-19758-2-git-send-email-jonathan.yong@intel.com>
Cc: qipeng.zha@intel.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <573C7E1D.3040602@roeck-us.net>
Date: Wed, 18 May 2016 07:37:17 -0700
MIME-Version: 1.0
In-Reply-To: <1463541972-19758-2-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/17/2016 08:26 PM, Yong, Jonathan wrote:
> The Apollo Lake Watchdog has the no_reboot flag in the 4th bit.
>
> Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/iTCO_wdt.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 0acc6c5..eccba32 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -150,6 +150,9 @@ static inline u32 no_reboot_bit(void)
>   	u32 enable_bit;
>
>   	switch (iTCO_wdt_private.iTCO_version) {
> +	case 5:
> +		enable_bit = 0x00000008;
> +		break;
>   	case 3:
>   		enable_bit = 0x00000010;
>   		break;
> @@ -512,6 +515,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>
>   	/* Clear out the (probably old) status */
>   	switch (iTCO_wdt_private.iTCO_version) {
> +	case 5:
>   	case 4:
>   		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
>   		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
>

