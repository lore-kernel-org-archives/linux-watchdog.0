Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:38814 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751983AbbBQUrk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Feb 2015 15:47:40 -0500
Date: Tue, 17 Feb 2015 21:47:36 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Naidu Tellapati <naidu.tellapati@gmail.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Paolo Teti <paolo.teti@gmail.com>,
	Masanari Iida <standby24x7@gmail.com>,
	John Crispin <blogic@openwrt.org>,
	Tony Lindgren <tony@atomide.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Doug Anderson <dianders@chromium.org>,
	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [GIT PULL REQUEST] watchdog - v3.20 or 4.00 Merge window
Message-ID: <20150217204736.GA5917@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

It adds the following new drivers:
* ImgTec PDC Watchdog Timer Driver,
* Mediatek SoC integrated watchdog
Adds support for BCM5301X, IT8783, NCT6791 and NCT6792 WDT's
Adds bcm47xx_wdt and da9063 restart handlers
and contains overall improvements and fixes

This will update the following files:

 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt           |    5 
 Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt         |   19 
 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt |   12 
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt            |   13 
 drivers/watchdog/Kconfig                                          |   25 
 drivers/watchdog/Makefile                                         |    2 
 drivers/watchdog/bcm47xx_wdt.c                                    |   21 
 drivers/watchdog/da9063_wdt.c                                     |   32 +
 drivers/watchdog/dw_wdt.c                                         |   32 -
 drivers/watchdog/gpio_wdt.c                                       |   37 +
 drivers/watchdog/hpwdt.c                                          |    2 
 drivers/watchdog/imgpdc_wdt.c                                     |  289 ++++++++++
 drivers/watchdog/imx2_wdt.c                                       |    4 
 drivers/watchdog/it87_wdt.c                                       |    6 
 drivers/watchdog/jz4740_wdt.c                                     |   10 
 drivers/watchdog/mtk_wdt.c                                        |  251 ++++++++
 drivers/watchdog/omap_wdt.c                                       |    2 
 drivers/watchdog/retu_wdt.c                                       |    2 
 drivers/watchdog/rt2880_wdt.c                                     |    9 
 drivers/watchdog/twl4030_wdt.c                                    |    2 
 drivers/watchdog/w83627hf_wdt.c                                   |   14 
 include/linux/bcm47xx_wdt.h                                       |    1 
 22 files changed, 758 insertions(+), 32 deletions(-)

with these Changes:

commit 94613431619b555ac1299634efabde2ffd0eb2b4
Author: Rafał Miłecki <zajec5@gmail.com>
Date:   Sat Feb 7 18:04:10 2015 +0100

    watchdog: bcm47xx_wdt.c: allow enabling on BCM5301X arch
    
    BCM5301X (ARCH_BCM_5301X) is a new Broadcom architecture using the same
    SoC bus driver (bcma) as BCM47XX but based on ARM instead of MIPS.
    
    Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 6b96c72279cd73c1a03e97265548ce067128203a
Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Date:   Tue Feb 3 10:25:48 2015 +0000

    watchdog: jz4740: Add DT support
    
    Add DT support to the jz4740 driver. Simple of_match_ptr. No other
    modification for probe needed
    
    Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 73af15205be6b5977d35619208fe97621903d4de
Author: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Date:   Tue Feb 3 10:25:47 2015 +0000

    dt: watchdog: Add DT binding documentation for jz4740 watchdog timer
    
    Add binding for jz4740 watchdog timer. It is a simple watchdog timer.
    
    Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b5ade9bc8dca839fb06cd2788046cfe923c06980
Author: Doug Anderson <dianders@chromium.org>
Date:   Tue Jan 27 14:25:17 2015 -0800

    watchdog: dw_wdt: Try to get a 30 second watchdog by default
    
    The dw_wdt_set_top() function takes in a value in seconds.  In
    dw_wdt_open() we were calling it with a value that's supposed to
    represent the maximum value programmed into the "top" register with a
    comment saying that we were trying to set the watchdog to its maximum
    value.  Instead we ended up setting the watchdog to ~15 seconds.
    
    Let's fix this.  However, setting things to the "max" gives me an 86
    second watchdog in the system I'm looking at.  86 seconds feels a
    little too long.  We'll explicitly choose 30 seconds as a more
    reasonable value.
    
    NOTE: Ideally this driver should be transitioned to be a real watchdog
    driver.  Then we could use "watchdog_init_timeout" and let the timeout
    be specified in a number of ways (device tree, module parameter, etc).
    This patch should be considered a bit of a stopgap solution.
    
    Signed-off-by: Doug Anderson <dianders@chromium.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a00850107eb050bf6427a8f3a0445bce9441b5df
Author: Doug Anderson <dianders@chromium.org>
Date:   Tue Jan 27 14:25:16 2015 -0800

    watchdog: dw_wdt: pat the watchdog before enabling it
    
    On some dw_wdt implementations the "top" register may be initted to 0
    at bootup.  In such a case, each "pat" of the watchdog will reset the
    timer to 0xffff.  That's pretty short.
    
    The input clock of the wdt can be any of a wide range of values.  On
    an rk3288 system, I've seen the wdt clock be 24.75 MHz.  That means
    each tick is ~40ns and we'll count to 0xffff in ~2.6ms.
    
    Because of the above two facts, it's a really good idea to pat the
    watchdog after initting the "top" register properly and before
    enabling the watchdog.  If you don't then there's no way we'll get the
    next heartbeat in time.
    
    Jisheng Zhang fixed this problem on some dw_wdt versions by using the
    TOP_INIT feature.  However, the dw_wdt on rk3288 doesn't have TOP_INIT
    so it's a good idea to also pat the watchdog manually.
    
    Signed-off-by: Doug Anderson <dianders@chromium.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a77841d59eb54ceb7b97b5e23053cd205e3a4c00
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Mon Jan 26 08:53:56 2015 -0800

    watchdog: w83627hf_wdt: Add support for NCT6791 and NCT6792
    
    The watchdog functionality in both chips is almost identical to NCT6779.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1cc7495c60879eeeda52385a70c99c4cbaace7ef
