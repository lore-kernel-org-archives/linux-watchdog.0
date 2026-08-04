Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124F43E094;
	Tue,  4 Aug 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835334; cv=none; b=GnMpWY2xoE36eOo0KsPNsBIM9QwoNdxr7gwGlI1IjkqAGY8wEqc1Q7fwq3CDdT3Pg/yUbqEtYZHKZb3RvEOO4/wL9LLcyG1S86sZrKpzHPLVJWksJ3lg+r2RUc/MQ3QHG350LxnvilfXJVkZGb+kNMev9Ac1fTa4+qiKMoRrDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835334; c=relaxed/simple;
	bh=17xrdJIWU4ZH/JxF9fsfn3sGYVwjviG/2kKacoqnHRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIQyAkulbKOdS+xKgdVBACjen5zYpsEzOqddSzBPiqr9m8qAyo1azIR49RqGbn34ywJsb/wuaHP7fhBABTvCbPsINP6Ortez1CwPdKSmiejtiLNmy0iJnf4BZz3fFiNCnu/9CaznxGxR5qA1TB4raJh2lZVEjAKCuR2YzoIIqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c0h37S+8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c0h37S+8"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CHlX3236530;
	Tue, 4 Aug 2026 09:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nRfsZhCcwjHwU9yHOJWvrhAiTLSvqkBHCQCwWwnd708=; b=c0h37S+8cuwOJ9vu
	tgHz0Kr5QVcGThT60XkAPP4mhYDv+4/XEeOPnDqHkRtzFjY39b5lBYy4zmFP6E38
	Pb4WdnA9fGn7S8M77UxYSgajo15gPdMGYxYL1JDVH4ccfVtYT5zW3vQEWtmKy80h
	5G9gGtoTkT26sn2rA89YOYpASdoTboezpeLFSgEimHvNozg0/dVx/GMlOjza0yKL
	QFSh33G+DyBZYNEq5PSe+NIwGvaeJymbnq7xPHW68eFWxWSaA8q2wRdg9CN6eQaS
	MqtEjRhKl3WNgFPaGrHIbGsT7M6Q6rbtZZenmAOLlm5WDLBYp8IzrQjfPRhMxzlO
	mdnaAQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu5hqsvrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 09:21:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749LZL3027311;
	Tue, 4 Aug 2026 09:21:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vjk7uu-1;
	Tue, 04 Aug 2026 09:21:35 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6749LY8K027285;
	Tue, 4 Aug 2026 09:21:34 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 6749LY9H027260;
	Tue, 04 Aug 2026 09:21:34 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 14:51:20 +0530
Subject: [PATCH v3 1/3] power: reset: pscrr: add kernel panic reason
 tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pscrr-reboot-reason-v3-1-e706dbfc7465@oss.qualcomm.com>
References: <20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com>
In-Reply-To: <20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfX2+YhBEsMeUv4
 yOuQF1gRAXw4llWs4CHAJyRIEFtTk9svQGn751yGUplGITcKS0U8oGKZkPoI9aZ37vRN5m1iBhG
 aZCRXCsye1Hga7NIML6P9V/ZSche/dQ=
X-Proofpoint-GUID: LtQwJli2caWtWwJ2o_Newzz9XfUuc6A6
X-Proofpoint-ORIG-GUID: LtQwJli2caWtWwJ2o_Newzz9XfUuc6A6
X-Authority-Analysis: v=2.4 cv=EoniaycA c=1 sm=1 tr=0 ts=6a71af23 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=opvmgqTE--nunqmWsLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfX1nX39WRrnRwv
 SYmp7r54mOPnzKYpC3SQssPHXN4QKabV6tk6HrSJVoKQNbiqYcijN1qR3V6qdwtAowUDngtrzqS
 vWcQAWdek7wOtpf6OPgVHZYf4PmK2RLrB2lA/gVmlvuwKrVuibKHn6UPqnZzxqg4h739ep+zZMU
 0JJMaO9r8GbL/75xBfyDgiAPSPNDLA+9hNYRCNRP3KohRniwSVJ9IGHn0hZwN8WNein78vYeab4
 l9mrx/m6yGjZNfjJpiy4qg1YzoMRFwjrsviK4OJvUSF5Ld3oKnDZc80Jiaw5hhKbgmkhsQbV/wF
 jMMvlqY+HPSYSl6xOI4xEMwgYTjTs8bEN1zbghV1nw4SnAq/rtAGKc3b2rqVeWX6GNt5jZMpWkX
 Fz0177bsmBm2Dwb+B8J2QkSkDu8FZ0P8nk0wpH+wQGBO/OLMPc8EG6wtWA7FakgzFFO1X96eB3+
 E0fAXxpyCbmzmGoVkMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040073

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

