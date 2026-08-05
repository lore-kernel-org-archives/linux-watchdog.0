Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C1391E59;
	Wed,  5 Aug 2026 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920139; cv=none; b=qcWeiOH/i7A05G9z56dOixRPBOH502e9AxkIsrZ2J1bL3aCEZsmxIBYzPMcBWpCuu7NrrumeC6Yin4CXyykehvaJ9qqXjRH5dqu8jtHBGqgdn7uh4Slmeq2rKuVKHhl6y4CRbtL+KCmv533VsTPb9nOPJtrNle9qyOXtINvaVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920139; c=relaxed/simple;
	bh=17xrdJIWU4ZH/JxF9fsfn3sGYVwjviG/2kKacoqnHRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cziTLNMeBQOaypYWCieMRS9qFxYB5nmZQVumP/cfOkWh9UE+Ng+BojxiQ2jqBOqD+XBdpkq99MC3wmq7WY9KYTdAw7AKv6K8+Lhn0oSn/KBM4TIUfaHoC4sKpIsXrHLmH+hIFDOhu3FmKCDu9mfITOjf9lcrAEt2AQlokRV02vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VhqNp4x+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhqNp4x+"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758db0S1713296;
	Wed, 5 Aug 2026 08:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nRfsZhCcwjHwU9yHOJWvrhAiTLSvqkBHCQCwWwnd708=; b=VhqNp4x+HSOL6vT2
	YtthAT4fCucVY9iVlP6enxW6laO3XiZR8wIUTtCKZOeGZ57intPflz4m7r1TxFkv
	DsaGOWlymZOYQjQ3MN9hjhYWHwOj98Pmih8PA+x/ZBa0t5hkgJbL2HBXg2QOju7C
	AMHTCgockSyQbMGr+RgFZxysd3J/Wkzj9a0xS3yP7b8QoxbV0f8QAyb16+fB66XL
	Xld7khvakJsYthwSqK6cn+TVjt1kxWrOmSY226zvDxgiZAlb6QOUJ1w8XOa6+SX9
	IOexqys0TudCN1NmHOvMyAU/oK9u7keJNctUe+tJ0UvdvOo+n7e29/DRItWoMvtF
	4Vj/gQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuwbqs87c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:55:11 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758t5iG007279;
	Wed, 5 Aug 2026 08:55:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vje9u3-1;
	Wed, 05 Aug 2026 08:55:09 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6758t5qF007272;
	Wed, 5 Aug 2026 08:55:09 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6758t23K006999;
	Wed, 05 Aug 2026 08:55:09 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 14:24:55 +0530
Subject: [PATCH v4 1/3] power: reset: pscrr: add kernel panic reason
 tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pscrr-reboot-reason-v4-1-54ef517084cc@oss.qualcomm.com>
References: <20260805-pscrr-reboot-reason-v4-0-54ef517084cc@oss.qualcomm.com>
In-Reply-To: <20260805-pscrr-reboot-reason-v4-0-54ef517084cc@oss.qualcomm.com>
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
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: xOfMG28_w4WPmLuwkXfF6MUGX-m331ng
X-Authority-Analysis: v=2.4 cv=B+uJFutM c=1 sm=1 tr=0 ts=6a72fa6f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=opvmgqTE--nunqmWsLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xOfMG28_w4WPmLuwkXfF6MUGX-m331ng
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX7AIBr8bidKi0
 29zjRZX65XQOYCJOwN9wnsVpJwK3H8yPgTCiAKMUGSrCRIJsnfr73wdcBrN+ITeZUJ0YjE7Ues5
 fC55MdPhxQtdA5FjmNLEGa0YoC1iCgA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfXys5Sc6MjGtDQ
 o7y0kuvpuepV1HaXKWfRqPjRewP6sXDzlZAJxRgFkOiN6UhIgq3eqPF/DbPfJyrjDh02RAoOQpm
 LU+j77PLMua14YWlXT8oVEKoPhbKASIBdH+yD3ocv7XPl6HARgc7hOgsm7ag3EbGhQId230V8hk
 nN6B7m5oObSOBnvBkw2xskp2xjCHw1K9C1+AwFL48B+XVu/E8Jvy9vmNKveLaGmy1Wg6qVWqWb2
 jFSnqZWJ3BEKFmr0hB4GBA0n8G1pZiH4vf3gnD5Zi4gR/pEUm2o/eRErxpKt8Kl8ivzet0KJNVr
 OPKUP5+ErnlIaMkDWy/6644xFcKa+TnczSfioyGTzdUkpyAZzBb0/vch+J+ZjOlcFjPw3wdzfiZ
 Qed4vRmbH/Uly7Jx2qzsGpgtt6m+lBgn7vF3T9B1GuPBoF+0O6oxMAXmcvawPkW2hZB8zASUQtq
 XdBWXXI1VlNEppWVFxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050069