Author: Rafał Miłecki <zajec5@gmail.com>
Date:   Sun Jan 25 11:40:57 2015 +0100

    watchdog: bcm47xx_wdt.c: add restart handler support
    
    Just like in case of other watchdog drivers, use the new kernel core
    API to provide restart support.
    
    Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit ba804a9510df555c42c2be6c340960879afe39d2
Author: Mike Looijmans <mike.looijmans@topic.nl>
Date:   Wed Jan 14 07:28:29 2015 +0100

    watchdog: gpio_wdt: Add "always_running" feature to GPIO watchdog
    
    On some chips, like the TPS386000, the trigger cannot be disabled
    and the CPU must keep toggling the line at all times. Add a switch
    "always_running" to keep toggling the GPIO line regardless of the
    state of the soft part of the watchdog. The "armed" member keeps
    track of whether a timeout must also cause a reset.
    
    Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 396f163ceba3ac2829e3076764efcfb10797293c
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Thu Jan 29 15:26:05 2015 +0100

    watchdog: da9063: Add restart handler support
    
    Register a restart handler for the da9063 watchdog.  System restart is
    triggered by sending the shutdown command to the PMIC.
    As more-suitable restart handlers may exist, the priority of the
    watchdog restart handler is set to 128.
    
    The actual restart method was inspired by a platform-specific patch from
    the BSP by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
    
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9a4c88016458424e53084ed3c26bfbae8cd8af22
Author: Matthias Brugger <matthias.bgg@gmail.com>
Date:   Tue Jan 13 13:28:56 2015 +0100

    ARM: mediatek: dts: Add bindings for watchdog
    
    Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a44a45536f7bc2a5349cd44ee5d8cccd9aae0612
Author: Matthias Brugger <matthias.bgg@gmail.com>
Date:   Tue Jan 13 13:28:55 2015 +0100

    watchdog: Add driver for Mediatek watchdog
    
    This patch adds a driver for the Mediatek SoC integrated
    watchdog. This driver supports watchdog and software reset
    for mt65xx and mt81xx SoCs.
    
    Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
    Tested-by: Eddie Huang <eddie.huang@mediatek.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit fb1cbeaeed0f41965ead2714bfc9c579188c6146
Author: Tony Lindgren <tony@atomide.com>
Date:   Tue Oct 14 12:25:19 2014 -0700

    watchdog: Fix omap watchdogs to enable the magic close bit
    
    This allows testing the watchdog easily with distros just by
    doing pkill -9 watchdog.
    
    Reported-by: Thomas Dziedzic <gostrc@gmail.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>
    Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
    Reviewed-by: Felipe Balbi <balbi@ti.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit a6f8f81ec77ba5e5f0b3249dfd3fc554ac5db117
Author: John Crispin <blogic@openwrt.org>
Date:   Thu Oct 16 22:01:05 2014 +0200

    watchdog: rt2880_wdt: minor clean up
    
    Replace device_reset() with devm_reset_control_get() + reset_control_deassert().
    Make use of watchdog_init_timeout() instead of setting the timeout manually.
    
    Signed-off-by: John Crispin <blogic@openwrt.org>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit b91b5be5ba92f2bc8018a900239cd07150639b5b
Author: Masanari Iida <standby24x7@gmail.com>
Date:   Wed Oct 22 20:24:35 2014 +0900

    watchdog: hpwdt: Fix initialization message in hpwdt.c
    
    allow_kdump was enabled as default since following commit.
    
    commit a089361cf5f1d6a5295aa5385238bd044998e1e9,
    watchdog: hpwdt: Unregister NMI events on exit.
    
    But the initialization message was not modified.
    So it still shows
    
      HP Watchdog Timer Driver: NMI decoding initialized,
      allow kernel dump: ON (default = 0/OFF)    <=
    
    This "default = 0/OFF" message may confuse users.
    Fix it as "default = 1/ON".
    
    Signed-off-by: Masanari Iida <standby24x7@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit f83918fb5cb0fd257fd05d588e0c0b3472ef18b0
Author: Paolo Teti <paolo.teti@gmail.com>
Date:   Sun Oct 19 21:39:33 2014 +0200

    watchdog: it87_wdt: add IT8783 ID
    
    IT8783 watchdog works as in IT872x
    
    Tested on Adlink cPCI-6520 boards
    
    Signed-off-by: Paolo Teti <paolo.teti@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4bd8ce33c0046e81dfc2b4d5886b6b253741261c
Author: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date:   Mon Jan 5 10:09:17 2015 +0100

    watchdog: imx2: Constify struct regmap_config and watchdog_ops
    
    The regmap_config struct may be const because it is not modified by the
    driver and regmap_init() accepts pointer to const. Make struct
    watchdog_ops const as well.
    
    Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1888e7ad568835debfc7f6dc9d722b2efc55c55d
Author: Naidu Tellapati <naidu.tellapati@gmail.com>
Date:   Tue Jan 6 10:19:35 2015 -0300

    DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation
    
    Add the devicetree binding document for ImgTec PDC Watchdog Timer.
    
    Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
    Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
    Signed-off-by: Jude Abraham <Jude.Abraham@gmail.com>
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 93937669e9b5873808e4f5dfd6cace53bdc57f17
Author: Naidu Tellapati <naidu.tellapati@gmail.com>
Date:   Tue Jan 6 10:19:34 2015 -0300

    watchdog: ImgTec PDC Watchdog Timer Driver
    
    This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
    
    Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
    Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
    Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
    [ezequiel: Minor style fixes]
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
index 37afec1..1987949 100644
--- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
@@ -13,6 +13,11 @@ Required Properties:
     by the GPIO flags.
 - hw_margin_ms: Maximum time to reset watchdog circuit (milliseconds).
 
