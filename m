Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 20 May 2017 15:39:27 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
	Johan Hovold <johan@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shile Zhang <shile.zhang@nokia.com>,
	Tomas Melin <tomas.melin@vaisala.com>,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v4.12-rc1 Fixes
Message-ID: <20170520133927.GA18824@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It will fix:
* orion_wdt compile-test dependencies
* sama5d4_wdt: WDDIS handling and a race confition
* pcwd_usb: fix NULL-deref at probe
* cadence_wdt: fix timeout setting
* wdt_pci: fix build error if SOFTWARE_REBOOT is defined
* iTCO_wdt: all versions count down twice
* zx2967: remove redundant dev_err call in zx2967_wdt_probe()
* bcm281xx: Fix use of uninitialized spinlock

This will update the following files:

 Documentation/watchdog/watchdog-parameters.txt |    2 
 drivers/watchdog/Kconfig                       |    2 
 drivers/watchdog/bcm_kona_wdt.c                |    3 
 drivers/watchdog/cadence_wdt.c                 |    2 
 drivers/watchdog/iTCO_wdt.c                    |   22 +++----
 drivers/watchdog/pcwd_usb.c                    |    3 
 drivers/watchdog/sama5d4_wdt.c                 |   77 ++++++++++++++++++-------
 drivers/watchdog/wdt_pci.c                     |    2 
 drivers/watchdog/zx2967_wdt.c                  |    4 -
 9 files changed, 77 insertions(+), 40 deletions(-)

with these Changes:

commit fedf266f9955d9a019643cde199a2fd9a0259f6f
Author: Eric Anholt <eric@anholt.net>
Date:   Thu Apr 27 18:02:32 2017 -0700

    watchdog: bcm281xx: Fix use of uninitialized spinlock.
    
    The bcm_kona_wdt_set_resolution_reg() call takes the spinlock, so
    initialize it earlier.  Fixes a warning at boot with lock debugging
    enabled.
    
    Fixes: 6adb730dc208 ("watchdog: bcm281xx: Watchdog Driver")
    Signed-off-by: Eric Anholt <eric@anholt.net>
    Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 07441a7dd11f6855bcf55fbbfc6abba42258b2c6
Author: Wei Yongjun <weiyongjun1@huawei.com>
Date:   Tue Apr 25 16:17:33 2017 +0000

    watchdog: zx2967: remove redundant dev_err call in zx2967_wdt_probe()
    
    There is a error message within devm_ioremap_resource
    already, so remove the dev_err call to avoid redundant
    error message.
    
    Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1fccb73011ea8a5fa0c6d357c33fa29c695139ea
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Apr 5 13:41:15 2017 +0200

    iTCO_wdt: all versions count down twice
    
    The ICH9 is listed as having TCO v2, and indeed the behavior in the
    datasheet corresponds to v2 (for example the NO_REBOOT flag is
    accessible via the 16KiB-aligned Root Complex Base Address).
    
    However, the TCO counts twice just like in v1; the documentation
    of the SECOND_TO_STS bit says: "ICH9 sets this bit to 1 to indicate
    that the TIMEOUT bit had been (or is currently) set and a second
    timeout occurred before the TCO_RLD register was written. If this
    bit is set and the NO_REBOOT config bit is 0, then the ICH9 will
    reboot the system after the second timeout.  The same can be found
    in the BayTrail (Atom E3800) datasheet, and even HOWTOs around
    the Internet say that it will reboot after _twice_ the specified
    heartbeat.
    
    I did not find the Apollo Lake datasheet, but because v4/v5 has
    a SECOND_TO_STS bit just like the previous version I'm enabling
    this for Apollo Lake as well.
    
    Cc: linux-watchdog@vger.kernel.org
    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 455a9a60b6d4afb293b0e63ec75cc8e82912a767
Author: Shile Zhang <shile.zhang@nokia.com>
Date:   Mon Apr 10 22:39:33 2017 +0800

    watchdog: wdt_pci: fix build error if define SOFTWARE_REBOOT
    
    To fix following build error when SOFTWARE_REBOOT is defined:
    
      CC [M]  driver/watchdog/wdt_pci.o
    driver/watchdog/wdt_pci.c: In function 'wdtpci_interrupt':
    driver/watchdog/wdt_pci.c:335:3: error: too many arguments to function 'emergency_restart'
       emergency_restart(NULL);
       ^
    In file included from driver/watchdog/wdt_pci.c:51:0:
    include/linux/reboot.h:80:13: note: declared here
     extern void emergency_restart(void);
                 ^
    
    Signed-off-by: Shile Zhang <shile.zhang@nokia.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0ddad77b90cb52075b5a9498f0621e3e265cc19f
