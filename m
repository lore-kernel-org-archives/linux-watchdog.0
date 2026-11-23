Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417546;
	b=13mrMWPptocKWfgmnyIk5kJlo3t896E0T6qCZ1DdleYQP0Xl4YzOvo/oyfLkiI7M9ZN0
	 Upolj9JCxSJHnxx35IErQpa+ISHfWhuw5VTJ+RKNahv6er6wNgako66vyNTIloYXGBB+U
	 dSixS+BPdfgrDZhvPF+cTawGvRa85DUfCwQaIjxy803XPaX5EHVC90h9VsCtq3YI+C8vT
	 E0uqxLPIdD8ikRE5hncx4Op+RWNVOz6IA4G6w4zAssyeTWc+dhVVtPAj1VNRaHCGkK2Kc
	 ffTbwrNC3A6yydAyP1fIZdACpF7HVozDFuebvtf/B9MvRb/pt7IUSKxIqCaz8V6LvFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417546;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mNZ6bZZf33/ujakZ94r0duEndktkggT7gLlZ0Hy4Jlk=;
	b=EGbHcB6f91bzFMkZld0TTf1VqH2VhIfimSv304YhhTJpVYg6vodlzXZeanmfZwyT56sr
	 04XlHlhGi20SZTmp5/1VCxhv3m8bubdPfYHnluFJQft4ftqELCqVn8QhHBzsVU1qeSuvg
	 laCkwSi2j6Txv8/l9dPVM/Mp91MqG51fKKG9T/qQRqE+BJuYpW0ppJioQbVvDvLQO7PWY
	 D9CihxnwPL7OL3suIcfGSmzvUe6h/fQFZKTqFFCZFz/ks7C2upv38E7K5y1DnB9wH7/nK
	 +nQEHT34WbOK8QOTWwuUbJFNn90Xl4mgh4/JpWEilMbEoMaVT1+sxlqezQvrr8ZFEBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ScdK6bnG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAC606A31F;
	Mon, 23 Nov 2026 07:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFAC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ScdK6bnG
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN699sq1011258;
	Mon, 23 Nov 2026 07:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNZ6bZZf33/ujakZ94r0duEndktkggT7gLlZ0Hy4Jlk=; b=ScdK6bnGQLdYSEVq
	Gf6PBQdTmaoey5pyQAaTNaNK2/NXR2IOSoEpD/RomSOFUnME3XO8oMGlKRrGPqzg
	Edn1SG5hfy6ZJ9dT4I7bXQeBiS2Ce316NioqW9d0D95XNwY2gbNykvg+Tz/7CdA2
	wJ+vjpRZsIf+qSY+yTw0ODRgjRKymWk2tgDUVrR2se9K0SQjPnxAnsrZyZ6DP2lm
	pONlZnjL5OXo8qdS+j/jrHklZB96cNNTDJNCt+Qt7avqki69I833drmLtdlX06oQ
	I2CWqv2FlKLoJeKz+wPS6io1N/lJGnwuM55fxLPKwLExGv4dXQ3nEjgRK93lR0ra
	48ixag==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyh063t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:05:09 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN756wG4185227;
	Mon, 23 Nov 2026 07:05:06 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 6AN753Q74185090;
	Mon, 23 Nov 2026 07:05:06 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 12:34:57 +0530
Subject: [PATCH v5 5/5] power: reset: pscrr: record reason for
 userspace-initiated reboots
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-pscrr-reboot-reason-v5-5-fbf3c7c92772@oss.qualcomm.com>
References: <20261123-pscrr-reboot-reason-v5-0-fbf3c7c92772@oss.qualcomm.com>
In-Reply-To: <20261123-pscrr-reboot-reason-v5-0-fbf3c7c92772@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=NM1AaE6g c=1 sm=1 tr=0 ts=6b03e5a5 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=y7n2HT4GL4nd4BABNBAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX7tW8e+53jAST
 XtIfZQIrvTZGpZ/pt3gB0WaVgyvYhStXjOwTE2bd0SVcqwrLI+qSlMdrNaFPNFbnJB0EUiU8QNI
 R2zmEumCqRzXvsjVRbGxSkjUn457560=
