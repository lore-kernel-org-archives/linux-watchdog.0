Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:57230 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422697AbbFEOOG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Jun 2015 10:14:06 -0400
Message-ID: <5571AEA9.7010803@mentor.com>
Date: Fri, 5 Jun 2015 17:14:01 +0300
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
To: Markus Rinne <markus.rinne@vincit.fi>, <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH] watchdog: imx2_wdt: Fix ioctl() results
References: <20150605124144.GA26755@markusri_laptop.vincit.intranet>
In-Reply-To: <20150605124144.GA26755@markusri_laptop.vincit.intranet>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Markus,

On 05.06.2015 15:41, Markus Rinne wrote:
> WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT returned the initial timeout and
> not the one that was last set.  Fix this by updating struct
> watchdog_device member 'timeout'.  This is how it's supposed to be done
> according to Documentation/watchdog/watchdog-kernel-api.txt.
> 
> This is the test case I used:
> 
> #include <fcntl.h>
> #include <linux/watchdog.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> 
> #include <assert.h>
> #include <stdlib.h>
> 
> static const int TIMEOUT = 127;
> 
> int main(void)
> {
> 	int fd = open("/dev/watchdog", O_WRONLY);
> 	if (fd == -1)
> 		return EXIT_FAILURE;
> 
> 	int timeout = TIMEOUT;
> 	ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
> 	assert(timeout == TIMEOUT);
> 
> 	close(fd);
> 
> 	return EXIT_SUCCESS;
> }
> 
> Signed-off-by: Markus Rinne <markus.rinne@vincit.fi>
> ---
>  drivers/watchdog/imx2_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 5e6d808..b636799 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -168,6 +168,7 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>  
>  	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
>  			   WDOG_SEC_TO_COUNT(new_timeout));
> +	wdog->timeout = new_timeout;
>  	return 0;
>  }
>  
> 

this change repeats the change sent by Michael Grzeschik one month ago
-- http://www.spinics.net/lists/linux-watchdog/msg06296.html

--
With best wishes,
Vladimir
