Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43697 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFWNjt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jun 2016 09:39:49 -0400
Subject: Re: [PATCH v2 1/2] watchdog: iTCO-wdt handle 5th variation for Apollo
 Lake
To: "Yong, Jonathan" <jonathan.yong@intel.com>,
	linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1466123612-50633-1-git-send-email-jonathan.yong@intel.com>
 <1466123612-50633-2-git-send-email-jonathan.yong@intel.com>
Cc: qipeng.zha@intel.com, dvhart@infradead.org,
	linux-kernel.vger.kernel.org@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <576BE697.2060907@roeck-us.net>
Date: Thu, 23 Jun 2016 06:39:35 -0700
MIME-Version: 1.0
In-Reply-To: <1466123612-50633-2-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/16/2016 05:33 PM, Yong, Jonathan wrote:
> The Apollo Lake Watchdog has the no_reboot flag in the 4th bit.
>
> Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/iTCO_wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 0acc6c5..54cab18 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -150,6 +150,7 @@ static inline u32 no_reboot_bit(void)
>   	u32 enable_bit;
>
>   	switch (iTCO_wdt_private.iTCO_version) {
> +	case 5:
>   	case 3:
>   		enable_bit = 0x00000010;
>   		break;
> @@ -512,6 +513,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>
>   	/* Clear out the (probably old) status */
>   	switch (iTCO_wdt_private.iTCO_version) {
> +	case 5:
>   	case 4:
>   		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
>   		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
>

