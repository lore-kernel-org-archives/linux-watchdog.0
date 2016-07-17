Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sun, 17 Jul 2016 21:49:00 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Joel Stanley <joel@jms.id.au>
Cc: linux@roeck-us.net, robh@kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jk@ozlabs.org,
	benh@kernel.crashing.org
Subject: Re: [PATCH v3 0/2]  watchdog: Add Aspeed watchdog driver
Message-ID: <20160717194900.GA32751@spo001.leaseweb.nl>
References: <1463062631-16432-1-git-send-email-joel@jms.id.au> <1463559661-14170-1-git-send-email-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463559661-14170-1-git-send-email-joel@jms.id.au>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Joel,

> Hello,
> 
> These patches add support for the watchdog timer found in Aspeed ast2400 and
> ast2500 BMC SoCs.
> 
> The u-boot that ships on the edk and with many systems leaves the watchdog
> running when jumping to the kernel, making this driver required for operation.
> 
> It has been tested on the ast2400 in an OpenPower Palmetto, and the ast2500-edk
> dev board.
> 
> Changes in v3:
>  - remove rate from struct aspeed_wdt in favour of #define
>  - don't start the timer when setting the timeout
>  - wait after initiaitng the reboot so it catches
>  - remove dev_info from startup
> 
>  - update bindings following review from Rob (this didn't make it to the
>  mailing list in v2)
> 
> Changes in v2:
> 
> Addressed review from Guenter:
>  - dropped the drv_dbgs
>  - added defines for all of the constants
>  - clarified the type of reset we want
>  - leaves the watchdog running
> 
> Cheers,
> 
> Joel
> 
> Joel Stanley (2):
>   doc/devicetree: Add Aspeed watchdog timer bindings
>   watchdog: Add Aspeed watchdog driver
> 
>  .../devicetree/bindings/watchdog/aspeed-wdt.txt    |  16 ++
>  drivers/watchdog/Kconfig                           |  13 ++
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/aspeed_wdt.c                      | 212 +++++++++++++++++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>  create mode 100644 drivers/watchdog/aspeed_wdt.c
> 
> -- 
> 2.8.1
> 

These patches have been added to linux-watchdog-next.

Kind regards,
Wim.