Kernel panic resets are not recorded in NVMEM, causing subsequent
boots to report PSCR_UNKNOWN and making post-mortem analysis more
difficult.

Register a panic notifier to preserve the shutdown reason across
panic-triggered resets. Add PSCR_KERNEL_PANIC as a dedicated reset
reason code and its corresponding reason string to identify kernel
panic resets on subsequent boots.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr/pscrr.c     | 27 +++++++++++++++++++++++++++
 include/linux/power/power_on_reason.h |  1 +
 include/linux/reboot.h                |  3 +++
 kernel/reboot.c                       |  1 +
 4 files changed, 32 insertions(+)

diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/reset/pscrr/pscrr.c
index 6f23f4c4f590..8c45b84059a9 100644
--- a/drivers/power/reset/pscrr/pscrr.c
+++ b/drivers/power/reset/pscrr/pscrr.c
@@ -41,6 +41,7 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
+#include <linux/panic_notifier.h>
 #include <linux/pscrr.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
@@ -519,6 +520,29 @@ static struct notifier_block pscrr_reboot_nb = {
 	.notifier_call = pscrr_reboot_notifier,
 };
 
+/*
+ * Panic notifier: record that the machine went down through a kernel panic, so
+ * the cause is visible on the next boot. Runs in atomic panic context, so the
+ * provider list is walked without pscrr_lock - providers no longer come or go
+ * once the machine is going down.
+ */
+static int pscrr_panic_notifier(struct notifier_block *nb,
+				unsigned long action, void *unused)
+{
+	struct pscrr_provider_dir *dir;
+
+	set_psc_reason(PSCR_KERNEL_PANIC);
+
+	list_for_each_entry(dir, &pscrr_dirs, node)
+		pscrr_do_record(dir, get_psc_reason());
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pscrr_panic_nb = {
+	.notifier_call = pscrr_panic_notifier,
+};
+
 /*----------------------------------------------------------------------*/
 /* Built-in provider: device-tree /chosen/reset-source                  */
 /*----------------------------------------------------------------------*/
@@ -611,6 +635,8 @@ static int __init pscrr_core_init(void)
 		return ret;
 	}
 
+	atomic_notifier_chain_register(&panic_notifier_list, &pscrr_panic_nb);
+
 	pscrr_register_reset_source();
 
 	return 0;
@@ -619,6 +645,7 @@ static int __init pscrr_core_init(void)
 static void __exit pscrr_core_exit(void)
 {
 	pscrr_provider_unregister(&pscrr_reset_source_provider);
+	atomic_notifier_chain_unregister(&panic_notifier_list, &pscrr_panic_nb);
 	unregister_reboot_notifier(&pscrr_reboot_nb);
 	kobject_put(pscrr_root);
 	pscrr_root = NULL;
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 13e61ace14f5..8c99bdd75021 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -20,5 +20,6 @@
 #define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
 #define POWER_ON_REASON_EC_PANIC "EC panic"
 #define POWER_ON_REASON_EXTERNAL "external reset"
+#define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
 
 #endif /* POWER_ON_REASON_H */
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 13f004ad1066..a117dd5eaecd 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -241,6 +241,8 @@ extern void orderly_reboot(void);
  *
  * @PSCR_XTAL_FAIL: Reset caused by a crystal oscillator failure.
  *
+ * @PSCR_KERNEL_PANIC: Reset that followed a kernel panic.
+ *
  * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
  *	value is useful for range checking and potential future extensions
  *	while maintaining compatibility.
@@ -264,6 +266,7 @@ enum psc_reason {
 	PSCR_RESET_BUTTON,
 	PSCR_CPU_CLK_FAIL,
 	PSCR_XTAL_FAIL,
+	PSCR_KERNEL_PANIC,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 75af5d763465..979ecf3b093c 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1109,6 +1109,7 @@ static const struct psc_reason_desc psc_reason_descs[] = {
 	[PSCR_RESET_BUTTON]	 = { "reset-button",	  POWER_ON_REASON_RST_BTN },
 	[PSCR_CPU_CLK_FAIL]	 = { "cpu-clock-failure", POWER_ON_REASON_CPU_CLK_FAIL },
 	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
+	[PSCR_KERNEL_PANIC]	 = { "kernel-panic",	  POWER_ON_REASON_KERNEL_PANIC },
 };
 
 /**

-- 
2.34.1