Author: Tomas Melin <tomas.melin@vaisala.com>
Date:   Mon Mar 20 09:29:31 2017 +0200

    watchdog: cadence_wdt: fix timeout setting
    
    wdt_timeout must not be initialized to CDNS_WDT_DEFAULT_TIMEOUT in
    order to allow the value to be overriddden by a device tree setting.
    
    This way, the default timeout value will be used only in case module_param
    has not been set, or device tree timeout-sec has not been defined.
    
    Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 46c319b848268dab3f0e7c4a5b6e9146d3bca8a4
Author: Johan Hovold <johan@kernel.org>
Date:   Mon Mar 13 13:49:45 2017 +0100

    watchdog: pcwd_usb: fix NULL-deref at probe
    
    Make sure to check the number of endpoints to avoid dereferencing a
    NULL-pointer should a malicious device lack endpoints.
    
    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
    Cc: stable <stable@vger.kernel.org>
    Signed-off-by: Johan Hovold <johan@kernel.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ddd6d240b26dcb8b8dc98bd493eba944dd97ebc8
Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date:   Thu Mar 2 18:31:12 2017 +0100

    watchdog: sama5d4: fix race condition
    
    WDT_MR and WDT_CR must not updated within three slow clock periods after
    the last ping (write to WDT_CR or WDT_MR). Ensure enough time has elapsed
    before writing those registers.
    wdt_write() waits for 4 periods to ensure at least 3 edges are seen by the
    IP.
    
    Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
    Acked-by: Wenyou.Yang <wenyou.yang@microchip.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 015b528644a84b0018d3286ecd6ea5f82dce0180
Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date:   Thu Mar 2 18:31:11 2017 +0100

    watchdog: sama5d4: fix WDDIS handling
    
    The datasheet states: "When setting the WDDIS bit, and while it is set, the
    fields WDV and WDD must not be modified."
    
    Because the whole configuration is already cached inside .mr, wait for the
    user to enable the watchdog to configure it so it is enabled and configured
    at the same time (what the IP is actually expecting).
    
    When the watchdog is already enabled, it is not an issue to reconfigure it.
    
    Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
    Acked-by: Wenyou.Yang <wenyou.yang@microchip.com>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit d8f1deaa5256aba3296025e103e8abb96f3e6479
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Mar 2 13:09:52 2017 +0100

    watchdog: orion: fix compile-test dependencies
    
    I ran into one corner case with the orion watchdog using the
    atomic_io_modify interface:
    
    drivers/watchdog/orion_wdt.o: In function `orion_stop':
    orion_wdt.c:(.text.orion_stop+0x28): undefined reference to `atomic_io_modify'
    drivers/watchdog/orion_wdt.o: In function `armada375_stop':
    orion_wdt.c:(.text.armada375_stop+0x28): undefined reference to `atomic_io_modify'
    
    This function is available on all 32-bit ARM builds except for ebsa110, so
    we have to specifically exclude that from compile-testing.
    
    Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 4f7d86d..914518a 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -117,7 +117,7 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 iTCO_wdt:
 heartbeat: Watchdog heartbeat in seconds.
-	(2<heartbeat<39 (TCO v1) or 613 (TCO v2), default=30)
+	(5<=heartbeat<=74 (TCO v1) or 1226 (TCO v2), default=30)
 nowayout: Watchdog cannot be stopped once started
 	(default=kernel config parameter)
 -------------------------------------------------
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 52a70ee..8b9049d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -452,7 +452,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || COMPILE_TEST
+	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU || (COMPILE_TEST && !ARCH_EBSA110)
 	depends on ARM
 	select WATCHDOG_CORE
 	help
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 6fce17d..a5775df 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -304,6 +304,8 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
+	spin_lock_init(&wdt->lock);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(wdt->base))
@@ -316,7 +318,6 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	spin_lock_init(&wdt->lock);
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
 	bcm_kona_wdt_wdd.parent = &pdev->dev;
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 8d61e8b..86e0b5d 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -49,7 +49,7 @@
 /* Counter maximum value */
 #define CDNS_WDT_COUNTER_MAX 0xFFF
 