X-Proofpoint-ORIG-GUID: g5LRt1hhqwD-5yxuCJsTt3Dbn-oqLm17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfXyglrIFxbW5Po
 fQYoKArx8jxZbGj6JFV9ZvGBA+sv2KCy14ZNxjE/qwJLPNU8HQjvDi5ostTCPHgVeL8Q0wjlsrU
 mp55stIPfZgu10QKqLV4PJAwFg/57l1PASAMRuFkWmlY4eqoO0sCsGEwAwxs07PC98JcoeZpl1Q
 bDFoSMwIAdDwZ8/VJd/46yc+Vj069O0HcSWJNehavm680dmflpkJrdVtra4MN0Ir00yOjoOwhkp
 64bVaD8XUG4Raah1GAjsuJHJPQ+adZ7Oa0EP/1uv2zGc/zOgKjPrtv1Zm6HJ6gdsNsUaJ4Lv4uE
 ycbxjGecbtVQRKFpqKeCB4Phzxr/MDV3t7Fg2sqoSF50D3fKaBwWcTTWoE0vCTys0lPraf8gi9f
 yMCDAHTb9oPQXcZlAsTU3l7exRY8s23e9Nly13rZLarYihQi8G0rI5mRzVhnEtAoPXKx61pFYYq
 R5ysZLOxiDnRc2jAGeQ==
X-Proofpoint-GUID: g5LRt1hhqwD-5yxuCJsTt3Dbn-oqLm17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

Userspace can request different reboot targets, such as
bootloader, recovery, OTA update, EDL and factory reset.

Add dedicated reset reason codes for these reboot targets to
preserve the requested reboot mode across system resets.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr/pscrr.c     |  9 ++++----
 include/linux/power/power_on_reason.h |  5 +++++
 include/linux/reboot.h                | 21 ++++++++++++++++++
 kernel/reboot.c                       | 40 +++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/reset/pscrr/pscrr.c
index 9e6dd3e17382..8e345d07269e 100644
--- a/drivers/power/reset/pscrr/pscrr.c
+++ b/drivers/power/reset/pscrr/pscrr.c
@@ -498,18 +498,19 @@ static void pscrr_record_current(void)
 }
 
 static int pscrr_reboot_notifier(struct notifier_block *nb,
-				 unsigned long action, void *unused)
+				 unsigned long action, void *cmd)
 {
 	guard(mutex)(&pscrr_lock);
 
 	/*
 	 * A reboot, halt or power-off that reaches here with no more specific
-	 * reason is software-initiated by definition. Record it as such rather
-	 * than leaving it unattributed; a real cause set earlier (thermal,
+	 * reason is attributed from the userspace reboot(2) command string
+	 * (e.g. "bootloader", "recovery", "ota-update") when present, or recorded as
+	 * software-initiated otherwise. A real cause set earlier (thermal,
 	 * under-voltage, ...) is already latched and left untouched.
 	 */
 	if (get_psc_reason() == PSCR_UNKNOWN)
-		set_psc_reason(PSCR_SOFTWARE);
+		set_psc_reason(psc_reason_from_reboot_cmd(cmd));
 
 	pscrr_record_current();
 
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 9bcce23c81e9..9bd903594f41 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -24,5 +24,10 @@
 #define POWER_ON_REASON_WATCHDOG_PRETIMEOUT "watchdog pretimeout"
 #define POWER_ON_REASON_HARD_LOCKUP "hard lockup"
 #define POWER_ON_REASON_SOFT_LOCKUP "soft lockup"
+#define POWER_ON_REASON_REBOOT_BOOTLOADER "reboot to bootloader"
+#define POWER_ON_REASON_REBOOT_RECOVERY "reboot to recovery"
+#define POWER_ON_REASON_REBOOT_OTA "reboot for OTA update"
+#define POWER_ON_REASON_EDL "reboot to emergency download mode"
+#define POWER_ON_REASON_REBOOT_FACTORY_RESET "reboot to factory reset"
 
 #endif /* POWER_ON_REASON_H */
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 45e64bcad37e..5723852135f2 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -254,6 +254,21 @@ extern void orderly_reboot(void);
  *	task) detected by the kernel's softlockup watchdog, before it
  *	escalated to panic.
  *
