Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572380;
	b=Wb3eFjXMbK1KDOAvhT5r/lRAKmbCggGZuJywojEBnHhsol72KwgQgfgSusr8dNlNoRWJ
	 XHsc0uPJzutG7kuvmtYed58cB4Fz5RnkNrG1IUUnHsAd0hNoU3LuP7N7uDf32HuE8eRJz
	 qAjy9vpM/+PVQotp/H1SaiLGfKUHQNfOgj7OAbZmVAuyhWuN5heFoZq+kt3sg4+KdeFF8
	 VX/GYDN8a7EVt0aZ/TleFopFlde/cKCSfWr3mXAAZD+TsldnmtxKDv6nF47heLWRIo8A7
	 ljnGr5cfRrPRh4voFem/73PsqyG6YGfNSbyZXasAGrx/UljBAxA6Dc0MNOohPziLHzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572380;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=B/nngffQbnxE8edZgYDkfDF569XKTL0+U5/3nMBa/VQ=;
	b=x5besFHAWA9EGmMh5sEbLBNGobezgOI0sjQNBUkGeu9R3OOTWJrE5uED7PiTA//eTFv+
	 Oov0LbJoR9676GzRTkd4dU0uGyxChpBelGiOGgx9NwI/yuWjcEz2t5lbFtEWsGOC8ClLB
	 urL/4g5pQqjlTD8631riSBfoGY+PzBEWUrvgGUj993fiP01dsSXAVn6STkT/gmRxRJ1xn
	 WLpfHyIHUj6mS06Wa4hpTmnVH7fBZkOL7H8TZAZ0ALuXbLxgalhNJ7/gnhctiNjY0i7pS
	 VWO2gcCeCX5k/jU6NyWiV4WRo/MrV1ITqrszmLpRLMqgrXCtk/zuHjDYZ8iQgdztGnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bCK+OWp0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ehmISyHy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64025606A332
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64025606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bCK+OWp0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ehmISyHy
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJdS6689076
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B/nngffQbnx
	E8edZgYDkfDF569XKTL0+U5/3nMBa/VQ=; b=bCK+OWp0G5lHhVe6YfUnn5l7N+C
	pA1AG8jbKad8bV0AqIqT6P9gVCl7OQAxy5M9MZAbXq5vXEsetliPTbcBNHWdV8Mj
	WE9GFw4V0Qag4OfOAbdAF370oEeGb5nxpHrCw4OPR0iViCWzygPIkCImHhMPTtUK
	LiQeHwjUmWZTIoC/DE3yUPQoL9xdZejvYghofWFw0zS19SE4XNceA+eSuqEhpCOv
	3Y10/omFZGSFj9vlf5q3e7c8Q5nhz7VzAU678iySXg4tPwTme37bBTv9xPEIbCtg
	uzYAaDQfUMdCMGKqfvLWMiqdvvgpUqbluy1vwKqkOBlnE/xPTzPn8r/2O3A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufj946-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1390845eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794572379; x=1795177179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/nngffQbnxE8edZgYDkfDF569XKTL0+U5/3nMBa/VQ=;
        b=ehmISyHyu7lEZwzXOwbLuzgmuep+B4OeRA6R4wnbsgvw4iqYRiGNLH1Y3Dhetdb7be
         DdXawlx8iqURsiosDbtghw0rseGePoNn/3Digj3+cyOkuYv7k9E9Z+vuKmnDSCqGRaHi
         PN4VQUkoR3LepRfpcnEPGNxLBYizTS/hRNl2mZZYsQH3imffQEcZ3I0vBYyDMk2bEA8+
         TEfrr6mRLgF2vfEhV4KyuRlYVXlEC2YKd+ATxrRIyKGqzOiq1VNdXNukCz94Fo1mICPn
         O5CM/gKrmtickwcy3CjxKWX9s6xF2Rl/IkbibTiT9twuKese7Hz5IQH3ZOQWWJUqfFp0
         4tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572379; x=1795177179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B/nngffQbnxE8edZgYDkfDF569XKTL0+U5/3nMBa/VQ=;
        b=YD3Q+U8Gm9QHiPr+wD/DBTdOYOKnZcL6+PPBjkCYEfI9neSe7vDaBbhn49eMyi72QH
         DuscjnrfEJfCHxgQPmxavVAujju3gDM50+oU9HZg+vLgKUQxoSudnopCYfANV+OM8Q5D
         sr0YODjut7UC/V4o0B6xgRENNnjDAG7fCmNGVPXbyo+MCsFJrZBDgFq1IohH+zQp7TV3
         OXWWF/UY4sjUDOTSZmNoUdXwRQ6qMjZXr9jvEGRJJ7NjZyg4VobcPNGgTLSmipqu5DwO
         ydqrR5nYWKvgvC7HPTxnKq/FKG3Y3RoSJNba8YPb9p/4qqMxcYHxmEVrhM7oyk52LI+Q
         pelw==
