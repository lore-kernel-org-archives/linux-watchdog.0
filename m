Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA066379C24
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787267669; cv=none; b=B1j+chVmOrA28IZN71DZpNRlvrpf2y51zo4fj20nQItYPvgS/2U6+VCohXkAMW9sHv2/npRubpqJ2vK2mW4ZVKw45YG3EMo2i1LHijfrefNUFG+DjQjEfZR1miJr1J8VXU72AQfZdDjPau3hLw3oGcDwxJ1e0cZRhZZACzsLLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787267669; c=relaxed/simple;
	bh=LXG5mF+s1KK8OFrog+E6IQuR1gJwInVZJykEn3GZCl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWf0BQUjoD6RF3yBq9OwImply0QLObtLCJBXCuUEbi6HM0c5v2BSydsa2krhDZ+sR7XoDCC606cYCzid5Y2tXw4uAWAEGtNpy1FzhMIBegx8gOR0C6LdhF7407lJAtrlJzVjlcDRFX4zrPc5rJB0OhDjVsUCgKKyTMjYJxktQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7By7jsa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7By7jsa"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso806312a12.0
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787267664; x=1787872464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNj7O2arqmQbzhzNSTkqZm35vv1TsZYc1Es6LlcrPAI=;
        b=T7By7jsa2TbBMAijgjvG74kMMTAqlpV9EAH/+e3F/QEjz/9/g14oUzRpgAsaMzs8qW
         qhEd9XYUOJLIokNXDj3eKWrvvZ9IKVHGGTccuuifuuoKVjnov+sc3T4Dg0vm3oEoDZyh
         +xa5ZE5g6TO3PmXcDXy03fEovauiepmiQh4YkC8deN4eUQgLsjnIxkFq8xzI+Tr9nDKW
         4ueN1ROpEPdsbd0LVKqyCPVx/juSbdo1c5ga0jHMaznqkth75bGWCLTOsxDaszyBlpu1
         DFRHJZQ4PrbeOSOPCjTVZEVLpH7xF6GWvadspMk11SsAqsSZFw6fb36wSI/EWDtFS0Td
         rj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787267664; x=1787872464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vNj7O2arqmQbzhzNSTkqZm35vv1TsZYc1Es6LlcrPAI=;
        b=cBIsX6c24jRWFc16bptj7DYADnmGXJydyjQ2NDymiv0jTrMK/tckVA9zf7M6PTnjKt
         RtQoTAKIVrMgVLsOTHiFrC5wiFV2efAwznLSI/jfrShRXBlsWe6vFz8wI6lAvxyxq35P
         zBKA+72e//5kUf+J+PgZII7uWbtW/VS7mWQfQrEiIcTiGhIqY1GNgcBOUdRkqTKn/S7Z
         oPKhO7mtDoKOCJSVaK5c6NGdxWkdyCKRX7yIRrpaYHOboa/YBtw7u7dWK+4H6vwa7pns
         PU+1U+O3OtdiKtaaMuTkHAoS9XxKF2SbvlWS9jYcW9CaHcYVdy6n2Sbra5aYyt1VjIJg
         4hgA==
X-Gm-Message-State: AFuF++nux+hVab+G1eKjgM9w+wDciKPXIsnrBng7jm0OtCrMk5/vT62i
	b9rRjsRfsoxochWsicx0BLz0TSMg7Qv1y130RDK6tnL8Ywc662Q0gy7y
