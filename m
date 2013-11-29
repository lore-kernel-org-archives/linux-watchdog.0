Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33056 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3K2NXU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Nov 2013 08:23:20 -0500
Message-ID: <5298943D.8010608@ti.com>
Date: Fri, 29 Nov 2013 15:18:53 +0200
From: Grygorii Strashko <grygorii.strashko@ti.com>
MIME-Version: 1.0
To: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>, <wim@iguana.be>,
	<nsekhar@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<Pawel.Moll@arm.com>, <swarren@wwwdotorg.org>,
	<ijc+devicetree@hellion.org.uk>, <galak@kernel.crashing.org>,
	<rob.herring@calxeda.com>, <linux-kernel@vger.kernel.org>,
	<grant.likely@linaro.org>
Subject: Re: [PATCH v4 0/5] Update Davinci watchdog driver
References: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
In-Reply-To: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Sekhar,

On 11/27/2013 02:48 PM, Ivan Khoronzhuk wrote:
> These patches are intended to update Davinci watchdog to use WDT core
> and reuse driver for keystone arch, because Keystone uses the similar
> IP like Davinci.
> 
> See Documentation:
> Davinci DM646x - http://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
> Keystone - http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
> 
> Also:
>   - improved to support GET_TIMELEFT option.
>   - added "clocks" and "timeout-sec" properties to DT.

Do you have any additional comments to this series?

By the way patch "[PATCH] watchdog: davinci: rename platform driver to davinci-wdt"
https://lkml.org/lkml/2013/11/27/201 can be applied as before as after this series
without conflicts.

> 
> Based on
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
> keystone/master
> 
> v3..v4:
> - watchdog: davinci: change driver to use WDT core
> 	reverted rename of platform driver to "davinci-wdt"
> 	as it causes a regression on Davinci platforms.
> 
[...]
> 
> Ivan Khoronzhuk (5):
>    watchdog: davinci: change driver to use WDT core
>    watchdog: davinci: use davinci_wdt_device structure to hold device
>      data
>    watchdog: davinci: add GET_TIMELEFT option support
>    watchdog: davinci: add "timeout-sec" property
>    watchdog: davinci: reuse driver for keystone arch
> 
>   .../devicetree/bindings/watchdog/davinci-wdt.txt   |   16 +-
>   drivers/watchdog/Kconfig                           |    6 +-
>   drivers/watchdog/davinci_wdt.c                     |  221 +++++++++-----------
>   3 files changed, 114 insertions(+), 129 deletions(-)
> 


Regards,
-grygorii
