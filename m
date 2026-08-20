Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFB37B41B
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264753; cv=none; b=OorFhoSLGcas17xyrgW2ottqIg5sCXeyyNd1rZA0aB2Kb9gZP5E400LWtB0gjy2jOVxvZngaR3zjSL62NF9Ibdqn+uOi7EsZjT/H2srd5b4HKJqWQg4ijkFQP0L2XlPDVtXIlSyAsvsmQsDPgf2NV5rWbNV6oWpusr3jQB5cpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264753; c=relaxed/simple;
	bh=qs0P8Z3L/DArAi6Mb7HK4TBeIAH+j772uQGs42hNLpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3nMzd6V8zi3fXGQe8dYCCxYW1gO30SaXDs6nK1zt6oyEbIiDMfpzCkHMEZYqn03l6z5VAfUtMw3eBnLvBuuukq4jP52BPIMU0kjFHNl/Blh6uVmbnpyywzJ5wkHM26UYa/0ZwwesEnyI1Bi1sHPmBW/YR0UggekMjZcSFVk8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVf33eMM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVf33eMM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so776180a12.3
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787264750; x=1787869550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qwcOFOWGnyyIIO6eY/AV8j0ZV0aP4Pzud4iHF54mes0=;
        b=pVf33eMMk4jXIJygsl4qp/Qe78rPGI1iajYbplk/4i6bdonf0uFMvB/TWIeQZ+IuOt
         owzmoluNedhwECQjS2B6TzgM1h/93vHTlMqIgaK5VizCpPkUt1w7VM70O4iEM+o4b2H8
         L8rkqfIvvgvbaDwd7mH1q0QzrgG+FJYNQ325gmt9FidqUxmihdablRrZ9hSHSDKyyCNK
         Tdb11Qb058qzDNzwu4AwpHZkKtIr/S3baK7BsytyHVcftL4z4cgrBaqtJn49OlejavMd
         o5Bm7WV618c8he1b3e6hLB5pGnzkvqZ7D/Hl/do2PS51xz8F8NcK7cPpNXbzEx2Jv4Pd
         4Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787264750; x=1787869550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qwcOFOWGnyyIIO6eY/AV8j0ZV0aP4Pzud4iHF54mes0=;
        b=MoWS2E8L/DNnqXHogslR+nY3C/pdfHkJK+2aS1VXx4CxbJfVCj37chpaExLs7ZgRKB
         KusvQg7Z8g32JaS9Q92kAyHzn0j1UCbO1SVK+dd1titOvWL/lfzvLJ3sx3e44BP2U7C4
         nzcQpQINIJ8AxnudZM+209KyySMUHFGBAM/1Ialc6Uhb+FuLRzwCJakFtN/+LBsEFPF/
         IOfejLhHzA4livXfZTmZCQQeEPL2DkOrTmjzOP97SFlEgWe3h1NfBFg6uW7b0mjx1wYJ
         2b93JRg+5rA2EgNzUJJlzQyWl6MtcPoGM5iNeHksmgo6MH73hZ0t3iZk0xYIZjQLsb14
         1ZVg==
X-Gm-Message-State: AFuF++k+zpHhgs33HcU0wihZHRieOuxHoKpTn5JbcBNIJpPY++5X6r2K
	KJ/wa1R31JASkB6yQmyiRDpoZP5d8gbHZB2tAdj2AvS6jT1lP3/xjNAZ
X-Gm-Gg: AR+sD13jmpV+ORQB/6RdZGQOUGQs4usCZbJc3FTBqwkhIJPn7/flsE/DonILQtkgADf
	Lhzj4BCNWSwbnVO3bmrHZtfHWOvShhbYuUdgn8NALQ3LWzWKY7tQSwPozubSKfuy9qV6PGo+9wp
	siz8CEDbRGWQP0KP6kpdkLDQJ7LfwCU5eKaUAqliFGjtAJO0roz4Wp+x+WwKe07kkMWC76MT6l0
	fZX4lMxW8Dpog6msx3C2Opw6PgfqQY/q4kwtUlUj3m4+QYJZjkotab0ShEdFlB66ci0j8rhCUkJ
	Tuz//BvJTx1oDV3FWWYOo8iANMk91+kmB7q9KkHP/c555XE83Xhz5mVwgGP7VlYHHl9lQmeOjyH
	JlJrziIJ6e8Ihc2Uw/PzJZQ85wakdav9k91a07RjLP46xhgGwmdpIZgjQkX1HsEBi//72v1h31/
	LBtcaFfebWMbKAs9//54gL5XnUqeNb/Oun0vCVGQbWlaOiRtI458SnOD0sF2s12QaHhEEwR17V4
	lVi6lF4bMEDXO8Jwmh67etYYiGg25+iOcLYSQw9zFzNaPgojZFj0L2NEgph899sX1rEJ3YkYjM=