X-Forwarded-Encrypted: i=1; AL+hErEnMcjA7q2LYdIFuJkrfK1PXnc+2EH1MbDO/1qYZA94xAnWgq5deeNr8cZEbNhUGseJ+irXtxkPQ7xvD/dSaw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/i3p4ru7ZQSTQZmYRRtgG1Dv/SK1pqrYeiYMLgWfy0nVLV6bju
	QYIKZQVrDiV/Pg1sZtCHrEuDupxCveD6eCjqYSkHA51ppSt+ZUBgdaPQW/HaDbtmybTmhE/2Ll8
	d3wlLbAnDpSuja3mYCOu4rfhHwcwBeWKzYAYNOEaZlLslC2KCTCV1qg4VOpn0p8Z2++F6xg==
X-Gm-Gg: AYBFou0sV1KIiCv3Z9CX8yyMSAo2lFcSLYLdW3lPWcUtblcxCWLC7ebTSjwwXR+W3UI
	JTwzpNoalI//k01Xm78apSlFAqVBNE4XAua+lOtgQo25oE/teKtvExyjQPb781kHdJFAs0cAa0P
	t4X8yN3PtzvBVZPi+ILY7mXTw5WCOlmhPvVtkOpSsrZ95MoaHZ68boDwBhdWJ/2yjfIRJz7xNy/
	j5sJS+Z9C/ejijwDI9YA9/B77VS6SQjRBJXyRyhUW73VXKKiQuUC4SNY5PHh/A3wdn8DAw9LTT1
	L7M8OWgKYgqn5qO1q3oa8cHDkczTVXj1DUa6SkQ6aNd0F+VurQ4PQleE07lCPVxMDgVoPV+TAA7
	nJCcVdS2/mTWtPHMC9z4z/voKer6fyLhti62GMEEIdcL+CQk/N2xmqKdeSI+9QcmJatJv/Izm52
	imJ0EcVYFnEE4VIiVZUC8Q5p0enzgHEBTPzt+GjRkt9nZv7KvHymtkzCmdwDwF
X-Received: by 2002:a05:7022:eb47:20b0:144:e246:a0b2 with SMTP id a92af1059eb24-1b50315729cmr2458872c88.44.1794572378683;
        Fri, 13 Nov 2026 04:19:38 -0800 (PST)
X-Received: by 2002:a05:7022:eb47:20b0:144:e246:a0b2 with SMTP id a92af1059eb24-1b50315729cmr2458857c88.44.1794572378050;
        Fri, 13 Nov 2026 04:19:38 -0800 (PST)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm6423629c88.7.2026.11.13.04.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:19:37 -0800 (PST)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net,
        radim.krcmar@oss.qualcomm.com, anup@brainfault.org
Cc: linux-riscv@lists.infradead.org, linux-watchdog@vger.kernel.org,
        prajwal.n.oss@gmail.com, Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH v2 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
