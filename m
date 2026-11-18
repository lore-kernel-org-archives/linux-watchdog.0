Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993730;
	b=ry30V8TCnffAK/Ao6aYLs+67O0hthjvtiD4QJ82JYs7zxYqobejhi3giVlH6I2LGK4NI
	 p3TNGWiYkSMqVe20mhq42060FEPtm4G81IyfQXb78Pl1RzxFPBhtw9CBG3ymh14ry2u/Q
	 yWKe5FoMc96LDEC4sT+SWCx0YMUaMcYvK+6/7lElDLM2TA8ltTmSow45gBcrsRJqsSIH9
	 wpYPMZldyW3uOJF6SVcVHnNZwSA8/se9npa6jHO/7O0jyQxfkf1rXDhXpF+UhE79Cgk1Q
	 eZHO9WM3PinHn9lXwyqumClI7/qjpK9zJGmMhF6VQ0YduL5V0Xhoob4VPsX0EeWCMIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pC+8Uzxj9HN3tj14OzQ4rXp40xz2b91V8LYMGXsBBMY=;
	b=RmgF7/na5pjUpoVWz9jwppX5P8l1TwGDuQ2xf1M7wTP3CoqW+0c7d49EVH0sMt5VXQIb
	 iIJY3SnMzzuJ54DseGb2ObYtk3dU1Q3uMWl7uzg8lJ27DQUvUPwY05yzhrQXXsLsYTopG
	 1REnjUY+P+iPFRCRGwNL0SGGPM2VNuobjfsqCYav+JRpyjEdGnnFHosTHAdeD4c0MrE3J
	 ynE435qFpt9qqV73t8zngWXdU8EMERY69sQg/Xf1AZ/5kXCwNaTbfayHnWeqaDYMSLgFj
	 4JE8vm//KAHh1KmnlTYSAA3S1ysStTlBu+ERvwaP69rp11lAJhAQxZ6Lsu44zZ3ZSog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kj5Rx1qH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cxNssoZP;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A921606A320
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A921606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kj5Rx1qH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cxNssoZP
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8MuKu2383028
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pC+8Uzxj9HN
	3tj14OzQ4rXp40xz2b91V8LYMGXsBBMY=; b=Kj5Rx1qHH6DEOf2Sc3GBMUtX9Ud
	15CfHnXzZejgSR2zBmzE8OjYz4gV219+mU8hhii1pRUNnsNKAAZat99MZv4MxmpO
	Io9GAjdkOdfxbsbUqNYLHSe55MfJB6walkvpuWC+XrJ8aXTrY5b89Ok2DDhqnI15
	ajyLR9qGBzKHYrClX3twg9Y5ATemn8Mga54rcmHc/CkeAtjPzitTBj/nLLtRxhyt
	GhRshAeLyxTVVN8eUesDeQw3sZRJxH6xcuGOORGn5bQ65QjA0Lvzd089j9IcTg9R
	z0Lzxg2Z9Rgg0x1bSLBcDrMimcZ53pJwAFablEzoBDK0N0xzOmEhRy4e6Iw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvata72-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:22:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-370230d93efso3083306eec.1
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794993728; x=1795598528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pC+8Uzxj9HN3tj14OzQ4rXp40xz2b91V8LYMGXsBBMY=;
        b=cxNssoZPnwQYDiRomGKaQnzm2e325KpvQMqb/uOHmjqB7jBX4ZuPuAjDS1B3r2HPw9
         VIGQmS8ugC0BOf3q3PhjUlrAQivV2jrEAWmcscgFXOg0Qb7L0ehdsWqWBoAvVk65h0qA
         cgWYsdoFaFYhdRRO1OaP4Rp96CVk3SJjbO3n14Km9h/3+aliwRmxyHQeBgrjXXfea3bS
         DbUvkVF5zF+0g3stE2yumZQbt9KZH81M00rhkgZJTVHwW9Z0YbtQ+h7ATF6IGZ8GXsOs
         yqlK7C620xnp6zRWBKaNvJki9bcm+ej66t79cvs0STOiklznsoHtMxjutq/JQ56qmB4q
         gYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993728; x=1795598528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pC+8Uzxj9HN3tj14OzQ4rXp40xz2b91V8LYMGXsBBMY=;
        b=FZ2pRkqm9YXifBfTh/0MK1PLKdvrIb9q7ZUEe38FckeWKF5hSDX7Acyp7TTqgAIOJQ
         zDeC56ENVMHf0YBvqKJqA0hVxmbSegEKfYth9rXZ2seogWF/Q4h0n+46vtXAiGol3Mk6
         NwVz3vXTjCMylTsktPiCGkBQnfVA+FQOy0thQSpO4I54ex9EC7i57ty5xTgufGSyhGZN
         fALvWUSHIjswUm0Gc2pQiL/Wh8PgyOcPjJdUYsvhOfaZ3ELpe6H8Qn3ldCUy4fpFnwAr
         qQ0ZYC0GMLQq5d5SMO4kwNZGPih5ASK5EmeTBO3mubDN76n26eDr8naSDN4yQKIR5mHI
         wn2A==
