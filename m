Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:55482 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab2FHNJ7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jun 2012 09:09:59 -0400
From: Tony Zelenoff <antonz@parallels.com>
To: <linux-watchdog@vger.kernel.org>
CC: <wim@iguana.be>, <antonz@parallels.com>
Subject: [RFC 3/3] watchdog: connect watchdog_may_open to legacy code
Date: Fri, 8 Jun 2012 17:09:57 +0400
Message-ID: <1339160997-160581-4-git-send-email-antonz@parallels.com>
In-Reply-To: <1339160997-160581-1-git-send-email-antonz@parallels.com>
References: <1339160997-160581-1-git-send-email-antonz@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Every /dev/watchdog opener must be checked of reboot capabilities
presence. In case of large amount of watchdog devices, there are
really lot of monkey work.

Signed-off-by: Tony Zelenoff <antonz@parallels.com>
---
 drivers/watchdog/acquirewdt.c         |    3 +++
 drivers/watchdog/advantechwdt.c       |    3 +++
 drivers/watchdog/alim1535_wdt.c       |    3 +++
 drivers/watchdog/alim7101_wdt.c       |    3 +++
 drivers/watchdog/ar7_wdt.c            |    3 +++
 drivers/watchdog/at32ap700x_wdt.c     |    3 +++
 drivers/watchdog/at91rm9200_wdt.c     |    3 +++
 drivers/watchdog/at91sam9_wdt.c       |    3 +++
 drivers/watchdog/ath79_wdt.c          |    3 +++
 drivers/watchdog/bcm47xx_wdt.c        |    3 +++
 drivers/watchdog/bcm63xx_wdt.c        |    3 +++
 drivers/watchdog/bfin_wdt.c           |    3 +++
 drivers/watchdog/booke_wdt.c          |    3 +++
 drivers/watchdog/cpu5wdt.c            |    3 +++
 drivers/watchdog/cpwd.c               |    7 ++++++-
 drivers/watchdog/davinci_wdt.c        |    3 +++
 drivers/watchdog/dw_wdt.c             |    3 +++
 drivers/watchdog/eurotechwdt.c        |    3 +++
 drivers/watchdog/f71808e_wdt.c        |    3 +++
 drivers/watchdog/gef_wdt.c            |    3 +++
 drivers/watchdog/geodewdt.c           |    3 +++
 drivers/watchdog/hpwdt.c              |    3 +++
 drivers/watchdog/i6300esb.c           |    3 +++
 drivers/watchdog/ib700wdt.c           |    3 +++
 drivers/watchdog/ibmasr.c             |    3 +++
 drivers/watchdog/imx2_wdt.c           |    3 +++
 drivers/watchdog/indydog.c            |    3 +++
 drivers/watchdog/intel_scu_watchdog.c |    2 ++
 drivers/watchdog/iop_wdt.c            |    3 +++
 drivers/watchdog/it8712f_wdt.c        |    4 ++++
 drivers/watchdog/it87_wdt.c           |    3 +++
 drivers/watchdog/ixp4xx_wdt.c         |    3 +++
 drivers/watchdog/ks8695_wdt.c         |    3 +++
 drivers/watchdog/lantiq_wdt.c         |    3 +++
 drivers/watchdog/m54xx_wdt.c          |    3 +++
 drivers/watchdog/machzwd.c            |    3 +++
 drivers/watchdog/mixcomwd.c           |    3 +++
 drivers/watchdog/mpc8xxx_wdt.c        |    4 ++++
 drivers/watchdog/mpcore_wdt.c         |    7 ++++++-
 drivers/watchdog/mtx-1_wdt.c          |    3 +++
 drivers/watchdog/mv64x60_wdt.c        |    3 +++
 drivers/watchdog/nuc900_wdt.c         |    2 ++
 drivers/watchdog/nv_tco.c             |    3 +++
 drivers/watchdog/octeon-wdt-main.c    |    3 +++
 drivers/watchdog/of_xilinx_wdt.c      |    3 +++
 drivers/watchdog/omap_wdt.c           |   10 ++++++++--
 drivers/watchdog/orion_wdt.c          |    3 +++
 drivers/watchdog/pc87413_wdt.c        |    3 +++
 drivers/watchdog/pcwd.c               |    3 +++
 drivers/watchdog/pcwd_pci.c           |    3 +++
 drivers/watchdog/pcwd_usb.c           |    3 +++
 drivers/watchdog/pika_wdt.c           |    3 +++
 drivers/watchdog/pnx833x_wdt.c        |    3 +++
 drivers/watchdog/rc32434_wdt.c        |    3 +++
 drivers/watchdog/rdc321x_wdt.c        |    3 +++
 drivers/watchdog/riowd.c              |    3 +++
 drivers/watchdog/sa1100_wdt.c         |    3 +++
 drivers/watchdog/sb_wdog.c            |    3 +++
 drivers/watchdog/sbc60xxwdt.c         |    3 +++
 drivers/watchdog/sbc7240_wdt.c        |    3 +++
 drivers/watchdog/sbc8360.c            |    3 +++
 drivers/watchdog/sbc_epx_c3.c         |    3 +++
 drivers/watchdog/sbc_fitpc2_wdt.c     |    3 +++
 drivers/watchdog/sc1200wdt.c          |    3 +++
 drivers/watchdog/sc520_wdt.c          |    3 +++
 drivers/watchdog/sch311x_wdt.c        |    3 +++
 drivers/watchdog/scx200_wdt.c         |    3 +++
 drivers/watchdog/smsc37b787_wdt.c     |    3 +++
 drivers/watchdog/sp5100_tco.c         |    3 +++
 drivers/watchdog/stmp3xxx_wdt.c       |    3 +++
 drivers/watchdog/ts72xx_wdt.c         |    7 ++++++-
 drivers/watchdog/twl4030_wdt.c        |    7 ++++++-
 drivers/watchdog/w83627hf_wdt.c       |    3 +++
 drivers/watchdog/w83697hf_wdt.c       |    3 +++
 drivers/watchdog/w83697ug_wdt.c       |    3 +++
 drivers/watchdog/w83877f_wdt.c        |    3 +++
 drivers/watchdog/w83977f_wdt.c        |    3 +++
 drivers/watchdog/wafer5823wdt.c       |    3 +++
 drivers/watchdog/wdrtas.c             |    3 +++
 drivers/watchdog/wdt.c                |    3 +++
 drivers/watchdog/wdt285.c             |    3 +++
 drivers/watchdog/wdt977.c             |    3 +++
 drivers/watchdog/wdt_pci.c            |    3 +++
 drivers/watchdog/xen_wdt.c            |    3 +++
 84 files changed, 269 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index 4397881..1a94fa8 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -193,6 +193,9 @@ static long acq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int acq_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &acq_is_open))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 64ae9e9..b8929d7 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -192,6 +192,9 @@ static long advwdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int advwdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &advwdt_is_open))
 		return -EBUSY;
 	/*
diff --git a/drivers/watchdog/alim1535_wdt.c b/drivers/watchdog/alim1535_wdt.c
index 41b8493..bfab9b1 100644
--- a/drivers/watchdog/alim1535_wdt.c
+++ b/drivers/watchdog/alim1535_wdt.c
@@ -243,6 +243,9 @@ static long ali_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int ali_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &ali_is_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 5eee550..6054324 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -209,6 +209,9 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 
 static int fop_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* Just in case we're already talking to someone... */
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index dc30dbd..d4019c3 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -171,6 +171,9 @@ static void ar7_wdt_disable_wdt(void)
 
 static int ar7_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* only allow one at a time */
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/at32ap700x_wdt.c b/drivers/watchdog/at32ap700x_wdt.c
index 2896430..e5bc225 100644
--- a/drivers/watchdog/at32ap700x_wdt.c
+++ b/drivers/watchdog/at32ap700x_wdt.c
@@ -132,6 +132,9 @@ static inline void at32_wdt_pat(void)
  */
 static int at32_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(1, &wdt->users))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 7ef99a1..bad2e6c 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -81,6 +81,9 @@ static inline void at91_wdt_reload(void)
  */
 static int at91_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &at91wdt_busy))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 05e1be8..e9b91e4 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -106,6 +106,9 @@ static void at91_ping(unsigned long data)
  */
 static int at91_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &at91wdt_private.open))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 1f9371f..eca986e 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -102,6 +102,9 @@ static int ath79_wdt_set_timeout(int val)
 
 static int ath79_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_FLAGS_BUSY, &wdt_flags))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index bc0e91e..b244092 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -130,6 +130,9 @@ static int bcm47xx_wdt_settimeout(int new_time)
 
 static int bcm47xx_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &bcm47xx_wdt_busy))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 8379dc3..5392713 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -116,6 +116,9 @@ static int bcm63xx_wdt_settimeout(int new_time)
 
 static int bcm63xx_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &bcm63xx_wdt_device.inuse))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/bfin_wdt.c b/drivers/watchdog/bfin_wdt.c