+Optional Properties:
+- always-running: If the watchdog timer cannot be disabled, add this flag to
+  have the driver keep toggling the signal without a client. It will only cease
+  to toggle the signal when the device is open and the timeout elapsed.
+
 Example:
 	watchdog: watchdog {
 		/* ADM706 */
diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
new file mode 100644
index 0000000..b2fa11f
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
@@ -0,0 +1,19 @@
+*ImgTec PowerDown Controller (PDC) Watchdog Timer (WDT)
+
+Required properties:
+- compatible : Should be "img,pdc-wdt"
+- reg : Should contain WDT registers location and length
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should contain "wdt" and "sys"; the watchdog counter
+               clock and register interface clock respectively.
+- interrupts : Should contain WDT interrupt
+
+Examples:
+
+watchdog@18102100 {
+	compatible = "img,pdc-wdt";
+	reg = <0x18102100 0x100>;
+	clocks = <&pdc_wdt_clk>, <&sys_clk>;
+	clock-names = "wdt", "sys";
+	interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
new file mode 100644
index 0000000..e27763e
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
@@ -0,0 +1,12 @@
+Ingenic Watchdog Timer (WDT) Controller for JZ4740
+
+Required properties:
+compatible: "ingenic,jz4740-watchdog"
+reg: Register address and length for watchdog registers
+
+Example:
+
+watchdog: jz4740-watchdog@0x10002000 {
+	compatible = "ingenic,jz4740-watchdog";
+	reg = <0x10002000 0x100>;
+};
diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
new file mode 100644
index 0000000..af9eb5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -0,0 +1,13 @@
+Mediatek SoCs Watchdog timer
+
+Required properties:
+
+- compatible : should be "mediatek,mt6589-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+wdt: watchdog@010000000 {
+	compatible = "mediatek,mt6589-wdt";
+	reg = <0x10000000 0x18>;
+};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 08f41ad..16f2023 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -505,6 +505,16 @@ config MESON_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called meson_wdt.
 
+config MEDIATEK_WATCHDOG
+	tristate "Mediatek SoCs watchdog support"
+	depends on ARCH_MEDIATEK
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Mediatek SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
@@ -1005,6 +1015,8 @@ config W83627HF_WDT
 		NCT6775
 		NCT6776
 		NCT6779
+		NCT6791
+		NCT6792
 
 	  This watchdog simply watches your kernel to make sure it doesn't
 	  freeze, and if it does, it reboots your computer after a certain
@@ -1101,7 +1113,7 @@ config ATH79_WDT
 
 config BCM47XX_WDT
 	tristate "Broadcom BCM47xx Watchdog Timer"
-	depends on BCM47XX
+	depends on BCM47XX || ARCH_BCM_5301X
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the Broadcom BCM47xx Watchdog Timer.
@@ -1235,6 +1247,17 @@ config BCM_KONA_WDT_DEBUG
 
 	  If in doubt, say 'N'.
 
+config IMGPDC_WDT
+	tristate "Imagination Technologies PDC Watchdog Timer"
+	depends on HAS_IOMEM
+	depends on METAG || MIPS || COMPILE_TEST
+	help
+	  Driver for Imagination Technologies PowerDown Controller
+	  Watchdog Timer.
+
+	  To compile this driver as a loadable module, choose M here.
+	  The module will be called imgpdc_wdt.
+
 config LANTIQ_WDT
 	tristate "Lantiq SoC watchdog"
 	depends on LANTIQ
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index c569ec8..5c19294 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_QCOM_WDT) += qcom-wdt.o
 obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
 obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
 obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
+obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
@@ -142,6 +143,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
 obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
 obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
+obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
 
 # PARISC Architecture
 
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index 9816485..b28a072 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -169,6 +169,17 @@ static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
+static int bcm47xx_wdt_restart(struct notifier_block *this, unsigned long mode,
+			       void *cmd)
+{
+	struct bcm47xx_wdt *wdt;
+
+	wdt = container_of(this, struct bcm47xx_wdt, restart_handler);
+	wdt->timer_set(wdt, 1);
+
+	return NOTIFY_DONE;
+}
+
 static struct watchdog_ops bcm47xx_wdt_soft_ops = {
 	.owner		= THIS_MODULE,
 	.start		= bcm47xx_wdt_soft_start,
@@ -209,15 +220,23 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_timer;
 
-	ret = watchdog_register_device(&wdt->wdd);
+	wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
+	wdt->restart_handler.priority = 64;
+	ret = register_restart_handler(&wdt->restart_handler);
 	if (ret)
 		goto err_notifier;
 
+	ret = watchdog_register_device(&wdt->wdd);
+	if (ret)
+		goto err_handler;
+
 	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
 		timeout, nowayout ? ", nowayout" : "",
 		soft ? ", Software Timer" : "");
 	return 0;
 
