Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109464DA548
	for <linux-watchdog@vger.kernel.org>; Fri, 21 Aug 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322324; cv=none; b=A41sc52kmOXnJUpS04N95AdSlFnMPcjuhRaiLdkuOopaj20eAtSEwqqF18dkfrjmENXGCh5ht2vavURg63p+OLyQWfeAbVhntQdMd/qfeW7F28a6crauNfApr23IlPL6I/QuA8L47lHbQ7L0NQXeU7P6qnnKr47XldsNJMixDjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322324; c=relaxed/simple;
	bh=7JV4nXUjZAoRBcGumksx0+ndKmHIY3HiRQBLnDLHigY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMiVik+c8u/SHrBwnmq5mD+pm6eO+Vy4kuWDxoCsKZnflM4Rfon5p/JHNNfzUQ2wZrazFmezTfHu4D69Mj8go1uEJmB3FNGsJugGmbX3HjSqnRh/mc+kT3Ud4IEhAtyGIcPkI/FUVFTRGEi/o6HKWL6Sl2OaviIBJsFXWs8Bybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB50uZew; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB50uZew"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2055f5a993so125561666b.2
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Aug 2026 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322321; x=1787927121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ghfr0i78CUZ4Akb16hbS992NQfKQCN5UasulxqlP14I=;
        b=VB50uZew6v4dk/2rf9Ca3asWiVeQXdTYR/JnD9exqztcvZkikMc9FTFfHCHiziwYSE
         QyxVuseCfXqcTs4VcBFbPgwp6w4lUxDMmBhm5avxPndTKHU0Q8wv2MUehB9v39FyE3hq
         +HHB3Fcr+hwDeF/pAGrFtl0wSlZ5XiB0ryWk7IO8bTOm8y8lAib4FKgwSmdznmIo08ni
         pJ1aWp1gv74tyy3/CUauGv2sOzSD/vacj4ivS02AEoIVvg+abi2dkMDS4V0rWQdLchXP
         +SFXIp+dGEjkPA25XTn6o25eFUYpuPJWkiy70tloqNe7a2kWIV4szFMBnxaGQbLSKWpQ
         trHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322321; x=1787927121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ghfr0i78CUZ4Akb16hbS992NQfKQCN5UasulxqlP14I=;
        b=BqUyx9gHQQ+8wzNuELcUsEH/T6wxw3XJJ9VB+3yEVpMdA+cawAT1M32W7V15aSkS/r
         XMWsqKRjssckHsY4PrQksHeGFMqwItvxSqVpGKRMeGsHUrXhLUdBmatPClCG+wUHHGaO
         eqi6+OVE4tt995nEoSiun+TPs+3+OJb5wqwdMJl1g5+Op8LlifG2mFkvHv1ssqP5xR9t
         CmysIFLg8bgnZlGRgc891hOxoKVpUxPgxL8E6GgIRLjrCp4eKY7UZLfjSPkkndzpaUSW
         Apn8UUCck2uhffWmmmzHXl8UIf0Nkx5qbW7bLyh9tyvXqMluWeORm/VAsE2c/Mz+X1Wq
         0LFw==
X-Gm-Message-State: AFuF++nVSAz1NuWqatEMS0UGO1+4V6gntkGYTFzwif21Gq3s+H7koyf2
	q5po5HMcrr01q5XK8biqfqYhWHq74joJJN1RGwZxlxjF82drprkU6kWYanE/iA==