-static int wdt_timeout = CDNS_WDT_DEFAULT_TIMEOUT;
+static int wdt_timeout;
 static int nowayout = WATCHDOG_NOWAYOUT;
 
 module_param(wdt_timeout, int, 0);
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 347f038..c4f6587 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -306,16 +306,15 @@ static int iTCO_wdt_ping(struct watchdog_device *wd_dev)
 
 	iTCO_vendor_pre_keepalive(p->smi_res, wd_dev->timeout);
 
+	/* Reset the timeout status bit so that the timer
+	 * needs to count down twice again before rebooting */
+	outw(0x0008, TCO1_STS(p));	/* write 1 to clear bit */
+
 	/* Reload the timer by writing to the TCO Timer Counter register */
-	if (p->iTCO_version >= 2) {
+	if (p->iTCO_version >= 2)
 		outw(0x01, TCO_RLD(p));
-	} else if (p->iTCO_version == 1) {
-		/* Reset the timeout status bit so that the timer
-		 * needs to count down twice again before rebooting */
-		outw(0x0008, TCO1_STS(p));	/* write 1 to clear bit */
-
+	else if (p->iTCO_version == 1)
 		outb(0x01, TCO_RLD(p));
-	}
 
 	spin_unlock(&p->io_lock);
 	return 0;
@@ -328,11 +327,8 @@ static int iTCO_wdt_set_timeout(struct watchdog_device *wd_dev, unsigned int t)
 	unsigned char val8;
 	unsigned int tmrval;
 
-	tmrval = seconds_to_ticks(p, t);
-
-	/* For TCO v1 the timer counts down twice before rebooting */
-	if (p->iTCO_version == 1)
-		tmrval /= 2;
+	/* The timer counts down twice before rebooting */
+	tmrval = seconds_to_ticks(p, t) / 2;
 
 	/* from the specs: */
 	/* "Values of 0h-3h are ignored and should not be attempted" */
@@ -385,6 +381,8 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 		spin_lock(&p->io_lock);
 		val16 = inw(TCO_RLD(p));
 		val16 &= 0x3ff;
+		if (!(inw(TCO1_STS(p)) & 0x0008))
+			val16 += (inw(TCOv2_TMR(p)) & 0x3ff);
 		spin_unlock(&p->io_lock);
 
 		time_left = ticks_to_seconds(p, val16);
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 99ebf6e..5615f40 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -630,6 +630,9 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 		return -ENODEV;
 	}
 