+ * @PSCR_BOOTLOADER: Userspace-requested reboot into the bootloader
+ *	(e.g. "reboot bootloader" / fastboot).
+ *
+ * @PSCR_RECOVERY: Userspace-requested reboot into the recovery image
+ *	(e.g. "reboot recovery").
+ *
+ * @PSCR_OTA: Userspace-requested reboot to apply an OTA update
+ *	(e.g. "reboot ota-update").
+ *
+ * @PSCR_EDL: Userspace-requested reboot into Emergency Download Mode
+ *	(e.g. "reboot edl").
+ *
+ * @PSCR_FACTORY_RESET: Userspace-requested reboot to perform a factory
+ *	reset (e.g. "reboot factory-reset").
+ *
  * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
  *	value is useful for range checking and potential future extensions
  *	while maintaining compatibility.
@@ -281,6 +296,11 @@ enum psc_reason {
 	PSCR_WATCHDOG_PRETIMEOUT,
 	PSCR_KERNEL_WATCHDOG_HARDLOCKUP,
 	PSCR_KERNEL_WATCHDOG_SOFTLOCKUP,
+	PSCR_BOOTLOADER,
+	PSCR_RECOVERY,
+	PSCR_OTA,
+	PSCR_EDL,
+	PSCR_FACTORY_RESET,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
@@ -291,6 +311,7 @@ enum psc_reason {
 const char *psc_reason_to_str(enum psc_reason reason);
 const char *psc_reason_to_token(enum psc_reason reason);
 int psc_reason_from_token(const char *token, enum psc_reason *reason);
+enum psc_reason psc_reason_from_reboot_cmd(const char *cmd);
 
 /**
  * enum hw_protection_action - Hardware protection action
diff --git a/kernel/reboot.c b/kernel/reboot.c
index b748153d18cc..73655bd2b02b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1113,6 +1113,11 @@ static const struct psc_reason_desc psc_reason_descs[] = {
 	[PSCR_WATCHDOG_PRETIMEOUT] = { "watchdog-pretimeout", POWER_ON_REASON_WATCHDOG_PRETIMEOUT },
 	[PSCR_KERNEL_WATCHDOG_HARDLOCKUP] = { "hardlockup",	  POWER_ON_REASON_HARD_LOCKUP },
 	[PSCR_KERNEL_WATCHDOG_SOFTLOCKUP] = { "softlockup",	  POWER_ON_REASON_SOFT_LOCKUP },
+	[PSCR_BOOTLOADER]	 = { "bootloader",	  POWER_ON_REASON_REBOOT_BOOTLOADER },
+	[PSCR_RECOVERY]		 = { "recovery",	  POWER_ON_REASON_REBOOT_RECOVERY },
+	[PSCR_OTA]		 = { "ota-update",	  POWER_ON_REASON_REBOOT_OTA },
+	[PSCR_EDL]		 = { "edl",		  POWER_ON_REASON_EDL },
+	[PSCR_FACTORY_RESET]	 = { "factory-reset",	  POWER_ON_REASON_REBOOT_FACTORY_RESET },
 };
 
 /**
@@ -1168,6 +1173,41 @@ int psc_reason_from_token(const char *token, enum psc_reason *reason)
 }
 EXPORT_SYMBOL_GPL(psc_reason_from_token);
 
+/**
+ * psc_reason_from_reboot_cmd - Map a userspace reboot(2) command string to a
+ *				 power-state-change reason.
+ * @cmd: Command string passed via LINUX_REBOOT_CMD_RESTART2 (e.g.
+ *	 "bootloader", "recovery", "ota-update", "edl", "factory-reset"), or
+ *	 NULL.
+ *
+ * Return: The specific reason for a recognized command, or PSCR_SOFTWARE for
+ * an unrecognized or absent command.
+ */
+enum psc_reason psc_reason_from_reboot_cmd(const char *cmd)
+{
+	static const struct {
+		const char *cmd;
+		enum psc_reason reason;
+	} cmd_reasons[] = {
+		{ "bootloader", PSCR_BOOTLOADER },
+		{ "recovery",	PSCR_RECOVERY },
+		{ "ota-update", PSCR_OTA },
+		{ "edl",	PSCR_EDL },
+		{ "factory-reset", PSCR_FACTORY_RESET },
+	};
+	int i;
+
+	if (!cmd)
+		return PSCR_SOFTWARE;
+
+	for (i = 0; i < ARRAY_SIZE(cmd_reasons); i++)
+		if (!strcmp(cmd, cmd_reasons[i].cmd))
+			return cmd_reasons[i].reason;
+
+	return PSCR_SOFTWARE;
+}
+EXPORT_SYMBOL_GPL(psc_reason_from_reboot_cmd);
+
 /**
  * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
  *

-- 
2.34.1