index 38bc383..60da625 100644
--- a/drivers/watchdog/bfin_wdt.c
+++ b/drivers/watchdog/bfin_wdt.c
@@ -151,6 +151,9 @@ static int bfin_wdt_open(struct inode *inode, struct file *file)
 {
 	stampit();
 
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &open_check))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index ce0ab44..115c759 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -218,6 +218,9 @@ static unsigned long wdt_is_active;
 
 static int booke_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &wdt_is_active))
 		return -EBUSY;
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 7e88839..2b83397 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -139,6 +139,9 @@ static int cpu5wdt_stop(void)
 
 static int cpu5wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &cpu5wdt_device.inuse))
 		return -EBUSY;
 	return nonseekable_open(inode, file);
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 95b1b95..ec119e5 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -368,7 +368,12 @@ static irqreturn_t cpwd_interrupt(int irq, void *dev_id)
 
 static int cpwd_open(struct inode *inode, struct file *f)
 {
-	struct cpwd *p = cpwd_device;
+	struct cpwd *p;
+
+	if (!watchdog_may_open())
+		return -EPERM;
+
+	p = cpwd_device;
 
 	mutex_lock(&cpwd_mutex);
 	switch (iminor(inode)) {
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index c8c5c80..fb5384e 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -125,6 +125,9 @@ static void wdt_enable(void)
 
 static int davinci_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 06de121..935000f 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -130,6 +130,9 @@ static void dw_wdt_ping(unsigned long data)
 
 static int dw_wdt_open(struct inode *inode, struct file *filp)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &dw_wdt.in_use))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index cd31b8a..3f7d689 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -311,6 +311,9 @@ static long eurwdt_ioctl(struct file *file,
 
 static int eurwdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &eurwdt_is_open))
 		return -EBUSY;
 	eurwdt_timeout = WDT_TIMEOUT;	/* initial timeout */
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index c65b0a5..78d01eb 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -464,6 +464,9 @@ static int watchdog_open(struct inode *inode, struct file *file)
 {
 	int err;
 
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* If the watchdog is alive we don't need to start it again */
 	if (test_and_set_bit(0, &watchdog.opened))
 		return -EBUSY;
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 17f4cae..b2b21e6 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -220,6 +220,9 @@ static long gef_wdt_ioctl(struct file *file, unsigned int cmd,
 
 static int gef_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(GEF_WDOG_FLAG_OPENED, &wdt_flags))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index dc563b6..0358c48 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -85,6 +85,9 @@ static int geodewdt_set_heartbeat(int val)
 
 static int geodewdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_FLAGS_OPEN, &wdt_flags))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 2b76381..3f3657d 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -511,6 +511,9 @@ out:
  */
 static int hpwdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &hpwdt_is_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 276877d..2500f75 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -198,6 +198,9 @@ static int esb_timer_set_heartbeat(int time)
 
 static int esb_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index 184c0bf..f7fe272 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -231,6 +231,9 @@ static long ibwdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int ibwdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &ibwdt_is_open))
 		return -EBUSY;
 	if (nowayout)
diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index bc3fb8f..4cc8010 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -317,6 +317,9 @@ static long asr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int asr_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &asr_is_open))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index bcfab2b..fdf3732 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -150,6 +150,9 @@ static void imx2_wdt_set_timeout(int new_timeout)
 
 static int imx2_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(IMX2_WDT_STATUS_OPEN, &imx2_wdt.status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
index 6d90f7a..6c86fb6 100644
--- a/drivers/watchdog/indydog.c
+++ b/drivers/watchdog/indydog.c
@@ -74,6 +74,9 @@ static void indydog_ping(void)
  */
 static int indydog_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &indydog_alive))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
index 9dda2d0..6a28664 100644
--- a/drivers/watchdog/intel_scu_watchdog.c
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -297,6 +297,8 @@ static int intel_scu_set_heartbeat(u32 t)
 
 static int intel_scu_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
 
 	/* Set flag to indicate that watchdog device is open */
 	if (test_and_set_bit(0, &watchdog_device.driver_open))
diff --git a/drivers/watchdog/iop_wdt.c b/drivers/watchdog/iop_wdt.c
index d964faf..320b001 100644
--- a/drivers/watchdog/iop_wdt.c
+++ b/drivers/watchdog/iop_wdt.c
@@ -95,6 +95,9 @@ static int wdt_disable(void)
 
 static int iop_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
