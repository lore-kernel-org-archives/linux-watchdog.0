Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 5 Feb 2016 08:12:23 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, Arnd Bergmann <arnd@arndb.de>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Sandeep Tripathy <tripathy@broadcom.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v4.5-rc Fixes
Message-ID: <20160205071223.GA29053@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It will fix several Kconfig dependencies, a compilation warning in pcwd_usb,
a failure to abort the sp805 wdt after a ping and the max63xx wdt's MODULE_LICENSE.

This will update the following files:

 Kconfig       |    6 +++++-
 max63xx_wdt.c |    2 +-
 pcwd_usb.c    |    3 +--
 sp805_wdt.c   |    5 ++---
 4 files changed, 9 insertions(+), 7 deletions(-)

with these Changes:

commit d42d6108711b142804b4710d4215efbf5f9b6e21
Author: Richard Weinberger <richard@nod.at>
Date:   Mon Jan 25 23:24:14 2016 +0100

    watchdog: Fix dependencies for !HAS_IOMEM archs
    
    Not every arch has io memory.
    So, unbreak the build by fixing the dependencies.
    
    Signed-off-by: Richard Weinberger <richard@nod.at>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit df1a3e64f79b3e277a22b2e789896f86c63eec1f
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Jan 25 17:06:27 2016 +0100

    watchdog: imgdpc: select WATCHDOG_CORE
    
    The imgpdc_wdt driver can be built on all architectures with
    CONFIG_COMPILE_TEST, but fails if no other watchdog driver is
    enabled:
    
    drivers/watchdog/built-in.o: In function `pdc_wdt_remove':
    imgpdc_wdt.c:(.text+0x74): undefined reference to `watchdog_unregister_device'
    
    This adds the normal 'select WATCHDOG_CORE' that is needed to
    ensure the driver always builds cleanly.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Reviewed-by: James Hogan <james.hogan@imgtec.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit c75f6c5ac0877e8d9728f680aa324e9adeff91e1
Author: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Date:   Thu Jan 21 15:27:07 2016 +0100

    watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
    
    This change was requested by arm-soc maintainer Kevin Hilman
    because the X in TANGOX is a wildcard.
    
    Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
    Acked-by: Mans Rullgard <mans@mansr.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 99f08ca84156f08b8545f7a5bfedfdd2452c4556
Author: Tomas Winkler <tomas.winkler@intel.com>
Date:   Tue Jan 19 15:51:04 2016 +0200

    watchdog: pcwd_usb: fix compilation warning
    
    In function ‘usb_pcwd_probe’:
    drivers/watchdog/pcwd_usb.c:611:12: warning: variable ‘maxp’ set but not
    used [-Wunused-but-set-variable]
      int pipe, maxp;
    
    Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 55e071779c79890f43b75d4472243280e91581de
Author: Sandeep Tripathy <tripathy@broadcom.com>
Date:   Tue Jan 19 14:44:49 2016 +0530

    watchdog: sp805: ping fails to abort wdt reset
    
    sp805 wdt asserts interrupt for the first expiry and
    reloads the counter. If wdt interrupt is set and count
    reaches zero then wdt reset event is generated. To get
    wdt reset at 't' timeout the driver loads wdt counter
    with 't/2'. A ping before time 't'  *should* prevent
    wdt reset. Currently if ping is done after 't/2' then
    wdt interrupt condition gets set. On the next countdown
    of loadval wdt reset event occurs eventhough wdt was
    reloaded before the set timeout 't'.
    
    This patch clears the interrupt condition on ping.
    
    Signed-off-by: Sandeep Tripathy <tripathy@broadcom.com>
    Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 29efefb9091dc7b58a2ac9d054c92295101e6bb2
Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date:   Fri Jan 15 18:35:34 2016 +0100

    watchdog: max63xx: make module's license marker match the header
    
    The header specifies GPL version 2 only, so make the MODULE_LICENSE
    string use the respective string for that.
    
    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4f0e7be..0f6d851 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -145,7 +145,8 @@ config MENF21BMC_WATCHDOG
 config TANGOX_WATCHDOG
 	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
 	select WATCHDOG_CORE
-	depends on ARCH_TANGOX || COMPILE_TEST
+	depends on ARCH_TANGO || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
 	  and SMP87xx (tango4) family chips.
@@ -618,6 +619,7 @@ config DIGICOLOR_WATCHDOG
 config LPC18XX_WATCHDOG
 	tristate "LPC18xx/43xx Watchdog"
 	depends on ARCH_LPC18XX || COMPILE_TEST
+	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
@@ -1374,6 +1376,7 @@ config BCM_KONA_WDT_DEBUG
 config BCM7038_WDT
 	tristate "BCM7038 Watchdog"
 	select WATCHDOG_CORE
+	depends on HAS_IOMEM
 	help
 	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
 
@@ -1383,6 +1386,7 @@ config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"
 	depends on HAS_IOMEM
 	depends on METAG || MIPS || COMPILE_TEST
+	select WATCHDOG_CORE
 	help
 	  Driver for Imagination Technologies PowerDown Controller
 	  Watchdog Timer.
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index f36ca4b..ac5840d 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -292,4 +292,4 @@ MODULE_PARM_DESC(nodelay,
 		 "Force selection of a timeout setting without initial delay "
 		 "(max6373/74 only, default=0)");
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 1a11aed..68952d9 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -608,7 +608,7 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_pcwd_private *usb_pcwd = NULL;
-	int pipe, maxp;
+	int pipe;
 	int retval = -ENOMEM;
 	int got_fw_rev;
 	unsigned char fw_rev_major, fw_rev_minor;
@@ -641,7 +641,6 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
-	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
 
 	/* allocate memory for our device and initialize it */
 	usb_pcwd = kzalloc(sizeof(struct usb_pcwd_private), GFP_KERNEL);
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 01d8162..e7a715e 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -139,12 +139,11 @@ static int wdt_config(struct watchdog_device *wdd, bool ping)
 
 	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
 	writel_relaxed(wdt->load_val, wdt->base + WDTLOAD);
+	writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
 
-	if (!ping) {
-		writel_relaxed(INT_MASK, wdt->base + WDTINTCLR);
+	if (!ping)
 		writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base +
 				WDTCONTROL);
-	}
 
 	writel_relaxed(LOCK, wdt->base + WDTLOCK);
 