X-Received: by 2002:a05:6402:458d:b0:6a3:87b7:b5a9 with SMTP id 4fb4d7f45d1cf-6a42f1f9d6cmr1788179a12.12.1787264750063;
        Thu, 20 Aug 2026 15:25:50 -0700 (PDT)
Received: from Arbeitszimmer.fritz.box ([2001:9e8:db05:b500:4296:43d1:74f1:665e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d52sm3522028a12.2.2026.08.20.15.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 15:25:49 -0700 (PDT)
From: Christoph Berliner <caberliner@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Berliner <caberliner@gmail.com>
Subject: [PATCH] watchdog: sp5100_tco: add reversible legacy MMIO relocation
Date: Fri, 21 Aug 2026 00:25:41 +0200
Message-ID: <20260820222541.16494-1-caberliner@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older SP5100/SB7x0 systems may provide a watchdog MMIO base that
overlaps another reserved resource. On the tested system firmware
programs the watchdog at 0xfec000f0, which falls inside the IOAPIC
resource and causes sp5100_tco to fail probing with -EBUSY.

A relocation mechanism for this class of conflict was introduced by
commit 740fbddf5c3f ("watchdog: sp5100_tco: Add SB8x0 chipset support")
for Linux 3.8.

It was deliberately removed shortly afterwards by commit 18e4321276fc
("watchdog: sp5100_tco: Remove code that may cause a boot failure")
after an SB700 machine failed to load BIOS after running a kernel
containing the relocation path until power was completely removed.

The exact cause of that failure is not documented. One relevant
difference is that the old relocation path reprogrammed the watchdog
base but did not restore the firmware-programmed PM register state when
the driver was removed.

Add a reversible relocation path for the legacy SP5100 register layout.
Locate the top-level firmware-reserved MMIO resource containing the
conflicting address and search it for a free, naturally aligned 8-byte
child resource.

Use request_resource() for conflict checking instead of
allocate_resource(), since x86 dynamic resource allocation excludes
E820-reserved address ranges.

Before reprogramming the watchdog, save the original PM control and base
registers. Restore them on probe failure or device removal and release
the relocated resource.

On the tested system the complete lifecycle is:

  firmware:  0xfec000f0, PM control 0x03
  relocated: 0xfec00400, PM control 0x06
  restored:  0xfec000f0, PM control 0x03

The relocated resource is registered correctly in /proc/iomem,
the watchdog registers successfully as /dev/watchdog0, and unloading
the module restores both the original firmware address and control
register.

Tested on Linux 7.1.8 with an AMD SBx00 SMBus controller
(PCI 1002:4385, revision 0x3c). The sp5100_tco.c driver in current
mainline is identical to the tested 7.1.8 version.

Signed-off-by: Christoph Berliner <caberliner@gmail.com>
---
Hi Wim, Guenter,

A note on context: I am a physician, not a software developer. This
watchdog issue has annoyed me for quite some time on an older machine
that I still use. Current AI-assisted programming tools finally gave me
a practical way to investigate it in enough depth to trace the firmware
configuration, historical driver behavior and kernel resource handling,
and to build and test a possible fix on the actual hardware.

While investigating the history I found the 2013 SB700 regression that
led to removal of the old relocation path. I do not have the machine
affected by that regression and therefore cannot establish its exact
root cause. The reversible restoration of the firmware-programmed PM
state in this patch is intended to address one important difference
from the old implementation.

I consider this a hardware-tested proposal rather than the work of an
experienced kernel developer. I would particularly appreciate review
of whether restoring the original PM state sufficiently addresses the
risk that led to commit 18e4321276fc ("watchdog: sp5100_tco: Remove
code that may cause a boot failure").

 drivers/watchdog/sp5100_tco.c | 255 +++++++++++++++++++++++++++++++++-
 1 file changed, 251 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 7e99c3b1f367..d21339d07942 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -229,6 +229,231 @@ static void tco_timer_enable(struct sp5100_tco *tco)
 	}
 }
 
+static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
+				   u32 mmio_addr,
+				   u32 alt_mmio_addr,
+				   const char *dev_name,
+				   bool report_error);
+
+/*
+ * Legacy SP5100/SB7x0 fallback.
+ *
+ * Some firmware uses 0xfec000f0 for the watchdog MMIO window.
+ * This may overlap the IOAPIC resource. Historical Linux versions
+ * relocated the watchdog to a free 8-byte MMIO window and
+ * reprogrammed PM registers 0x6c..0x6f.
+ */
+static void sp5100_tco_write_pm_reg8(u8 index, u8 val)
+{
+	outb(index, SP5100_IO_PM_INDEX_REG);
+	outb(val, SP5100_IO_PM_DATA_REG);
+}
+
+struct sp5100_tco_relocation {
+	struct resource res;
+	u8 saved_control;
+	u8 saved_base[4];
+	bool programmed;
+};
+
+static void sp5100_tco_release_relocation(void *data)
+{
+	struct sp5100_tco_relocation *reloc = data;
+	int i;
+
+	if (reloc->programmed &&
+	    request_muxed_region(SP5100_IO_PM_INDEX_REG,
+				 SP5100_PM_IOPORTS_SIZE,
+				 "sp5100_tco restore")) {
+		/*
+		 * Disable decoding while restoring the original base.
+		 */
+		sp5100_tco_update_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
+					  0xff,
+					  SP5100_PM_WATCHDOG_DISABLE);
+
+		for (i = 0; i < 4; i++)
+			sp5100_tco_write_pm_reg8(SP5100_PM_WATCHDOG_BASE + i,
+						 reloc->saved_base[i]);
+
+		sp5100_tco_write_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
+					 reloc->saved_control);
+
+		release_region(SP5100_IO_PM_INDEX_REG,
+			       SP5100_PM_IOPORTS_SIZE);
+	}
+
+	if (reloc->res.parent)
+		release_resource(&reloc->res);
+}
+
+/*
+ * Find the top-level firmware resource containing the conflicting
+ * watchdog address.  The watchdog can then be allocated as a sibling
+ * of resources such as the IOAPIC rather than as a child of them.
+ */
+static struct resource *
+sp5100_tco_find_parent_resource(resource_size_t addr)
+{
+	struct resource *res;
+
+	for (res = iomem_resource.child; res; res = res->sibling) {
+		if (addr >= res->start && addr <= res->end)
+			return res;
+	}
+
+	return NULL;
+}
+
+/*
+ * Older SP5100/SB7x0 firmware may place the watchdog MMIO window inside
+ * another reserved resource, historically most notably the IOAPIC area.
+ *
+ * The old Linux driver could relocate the watchdog when its firmware
+ * supplied address was unusable.  Modern resource trees may expose one
+ * large firmware-reserved parent with individual resources below it.
+ *
+ * Allocate an unused, naturally aligned watchdog-sized child resource
+ * inside that parent and reprogram the SP5100 watchdog base registers.
+ */
+static int sp5100_tco_reprogram_base(struct sp5100_tco *tco,
+				     u32 conflict_addr,
+				     const char *dev_name)
+{
+	struct device *dev = tco->wdd.parent;
+	struct resource *parent;
+	struct sp5100_tco_relocation *reloc;
+	struct resource *res;
+	resource_size_t candidate;
+	resource_size_t max_addr;
+	u32 mmio_addr;
+	u8 base0_reserved;
+	int ret;
+	int i;
+
+	parent = sp5100_tco_find_parent_resource(conflict_addr);
+	if (!parent) {
+		dev_err(dev,
+			"No parent MMIO resource contains conflicting watchdog address 0x%08x\n",
+			conflict_addr);
+		return -ENODEV;
+	}
+
+	/*
+	 * The SP5100 watchdog base is a 32-bit physical address.
+	 */
+	if (parent->start > U32_MAX)
+		return -ERANGE;
+
+	max_addr = min_t(resource_size_t, parent->end, U32_MAX);
+
+	reloc = devm_kzalloc(dev, sizeof(*reloc), GFP_KERNEL);
+	if (!reloc)
+		return -ENOMEM;
+
+	res = &reloc->res;
+	res->name = dev_name;
+	res->flags = IORESOURCE_MEM;
+
+	/*
+	 * Do not use allocate_resource() here.
+	 *
+	 * On x86, dynamic resource allocation excludes E820-reserved
+	 * address ranges. Legacy SP5100 firmware may deliberately place
+	 * the watchdog inside such a reserved parent resource.
+	 *
+	 * Try naturally aligned watchdog-sized slots inside the existing
+	 * parent. request_resource() performs the actual conflict check
+	 * while holding the resource lock.
+	 */
+	candidate = ALIGN(parent->start, SP5100_WDT_MEM_MAP_SIZE);
+
+	for (;;) {
+		if (candidate > max_addr ||
+		    max_addr - candidate + 1 < SP5100_WDT_MEM_MAP_SIZE) {
+			dev_err(dev,
+				"No free watchdog MMIO slot found inside %pR\n",
+				parent);
+			return -EBUSY;
+		}
+
+		res->start = candidate;
+		res->end = candidate + SP5100_WDT_MEM_MAP_SIZE - 1;
+
+		ret = request_resource(parent, res);
+		if (!ret)
+			break;
+
+		if (ret != -EBUSY)
+			return ret;
+
+		candidate += SP5100_WDT_MEM_MAP_SIZE;
+	}
+
+	/*
+	 * Save the firmware-provided watchdog state before changing it.
+	 * The devm cleanup action restores it on probe failure or device
+	 * removal and releases the relocated resource.
+	 */
+	reloc->saved_control =
+		sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_CONTROL);
+
+	for (i = 0; i < 4; i++)
+		reloc->saved_base[i] =
+			sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_BASE + i);
+
+	ret = devm_add_action_or_reset(dev,
+				       sp5100_tco_release_relocation,
+				       reloc);
+	if (ret)
+		return ret;
+
+	mmio_addr = (u32)res->start;
+
+	/*
+	 * Disable the watchdog before changing its decode address.
+	 */
+	sp5100_tco_update_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
+				  0xff,
+				  SP5100_PM_WATCHDOG_DISABLE);
+
+	/*
+	 * Preserve the reserved low three bits of BASE0 while
+	 * reprogramming the aligned watchdog address.
+	 */
+	base0_reserved = reloc->saved_base[0] & 0x07;
+
+	for (i = 0; i < 4; i++) {
+		u8 val = (mmio_addr >> (8 * i)) & 0xff;
+
+		if (!i)
+			val |= base0_reserved;
+
+		sp5100_tco_write_pm_reg8(SP5100_PM_WATCHDOG_BASE + i, val);
+	}
+
+	reloc->programmed = true;
+
+	dev_info(dev,
+		 "Relocated legacy SP5100 watchdog MMIO from 0x%08x to 0x%08x\n",
+		 conflict_addr, mmio_addr);
+
+	tco->tcobase = devm_ioremap(dev, mmio_addr,
+				    SP5100_WDT_MEM_MAP_SIZE);
+	if (!tco->tcobase) {
+		dev_err(dev,
+			"Relocated watchdog MMIO address 0x%08x failed mapping\n",
+			mmio_addr);
+		return -ENOMEM;
+	}
+
+	dev_info(dev,
+		 "Using relocated 0x%08x for watchdog MMIO address\n",
+		 mmio_addr);
+
+	return 0;
+}
+
 static u32 sp5100_tco_read_pm_reg32(u8 index)
 {
 	u32 val = 0;
@@ -256,7 +481,8 @@ static u32 sp5100_tco_request_region(struct device *dev,
 static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
 				   u32 mmio_addr,
 				   u32 alt_mmio_addr,
-				   const char *dev_name)
+				   const char *dev_name,
+				   bool report_error)
 {
 	struct device *dev = tco->wdd.parent;
 
@@ -273,7 +499,9 @@ static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
 		mmio_addr = sp5100_tco_request_region(dev, alt_mmio_addr, dev_name);
 
 	if (!mmio_addr) {
-		dev_err(dev, "Failed to reserve MMIO or alternate MMIO region\n");
+		if (report_error)
+			dev_err(dev,
+				"Failed to reserve MMIO or alternate MMIO region\n");
 		return -EBUSY;
 	}
 
@@ -405,7 +633,7 @@ static int sp5100_tco_setupdevice_mmio(struct device *dev,
 		alt_mmio_addr = EFCH_PM_ACPI_MMIO_ADDR +
 			EFCH_PM_ACPI_MMIO_WDT_OFFSET;
 
-	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name);
+	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name, true);
 	if (!ret) {
 		tco_timer_enable_mmio(addr);
 		ret = sp5100_tco_timer_init(tco);
@@ -428,6 +656,8 @@ static int sp5100_tco_setupdevice(struct device *dev,
 	const char *dev_name;
 	u32 mmio_addr = 0, val;
 	u32 alt_mmio_addr = 0;
+	u32 conflict_addr;
+	bool report_error;
 	int ret;
 
 	if (tco->tco_reg_layout == efch_mmio)
@@ -491,7 +721,24 @@ static int sp5100_tco_setupdevice(struct device *dev,
 		return -ENODEV;
 	}
 
-	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name);
+	report_error = tco->tco_reg_layout != sp5100;
+	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name, report_error);
+
+	/*
+	 * Legacy SP5100/SB7x0 firmware commonly uses 0xfec000f0,
+	 * which can overlap the IOAPIC resource. If neither firmware
+	 * MMIO location can be reserved, restore the historical
+	 * relocation fallback.
+	 */
+	if (ret == -EBUSY && tco->tco_reg_layout == sp5100) {
+		conflict_addr = mmio_addr ? mmio_addr : alt_mmio_addr;
+		ret = sp5100_tco_reprogram_base(tco, conflict_addr, dev_name);
+		if (ret)
+			dev_err(dev,
+				"Failed to reserve or relocate watchdog MMIO region: %d\n",
+				ret);
+	}
+
 	if (!ret) {
 		/* Setup the watchdog timer */
 		tco_timer_enable(tco);
-- 
2.55.0