X-Gm-Gg: AR+sD12AAtX4NGljD3Z4Ycm0AXJ9U1L461VKTOW+9VlWHxaz7+Dw+L+3VTUgbGHeK0w
	O/MQlwhh+6+4IyJZPO8qheg/FjTeAfDQVSYszMK0DxevS2nA4X4pvWwjDTcvyrsCVImmVcuy3aA
	Vz5LlTY27SZddI6GH3ACNabWKa8gjhoCDHOXUZERxa3Ir0f7SejF3XWVFuj8Nu/e555QGJcmMZd
	7qLkCWtwWlmeLxCDg+4o2VyMBE2RCCmddtDHZ55l1wQpUTCF96z0iC/aUjzx8wb2lTMnsmuiAq5
	coOClEdz3m1q3Gj6y8+cpGnhyVTX34dEZVV6dqDsaTa99eMXwOXnvNjoG5VC7AGifP1hTr/yxEh
	qo2dBCExGq66v6xmkTDW6ADUov055o1YH6Gm1RoLm2XShGOj1U/HaNAsr4UHRy1/xw8pJhIrrrx
	7Rd0oRf0n2z+sLnxDzHGM2oDVWKeSoRJ+6IUFilCi/V0yQHZsmiIc2D3IMHIphcOsRhuIL7ODUH
	WAIeKqTDUQckWyZlFARPmWKmWPx1WXGhtgmzz7eOMW2kkt043TSgN6xy5ln/X08/aap
X-Received: by 2002:a17:907:d08c:b0:c16:8931:245c with SMTP id a640c23a62f3a-c246a72fdcdmr706454866b.21.1787322320902;
        Fri, 21 Aug 2026 07:25:20 -0700 (PDT)
Received: from Arbeitszimmer.fritz.box ([2001:9e8:db15:b000:a01f:964b:34ea:c4dc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e1ab3sm546904466b.4.2026.08.21.07.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:25:20 -0700 (PDT)
From: Christoph Berliner <caberliner@gmail.com>
To: linux@roeck-us.net,
	wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Berliner <caberliner@gmail.com>
Subject: [PATCH v3] watchdog: sp5100_tco: allow unreserved MMIO on GA-78LMT-USB3
Date: Fri, 21 Aug 2026 16:25:11 +0200
Message-ID: <20260821142511.49934-1-caberliner@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820231409.8427-1-caberliner@gmail.com>
References: <20260820231409.8427-1-caberliner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Gigabyte GA-78LMT-USB3 firmware programs the legacy SP5100
watchdog MMIO window at 0xfec000f0. This address falls inside the
IOAPIC resource, so sp5100_tco fails to reserve it and aborts probing.

Do not relocate or reprogram the watchdog. Instead, add a narrowly
scoped DMI quirk for this board which permits use of the
firmware-provided MMIO address without reserving it.

The exception is limited to the legacy SP5100 register layout, the
GA-78LMT-USB3 DMI identity, and the firmware address 0xfec000f0.
All other systems retain the existing resource reservation behavior.

On the affected system the watchdog initializes successfully and
/dev/watchdog0 is registered while the firmware-programmed watchdog
base remains unchanged at 0xfec000f0 during load and unload.

Tested on a Gigabyte GA-78LMT-USB3 with AMD SBx00 SMBus controller
(PCI 1002:4385, revision 0x3c).

Signed-off-by: Christoph Berliner <caberliner@gmail.com>
---
Thanks Guenter. I reworked the patch along the lines you suggested.

v3 is a complete replacement of the v2 relocation approach. None of the
relocation code from v2 is retained.

Instead, v3 adds a narrowly scoped DMI quirk for the affected
GA-78LMT-USB3. On that system, and only for the legacy SP5100 register
layout with the firmware-programmed watchdog address 0xfec000f0, the
driver is allowed to map and use the existing watchdog MMIO window
without reserving it.

The watchdog base is not relocated or reprogrammed. All other systems
retain the existing resource reservation behavior.

I tested the new path on the affected machine and again from a fresh
clone of the published GitHub repository. The watchdog initializes
successfully and /dev/watchdog0 is registered, while the firmware MMIO
base remains unchanged at 0xfec000f0 before, during and after driver use.
No separate SP5100 TCO resource is added to /proc/iomem.

Changes in v3:
- replace the v2 relocation approach entirely; none of the relocation
  code from v2 is retained
- add a DMI quirk for the affected Gigabyte GA-78LMT-USB3
- allow the firmware-programmed 0xfec000f0 watchdog window to be used
  without reserving it
- restrict the exception to the legacy SP5100 register layout and the
  known firmware address
- leave all other systems on the existing resource reservation path
- hardware-test the new path and verify that the watchdog MMIO base
  remains unchanged

 drivers/watchdog/sp5100_tco.c | 61 ++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 7e99c3b1f367..6c85f11cff24 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -33,6 +33,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
+#include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -240,6 +241,35 @@ static u32 sp5100_tco_read_pm_reg32(u8 index)
 	return val;
 }
 
+/*
+ * The Gigabyte GA-78LMT-USB3 firmware programs the legacy SP5100 watchdog
+ * MMIO window at 0xfec000f0. This address lies inside the IOAPIC resource,
+ * so the generic resource reservation fails even though firmware explicitly
+ * assigns the watchdog to this address.
+ *
+ * Keep this exception narrowly scoped to the affected system and firmware
+ * address. Do not relocate or otherwise reprogram the watchdog.
+ */
+#define SP5100_WDT_GA78LMT_MMIO	0xfec000f0
+
+static const struct dmi_system_id sp5100_tco_unreserved_mmio_dmi[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gigabyte Technology Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GA-78LMT-USB3"),
+		},
+	},
+	{}
+};
+
+static bool sp5100_tco_allow_unreserved_mmio(struct sp5100_tco *tco,
+					     u32 mmio_addr)
+{
+	return tco->tco_reg_layout == sp5100 &&
+	       mmio_addr == SP5100_WDT_GA78LMT_MMIO &&
+	       dmi_check_system(sp5100_tco_unreserved_mmio_dmi);
+}
+
 static u32 sp5100_tco_request_region(struct device *dev,
 				     u32 mmio_addr,
 				     const char *dev_name)