X-Forwarded-Encrypted: i=1; AL+hErGL3KDKqniWTfD/8zAmzThUAcolWHVYdU4HNFh/p1xm/DZeC5VR0XGUzHmEAHXKIjgfeGvA4SjjyTtjaPKrRg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pSt+JQfyGniPVXbbSSzlivy/Pl+LlKOhRKIbc0ebRSRmNGc1H
	R5vFrckLkKNuhJhNtMg6db5umCdRxmCFo2geYupYyg0lgRNOziPUi9l3va4gVayiwVwfzcCDGG7
	Px2v6ex2gUPA+pKOnXagVnskVHTrQPBBNtrekLpsXT8UYkJhGTP+EwFkz3MbEhEubRZekBQ==
X-Gm-Gg: AZFdTZcT05KEgcAXDsCQHttv3qTTCXKBxp2DcYVxc16Qiy0jnm1/yL6hnTj3bZQmZMQ
	FhMX6xG/swxIN25a7bjIQk93ChhmtQ3Z/WbVFBI4g1P+1hKg9OaxpD1a9znjxHaUasrd3aQaSFC
	GliyigqshYL076JUbISgHIZQWGoXSvqvyAGG1n0vGMUBxjDBSGDVedS/aBaq8E5XeG3qNMBORB5
	Im5uApjF/ARk0q6T4b6CWMCKLE5j5/2IJmjLzleND+E8udb17jfqiUNLRelWkO/jYe4EeoKoV1O
	I/wDxUcgZ13JRJbLORzAZBAY94U+eutQ5Ox4O1l/ddONbrrlxfR+I/tgCKCazZ4xg+ciMlaJmfp
	fFlx4bWNWusBwK9GBBjWjEx2+cCslt4QXxWpsLGWg/IcYNutHgpKuYDuUA2XNFy8WzlX4jpMyWw
	upjP0WE50R6gzhR4faG5JRHw1AebVddY7O5tXBN5hIzsiYKo55EGUfeh3gFjcOJg==
X-Received: by 2002:a05:7300:fe09:b0:382:4c1e:1c1a with SMTP id 5a478bee46e88-3828151fe38mr1933026eec.40.1794993728309;
        Wed, 18 Nov 2026 01:22:08 -0800 (PST)
X-Received: by 2002:a05:7300:fe09:b0:382:4c1e:1c1a with SMTP id 5a478bee46e88-3828151fe38mr1932991eec.40.1794993727729;
        Wed, 18 Nov 2026 01:22:07 -0800 (PST)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm9194334eec.5.2026.11.18.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:22:07 -0800 (PST)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net,
        radim.krcmar@oss.qualcomm.com, anup@brainfault.org,
        anup.patel@oss.qualcomm.com
Cc: linux-riscv@lists.infradead.org, linux-watchdog@vger.kernel.org,
        prajwal.n.oss@gmail.com, Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH v3 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