+err_handler:
+	unregister_restart_handler(&wdt->restart_handler);
 err_notifier:
 	unregister_reboot_notifier(&wdt->notifier);
 err_timer:
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 2cd6b2c..e2fe2eb 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9063/core.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 
 /*
@@ -38,6 +39,7 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 struct da9063_watchdog {
 	struct da9063 *da9063;
 	struct watchdog_device wdtdev;
+	struct notifier_block restart_handler;
 };
 
 static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
@@ -119,6 +121,23 @@ static int da9063_wdt_set_timeout(struct watchdog_device *wdd,
 	return ret;
 }
 
+static int da9063_wdt_restart_handler(struct notifier_block *this,
+				      unsigned long mode, void *cmd)
+{
+	struct da9063_watchdog *wdt = container_of(this,
+						   struct da9063_watchdog,
+						   restart_handler);
+	int ret;
+
+	ret = regmap_write(wdt->da9063->regmap, DA9063_REG_CONTROL_F,
+			   DA9063_SHUTDOWN);
+	if (ret)
+		dev_alert(wdt->da9063->dev, "Failed to shutdown (err = %d)\n",
+			  ret);
+
+	return NOTIFY_DONE;
+}
+
 static const struct watchdog_info da9063_watchdog_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity = "DA9063 Watchdog",
@@ -163,14 +182,25 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, wdt);
 
 	ret = watchdog_register_device(&wdt->wdtdev);
+	if (ret)
+		return ret;
 
-	return ret;
+	wdt->restart_handler.notifier_call = da9063_wdt_restart_handler;
+	wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdt->restart_handler);
+	if (ret)
+		dev_err(wdt->da9063->dev,
+			"Failed to register restart handler (err = %d)\n", ret);
+
+	return 0;
 }
 
 static int da9063_wdt_remove(struct platform_device *pdev)
 {
 	struct da9063_watchdog *wdt = dev_get_drvdata(&pdev->dev);
 
+	unregister_restart_handler(&wdt->restart_handler);
+
 	watchdog_unregister_device(&wdt->wdtdev);
 
 	return 0;
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index b34a2e4..d0bb949 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -51,6 +51,8 @@
 /* The maximum TOP (timeout period) value that can be set in the watchdog. */
 #define DW_WDT_MAX_TOP		15
 
+#define DW_WDT_DEFAULT_SECONDS	30
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
@@ -96,6 +98,12 @@ static inline void dw_wdt_set_next_heartbeat(void)
 	dw_wdt.next_heartbeat = jiffies + dw_wdt_get_top() * HZ;
 }
 
+static void dw_wdt_keepalive(void)
+{
+	writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
+	       WDOG_COUNTER_RESTART_REG_OFFSET);
+}
+
 static int dw_wdt_set_top(unsigned top_s)
 {
 	int i, top_val = DW_WDT_MAX_TOP;
@@ -110,21 +118,27 @@ static int dw_wdt_set_top(unsigned top_s)
 			break;
 		}
 
-	/* Set the new value in the watchdog. */
+	/*
+	 * Set the new value in the watchdog.  Some versions of dw_wdt
+	 * have have TOPINIT in the TIMEOUT_RANGE register (as per
+	 * CP_WDT_DUAL_TOP in WDT_COMP_PARAMS_1).  On those we
+	 * effectively get a pat of the watchdog right here.
+	 */
 	writel(top_val | top_val << WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT,
 		dw_wdt.regs + WDOG_TIMEOUT_RANGE_REG_OFFSET);
 
+	/*
+	 * Add an explicit pat to handle versions of the watchdog that
+	 * don't have TOPINIT.  This won't hurt on versions that have
+	 * it.
+	 */
+	dw_wdt_keepalive();
+
 	dw_wdt_set_next_heartbeat();
 
 	return dw_wdt_top_in_seconds(top_val);
 }
 
