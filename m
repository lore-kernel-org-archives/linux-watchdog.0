Return-path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Paul Burton <paul.burton@imgtec.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Maarten ter Huurne <maarten@treewalker.org>,
	linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] MIPS: qi_lb60: Register watchdog device
Date: Sat, 10 Jan 2015 19:29:09 +0100
Message-Id: <1420914550-18335-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1420914550-18335-1-git-send-email-lars@metafoo.de>
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>
List-ID: <linux-watchdog@vger.kernel.org>

The next commit will move the restart code to the watchdog driver. So for
restart to continue to work we need to register the watchdog device.

Also enable the watchdog driver in the default config.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/configs/qi_lb60_defconfig |    2 ++
 arch/mips/jz4740/board-qi_lb60.c    |    1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index 2b96547..ce06a92 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -73,6 +73,8 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_JZ4740=y
 CONFIG_CHARGER_GPIO=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_JZ4740_WDT=y
 CONFIG_MFD_JZ4740_ADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index c454525..a00f134 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -436,6 +436,7 @@ static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
 };
 
 static struct platform_device *jz_platform_devices[] __initdata = {
+	&jz4740_wdt_device,
 	&jz4740_udc_device,
 	&jz4740_udc_xceiv_device,
 	&jz4740_mmc_device,
-- 
1.7.10.4
