Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4F31E106
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959103; cv=none; b=IPuavntkqsaLOY+HrtTXA6Tzf1c3Hzw5wu6rJaKI0MFnVZddnXnOyaVBSeSFdYtOFENyx/ruRVXPld26kRXlaXm59YGjKM9DdiQLv9BwI6+pP5YbcBRrI/SW2mjIvyUzNI/KMVTjkSQh5b0uPAFdwjrJNiEg/8IGFpKLb1V0WPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959103; c=relaxed/simple;
	bh=dItVvoClS6AOE3TaSQpuL9pYogFSz5pNFPx/p0TbEiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/T6XhL44O54ltvPDCuHokxkC13iOY0WxM++AVRd0d9YwuZ9V3U2AlOGFB2lEii+1HIKdldgtWBvUtl0ls5Df8/WtA1sFq50pRM7rCYCkwl2+wzR+HVNXNHfJVzh4EYYVNh3MaQthgSiYKAARt43Vnd/06fOpBHKpYbz8JxhFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elBbG6y7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ihn3vtuh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elBbG6y7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ihn3vtuh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692FGqOE1246579
	for <linux-watchdog@vger.kernel.org>; Fri, 2 Oct 2026 16:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vTLMfajcCsI
	mjqxB26wTeOTH8VbKSTRuKEuN26ocKE8=; b=elBbG6y7rUmNTRbxntzMr7doHYC
	e/R4FZVMawbrHz+NYd2U9Rl/Zo2++V4fxqss8oBg4fB1WXO6vtYx/WRYEolS1asw
	3ZTGiA2CghS2vAGcRJeIph5zzAztZK/qelQubrCK3ONaJoJu5zhTk7ppreqr8ZJT
	fRJ6KmZncRbFCsvIx2rD7o3ltfM84sEha3wIraCl4b2BZoAFF/JdUgYvJ99cxe8n
	q3aw6/6vgbk2su/Nix8m3ZmgP+mM6gWbOAM9+DicrdO4lzNjdSorZS+A7Q2CRceD
	RPLDjvUZmNogCYTfXNK+9Rb2iNN5YEpxJL8tChNOeA/zTyB0ybvkACsBl1Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d8c0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 16:38:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34ef5fd7934so2195361eec.0
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790959100; x=1791563900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTLMfajcCsImjqxB26wTeOTH8VbKSTRuKEuN26ocKE8=;
        b=ihn3vtuhxJiN9iTBCnjmgFoZS6GkmZNUXyp/pPsVJwuV8FgH9O0LE0uZmz4Fd5vTDs
         +nhyApbHoPHMikODe9Nkzp1vIYTugm2xqRkgC46FbN2cs9mDDX2RdWZCc+VD/9aAYNhi
         ElFwDVPtJJFALEkAaG6HEEB+8X6uIweAzPf+bu8VYmPOGY8Uxo15ssSrbP783WuS1LN1
         jNtLtkGKqm0NuNnmZEUszSjIRg8VUrCWY9zlpEBG7TMhios68ydp8wBw1jX9tr+LfI70
         ibc0Knv1nHeFuk5FfvC+a0WFMgx/t97LlRqJIIj+K/G8iAliTrfGITPxVj4qjiC/Lz/I
         brgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959100; x=1791563900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vTLMfajcCsImjqxB26wTeOTH8VbKSTRuKEuN26ocKE8=;
        b=H3A4QbeCd/RdbxXx+1hukhooe3VfzLGJeK4xuqVFuI4iO6DIauwzZF1s/v2F69YnZl
         6wXnbTMssno5jCROGf5WpU1nOX8wZL2qdskYFPlmuWrHsF+YqpoyjILIs3EUTH2fT2an
         r8sPA2StuZfdeAEYySfB9ZELiV7XdUVJINaolV1XYI48rr0Hg0Lzv8yPTYLAZGmb2glD
         f9g/Is6Mb0WGO+I9d9/UVkfJoXVMrxM6pqUwF/hJgTHrvDME7qtmHJMahg0OvCzeRYlN
         Iafqu4TQ0VPDsqUidTxwRwjfQ/TubjLzz9PylrvV+3TrJwp8nUjdfKjE0FItfsvPdFGN
         uC8g==