-static void dw_wdt_keepalive(void)
-{
-	writel(WDOG_COUNTER_RESTART_KICK_VALUE, dw_wdt.regs +
-	       WDOG_COUNTER_RESTART_REG_OFFSET);
-}
-
 static int dw_wdt_restart_handle(struct notifier_block *this,
 				unsigned long mode, void *cmd)
 {
@@ -167,9 +181,9 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 	if (!dw_wdt_is_enabled()) {
 		/*
 		 * The watchdog is not currently enabled. Set the timeout to
-		 * the maximum and then start it.
+		 * something reasonable and then start it.
 		 */
-		dw_wdt_set_top(DW_WDT_MAX_TOP);
+		dw_wdt_set_top(DW_WDT_DEFAULT_SECONDS);
 		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
 		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
 	}
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index bbdb19b..cbc313d 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -31,6 +31,8 @@ struct gpio_wdt_priv {
 	int			gpio;
 	bool			active_low;
 	bool			state;
+	bool			always_running;
+	bool			armed;
 	unsigned int		hw_algo;
 	unsigned int		hw_margin;
 	unsigned long		last_jiffies;
@@ -48,14 +50,20 @@ static void gpio_wdt_disable(struct gpio_wdt_priv *priv)
 		gpio_direction_input(priv->gpio);
 }
 
-static int gpio_wdt_start(struct watchdog_device *wdd)
+static void gpio_wdt_start_impl(struct gpio_wdt_priv *priv)
 {
-	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
-
 	priv->state = priv->active_low;
 	gpio_direction_output(priv->gpio, priv->state);
 	priv->last_jiffies = jiffies;
 	mod_timer(&priv->timer, priv->last_jiffies + priv->hw_margin);
+}
+
+static int gpio_wdt_start(struct watchdog_device *wdd)
+{
+	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	gpio_wdt_start_impl(priv);
+	priv->armed = true;
 
 	return 0;
 }
@@ -64,8 +72,11 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
 {
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	mod_timer(&priv->timer, 0);
-	gpio_wdt_disable(priv);
+	priv->armed = false;
+	if (!priv->always_running) {
+		mod_timer(&priv->timer, 0);
+		gpio_wdt_disable(priv);
+	}
 
 	return 0;
 }
@@ -91,8 +102,8 @@ static void gpio_wdt_hwping(unsigned long data)
 	struct watchdog_device *wdd = (struct watchdog_device *)data;
 	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	if (time_after(jiffies, priv->last_jiffies +
-		       msecs_to_jiffies(wdd->timeout * 1000))) {
+	if (priv->armed && time_after(jiffies, priv->last_jiffies +
+				      msecs_to_jiffies(wdd->timeout * 1000))) {
 		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
 		return;
 	}
@@ -197,6 +208,9 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	/* Use safe value (1/2 of real timeout) */
 	priv->hw_margin = msecs_to_jiffies(hw_margin / 2);
 
+	priv->always_running = of_property_read_bool(pdev->dev.of_node,
+						     "always-running");
+
 	watchdog_set_drvdata(&priv->wdd, priv);
 
 	priv->wdd.info		= &gpio_wdt_ident;
@@ -216,8 +230,15 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->notifier.notifier_call = gpio_wdt_notify_sys;
 	ret = register_reboot_notifier(&priv->notifier);
 	if (ret)
-		watchdog_unregister_device(&priv->wdd);
+		goto error_unregister;
 
+	if (priv->always_running)
+		gpio_wdt_start_impl(priv);
+
+	return 0;
+
+error_unregister:
+	watchdog_unregister_device(&priv->wdd);
 	return ret;
 }
 
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 75d2243..ada3e44 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -745,7 +745,7 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 
 	dev_info(&dev->dev,
 			"HP Watchdog Timer Driver: NMI decoding initialized"
-			", allow kernel dump: %s (default = 0/OFF)\n",
+			", allow kernel dump: %s (default = 1/ON)\n",
 			(allow_kdump == 0) ? "OFF" : "ON");
 	return 0;
 
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
new file mode 100644
index 0000000..c8def68
--- /dev/null
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -0,0 +1,289 @@
+/*
+ * Imagination Technologies PowerDown Controller Watchdog Timer.
+ *
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo Caione
+ *                                                     2012 Henrik Nordstrom
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/watchdog.h>
+
+/* registers */
+#define PDC_WDT_SOFT_RESET		0x00
+#define PDC_WDT_CONFIG			0x04
+  #define PDC_WDT_CONFIG_ENABLE		BIT(31)
+  #define PDC_WDT_CONFIG_DELAY_MASK	0x1f
+
+#define PDC_WDT_TICKLE1			0x08
+#define PDC_WDT_TICKLE1_MAGIC		0xabcd1234
+#define PDC_WDT_TICKLE2			0x0c
+#define PDC_WDT_TICKLE2_MAGIC		0x4321dcba
+
+#define PDC_WDT_TICKLE_STATUS_MASK	0x7
+#define PDC_WDT_TICKLE_STATUS_SHIFT	0
+#define PDC_WDT_TICKLE_STATUS_HRESET	0x0  /* Hard reset */
+#define PDC_WDT_TICKLE_STATUS_TIMEOUT	0x1  /* Timeout */
+#define PDC_WDT_TICKLE_STATUS_TICKLE	0x2  /* Tickled incorrectly */
+#define PDC_WDT_TICKLE_STATUS_SRESET	0x3  /* Soft reset */
+#define PDC_WDT_TICKLE_STATUS_USER	0x4  /* User reset */
+
+/* Timeout values are in seconds */
+#define PDC_WDT_MIN_TIMEOUT		1
+#define PDC_WDT_DEF_TIMEOUT		64
+
+static int heartbeat;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
+	"(default = " __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct pdc_wdt_dev {
+	struct watchdog_device wdt_dev;
+	struct clk *wdt_clk;
+	struct clk *sys_clk;
+	void __iomem *base;
+};
+
+static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
+{
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	writel(PDC_WDT_TICKLE1_MAGIC, wdt->base + PDC_WDT_TICKLE1);
+	writel(PDC_WDT_TICKLE2_MAGIC, wdt->base + PDC_WDT_TICKLE2);
+
+	return 0;
+}
+
+static int pdc_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	val = readl(wdt->base + PDC_WDT_CONFIG);
+	val &= ~PDC_WDT_CONFIG_ENABLE;
+	writel(val, wdt->base + PDC_WDT_CONFIG);
+
+	/* Must tickle to finish the stop */
+	pdc_wdt_keepalive(wdt_dev);
+
+	return 0;
+}
+
+static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
+			       unsigned int new_timeout)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+	unsigned long clk_rate = clk_get_rate(wdt->wdt_clk);
+
+	wdt->wdt_dev.timeout = new_timeout;
+
+	val = readl(wdt->base + PDC_WDT_CONFIG) & ~PDC_WDT_CONFIG_DELAY_MASK;
+	val |= order_base_2(new_timeout * clk_rate) - 1;
+	writel(val, wdt->base + PDC_WDT_CONFIG);
+
+	return 0;
+}
+
+/* Start the watchdog timer (delay should already be set) */
+static int pdc_wdt_start(struct watchdog_device *wdt_dev)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	val = readl(wdt->base + PDC_WDT_CONFIG);
+	val |= PDC_WDT_CONFIG_ENABLE;
+	writel(val, wdt->base + PDC_WDT_CONFIG);
+
+	return 0;
+}
+
+static struct watchdog_info pdc_wdt_info = {
+	.identity	= "IMG PDC Watchdog",
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops pdc_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= pdc_wdt_start,
+	.stop		= pdc_wdt_stop,
+	.ping		= pdc_wdt_keepalive,
+	.set_timeout	= pdc_wdt_set_timeout,
+};
+
+static int pdc_wdt_probe(struct platform_device *pdev)
+{
+	int ret, val;
+	unsigned long clk_rate;
+	struct resource *res;
+	struct pdc_wdt_dev *pdc_wdt;
+
+	pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
+	if (!pdc_wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pdc_wdt->base))
+		return PTR_ERR(pdc_wdt->base);
+
+	pdc_wdt->sys_clk = devm_clk_get(&pdev->dev, "sys");
+	if (IS_ERR(pdc_wdt->sys_clk)) {
+		dev_err(&pdev->dev, "failed to get the sys clock\n");
+		return PTR_ERR(pdc_wdt->sys_clk);
+	}
+
+	pdc_wdt->wdt_clk = devm_clk_get(&pdev->dev, "wdt");
+	if (IS_ERR(pdc_wdt->wdt_clk)) {
+		dev_err(&pdev->dev, "failed to get the wdt clock\n");
+		return PTR_ERR(pdc_wdt->wdt_clk);
+	}
+
+	ret = clk_prepare_enable(pdc_wdt->sys_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not prepare or enable sys clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pdc_wdt->wdt_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not prepare or enable wdt clock\n");
+		goto disable_sys_clk;
+	}
+
+	/* We use the clock rate to calculate the max timeout */
+	clk_rate = clk_get_rate(pdc_wdt->wdt_clk);
+	if (clk_rate == 0) {
+		dev_err(&pdev->dev, "failed to get clock rate\n");
+		ret = -EINVAL;
+		goto disable_wdt_clk;
+	}
+
+	if (order_base_2(clk_rate) > PDC_WDT_CONFIG_DELAY_MASK + 1) {
+		dev_err(&pdev->dev, "invalid clock rate\n");
+		ret = -EINVAL;
+		goto disable_wdt_clk;
+	}
+
+	if (order_base_2(clk_rate) == 0)
+		pdc_wdt->wdt_dev.min_timeout = PDC_WDT_MIN_TIMEOUT + 1;
+	else
+		pdc_wdt->wdt_dev.min_timeout = PDC_WDT_MIN_TIMEOUT;
+
+	pdc_wdt->wdt_dev.info = &pdc_wdt_info;
+	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
+	pdc_wdt->wdt_dev.max_timeout = 1 << PDC_WDT_CONFIG_DELAY_MASK;
+	pdc_wdt->wdt_dev.parent = &pdev->dev;
+
+	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, heartbeat, &pdev->dev);
+	if (ret < 0) {
+		pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
+		dev_warn(&pdev->dev,
+			 "Initial timeout out of range! setting max timeout\n");
+	}
+
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+
+	/* Find what caused the last reset */
+	val = readl(pdc_wdt->base + PDC_WDT_TICKLE1);
+	val = (val & PDC_WDT_TICKLE_STATUS_MASK) >> PDC_WDT_TICKLE_STATUS_SHIFT;
+	switch (val) {
+	case PDC_WDT_TICKLE_STATUS_TICKLE:
+	case PDC_WDT_TICKLE_STATUS_TIMEOUT:
+		pdc_wdt->wdt_dev.bootstatus |= WDIOF_CARDRESET;
+		dev_info(&pdev->dev,
+			 "watchdog module last reset due to timeout\n");
+		break;
+	case PDC_WDT_TICKLE_STATUS_HRESET:
+		dev_info(&pdev->dev,
+			 "watchdog module last reset due to hard reset\n");
+		break;
+	case PDC_WDT_TICKLE_STATUS_SRESET:
+		dev_info(&pdev->dev,
+			 "watchdog module last reset due to soft reset\n");
+		break;
+	case PDC_WDT_TICKLE_STATUS_USER:
+		dev_info(&pdev->dev,
+			 "watchdog module last reset due to user reset\n");
+		break;
+	default:
+		dev_info(&pdev->dev,
+			 "contains an illegal status code (%08x)\n", val);
+		break;
+	}
+
+	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
+
+	platform_set_drvdata(pdev, pdc_wdt);
+	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
+
+	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
+	if (ret)
+		goto disable_wdt_clk;
+
+	return 0;
+
+disable_wdt_clk:
+	clk_disable_unprepare(pdc_wdt->wdt_clk);
+disable_sys_clk:
+	clk_disable_unprepare(pdc_wdt->sys_clk);
+	return ret;
+}
+
+static void pdc_wdt_shutdown(struct platform_device *pdev)
+{
+	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
+
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+}
+
+static int pdc_wdt_remove(struct platform_device *pdev)
+{
+	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
+
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+	watchdog_unregister_device(&pdc_wdt->wdt_dev);
+	clk_disable_unprepare(pdc_wdt->wdt_clk);
+	clk_disable_unprepare(pdc_wdt->sys_clk);
+
+	return 0;
+}
+
+static const struct of_device_id pdc_wdt_match[] = {
+	{ .compatible = "img,pdc-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pdc_wdt_match);
+
+static struct platform_driver pdc_wdt_driver = {
+	.driver = {
+		.name = "imgpdc-wdt",
+		.of_match_table	= pdc_wdt_match,
+	},
+	.probe = pdc_wdt_probe,
+	.remove = pdc_wdt_remove,
+	.shutdown = pdc_wdt_shutdown,
+};
+module_platform_driver(pdc_wdt_driver);
+
+MODULE_AUTHOR("Jude Abraham <Jude.Abraham@imgtec.com>");
+MODULE_AUTHOR("Naidu Tellapati <Naidu.Tellapati@imgtec.com>");
+MODULE_DESCRIPTION("Imagination Technologies PDC Watchdog Timer Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5142bba..5e6d808 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -205,7 +205,7 @@ static inline void imx2_wdt_ping_if_active(struct watchdog_device *wdog)
 	}
 }
 
-static struct watchdog_ops imx2_wdt_ops = {
+static const struct watchdog_ops imx2_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = imx2_wdt_start,
 	.stop = imx2_wdt_stop,
@@ -213,7 +213,7 @@ static struct watchdog_ops imx2_wdt_ops = {
 	.set_timeout = imx2_wdt_set_timeout,
 };
 
-static struct regmap_config imx2_wdt_regmap_config = {
+static const struct regmap_config imx2_wdt_regmap_config = {
 	.reg_bits = 16,
 	.reg_stride = 2,
 	.val_bits = 16,
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 0b93739..e54839b 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -12,8 +12,8 @@
  *		    http://www.ite.com.tw/
  *
  *	Support of the watchdog timers, which are available on
- *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726
- *	and IT8728.
+ *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726,
+ *	IT8728 and IT8783.
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -87,6 +87,7 @@
 #define IT8721_ID	0x8721
 #define IT8726_ID	0x8726	/* the data sheet suggest wrongly 0x8716 */
 #define IT8728_ID	0x8728
+#define IT8783_ID	0x8783
 
 /* GPIO Configuration Registers LDN=0x07 */
 #define WDTCTRL		0x71
@@ -633,6 +634,7 @@ static int __init it87_wdt_init(void)
 	case IT8720_ID:
 	case IT8721_ID:
 	case IT8728_ID:
+	case IT8783_ID:
 		max_units = 65535;
 		try_gameport = 0;
 		break;
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 18e41af..4c2cc09 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <asm/mach-jz4740/timer.h>
 
@@ -142,6 +143,14 @@ static const struct watchdog_ops jz4740_wdt_ops = {
 	.set_timeout = jz4740_wdt_set_timeout,
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id jz4740_wdt_of_matches[] = {
+	{ .compatible = "ingenic,jz4740-watchdog", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches)
+#endif
+
 static int jz4740_wdt_probe(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata;
@@ -211,6 +220,7 @@ static struct platform_driver jz4740_wdt_driver = {
 	.remove = jz4740_wdt_remove,
 	.driver = {
 		.name = "jz4740-wdt",
+		.of_match_table = of_match_ptr(jz4740_wdt_of_matches),
 	},
 };
 
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
new file mode 100644
index 0000000..a87f6df
--- /dev/null
+++ b/drivers/watchdog/mtk_wdt.c
@@ -0,0 +1,251 @@
+/*
+ * Mediatek Watchdog Driver
+ *
+ * Copyright (C) 2014 Matthias Brugger
+ *
+ * Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Based on sunxi_wdt.c
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/delay.h>
+
+#define WDT_MAX_TIMEOUT		31
+#define WDT_MIN_TIMEOUT		1
+#define WDT_LENGTH_TIMEOUT(n)	((n) << 5)
+
+#define WDT_LENGTH		0x04
+#define WDT_LENGTH_KEY		0x8
+
+#define WDT_RST			0x08
+#define WDT_RST_RELOAD		0x1971
+
+#define WDT_MODE		0x00
+#define WDT_MODE_EN		(1 << 0)
+#define WDT_MODE_EXT_POL_LOW	(0 << 1)
+#define WDT_MODE_EXT_POL_HIGH	(1 << 1)
+#define WDT_MODE_EXRST_EN	(1 << 2)
+#define WDT_MODE_IRQ_EN		(1 << 3)
+#define WDT_MODE_AUTO_START	(1 << 4)
+#define WDT_MODE_DUAL_EN	(1 << 6)
+#define WDT_MODE_KEY		0x22000000
+
+#define WDT_SWRST		0x14
+#define WDT_SWRST_KEY		0x1209
+
+#define DRV_NAME		"mtk-wdt"
+#define DRV_VERSION		"1.0"
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+static unsigned int timeout = WDT_MAX_TIMEOUT;
+
+struct mtk_wdt_dev {
+	struct watchdog_device wdt_dev;
+	void __iomem *wdt_base;
+	struct notifier_block restart_handler;
+};
+
+static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
+				void *cmd)
+{
+	struct mtk_wdt_dev *mtk_wdt;
+	void __iomem *wdt_base;
+
+	mtk_wdt = container_of(this, struct mtk_wdt_dev, restart_handler);
+	wdt_base = mtk_wdt->wdt_base;
+
+	while (1) {
+		writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
+		mdelay(5);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int mtk_wdt_ping(struct watchdog_device *wdt_dev)
+{
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = mtk_wdt->wdt_base;
+
+	iowrite32(WDT_RST_RELOAD, wdt_base + WDT_RST);
+
+	return 0;
+}
+
+static int mtk_wdt_set_timeout(struct watchdog_device *wdt_dev,
+				unsigned int timeout)
+{
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = mtk_wdt->wdt_base;
+	u32 reg;
+
+	wdt_dev->timeout = timeout;
+
+	/*
+	 * One bit is the value of 512 ticks
+	 * The clock has 32 KHz
+	 */
+	reg = WDT_LENGTH_TIMEOUT(timeout << 6) | WDT_LENGTH_KEY;
+	iowrite32(reg, wdt_base + WDT_LENGTH);
+
+	mtk_wdt_ping(wdt_dev);
+
+	return 0;
+}
+
+static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = mtk_wdt->wdt_base;
+	u32 reg;
+
+	reg = readl(wdt_base + WDT_MODE);
+	reg &= ~WDT_MODE_EN;
+	iowrite32(reg, wdt_base + WDT_MODE);
+
+	return 0;
+}
+
+static int mtk_wdt_start(struct watchdog_device *wdt_dev)
+{
+	u32 reg;
+	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
+	void __iomem *wdt_base = mtk_wdt->wdt_base;
+	u32 ret;
+
+	ret = mtk_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	if (ret < 0)
+		return ret;
+
+	reg = ioread32(wdt_base + WDT_MODE);
+	reg &= ~(WDT_MODE_IRQ_EN | WDT_MODE_DUAL_EN);
+	reg |= (WDT_MODE_EN | WDT_MODE_KEY);
+	iowrite32(reg, wdt_base + WDT_MODE);
+
+	return 0;
+}
+
+static const struct watchdog_info mtk_wdt_info = {
+	.identity	= DRV_NAME,
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops mtk_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= mtk_wdt_start,
+	.stop		= mtk_wdt_stop,
+	.ping		= mtk_wdt_ping,
+	.set_timeout	= mtk_wdt_set_timeout,
+};
+
+static int mtk_wdt_probe(struct platform_device *pdev)
+{
+	struct mtk_wdt_dev *mtk_wdt;
+	struct resource *res;
+	int err;
+
+	mtk_wdt = devm_kzalloc(&pdev->dev, sizeof(*mtk_wdt), GFP_KERNEL);
+	if (!mtk_wdt)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mtk_wdt);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mtk_wdt->wdt_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mtk_wdt->wdt_base))
+		return PTR_ERR(mtk_wdt->wdt_base);
+
+	mtk_wdt->wdt_dev.info = &mtk_wdt_info;
+	mtk_wdt->wdt_dev.ops = &mtk_wdt_ops;
+	mtk_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;
+	mtk_wdt->wdt_dev.max_timeout = WDT_MAX_TIMEOUT;
+	mtk_wdt->wdt_dev.min_timeout = WDT_MIN_TIMEOUT;
+	mtk_wdt->wdt_dev.parent = &pdev->dev;
+
+	watchdog_init_timeout(&mtk_wdt->wdt_dev, timeout, &pdev->dev);
+	watchdog_set_nowayout(&mtk_wdt->wdt_dev, nowayout);
+
+	watchdog_set_drvdata(&mtk_wdt->wdt_dev, mtk_wdt);
+
+	mtk_wdt_stop(&mtk_wdt->wdt_dev);
+
+	err = watchdog_register_device(&mtk_wdt->wdt_dev);
+	if (unlikely(err))
+		return err;
+
+	mtk_wdt->restart_handler.notifier_call = mtk_reset_handler;
+	mtk_wdt->restart_handler.priority = 128;
+	err = register_restart_handler(&mtk_wdt->restart_handler);
+	if (err)
+		dev_warn(&pdev->dev,
+			"cannot register restart handler (err=%d)\n", err);
+
+	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
+			mtk_wdt->wdt_dev.timeout, nowayout);
+
+	return 0;
+}
+
+static int mtk_wdt_remove(struct platform_device *pdev)
+{
+	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&mtk_wdt->restart_handler);
+
+	watchdog_unregister_device(&mtk_wdt->wdt_dev);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_wdt_dt_ids[] = {
+	{ .compatible = "mediatek,mt6589-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
+
+static struct platform_driver mtk_wdt_driver = {
+	.probe		= mtk_wdt_probe,
+	.remove		= mtk_wdt_remove,
+	.driver		= {
+		.name		= DRV_NAME,
+		.of_match_table	= mtk_wdt_dt_ids,
+	},
+};
+
+module_platform_driver(mtk_wdt_driver);
+
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog heartbeat in seconds");
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matthias Brugger <matthias.bgg@gmail.com>");
+MODULE_DESCRIPTION("Mediatek WatchDog Timer Driver");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 9f2709d..1e6be9e 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -189,7 +189,7 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 }
 
 static const struct watchdog_info omap_wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "OMAP Watchdog",
 };
 
diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
index a7a0695..b7c68e2 100644
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -94,7 +94,7 @@ static int retu_wdt_set_timeout(struct watchdog_device *wdog,
 }
 
 static const struct watchdog_info retu_wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "Retu watchdog",
 };
 
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 11aad5b..a6f7e2e 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -45,6 +45,7 @@
 static struct clk *rt288x_wdt_clk;
 static unsigned long rt288x_wdt_freq;
 static void __iomem *rt288x_wdt_base;