X-Gm-Gg: AR+sD10ZMGbYmOE1jmhJO08IOou19k3yphu43X1nLsNct3vmM7k4+Eme4FDLZHxmXe/
	aCByK5H+Hf9YipraBXsVkTDd29NgjtdjT/tJb4qxLtsQahpGvpC3YivHCYvn5W6GPYbdF1C3MBs
	38xoIWgu3xMGQ/w2eqLFo5t92Sn4457XFPCOjGr3ht6wcRbCrPAhSWfD73H2zbDRmuOitW+NKTb
	JWqiLtv/zelSHDi/Ukd5mw/24mgqeop/ldVUfhMS46snGQr7EbOgMXsN2eYXIZ+8OeO5O/d69tE
	MJSnRAovTc93hbz3uQ0hiVKWqVtZBk9ql5EYUowGCeRJ2PXdXBKWwzDMpRxJNRYlWQ+H+lgeBUa
	9uuYtLav6aPlsZcGPRjPcwJANlYklmuM+ng7Yx1nCDxpQNm+TjurV/OfIaLkMmwvUg/4aEnRV0Z
	gQb73IH2/FfHlEYCMEtBpXphyOa2ithjBxfA6xANDY0bkNJph7QDdij5rMq9og03BE9VFVU/BXP
	zHYg3sQ14xnDhbx2NwO4q1WlQ0yLyNDevoTICEZDX8y2i680ns+B5+7kOdk84VupukCqw==
X-Received: by 2002:a05:6402:3818:b0:6a4:cc9:c8f0 with SMTP id 4fb4d7f45d1cf-6a42f16302bmr2050428a12.1.1787267663730;
        Thu, 20 Aug 2026 16:14:23 -0700 (PDT)
Received: from Arbeitszimmer.fritz.box ([2001:9e8:db05:b500:4296:43d1:74f1:665e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff17df84sm3894430a12.31.2026.08.20.16.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:14:23 -0700 (PDT)
From: Christoph Berliner <caberliner@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Berliner <caberliner@gmail.com>
Subject: [PATCH v2] watchdog: sp5100_tco: add reversible legacy MMIO relocation
Date: Fri, 21 Aug 2026 01:14:09 +0200
Message-ID: <20260820231409.8427-1-caberliner@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820222541.16494-1-caberliner@gmail.com>
References: <20260820222541.16494-1-caberliner@gmail.com>
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

When the firmware-provided watchdog address cannot be reserved, search a
bounded 4 KiB range above it for a free, naturally aligned 8-byte MMIO
window. Use devm_request_mem_region() for each candidate so resource-tree
traversal, conflict checking and IORESOURCE_BUSY registration are handled
by the resource core under its lock.

Before reprogramming the watchdog, save the original PM control and base
registers as well as the PCI watchdog decode register. Disable PCI MMIO
decode and the watchdog timer before changing the byte-wise base
registers, avoiding transient decoded addresses while BASE0..3 are being
updated.

Restore the original firmware PM and PCI state on probe failure or device
removal and release the relocated MMIO resource through devres.

On the tested system the complete load/unload lifecycle is:

  firmware:  0xfec000f0, PM control 0x03
  relocated: 0xfec00400, PM control 0x06
  restored:  0xfec000f0, PM control 0x03

The relocated range appears as an exclusive SP5100 TCO resource in
/proc/iomem, /dev/watchdog0 registers successfully, and unloading the
module restores the original firmware state and removes the resource.

A warm reboot with the relocated watchdog loaded was also tested
successfully; the machine booted normally and the firmware watchdog state
after reboot was again 0xfec000f0 with PM control 0x03.

Tested on Linux 7.1.8 with an AMD SBx00 SMBus controller
(PCI 1002:4385, revision 0x3c). The sp5100_tco.c driver in current
mainline is identical to the tested 7.1.8 version.

Signed-off-by: Christoph Berliner <caberliner@gmail.com>
---
Changes in v2:
- replace direct iomem resource-tree traversal with
  devm_request_mem_region(), providing locked conflict handling and
  IORESOURCE_BUSY semantics
- bound the relocation search to a 4 KiB window
- disable PCI watchdog MMIO decode while rewriting BASE0..3
- save and restore the original PCI watchdog decode register
- retain reversible restoration on probe failure and device removal
- hardware-test the updated load/unload lifecycle and a warm reboot

 drivers/watchdog/sp5100_tco.c | 239 +++++++++++++++++++++++++++++++++-
 1 file changed, 235 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 7e99c3b1f367..dbe6946d8f95 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -229,6 +229,215 @@ static void tco_timer_enable(struct sp5100_tco *tco)
 	}
 }
 