X-Forwarded-Encrypted: i=1; AKwUvBxxRr5dok/IFKXo6mDw2OtNBuBtNZ5vC4O5nBjOXMD+/504ynIjaAbjjbbL8+CCFhcnbjB9aU/Q60tMMQws0w==@vger.kernel.org
X-Gm-Message-State: AFuF++mAX3kmwqpi58ULbgpL+nlfKxI27iQeDzZMwMqjLrCEPpO2fTjD
	lk8QHeXHcpS9RaI1kZj00/b37mGj0ZNhbVNSVe/9ayZ0zhdOuqAsGD4hUIZXzh9rPD6k2FxfbMs
	eAPmXYHFSCVX/8w7Rw4liNXbA7MibdHxSotlfKWiTGBZGI9obvPm33yToCWWA1ERAncC1IA==
X-Gm-Gg: AYBFou20627dnVIbQ7S7EA9nPO7mzLsNZPjcmTBGM6ENGer9E2hJwyr23hGal/u7czl
	Y7fJmNrNMxypJLJYsFBeCCGajj77JdHkJdldK+2HpQbT5AhKn+wIqTXZAEn3OzTod+9Gwobg4Yw
	hKd2dDeJtgcPgRDIkaBQbNxKa/avOehXufphcm2/2u0ZTfhq868WnI887BigTWwoPJRXStHvGjv
	eygKWvJr2PrxUEhIg8d2Y50+ivKUVruGj5Mgd9+KFuAoTW19DW9VzJ6uF6zHWmDVrb60S51S+12
	EV+pzs5T8wT/gFrRhWCpRuhOo33kUWZ5p9TBsHCKxnrpRxXTH0t88Mo04/5faPteL+UPdMqTLGv
	COGlSSTjGivdln2L6GqOQ2pgZZaP/cSrcUNxSv+9HdeDyNi5a1tA64zMF9OCb8+3e9fZB6HmF+c
	ONfcN2J/X7sjWy
X-Received: by 2002:a05:7301:1526:b0:33e:451e:c8b2 with SMTP id 5a478bee46e88-34f21972333mr3290076eec.37.1790959099993;
        Fri, 02 Oct 2026 09:38:19 -0700 (PDT)
X-Received: by 2002:a05:7301:1526:b0:33e:451e:c8b2 with SMTP id 5a478bee46e88-34f21972333mr3290049eec.37.1790959099386;
        Fri, 02 Oct 2026 09:38:19 -0700 (PDT)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd5620sm7756398eec.21.2026.10.02.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:38:19 -0700 (PDT)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net, anup@brainfault.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, prajwal.n.oss@gmail.com,
        Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
Date: Fri,  2 Oct 2026 22:07:58 +0530
Message-ID: <20261002163758.2919372-3-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
References: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7laj597I0EHa9CO92ljAhO03wh-pAfEx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX44NHu8GkyLsy
 ae7oySHaUrCC/aWagTspk0b9nkz4aMheCIbNPXLdKTteTGOgcA0f5TUDJqmqffkRM0upUYEs+ff
 sQjHVV9iF0ffP3yhPgS8GtETv6eMDOY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfXyZKTvKB29pDP
 ab+2oyvyYsKhL97qCHy6obHoncKZbzOv5KTIIKRSZfScH+E+RKp95rvlBQuHmE5iTt1AUgopbM0
 50zozkAQrBmb/PBA37KLWV3OjtDfXeRVkGTw69s59bzg7dvMU4BJ7xP4lwSvEPcWGigsKnsnZTo
 arrmD3KrcccpAPGRwTn7B+KfZAOVsPyQ49fPcJBICYEd80r7qgq7+hBQR/NQo4wRvBCko6Hshaj
 64YY4kin+pDtmOgcAzmcFHK5kMROczIPgX/JnL1PjF+7ox0ouwVQDwrVHDYSczsKkCwk0K0KteK
 Z8mQkzcC3s0PubsEhTzVwQpS9WwSjMVqJelkJFbHiArd3JZQkIZYv6LB68yk7wcdR9/bpxR6ROk
 xEk8+bdozFYt4pBj8+gQ7X9q/t+1qSUwJGQfupHUFVRk0MnXQkweB+psPW03P9zPZe5FQOtvr1C
 091Pb6MHpDDR5hSQOEQ==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfddfc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0SxRSwYGAAAA:8 a=22yyh5sOeYvUcQn6--4A:9 a=O8hF6Hzn-FEA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=evtWB9OUeeBtXImRToD_:22