+static struct reset_control *rt288x_wdt_reset;
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -151,16 +152,18 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(rt288x_wdt_clk))
 		return PTR_ERR(rt288x_wdt_clk);
 
-	device_reset(&pdev->dev);
+	rt288x_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(rt288x_wdt_reset))
+		reset_control_deassert(rt288x_wdt_reset);
 
 	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
 
 	rt288x_wdt_dev.dev = &pdev->dev;
 	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
-
 	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
-	rt288x_wdt_dev.timeout = rt288x_wdt_dev.max_timeout;
 
+	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
+			      &pdev->dev);
 	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
 
 	ret = watchdog_register_device(&rt288x_wdt_dev);
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 12c1590..2c1db6f 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -57,7 +57,7 @@ static int twl4030_wdt_set_timeout(struct watchdog_device *wdt,
 }
 
 static const struct watchdog_info twl4030_wdt_info = {
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "TWL4030 Watchdog",
 };
 
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 7165704..5824e25 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -50,7 +50,7 @@ static int cr_wdt_control;	/* WDT control register */
 
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
-	     w83667hg_b, nct6775, nct6776, nct6779 };
+	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792 };
 
 static int timeout;			/* in seconds */
 module_param(timeout, int, 0);
@@ -95,6 +95,8 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define NCT6775_ID		0xb4
 #define NCT6776_ID		0xc3
 #define NCT6779_ID		0xc5