+static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
+				   u32 mmio_addr,
+				   u32 alt_mmio_addr,
+				   const char *dev_name,
+				   bool report_error);
+
+#define SP5100_WDT_RELOCATION_RANGE	0x1000
+
+/*
+ * Legacy SP5100/SB7x0 fallback.
+ *
+ * Some firmware uses 0xfec000f0 for the watchdog MMIO window.
+ * This may overlap the IOAPIC resource. Historical Linux versions
+ * relocated the watchdog and reprogrammed PM registers 0x6c..0x6f.
+ */
+static void sp5100_tco_write_pm_reg8(u8 index, u8 val)
+{
+	outb(index, SP5100_IO_PM_INDEX_REG);
+	outb(val, SP5100_IO_PM_DATA_REG);
+}
+
+struct sp5100_tco_relocation {
+	u32 saved_pci_misc;
+	u8 saved_control;
+	u8 saved_base[4];
+	bool programmed;
+	bool restored;
+};
+
+static void sp5100_tco_restore_relocation(struct sp5100_tco_relocation *reloc)
+{
+	u32 val;
+	int i;
+
+	if (!reloc || !reloc->programmed || reloc->restored)
+		return;
+
+	if (!request_muxed_region(SP5100_IO_PM_INDEX_REG,
+				  SP5100_PM_IOPORTS_SIZE,
+				  "sp5100_tco restore"))
+		return;
+
+	/*
+	 * MMIO decode is controlled independently of the PM watchdog-disable
+	 * bit. Disable decode before changing the byte-wise base registers so
+	 * that no intermediate address can become active.
+	 */
+	pci_read_config_dword(sp5100_tco_pci,
+			      SP5100_PCI_WATCHDOG_MISC_REG, &val);
+	pci_write_config_dword(sp5100_tco_pci,
+			       SP5100_PCI_WATCHDOG_MISC_REG,
+			       val & ~SP5100_PCI_WATCHDOG_DECODE_EN);
+
+	sp5100_tco_update_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
+				  0xff,
+				  SP5100_PM_WATCHDOG_DISABLE);
+
+	for (i = 0; i < 4; i++)
+		sp5100_tco_write_pm_reg8(SP5100_PM_WATCHDOG_BASE + i,
+					 reloc->saved_base[i]);
+
+	sp5100_tco_write_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
+				 reloc->saved_control);
+
+	/*
+	 * Restore the firmware-programmed PCI state only after the original
+	 * watchdog base and PM control register have been restored.
+	 */
+	pci_write_config_dword(sp5100_tco_pci,
+			       SP5100_PCI_WATCHDOG_MISC_REG,
+			       reloc->saved_pci_misc);
+
+	reloc->restored = true;
+
+	release_region(SP5100_IO_PM_INDEX_REG,
+		       SP5100_PM_IOPORTS_SIZE);
+}
+
+static void sp5100_tco_release_relocation(void *data)
+{
+	struct sp5100_tco_relocation *reloc = data;
+
+	sp5100_tco_restore_relocation(reloc);
+}
+
+/*
+ * Older SP5100/SB7x0 firmware may place the watchdog MMIO window inside
+ * another reserved resource, historically most notably the IOAPIC area.
+ *
+ * E820 reserved device address ranges are represented as non-busy
+ * containers in the iomem tree. devm_request_mem_region() performs the
+ * resource-tree traversal and conflict checking under resource_lock and
+ * creates an IORESOURCE_BUSY child for a successful reservation.
+ *
+ * Keep the search deliberately local to the firmware-provided address
+ * instead of walking an arbitrarily large reserved address range.
+ */
+static int sp5100_tco_reprogram_base(struct sp5100_tco *tco,
+				     u32 conflict_addr,
+				     const char *dev_name)
+{
+	struct device *dev = tco->wdd.parent;
+	struct sp5100_tco_relocation *reloc;
+	struct resource *res = NULL;
+	resource_size_t candidate;
+	resource_size_t search_end;
+	u32 mmio_addr;
+	u8 base0_reserved;
+	int ret;
+	int i;
+
+	reloc = devm_kzalloc(dev, sizeof(*reloc), GFP_KERNEL);
+	if (!reloc)
+		return -ENOMEM;
+
+	search_end = min_t(resource_size_t, U32_MAX,
+			   (resource_size_t)conflict_addr +
+			   SP5100_WDT_RELOCATION_RANGE);
+
+	candidate = ALIGN((resource_size_t)conflict_addr +
+			  SP5100_WDT_MEM_MAP_SIZE,
+			  SP5100_WDT_MEM_MAP_SIZE);
+
+	for (; candidate <= search_end &&
+	     search_end - candidate + 1 >= SP5100_WDT_MEM_MAP_SIZE;
+	     candidate += SP5100_WDT_MEM_MAP_SIZE) {
+		res = devm_request_mem_region(dev, candidate,
+					      SP5100_WDT_MEM_MAP_SIZE,
+					     dev_name);
+		if (res)
+			break;
+	}
+
+	if (!res) {
+		dev_err(dev,
+			"No free watchdog MMIO slot found within 0x%x bytes of 0x%08x\n",
+			SP5100_WDT_RELOCATION_RANGE, conflict_addr);
+		return -EBUSY;
+	}
+
+	mmio_addr = (u32)res->start;
+
+	/*
+	 * Save all firmware-programmed watchdog and decode state before
+	 * changing anything.
+	 */
+	reloc->saved_control =
+		sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_CONTROL);
+
+	for (i = 0; i < 4; i++)
+		reloc->saved_base[i] =
+			sp5100_tco_read_pm_reg8(SP5100_PM_WATCHDOG_BASE + i);
+
+	pci_read_config_dword(sp5100_tco_pci,
+			      SP5100_PCI_WATCHDOG_MISC_REG,
+			      &reloc->saved_pci_misc);
+
+	ret = devm_add_action_or_reset(dev,
+				       sp5100_tco_release_relocation,
+				       reloc);
+	if (ret)
+		return ret;
+
+	/*
+	 * Disable MMIO decode before byte-wise modification of BASE0..3.
+	 */
+	pci_write_config_dword(sp5100_tco_pci,
+			       SP5100_PCI_WATCHDOG_MISC_REG,
+			       reloc->saved_pci_misc &
+			       ~SP5100_PCI_WATCHDOG_DECODE_EN);
+
+	/* Stop the watchdog timer as well before changing its base. */
+	sp5100_tco_update_pm_reg8(SP5100_PM_WATCHDOG_CONTROL,
+				  0xff,
+				  SP5100_PM_WATCHDOG_DISABLE);
+
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
@@ -256,7 +465,8 @@ static u32 sp5100_tco_request_region(struct device *dev,
 static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
 				   u32 mmio_addr,
 				   u32 alt_mmio_addr,
-				   const char *dev_name)
+				   const char *dev_name,
+				   bool report_error)
 {
 	struct device *dev = tco->wdd.parent;
 
@@ -273,7 +483,9 @@ static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
 		mmio_addr = sp5100_tco_request_region(dev, alt_mmio_addr, dev_name);
 
 	if (!mmio_addr) {
-		dev_err(dev, "Failed to reserve MMIO or alternate MMIO region\n");
+		if (report_error)
+			dev_err(dev,
+				"Failed to reserve MMIO or alternate MMIO region\n");
 		return -EBUSY;
 	}
 
@@ -405,7 +617,7 @@ static int sp5100_tco_setupdevice_mmio(struct device *dev,
 		alt_mmio_addr = EFCH_PM_ACPI_MMIO_ADDR +
 			EFCH_PM_ACPI_MMIO_WDT_OFFSET;
 
-	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name);
+	ret = sp5100_tco_prepare_base(tco, mmio_addr, alt_mmio_addr, dev_name, true);
 	if (!ret) {
 		tco_timer_enable_mmio(addr);
 		ret = sp5100_tco_timer_init(tco);
@@ -428,6 +640,8 @@ static int sp5100_tco_setupdevice(struct device *dev,
 	const char *dev_name;
 	u32 mmio_addr = 0, val;
 	u32 alt_mmio_addr = 0;
+	u32 conflict_addr;
+	bool report_error;
 	int ret;
 
 	if (tco->tco_reg_layout == efch_mmio)
@@ -491,7 +705,24 @@ static int sp5100_tco_setupdevice(struct device *dev,
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