@@ -259,6 +289,7 @@ static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
 				   const char *dev_name)
 {
 	struct device *dev = tco->wdd.parent;
+	bool reserved = false;
 
 	dev_dbg(dev, "Got 0x%08x from SBResource_MMIO register\n", mmio_addr);
 
@@ -266,11 +297,29 @@ static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
 		return -ENODEV;
 
 	/* Check for MMIO address and alternate MMIO address conflicts */
-	if (mmio_addr)
-		mmio_addr = sp5100_tco_request_region(dev, mmio_addr, dev_name);
+	if (mmio_addr) {
+		u32 requested_addr;
+
+		requested_addr = sp5100_tco_request_region(dev, mmio_addr,
+							   dev_name);
+		if (requested_addr) {
+			mmio_addr = requested_addr;
+			reserved = true;
+		} else if (sp5100_tco_allow_unreserved_mmio(tco, mmio_addr)) {
+			dev_info(dev,
+				 "Using firmware watchdog MMIO 0x%08x without reserving it\n",
+				 mmio_addr);
+		} else {
+			mmio_addr = 0;
+		}
+	}
 
-	if (!mmio_addr && alt_mmio_addr)
-		mmio_addr = sp5100_tco_request_region(dev, alt_mmio_addr, dev_name);
+	if (!mmio_addr && alt_mmio_addr) {
+		mmio_addr = sp5100_tco_request_region(dev, alt_mmio_addr,
+						      dev_name);
+		if (mmio_addr)
+			reserved = true;
+	}
 
 	if (!mmio_addr) {
 		dev_err(dev, "Failed to reserve MMIO or alternate MMIO region\n");
@@ -280,7 +329,9 @@ static u32 sp5100_tco_prepare_base(struct sp5100_tco *tco,
 	tco->tcobase = devm_ioremap(dev, mmio_addr, SP5100_WDT_MEM_MAP_SIZE);
 	if (!tco->tcobase) {
 		dev_err(dev, "MMIO address 0x%08x failed mapping\n", mmio_addr);
-		devm_release_mem_region(dev, mmio_addr, SP5100_WDT_MEM_MAP_SIZE);
+		if (reserved)
+			devm_release_mem_region(dev, mmio_addr,
+						SP5100_WDT_MEM_MAP_SIZE);
 		return -ENOMEM;
 	}
 
-- 
2.55.0