Date: Fri, 13 Nov 2026 17:48:57 +0530
Message-ID: <20261113121857.1640918-3-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
References: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Vhcx8Hfk9k0Yl8ccP-MkoMVwm4pg9pgl
X-Proofpoint-ORIG-GUID: Vhcx8Hfk9k0Yl8ccP-MkoMVwm4pg9pgl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX41FK7OEXJJoc
 7qPDA1JHCn4fVSXTz93FC5PmQqa/Bnp7HjE0fK2dzbD18Jf6Ux/DTXF2VlXWookPR0tGO8KYP2n
 JToUA37aeOGqhjAhAgaNancw2f4oZXqnilig5mTaQhlbpVoujATkheya33xDb7ChvbSzgey9vg/
 WzahSag2CgCg9dPfuuKABfIgg0YPYwv7rvG0nCXmhqKi6E4qsmLVbKgVkA1m4JaNURKpp0hQPlZ
 PibaFiWahaI8Qx3Za15jEBLP0h+mWkAUJSzshjV/iTYerQ8s/5Mu5FV8U90ubfgDBE//f0SY5N7
 /y2oCHVmG9O8hSRsNcNttH2g4oF2Yylg6dZoZ1icB+g9v5UbXMYbia52UDbqa2z9KlWdFsbSmuK
 BEcfnvREi53crb/GIwOP4C52nycnq2nQene4PmhZ4NRV5gjYq5+c7eM6F5OWsWiXkiyUQJu8squ
 IkvZShVnoGNyy8bVJ+g==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af7005b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=0SxRSwYGAAAA:8 a=TyS6Ky86QTBuXj3fIXcA:9 a=O8hF6Hzn-FEA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=evtWB9OUeeBtXImRToD_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX1z2Dixgv4CMD
 KGsfYjouhTRZJ8srDFVUiZz6hH2FqOGqu2Hct1o31GdAIfxooAjX83p6D9QMZJbpnOkuZeIZ9sR
 yP/pTxfC5vqWeA/Klqm5riuXDGlsCsU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130048

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
 drivers/watchdog/riscv_sbi_wdt.c | 435 +++++++++++++++++++++++++++++++
 3 files changed, 445 insertions(+)
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
index 000000000000..577756f152ce
--- /dev/null
+++ b/drivers/watchdog/riscv_sbi_wdt.c
@@ -0,0 +1,435 @@
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
+#define SBI_WATCHDOG_DEFAULT_TIMEOUT		60
+
+/* MSI capability mask */
+#define SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK	BIT(1)
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
+static int sbiwdt_read_attribute(enum sbi_ext_wdt_attribute_id attr_id, u32 *attr_val)
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
+static int sbiwdt_write_attribute(enum sbi_ext_wdt_attribute_id attr_id, u32 val)
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
+	if (timeout <= wdt->wdd.pretimeout)
+		return -EINVAL;
+
+	period_usec = sec_to_usec(timeout);
+
+	ret = sbiwdt_write_attribute(SBI_WATCHDOG_PERIOD, period_usec);
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
+	ret = sbiwdt_write_attribute(SBI_WATCHDOG_NOTIF_TIME, notif_time_usec);
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
+	ret = sbiwdt_read_attribute(SBI_WATCHDOG_TIME_LEFT, &time_left_usec);
+	if (ret) {
+		dev_err(wdt->wdd.parent, "Failed to read watchdog time left: %d\n", ret);
+		return 0;
+	}
+
+	return usec_to_sec(time_left_usec);
+}
+
+static const struct watchdog_info sbiwdt_info = {
+	.options	=	WDIOF_SETTIMEOUT	|
+				WDIOF_KEEPALIVEPING	|
+				WDIOF_MAGICCLOSE,
+	.identity	=	DRV_NAME,
+};
+
+static const struct watchdog_info sbiwdt_pretimeout_info = {
+	.options	=	WDIOF_SETTIMEOUT		|
+				WDIOF_KEEPALIVEPING		|
+				WDIOF_MAGICCLOSE		|
+				WDIOF_PRETIMEOUT,
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
+	ret = sbiwdt_read_attribute(SBI_WATCHDOG_CAPABILITY, &attr_val);
+	if (ret)
+		return ret;
+
+	wdt->attrs.wdt_capability = attr_val;
+
+	/* Read watchdog min period supported in firmware */
+	ret = sbiwdt_read_attribute(SBI_WATCHDOG_MIN_PERIOD, &attr_val);
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
+	timeout_usec = sec_to_usec(SBI_WATCHDOG_DEFAULT_TIMEOUT);
+	ret = sbiwdt_write_attribute(SBI_WATCHDOG_PERIOD, timeout_usec);
+	if (ret)
+		return ret;
+
+	wdt->attrs.wdt_period = timeout_usec;
+	wdt->wdd.timeout = SBI_WATCHDOG_DEFAULT_TIMEOUT;
+	wdt->wdd.max_timeout = U32_MAX / USEC_PER_SEC;
+
+	/* Initialize the pretimeout to default value */
+	wdt->attrs.wdt_notif_time = 0;
+	wdt->wdd.pretimeout = 0;
+
+	return 0;
+}
+
+/* Callback from devm for MSI cleanup */
+static void sbiwdt_msi_free_irqs(void *dev)
+{
+	platform_device_msi_free_irqs_all((struct device *) dev);
+}
+
+static int sbiwdt_probe(struct platform_device *pdev)
+{
+	struct sbiwdt *wdt;
+	const struct imsic_global_config *imsic_global;
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
+	if (rc)
+		dev_err_probe(dev, rc, "Failed to read SBI watchdog attributes\n");
+
+	wdt->wdd.parent = dev;
+	wdt->wdd.info = &sbiwdt_info;
+	wdt->wdd.ops = &sbiwdt_ops;
+
+	watchdog_stop_on_unregister(&wdt->wdd);
+	watchdog_stop_on_reboot(&wdt->wdd);
+
+	/* Setup MSI if the capability is available */
+	if (wdt->attrs.wdt_capability & SBI_WATCHDOG_CAP_MSI_SUPPORT_MASK) {
+		imsic_global = imsic_get_global_config();
+		if (!imsic_global)
+			dev_err_probe(dev, -ENODEV, "IMSIC firmware node is unavailable\n");
+
+		msi_domain = irq_find_matching_fwnode(imsic_global->fwnode,
+							DOMAIN_BUS_PLATFORM_MSI);
+
+		if (!msi_domain)
+			dev_err_probe(dev, -ENODEV, "IMSIC platform MSI domain is unavailable\n");
+
+		dev_set_msi_domain(&pdev->dev, msi_domain);
+
+		/* MSI setup */
+		rc = platform_device_msi_init_and_alloc_irqs(dev, 1, sbiwdt_msi_write);
+		if (rc)
+			dev_err_probe(dev, rc, "Failed to allocate MSIs\n");
+
+		/* Register with devm the MSI cleanup callback */
+		rc = devm_add_action_or_reset(dev, sbiwdt_msi_free_irqs, dev);
+		if (rc)
+			return dev_err_probe(dev, rc, "Failed to add sbiwdt MSI cleanup\n");
+
+		/* Enable pretimeout only when the MSI is allocated */
+		wdt->wdd.info = &sbiwdt_pretimeout_info;
+
+		wdt->virq = msi_get_virq(dev, 0);
+		if (!wdt->virq)
+			dev_err_probe(dev, -ENODEV, "Failed to get MSI virtual IRQ\n");
+
+		rc = devm_request_irq(dev, wdt->virq,
+					sbiwdt_pretimeout_handler,
+					0, "sbiwdt-pretimeout", wdt);
+		if (rc)
+			dev_err_probe(dev, rc, "Failed to request pretimeout IRQ\n");
+	}
+
+	rc = devm_watchdog_register_device(dev, &wdt->wdd);
+	if (rc)
+		dev_err_probe(dev, rc, "Failed to register RISC-V SBI watchdog device\n");
+
+	dev_info(&pdev->dev, "RISC-V SBI Watchdog registered\n");
+
+	return 0;
+}
+
+static struct platform_driver sbiwdt_driver = {
+	.driver = {
+			.name = DRV_NAME,
+	},
+	.probe  = sbiwdt_probe,
+};
+
+static struct platform_device *sbiwdt_pdev;
+
+static void __exit sbiwdt_exit(void)
+{
+	platform_device_unregister(sbiwdt_pdev);
+	platform_driver_unregister(&sbiwdt_driver);
+}
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
+	sbiwdt_pdev = pdev;
+
+	return 0;
+}
+late_initcall(sbiwdt_init);
+module_exit(sbiwdt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Prajwal N <prajwal.n@oss.qualcomm.com>");
+MODULE_DESCRIPTION("RISC-V SBI Watchdog Driver");
-- 
2.43.0