index f4cce6d..80398a4 100644
--- a/drivers/watchdog/it8712f_wdt.c
+++ b/drivers/watchdog/it8712f_wdt.c
@@ -321,6 +321,10 @@ static long it8712f_wdt_ioctl(struct file *file, unsigned int cmd,
 static int it8712f_wdt_open(struct inode *inode, struct file *file)
 {
 	int ret;
+
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* only allow one at a time */
 	if (test_and_set_bit(0, &wdt_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index d3dcc69..582deed 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -382,6 +382,9 @@ static int wdt_get_status(int *status)
 
 static int wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (exclusive && test_and_set_bit(WDTS_DEV_OPEN, &wdt_status))
 		return -EBUSY;
 	if (!test_and_set_bit(WDTS_TIMER_RUN, &wdt_status)) {
diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 5580b4f..1ee3356 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -60,6 +60,9 @@ static void wdt_disable(void)
 
 static int ixp4xx_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 59e75d9..34a9ae4 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -126,6 +126,9 @@ static int ks8695_wdt_settimeout(int new_time)
  */
 static int ks8695_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &ks8695wdt_busy))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 2e74c3a..f72c302 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -150,6 +150,9 @@ ltq_wdt_ioctl(struct file *file,
 static int
 ltq_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &ltq_wdt_in_use))
 		return -EBUSY;
 	ltq_wdt_in_use = 1;
diff --git a/drivers/watchdog/m54xx_wdt.c b/drivers/watchdog/m54xx_wdt.c
index 663cad8..733905a 100644
--- a/drivers/watchdog/m54xx_wdt.c
+++ b/drivers/watchdog/m54xx_wdt.c
@@ -80,6 +80,9 @@ static void wdt_keepalive(void)
 
 static int m54xx_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index bf84f78..531d192 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -329,6 +329,9 @@ static long zf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int zf_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &zf_is_open))
 		return -EBUSY;
 	if (nowayout)
diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index 37e4b52..02f9908 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -132,6 +132,9 @@ static void mixcomwd_timerfun(unsigned long d)
 
 static int mixcomwd_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &mixcomwd_opened))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 40f7bf1..f17ffb7 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -113,6 +113,10 @@ static ssize_t mpc8xxx_wdt_write(struct file *file, const char __user *buf,
 static int mpc8xxx_wdt_open(struct inode *inode, struct file *file)
 {
 	u32 tmp = SWCRR_SWEN;
+
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 7c741dc..36594b0 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -151,7 +151,12 @@ static int mpcore_wdt_set_heartbeat(int t)
  */
 static int mpcore_wdt_open(struct inode *inode, struct file *file)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(mpcore_wdt_pdev);
+	struct mpcore_wdt *wdt;
+
+	if (!watchdog_may_open())
+		return -EPERM;
+
+	wdt = platform_get_drvdata(mpcore_wdt_pdev);
 
 	if (test_and_set_bit(0, &wdt->timer_alive))
 		return -EBUSY;
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index c29e31d..f03d09a 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -126,6 +126,9 @@ static int mtx1_wdt_stop(void)
 
 static int mtx1_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &mtx1_wdt_device.inuse))
 		return -EBUSY;
 	return nonseekable_open(inode, file);
diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index c53d025..3d6809a 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -125,6 +125,9 @@ static void mv64x60_wdt_set_timeout(unsigned int timeout)
 
 static int mv64x60_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(MV64x60_WDOG_FLAG_OPENED, &wdt_flags))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index ea4c744..3a795b6 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -127,6 +127,8 @@ static inline void nuc900_wdt_ping(void)
 
 static int nuc900_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
 
 	if (test_and_set_bit(0, &nuc900wdt_busy))
 		return -EBUSY;
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index 6bbb9ef..5b53411 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -154,6 +154,9 @@ static int tco_timer_set_heartbeat(int t)
 
 static int nv_tco_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 4612088..fd7bc6a 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -601,6 +601,9 @@ static long octeon_wdt_ioctl(struct file *file, unsigned int cmd,
 
 static int octeon_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &octeon_wdt_is_open))
 		return -EBUSY;
 	/*
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 55d2f66..3dcc5f4 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -158,6 +158,9 @@ static u32 xwdt_selftest(void)
 
 static int xwdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* Only one process can handle the wdt at a time */
 	if (test_and_set_bit(0, &driver_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 8285d65..863e181 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -144,8 +144,14 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
  */
 static int omap_wdt_open(struct inode *inode, struct file *file)
 {
-	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
-	void __iomem *base = wdev->base;
+	struct omap_wdt_dev *wdev;
+	void __iomem *base;
+
+	if (!watchdog_may_open())
+		return -EPERM;
+
+	wdev = platform_get_drvdata(omap_wdt_dev);
+	base = wdev->base;
 
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0f57369..965a78e 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -113,6 +113,9 @@ static int orion_wdt_get_timeleft(int *time_left)
 
 static int orion_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
 		return -EBUSY;
 	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 5afb89b..239e449 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -273,6 +273,9 @@ static void pc87413_refresh(void)
 
 static int pc87413_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 
 	if (test_and_set_bit(0, &timer_enabled))
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index 75694cf..00a7810 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -688,6 +688,9 @@ static ssize_t pcwd_write(struct file *file, const char __user *buf, size_t len,
 
 static int pcwd_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &open_allowed))
 		return -EBUSY;
 	if (nowayout)
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index ee6900d..12eafff 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -568,6 +568,9 @@ static long pcipcwd_ioctl(struct file *file, unsigned int cmd,
 
 static int pcipcwd_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &is_active)) {
 		if (debug >= VERBOSE)
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 7b14d18..b4697c0 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -493,6 +493,9 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 
 static int usb_pcwd_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &is_active))
 		return -EBUSY;
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 7d3d471..51253bc 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -111,6 +111,9 @@ static void pikawdt_start(void)
  */
 static int pikawdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &pikawdt_private.open))
 		return -EBUSY;
diff --git a/drivers/watchdog/pnx833x_wdt.c b/drivers/watchdog/pnx833x_wdt.c
index 1b62a7d..69e5fa9 100644
--- a/drivers/watchdog/pnx833x_wdt.c
+++ b/drivers/watchdog/pnx833x_wdt.c
@@ -102,6 +102,9 @@ static void pnx833x_wdt_ping(void)
  */
 static int pnx833x_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &pnx833x_wdt_alive))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index 547353a..e216aa4 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -141,6 +141,9 @@ static void rc32434_wdt_ping(void)
 
 static int rc32434_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &rc32434_wdt_device.inuse))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 042ccc5..1ff6fc7 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -140,6 +140,9 @@ static int rdc321x_wdt_stop(void)
 /* filesystem operations */
 static int rdc321x_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &rdc321x_wdt_device.inuse))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 49e1b1c..e83154f 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -77,6 +77,9 @@ static void riowd_writereg(struct riowd *p, u8 val, int index)
 
 static int riowd_open(struct inode *inode, struct file *filp)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	nonseekable_open(inode, filp);
 	return 0;
 }
diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 54984de..df73b9c 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -50,6 +50,9 @@ static int boot_status;
  */
 static int sa1100dog_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(1, &sa1100wdt_users))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 25c7a3f..1ba83e4 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -105,6 +105,9 @@ static const struct watchdog_info ident = {
  */
 static int sbwdog_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	nonseekable_open(inode, file);
 	if (test_and_set_bit(0, &sbwdog_gate))
 		return -EBUSY;
diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
index 63632ec..13d9599 100644
--- a/drivers/watchdog/sbc60xxwdt.c
+++ b/drivers/watchdog/sbc60xxwdt.c
@@ -199,6 +199,9 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 
 static int fop_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* Just in case we're already talking to someone... */
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/sbc7240_wdt.c b/drivers/watchdog/sbc7240_wdt.c
index 719edc8..17ef2f5 100644
--- a/drivers/watchdog/sbc7240_wdt.c
+++ b/drivers/watchdog/sbc7240_wdt.c
@@ -131,6 +131,9 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 
 static int fop_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(SBC7240_OPEN_STATUS_BIT, &wdt_status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/sbc8360.c b/drivers/watchdog/sbc8360.c
index d4781e0..607bf3a 100644
--- a/drivers/watchdog/sbc8360.c
+++ b/drivers/watchdog/sbc8360.c
@@ -263,6 +263,9 @@ static ssize_t sbc8360_write(struct file *file, const char __user *buf,
 
 static int sbc8360_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &sbc8360_is_open))
 		return -EBUSY;
 	if (nowayout)
diff --git a/drivers/watchdog/sbc_epx_c3.c b/drivers/watchdog/sbc_epx_c3.c
index 0c3e9f6..dc39411 100644
--- a/drivers/watchdog/sbc_epx_c3.c
+++ b/drivers/watchdog/sbc_epx_c3.c
@@ -65,6 +65,9 @@ static void epx_c3_pet(void)
  */
 static int epx_c3_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (epx_c3_alive)
 		return -EBUSY;
 
diff --git a/drivers/watchdog/sbc_fitpc2_wdt.c b/drivers/watchdog/sbc_fitpc2_wdt.c
index 90d5527..7deb58b 100644
--- a/drivers/watchdog/sbc_fitpc2_wdt.c
+++ b/drivers/watchdog/sbc_fitpc2_wdt.c
@@ -68,6 +68,9 @@ static void wdt_disable(void)
 
 static int fitpc2_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 3fb83b0..ef2b39f 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -168,6 +168,9 @@ static inline int sc1200wdt_status(void)
 
 static int sc1200wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* allow one at a time */
 	if (test_and_set_bit(0, &open_flag))
 		return -EBUSY;
diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index 707e027..a219d7f 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -251,6 +251,9 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 
 static int fop_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* Just in case we're already talking to someone... */
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index f847700..909df80 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -305,6 +305,9 @@ static long sch311x_wdt_ioctl(struct file *file, unsigned int cmd,
 
 static int sch311x_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &sch311x_wdt_is_open))
 		return -EBUSY;
 	/*
diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
index 8ae7c28..2f9c6b5 100644
--- a/drivers/watchdog/scx200_wdt.c
+++ b/drivers/watchdog/scx200_wdt.c
@@ -98,6 +98,9 @@ static void scx200_wdt_disable(void)
 
 static int scx200_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* only allow one at a time */
 	if (test_and_set_bit(0, &open_lock))
 		return -EBUSY;
diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index 6d665f9..5b7e1c1 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -352,6 +352,9 @@ static int wb_smsc_wdt_status(void)
 
 static int wb_smsc_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 
 	if (test_and_set_bit(0, &timer_enabled))
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index ae5e82c..a3b39b5 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -128,6 +128,9 @@ static int tco_timer_set_heartbeat(int t)
 
 static int sp5100_tco_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