X-Proofpoint-ORIG-GUID: 7laj597I0EHa9CO92ljAhO03wh-pAfEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020066

Add the RISCV_SBI_WATCHDOG Kconfig option, which depends on
RISCV and RISCV_SBI support.

Add a watchdog driver for the RISC-V SBI watchdog extension.
The driver integrates with the Linux watchdog framework to
configure and control the watchdog. The driver invokes the
SBI watchdog using the standard SBI calls.

Support pretimeout event notifications using Message Signaled
Interrupts (MSIs).

Signed-off-by: Prajwal N <prajwal.n@oss.qualcomm.com>
---
 drivers/watchdog/Kconfig         |   9 +
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/riscv_sbi_wdt.c | 406 +++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/watchdog/riscv_sbi_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c0ef..69dce9b7f164 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2164,6 +2164,15 @@ config STARFIVE_WATCHDOG
 	  Say Y here to support the watchdog of StarFive JH7100 and JH7110
 	  SoC. This driver can also be built as a module if choose M.
 
+config RISCV_SBI_WATCHDOG
+	tristate "RISC-V SBI based Watchdog support"
+	depends on RISCV_SBI
+	default RISCV
+	help
+	  Say Y here to include support for a watchdog timer
+	  implemented by the Supervisor Binary Interface on RISCV platforms.
+	  Requires firmware support.
+
 # S390 Architecture
 
 config DIAG288_WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9ac406677aba..c20c43f06ed0 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -202,6 +202,7 @@ obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
 # RISC-V Architecture
 obj-$(CONFIG_ATCWDT200_WATCHDOG) += atcwdt200_wdt.o
 obj-$(CONFIG_STARFIVE_WATCHDOG) += starfive-wdt.o
+obj-$(CONFIG_RISCV_SBI_WATCHDOG) += riscv_sbi_wdt.o
 
 # S390 Architecture
 obj-$(CONFIG_DIAG288_WATCHDOG) += diag288_wdt.o
diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sbi_wdt.c
new file mode 100644
index 000000000000..f492deceda61
--- /dev/null
+++ b/drivers/watchdog/riscv_sbi_wdt.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V SBI watchdog driver
+ *
+ * Copyright (C) 2026 Qualcomm Inc.
+ */
+
+#include <linux/device.h>
+#include <asm/sbi.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+#include <linux/msi.h>
+#include <linux/kernel.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/riscv-imsic.h>
+
+#define DRV_NAME            "riscv-sbi-wdt"
+#define DRV_VERSION         "1.0"
+
+/* Watchdog default timeout in seconds */
+#define SBI_WDT_DEFAULT_TIMEOUT         60
+
+/* MSI capability mask */
+#define SBI_WDT_CAP_MSI_SUPPORT_MASK         BIT(1)
+
+/* Convert second to microsecond */
+static inline u32 sec_to_usec(unsigned int sec)
+{
+	return (u32)(sec * 1000000ULL);
+}
+
+/* Convert microsecond to second and ceil the result */
+static inline unsigned int usec_to_sec_ceil(u32 usec)
+{
+	return (unsigned int) DIV_ROUND_UP_ULL(usec, 1000000ULL);
+}
+
+/* Convert microsecond to second and floor the result */
+static inline unsigned int usec_to_sec(u32 usec)
+{
+	return (unsigned int) (usec / 1000000ULL);
+}
+
+/* SBI watchdog attributes */
+struct sbiwdt_attributes {
+	/* MSI and SSE capability flags */
+	u32 wdt_capability;
+	/* Watchdog state */
+	u32 wdt_state;
+	/* Minimum watchdog timeout supported in us */
+	u32 wdt_min_period;
+	/* Watchdog timeout period in us */
+	u32 wdt_period;
+	/* Time left until watchdog expiry in us */
+	u32 wdt_time_left;
+	/* Watchdog pretimeout in us */
+	u32 wdt_notif_time;
+	/* MSI target address low 32-bit */
+	u32 wdt_notif_msi_addr_low;
+	/* MSI target address high 32-bit */
+	u32 wdt_notif_msi_addr_high;
+	/* MSI data */
+	u32 wdt_notif_msi_data;
+};
+
+/* SBI watchdog global structure */
+struct sbiwdt {
+	/* Kernel watchdog instance */
+	struct watchdog_device          wdd;
+	struct device                   *dev;
+	struct sbiwdt_attributes        attrs;
+	int                             virq;
+};
+
+/* Watchdog pretimeout expiry handler */
+static irqreturn_t sbiwdt_pretimeout_handler(int irq, void *dev_id)
+{
+	struct sbiwdt *wdt = dev_id;
+
+	watchdog_notify_pretimeout(&wdt->wdd);
+
+	return IRQ_HANDLED;
+}
+
+/* Read watchdog attribute */
+static int sbiwdt_read_attribute(enum sbi_ext_attribute_id attr_id, u32 *attr_val)
+{
+	struct sbiret sret;
+
+	sret = sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_READ_ATTRIBUTE, attr_id, 0, 0, 0, 0, 0);
+	*attr_val = sret.value;
+
+	return sbi_err_map_linux_errno(sret.error);
+}
+
+/* Write watchdog attribute */
+static int sbiwdt_write_attribute(enum sbi_ext_attribute_id attr_id, u32 val)
+{
+	struct sbiret sret;
+
+	sret = sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_WRITE_ATTRIBUTE, attr_id, val, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(sret.error);
+}
+
+/* Write the MSI address and data attributes in one SBI call*/
+static int sbiwdt_write_notif_msi_message(u32 msi_addr_low, u32 msi_addr_high, u32 msi_data)
+{
+	struct sbiret sret;
+
+	sret = sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_WRITE_NOTIF_MSI_MESSAGE, msi_addr_low,
+								msi_addr_high, msi_data, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(sret.error);
+}
+
+/* Start the watchdog */
+static int sbiwdt_start(struct watchdog_device *wdd)
+{
+	struct sbiret sret;
+
+	sret = sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_START, 0, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(sret.error);
+}
+
+/* Stop the watchdog */
+static int sbiwdt_stop(struct watchdog_device *wdd)
+{
+	struct sbiret sret;
+
+	sret = sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_STOP, 0, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(sret.error);
+}
+
+/* Pat the watchdog */
+static int sbiwdt_pat(struct watchdog_device *wdd)
+{
+	struct sbiret sret;
+
+	sret = sbi_ecall(SBI_EXT_WDT, SBI_EXT_WATCHDOG_PAT, 0, 0, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(sret.error);
+}
+
+/* Set the watchdog timeout value */
+static int sbiwdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
+{
+	struct sbiwdt *wdt = watchdog_get_drvdata(wdd);
+	u32 period_usec;
+	int ret;
+
+	period_usec = sec_to_usec(timeout);
+
+	ret = sbiwdt_write_attribute(SBI_WDT_PERIOD, period_usec);
+	if (ret)
+		return ret;
+
+	wdt->attrs.wdt_period = period_usec;
+	wdt->wdd.timeout = timeout;
+
+	return 0;
+}
+
+/* Set the watchdog pretimeout value*/
+static int sbiwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int pretimeout)
+{
+	struct sbiwdt *wdt = watchdog_get_drvdata(wdd);
+	u32 notif_time_usec;
+	int ret;
+
+	if (pretimeout >= wdd->timeout)
+		return -EINVAL;
+
+	notif_time_usec = sec_to_usec(pretimeout);
+	ret = sbiwdt_write_attribute(SBI_WDT_NOTIF_TIME, notif_time_usec);
+	if (ret)
+		return ret;
+
+	wdt->wdd.pretimeout = pretimeout;
+	wdt->attrs.wdt_notif_time = notif_time_usec;
+
+	return ret;
+}
+
+/* Get the watchdog timeleft before expiry */
+static unsigned int sbiwdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct sbiwdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned int time_left_usec;
+	int ret;
+
+	ret = sbiwdt_read_attribute(SBI_WDT_TIME_LEFT, &time_left_usec);
+	if (ret) {
+		dev_err(wdt->dev, "Failed to read watchdog time left: %d\n", ret);
+		return 0;
+	}
+
+	return usec_to_sec(time_left_usec);
+}
+
+static const struct watchdog_info sbiwdt_info = {
+	.options	=	WDIOF_SETTIMEOUT	|
+				WDIOF_KEEPALIVEPING	|
+				WDIOF_PRETIMEOUT	|
+				WDIOF_MAGICCLOSE,
+	.identity	=	DRV_NAME,
+};
+
+static const struct watchdog_ops sbiwdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= sbiwdt_start,
+	.stop		= sbiwdt_stop,
+	.ping		= sbiwdt_pat,
+	.set_timeout	= sbiwdt_set_timeout,
+	.set_pretimeout	= sbiwdt_set_pretimeout,
+	.get_timeleft	= sbiwdt_get_timeleft,
+};
+
+/* The callback function from IMSIC containing the MSI address and data */
+static void sbiwdt_msi_write(struct msi_desc *desc, struct msi_msg *msg)
+{
+	int ret;
+	struct device *dev = msi_desc_to_dev(desc);
+	struct sbiwdt *wdt;
+
+	if (!dev || !msg)
+		return;
+
+	wdt = dev_get_drvdata(dev);
+	if (!wdt) {
+		dev_err(dev, "Missing SBI watchdog driver data\n");
+		return;
+	}
+
+	/* Store MSI info in attributes*/
+	wdt->attrs.wdt_notif_msi_addr_low = msg->address_lo;
+	wdt->attrs.wdt_notif_msi_addr_high = msg->address_hi;
+	wdt->attrs.wdt_notif_msi_data = msg->data;
+
+	/* Pass the MSI attribute values to OpenSBI */
+	ret = sbiwdt_write_notif_msi_message(wdt->attrs.wdt_notif_msi_addr_low,
+						wdt->attrs.wdt_notif_msi_addr_high,
+						wdt->attrs.wdt_notif_msi_data);
+	if (ret) {
+		dev_err(dev, "Failed to configure watchdog MSI: %d\n", ret);
+		return;
+	}
+}
+
+/* Initialize the watchdog attributes */
+static int sbiwdt_init_attributes(struct sbiwdt *wdt)
+{
+	int ret;
+	u32 attr_val;
+	u32 timeout_usec;
+
+	/* Read watchdog capability from firmware */
+	ret = sbiwdt_read_attribute(SBI_WDT_CAPABILITY, &attr_val);
+	if (ret)
+		return ret;
+
+	wdt->attrs.wdt_capability = attr_val;
+
+	/* Read watchdog min period supported in firmware */
+	ret = sbiwdt_read_attribute(SBI_WDT_MIN_PERIOD, &attr_val);
+	if (ret)
+		return ret;
+
+	if (!attr_val)
+		attr_val = 1;
+
+	wdt->attrs.wdt_min_period = attr_val;
+	wdt->wdd.min_timeout = usec_to_sec_ceil(wdt->attrs.wdt_min_period);
+
+	/* Initialize the watchdog timeout to default value */
+	timeout_usec = sec_to_usec(SBI_WDT_DEFAULT_TIMEOUT);
+	ret = sbiwdt_write_attribute(SBI_WDT_PERIOD, timeout_usec);
+	if (ret)
+		return ret;
+
+	wdt->attrs.wdt_period = timeout_usec;
+	wdt->wdd.timeout = SBI_WDT_DEFAULT_TIMEOUT;
+
+	/* Initialize the pretimeout to default value */
+	wdt->attrs.wdt_notif_time = 0;
+	wdt->wdd.pretimeout = 0;
+
+	return 0;
+}
+
+static int sbiwdt_probe(struct platform_device *pdev)
+{
+	struct sbiwdt *wdt;
+	struct imsic_global_config *imsic_global;
+	struct irq_domain *msi_domain;
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	/* Allocate memory for the global watchdog structure */
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, wdt);
+	watchdog_set_drvdata(&wdt->wdd, wdt);
+
+	/* Initialiaze watchdog attributes */
+	rc = sbiwdt_init_attributes(wdt);
+	if (rc) {
+		dev_err(dev, "Failed to read SBI watchdog attributes: %d\n", rc);
+		return rc;
+	}
+
+	wdt->wdd.info = &sbiwdt_info;
+	wdt->wdd.ops = &sbiwdt_ops;
+
+	/* Setup MSI if the capability is available */
+	if (wdt->attrs.wdt_capability & SBI_WDT_CAP_MSI_SUPPORT_MASK) {
+		imsic_global = imsic_get_global_config();
+		if (!imsic_global) {
+			dev_err(dev, "IMSIC firmware node is unavailable\n");
+			return -ENODEV;
+		}
+
+		msi_domain = irq_find_matching_fwnode(imsic_global->fwnode,
+							DOMAIN_BUS_PLATFORM_MSI);
+
+		if (!msi_domain) {
+			dev_err(dev, "IMSIC platform MSI domain is unavailable\n");
+			return -ENODEV;
+		}
+
+		dev_set_msi_domain(&pdev->dev, msi_domain);
+
+		/* MSI setup*/
+		rc = platform_device_msi_init_and_alloc_irqs(dev, 1, sbiwdt_msi_write);
+		if (rc) {
+			dev_err(dev, "Failed to allocate MSIs\n");
+			return rc;
+		}
+
+		wdt->virq = msi_get_virq(dev, 0);
+		if (!wdt->virq) {
+			dev_err(dev, "Failed to get MSI virtual IRQ: %d\n", wdt->virq);
+			return wdt->virq;
+		}
+
+		rc = devm_request_irq(dev, wdt->virq,
+					sbiwdt_pretimeout_handler,
+					0, "sbiwdt-pretimeout", wdt);
+		if (rc) {
+			dev_err(dev, "Failed to request pretimeout IRQ: %d\n", rc);
+			return rc;
+		}
+	}
+
+	rc = devm_watchdog_register_device(dev, &wdt->wdd);
+	if (rc) {
+		dev_err(dev, "Failed to register RISC-V SBI watchdog device\n");
+		return rc;
+	}
+
+	dev_info(&pdev->dev, "RISC-V SBI Watchdog registered\n");
+
+	return 0;
+}
+
+static struct platform_driver sbiwdt_driver = {
+	.probe  = sbiwdt_probe,
+	.driver = {
+			.name = DRV_NAME,
+	},
+};
+
+static int __init sbiwdt_init(void)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	/* Probe for SBI WDT extension */
+	if (sbi_spec_version < sbi_mk_version(3, 0) ||
+		sbi_probe_extension(SBI_EXT_WDT) <= 0) {
+		return -ENODEV;
+	}
+
+	ret = platform_driver_register(&sbiwdt_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&sbiwdt_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+late_initcall(sbiwdt_init);
-- 
2.43.0