+#define NCT6791_ID		0xc8
+#define NCT6792_ID		0xc9
 
 #define W83627HF_WDT_TIMEOUT	0xf6
 #define W83697HF_WDT_TIMEOUT	0xf4
@@ -195,6 +197,8 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	case nct6775:
 	case nct6776:
 	case nct6779:
+	case nct6791:
+	case nct6792:
 		/*
 		 * These chips have a fixed WDTO# output pin (W83627UHG),
 		 * or support more than one WDTO# output pin.
@@ -395,6 +399,12 @@ static int wdt_find(int addr)
 	case NCT6779_ID:
 		ret = nct6779;
 		break;
+	case NCT6791_ID:
+		ret = nct6791;
+		break;
+	case NCT6792_ID:
+		ret = nct6792;
+		break;
 	case 0xff:
 		ret = -ENODEV;
 		break;
@@ -428,6 +438,8 @@ static int __init wdt_init(void)
 		"NCT6775",
 		"NCT6776",
 		"NCT6779",
+		"NCT6791",
+		"NCT6792",
 	};
 
 	wdt_io = 0x2e;
diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
index b708786..5582c21 100644
--- a/include/linux/bcm47xx_wdt.h
+++ b/include/linux/bcm47xx_wdt.h
@@ -16,6 +16,7 @@ struct bcm47xx_wdt {
 
 	struct watchdog_device wdd;
 	struct notifier_block notifier;
+	struct notifier_block restart_handler;
 
 	struct timer_list soft_timer;
 	atomic_t soft_ticks;
