Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46448 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbcEDCvN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2016 22:51:13 -0400
Subject: Re: [PATCH v2] watchdog: f71808e_wdt: Fix WDTMOUT_STS register read
To: Knud Poulsen <knpo@ieee.org>, Wim Van Sebroeck <wim@iguana.be>,
	Linux Watchdog <linux-watchdog@vger.kernel.org>
References: <571F0E40.6080205@ieee.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57296399.6060308@roeck-us.net>
Date: Tue, 3 May 2016 19:51:05 -0700
MIME-Version: 1.0
In-Reply-To: <571F0E40.6080205@ieee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/25/2016 11:44 PM, Knud Poulsen wrote:
>
> Tested and verified on Lanner LEC-3030 Industrial PC (with F81865)
>
> Datasheet verified for
>   F71808, F71858, F71862, F71869, F71869A, F71882, F71889, F81865
>
> Datasheet references:
> F71808A:
>   http://www.electronicsdatasheets.com/download/534cf560e34e2406135f4658.pdf?format=pdf
> F71858:
>   http://www.electronicsdatasheets.com/download/534cf55fe34e2406135f4635.pdf?format=pdf
> F71862:
>   http://www.hardwaresecrets.com/datasheets/F71862_V027P.pdf
> F71869:
>   http://www.clubedohardware.com.br/datasheets/366451_F71869.pdf
> F71869A:
>   http://www.chipset-ic.com/datasheet/F71869AD.pdf
> F71882:
>   http://www.digchip.com/datasheets/parts/datasheet/931/F71882-pdf.php
> F71889:
>   http://pdf1.alldatasheet.com/datasheet-pdf/view/406312/FINTEK/F71889.html
> F81865:
>   http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
>   http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
>
> Signed-off-by: Knud Poulsen <knpo@ieee.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/f71808e_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 016bd93..190d87c 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -66,7 +66,7 @@
>
>   #define F71808FG_FLAG_WDOUT_EN		7
>
> -#define F71808FG_FLAG_WDTMOUT_STS	5
> +#define F71808FG_FLAG_WDTMOUT_STS	6
>   #define F71808FG_FLAG_WD_EN		5
>   #define F71808FG_FLAG_WD_PULSE		4
>   #define F71808FG_FLAG_WD_UNIT		3
> @@ -655,7 +655,7 @@ static int __init watchdog_init(int sioaddr)
>   	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
>
>   	wdt_conf = superio_inb(sioaddr, F71808FG_REG_WDT_CONF);
> -	watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
> +	watchdog.caused_reboot = wdt_conf & BIT(F71808FG_FLAG_WDTMOUT_STS);
>
>   	superio_exit(sioaddr);
>

