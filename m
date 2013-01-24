Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56675 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab3AXRQF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Jan 2013 12:16:05 -0500
Message-ID: <51016C4D.40707@hauke-m.de>
Date: Thu, 24 Jan 2013 18:15:57 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: wim@iguana.be
CC: linux-watchdog@vger.kernel.org, zajec5@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs
 with PMU
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/12/2013 06:14 PM, Hauke Mehrtens wrote:
> This patch series improves the functions for setting the watchdog 
> driver for bcm47xx based SoCs using ssb and bcma. This makes the 
> watchdog driver use the platform device provided by bcma or ssb.
> 
> This code is currently based on the linux-watchdog/master tree by 
> Wim Van Sebroeck.
> 
> v4:
>  * Just the parts changing the watchdog driver itself and not ssb or bcma.
> 
> v3:
>  * Remove changes done to the watchdog driver so John could pull this 
>    into wireless-testing, this sill works with the old watchdog driver. 
>    The patches changing the watchdog driver will be send later.
>    This was done to get this into 3.8 because Wim Van Sebroeck is 
>    neither giving an Ack or a Nack on these patches and we want to do 
>    more changes to bcma/ssb on top of these.
> 
> v2:
>  * reword some commit messages
>  * rebase on current wireless-testing/master with 
>       "ssb: extif: fix compile errors" applied on top of it.
>  * do not change value of WDT_SOFTTIMER_MAX
>  * moved some small changes in the bcm47xx_wdt.c patches
> 
> Hauke Mehrtens (5):
>   watchdog: bcm47xx_wdt.c: convert to watchdog core api
>   watchdog: bcm47xx_wdt.c: use platform device
>   watchdog: bcm47xx_wdt.c: rename ops methods
>   watchdog: bcm47xx_wdt.c: rename wdt_time to timeout
>   watchdog: bcm47xx_wdt.c: add hard timer
> 
>  drivers/watchdog/Kconfig       |    1 +
>  drivers/watchdog/bcm47xx_wdt.c |  339 +++++++++++++++++-----------------------
>  include/linux/bcm47xx_wdt.h    |    9 ++
>  3 files changed, 154 insertions(+), 195 deletions(-)
> 
Hi Wim,

what is the status of these patches?

Hauke