Date: Wed, 18 Nov 2026 14:51:47 +0530
Message-ID: <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=SMzXx+vH c=1 sm=1 tr=0 ts=6afd6e41 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=0SxRSwYGAAAA:8 a=TyS6Ky86QTBuXj3fIXcA:9 a=O8hF6Hzn-FEA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=evtWB9OUeeBtXImRToD_:22
X-Proofpoint-GUID: 63gjMoogUVjVTRC_BgFlVi_7VktOz74E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfX8tcZ8bkLFwTE
 8PY1MywlQpajrm56m4TwJOEZtY9xPbttqdmKimYOVNSF+KNv9PPTWJwh+FttFU8w4AMhaFAGkXW
 rMW8FPRQpi9am9E1RMhyqcQkpXw3yvH/JZ8Pp2Sxl2OgSo4ytKHuHDXflCWRCUHBA6syUGjzRps
 byEj1Dhfx91h1uoAo92/kNnujVWAsFGLuFQmNBmZeczyEG2kbJmJ87MZYAx8lufkIcsoRGaXwjO
 LEpIjC/nUz21LZ6Cl29Kg/Eh902miAyHVA42CuzCNI/i1J358lkZ92WSuj2AT+eA2+pLx4cjzyW
 o8i41KNAQ3ifrr35Ze3A1Zm1c3NZBjxQdQ2dcjPB/2Cl+eTyZC/NHfeIerSoXOF9UTGxi/rFDBi
 Uyv/fTOZWqcNCrA7ZEYwQNrDo3eGF14cdpCvpRPa1VB5eUffSeuigIOd2A4EYIJhQARunJBb+a3
 H27gIFmcYzLdN6zDPSg==
X-Proofpoint-ORIG-GUID: 63gjMoogUVjVTRC_BgFlVi_7VktOz74E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfXxwGt3Vk4Voyl
 mjbdc2mmnjTT2+7BVQg+U6XU7aYB4VT3IBI5JoJH1mbco4xXLT/dIzVO2eTxUcFRMf/F7JTUwJl
 ac3vm/W12WCg9ec46imj6zB8m09cqRw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180037

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
 drivers/watchdog/Kconfig         |  10 +
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/riscv_sbi_wdt.c | 436 +++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+)
 create mode 100644 drivers/watchdog/riscv_sbi_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c0ef..d6b4e8ccd057 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2164,6 +2164,16 @@ config STARFIVE_WATCHDOG
 	  Say Y here to support the watchdog of StarFive JH7100 and JH7110
 	  SoC. This driver can also be built as a module if choose M.
 
+config RISCV_SBI_WATCHDOG
+	tristate "RISC-V SBI based Watchdog support"
+	depends on RISCV_SBI
+	default RISCV
+	select WATCHDOG_CORE
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
index 000000000000..026579a3c5cf
--- /dev/null
+++ b/drivers/watchdog/riscv_sbi_wdt.c
@@ -0,0 +1,436 @@
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
+		return dev_err_probe(dev, rc, "Failed to read SBI watchdog attributes\n");
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
+			return dev_err_probe(dev, -ENODEV, "IMSIC firmware node is unavailable\n");
+
+		msi_domain = irq_find_matching_fwnode(imsic_global->fwnode,
+							DOMAIN_BUS_PLATFORM_MSI);
+
+		if (!msi_domain)
+			return dev_err_probe(dev, -ENODEV,
+					     "IMSIC platform MSI domain is unavailable\n");
+
+		dev_set_msi_domain(&pdev->dev, msi_domain);
+
+		/* MSI setup */
+		rc = platform_device_msi_init_and_alloc_irqs(dev, 1, sbiwdt_msi_write);
+		if (rc)
+			return dev_err_probe(dev, rc, "Failed to allocate MSIs\n");
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
+			return dev_err_probe(dev, -ENODEV, "Failed to get MSI virtual IRQ\n");
+
+		rc = devm_request_irq(dev, wdt->virq,
+					sbiwdt_pretimeout_handler,
+					0, "sbiwdt-pretimeout", wdt);
+		if (rc)
+			return dev_err_probe(dev, rc, "Failed to request pretimeout IRQ\n");
+	}
+
+	rc = devm_watchdog_register_device(dev, &wdt->wdd);
+	if (rc)
+		return dev_err_probe(dev, rc, "Failed to register RISC-V SBI watchdog device\n");
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