diff --git a/drivers/watchdog/stmp3xxx_wdt.c b/drivers/watchdog/stmp3xxx_wdt.c
index 21d96b9..a0af17d 100644
--- a/drivers/watchdog/stmp3xxx_wdt.c
+++ b/drivers/watchdog/stmp3xxx_wdt.c
@@ -65,6 +65,9 @@ static void wdt_ping(void)
 
 static int stmp3xxx_wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 8df050d..d883b43 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -180,9 +180,14 @@ static void ts72xx_wdt_stop(struct ts72xx_wdt *wdt)
 
 static int ts72xx_wdt_open(struct inode *inode, struct file *file)
 {
-	struct ts72xx_wdt *wdt = platform_get_drvdata(ts72xx_wdt_pdev);
+	struct ts72xx_wdt *wdt;
 	int regval;
 
+	if (!watchdog_may_open())
+		return -EPERM;
+
+	wdt = platform_get_drvdata(ts72xx_wdt_pdev);
+
 	/*
 	 * Try to convert default timeout to valid register
 	 * value first.
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 249f113..49e698d 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -131,7 +131,12 @@ static long twl4030_wdt_ioctl(struct file *file,
 
 static int twl4030_wdt_open(struct inode *inode, struct file *file)
 {
-	struct twl4030_wdt *wdt = platform_get_drvdata(twl4030_wdt_dev);
+	struct twl4030_wdt *wdt;
+
+	if (!watchdog_may_open())
+		return -EPERM;
+
+	wdt = platform_get_drvdata(twl4030_wdt_dev);
 
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &wdt->state))
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 92f1326..22b8f2b 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -274,6 +274,9 @@ static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
 	/*
diff --git a/drivers/watchdog/w83697hf_wdt.c b/drivers/watchdog/w83697hf_wdt.c
index cd9f3c1..56ebae2 100644
--- a/drivers/watchdog/w83697hf_wdt.c
+++ b/drivers/watchdog/w83697hf_wdt.c
@@ -294,6 +294,9 @@ static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
 	/*
diff --git a/drivers/watchdog/w83697ug_wdt.c b/drivers/watchdog/w83697ug_wdt.c
index 274be0b..c868a5b 100644
--- a/drivers/watchdog/w83697ug_wdt.c
+++ b/drivers/watchdog/w83697ug_wdt.c
@@ -271,6 +271,9 @@ static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
 	/*
diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index 7874ae0..69b44bc 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -218,6 +218,9 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 
 static int fop_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* Just in case we're already talking to someone... */
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index 5d2c902..0bdbf2f 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -290,6 +290,9 @@ static int wdt_get_status(int *status)
 
 static int wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* If the watchdog is alive we don't need to start it again */
 	if (test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
index 25aba6e..33cb01b 100644
--- a/drivers/watchdog/wafer5823wdt.c
+++ b/drivers/watchdog/wafer5823wdt.c
@@ -190,6 +190,9 @@ static long wafwdt_ioctl(struct file *file, unsigned int cmd,
 
 static int wafwdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &wafwdt_is_open))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index 0a77655..7e45417 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -392,6 +392,9 @@ static long wdrtas_ioctl(struct file *file, unsigned int cmd,
  */
 static int wdrtas_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* only open once */
 	if (atomic_inc_return(&wdrtas_miscdev_open) > 1) {
 		atomic_dec(&wdrtas_miscdev_open);
diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
index ee4333c..fbe266e 100644
--- a/drivers/watchdog/wdt.c
+++ b/drivers/watchdog/wdt.c
@@ -415,6 +415,9 @@ static long wdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static int wdt_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &wdt_is_open))
 		return -EBUSY;
 	/*
diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index 5eec740..a2da70a 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -73,6 +73,9 @@ static int watchdog_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (*CSR_SA110_CNTL & (1 << 13))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/wdt977.c b/drivers/watchdog/wdt977.c
index 65a4023..9993e36 100644
--- a/drivers/watchdog/wdt977.c
+++ b/drivers/watchdog/wdt977.c
@@ -265,6 +265,9 @@ static int wdt977_get_status(int *status)
 
 static int wdt977_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* If the watchdog is alive we don't need to start it again */
 	if (test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index e32654e..2d55dc5 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -453,6 +453,9 @@ static long wdtpci_ioctl(struct file *file, unsigned int cmd,
 
 static int wdtpci_open(struct inode *inode, struct file *file)
 {
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	if (test_and_set_bit(0, &open_lock))
 		return -EBUSY;
 
diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index e4a25b5..4e596dc 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -120,6 +120,9 @@ static int xen_wdt_open(struct inode *inode, struct file *file)
 {
 	int err;
 
+	if (!watchdog_may_open())
+		return -EPERM;
+
 	/* /dev/watchdog can only be opened once */
 	if (xchg(&is_active, true))
 		return -EBUSY;
-- 
1.7.1

