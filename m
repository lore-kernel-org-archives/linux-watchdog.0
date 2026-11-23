Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417541;
	b=KH2gDAC1x7bI8i/9TkpW56tSBlTuPAa54PAh6rzYnaz7FveD7UuoZqlTTtxtpzeKMmcu
	 mB9xv8GGCbS2GhHAAB2S6hoO91lNZnbGo3WQ0yy5oRSGvJHueYLYihkmBUVNO3cV+lqqI
	 xhltCqlbqRm0344ofVKOWYJDG4zOJawEjBq/AIJSARFQM7iqtmrjtdfzV6BvAohFVMsEX
	 aWVFVfO7nSleH2X4m+GASlCJHweMulDp+RCMRyoG9749CEdCYLnRUNbELGbPWyC04YA8c
	 fFKGuyfZ6dF1Mx84dZw/Q97e3CPCm7SKt99O1ts3/KjqIkyXTSghqOve0lfLFnjgQQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417541;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=p6K6BHA8f60tUUn0BXpwoKTl1UjqiSlQvS+aUVZvn0M=;
	b=aw98yWy1zlV1DeriMCB5PlQu6w9a4ERuYNy7Gq+jwmBaAYP9ru+dq/045jj5mSa+Cgrj
	 929wC3sF52TrH2f5MwKgMzeByZ9Q7U9LnGUVSeu1MKjHgAQaprxQ2cCOodjcn6yLRyiS3
	 zeoJo4gklZGSWUnSos1OrqQUOX5bKc+lKl7XXS5ybADW+zfq/RvyJW+YSKqqlkjdhTnhC
	 acFYWCcVkRjlo/7zcOyusKtv/PmNmwSJ62uFcpmJaOtFnQOcri/fWF9VKeCM95qGtDeLK
	 y7f1wWFAXAaJpeJJWTlIxwNCOASEVU+nZMQg7lQepu/UV4vZzbm3k8pXK1J+3aYEqtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MKeyK6oU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988C606A31A;
	Mon, 23 Nov 2026 07:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4988C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MKeyK6oU
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN6PZP83713062;
	Mon, 23 Nov 2026 07:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p6K6BHA8f60tUUn0BXpwoKTl1UjqiSlQvS+aUVZvn0M=; b=MKeyK6oU+KNsKJgD
	I1bakOOX+ujXmshp4r9OcPex82Bdo3u6cX7ydKC8Wk1mX8ceJJDV3TcHGsHX87ar
	6dQMfb0r1T82t0kq33/B0Db6zgRe8s/3XWFzvXwBO0DslcnqIHdjcMiRAGXheE20
	V9nb/+D3dwPNVIODYbfRJ9vYP4+/YuGBiQSNnlYz5DCUi+rug9vTOwaUL588H2IO
	1HzUGoUw6nSo/LaEvpGLBYPx6kkoAkhjAhLOjBEtw92a4xbTYEU0lSZNtVW9L/+4
	UZ/pzMxAP61w6+BH8E9BhtbZKJVEBRexNcJlOPaqk+TWOL14gpEz8Frem5OsyMR5
	rGv/SQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g740500-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:05:07 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN72cFi4179942;
	Mon, 23 Nov 2026 07:05:04 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 6AN753Q34185090;
	Mon, 23 Nov 2026 07:05:04 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 12:34:53 +0530
Subject: [PATCH v5 1/5] power: reset: pscrr: add kernel panic reason
 tracking
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
Message-Id: <20261123-pscrr-reboot-reason-v5-1-fbf3c7c92772@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: kg99tHVNhU9lTIAZgMBhrsM9W3Mtufw2
X-Proofpoint-ORIG-GUID: kg99tHVNhU9lTIAZgMBhrsM9W3Mtufw2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX61+4L7qx1w8C
 Z0aqJ2v1FvfXoW6lfSs2D5KUz8L6+sH/3SbmGRq3PVJn4+9zKGXeH/j1H14Jp3TwSwI6iEZ7Brp
 6BuRX/uujMhiVnXvSF/yCl99xpl7Usc=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b03e5a3 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=opvmgqTE--nunqmWsLMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX7rMQa4F2/tqz
 0s42MnDofvUEhm5HIdh//NbJgExe1qiUrYc4meUcdE+cDFgUb/hJ1cXew53JX9cFkNR/box2mH1
 DpXuMesTxorsuVBscJ6iGC9EZcS4nR64p2v0jsjjX+B13g3gIX2TqTjN/HGz71MCnEk9Ub9YQqm
 LpjHl1I4NjQ476wqAfqEx1KzE5LqLG3R6U4Dnp5kVoUIJ9QtjlE/tdRFXaFNtRg56NeIWlbuhc8
 qsNGJcgJzjejcBzszetRqylg82qbkFriFsa+CEEHYi8pk/ReLtw5bVxLTwQD8i/G2tkEtFaxY53
 QUQo37oWjoaDGJQIHUsLD8dmw2qxKN39xTZhQ3EHoxu/jVBPTCv5yNgWDDRlnG8WmYBDsOHetu4
 qyD4CcUtp4yEu6S3Yhks9dhBtH2nT+lNJGaGFQ4fInikNaxNRNBC8CVngLFMyohg8FZOjXNqkvT
 +QKcWGLcR1F3WzCpHqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

Kernel panic resets are not recorded in NVMEM, causing subsequent
boots to report PSCR_UNKNOWN and making post-mortem analysis more
difficult.

Register a panic notifier to preserve the shutdown reason across
panic-triggered resets. Add PSCR_KERNEL_PANIC as a dedicated reset
reason code and its corresponding reason string to identify kernel
panic resets on subsequent boots.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
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