+	if (iface_desc->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	/* check out the endpoint: it has to be Interrupt & IN */
 	endpoint = &iface_desc->endpoint[0].desc;
 
diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index f709962..362fd22 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -6,6 +6,7 @@
  * Licensed under GPLv2.
  */
 
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -29,6 +30,7 @@ struct sama5d4_wdt {
 	struct watchdog_device	wdd;
 	void __iomem		*reg_base;
 	u32			mr;
+	unsigned long		last_ping;
 };
 
 static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
@@ -44,11 +46,34 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+#define wdt_enabled (!(wdt->mr & AT91_WDT_WDDIS))
+
 #define wdt_read(wdt, field) \
 	readl_relaxed((wdt)->reg_base + (field))
 
-#define wdt_write(wtd, field, val) \
-	writel_relaxed((val), (wdt)->reg_base + (field))
+/* 4 slow clock periods is 4/32768 = 122.07µs*/
+#define WDT_DELAY	usecs_to_jiffies(123)
+
+static void wdt_write(struct sama5d4_wdt *wdt, u32 field, u32 val)
+{
+	/*
+	 * WDT_CR and WDT_MR must not be modified within three slow clock
+	 * periods following a restart of the watchdog performed by a write
+	 * access in WDT_CR.
+	 */
+	while (time_before(jiffies, wdt->last_ping + WDT_DELAY))
+		usleep_range(30, 125);
+	writel_relaxed(val, wdt->reg_base + field);
+	wdt->last_ping = jiffies;
+}
+
+static void wdt_write_nosleep(struct sama5d4_wdt *wdt, u32 field, u32 val)
+{
+	if (time_before(jiffies, wdt->last_ping + WDT_DELAY))
+		udelay(123);
+	writel_relaxed(val, wdt->reg_base + field);
+	wdt->last_ping = jiffies;
+}
 
 static int sama5d4_wdt_start(struct watchdog_device *wdd)
 {
@@ -89,7 +114,16 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
 	wdt->mr &= ~AT91_WDT_WDD;
 	wdt->mr |= AT91_WDT_SET_WDV(value);
 	wdt->mr |= AT91_WDT_SET_WDD(value);
-	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
+
+	/*
+	 * WDDIS has to be 0 when updating WDD/WDV. The datasheet states: When
+	 * setting the WDDIS bit, and while it is set, the fields WDV and WDD
+	 * must not be modified.
+	 * If the watchdog is enabled, then the timeout can be updated. Else,
+	 * wait that the user enables it.
+	 */
+	if (wdt_enabled)
+		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
 
 	wdd->timeout = timeout;
 
@@ -145,23 +179,21 @@ static int of_sama5d4_wdt_init(struct device_node *np, struct sama5d4_wdt *wdt)
 
 static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
 {
-	struct watchdog_device *wdd = &wdt->wdd;
-	u32 value = WDT_SEC2TICKS(wdd->timeout);
 	u32 reg;
-
 	/*
-	 * Because the fields WDV and WDD must not be modified when the WDDIS
-	 * bit is set, so clear the WDDIS bit before writing the WDT_MR.
+	 * When booting and resuming, the bootloader may have changed the
+	 * watchdog configuration.
+	 * If the watchdog is already running, we can safely update it.
+	 * Else, we have to disable it properly.
 	 */
-	reg = wdt_read(wdt, AT91_WDT_MR);
-	reg &= ~AT91_WDT_WDDIS;
-	wdt_write(wdt, AT91_WDT_MR, reg);
-
-	wdt->mr |= AT91_WDT_SET_WDD(value);
-	wdt->mr |= AT91_WDT_SET_WDV(value);
-
-	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
-
+	if (wdt_enabled) {
+		wdt_write_nosleep(wdt, AT91_WDT_MR, wdt->mr);
+	} else {
+		reg = wdt_read(wdt, AT91_WDT_MR);
+		if (!(reg & AT91_WDT_WDDIS))
+			wdt_write_nosleep(wdt, AT91_WDT_MR,
+					  reg | AT91_WDT_WDDIS);
+	}
 	return 0;
 }
 
@@ -172,6 +204,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *regs;
 	u32 irq = 0;
+	u32 timeout;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -184,6 +217,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	wdd->ops = &sama5d4_wdt_ops;
 	wdd->min_timeout = MIN_WDT_TIMEOUT;
 	wdd->max_timeout = MAX_WDT_TIMEOUT;
+	wdt->last_ping = jiffies;
 
 	watchdog_set_drvdata(wdd, wdt);
 
@@ -221,6 +255,11 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	timeout = WDT_SEC2TICKS(wdd->timeout);
+
+	wdt->mr |= AT91_WDT_SET_WDD(timeout);
+	wdt->mr |= AT91_WDT_SET_WDV(timeout);
+
 	ret = sama5d4_wdt_init(wdt);
 	if (ret)
 		return ret;
@@ -263,9 +302,7 @@ static int sama5d4_wdt_resume(struct device *dev)
 {
 	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
 
-	wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
-	if (wdt->mr & AT91_WDT_WDDIS)
-		wdt_write(wdt, AT91_WDT_MR, wdt->mr);
+	sama5d4_wdt_init(wdt);
 
 	return 0;
 }
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 48b2c05..bc7addc 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -332,7 +332,7 @@ static irqreturn_t wdtpci_interrupt(int irq, void *dev_id)
 		pr_crit("Would Reboot\n");
 #else
 		pr_crit("Initiating system reboot\n");
-		emergency_restart(NULL);
+		emergency_restart();
 #endif
 #else
 		pr_crit("Reset in 5ms\n");
diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
index e290d5a..c982527 100644
--- a/drivers/watchdog/zx2967_wdt.c
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -211,10 +211,8 @@ static int zx2967_wdt_probe(struct platform_device *pdev)
 
 	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->reg_base = devm_ioremap_resource(dev, base);
-	if (IS_ERR(wdt->reg_base)) {
-		dev_err(dev, "ioremap failed\n");
+	if (IS_ERR(wdt->reg_base))
 		return PTR_ERR(wdt->reg_base);
-	}
 
 	zx2967_wdt_reset_sysctrl(dev);
 
