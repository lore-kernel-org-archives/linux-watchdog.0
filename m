Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA194315A;
	Wed, 22 Jul 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733218; cv=none; b=nEcJQ+sxeUJka6H2E/xioO36PEU6Vx0lz95tQK1ce3XV3H/l6uvCPdMn3K0TEOFiiR1m/5qJmi2lZcwuXRRIBPjBDi1+vXNsoPl79qS/Lpr+3OEVk55nECvpIm26QK3c34doP06qTyaiBv5RIMUJOVh6ZonTPcZUJBpS7OZdye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733218; c=relaxed/simple;
	bh=y2vls3x2gNwN6HCM1KOY2Lv3qcDk+OrAfe0zg3iWYlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AX5bpHocpBEL20XcK7vn+SBcVWuBI5MSPKZanky5IV12VWrKqhKwJWg0GRrybXNyM7JQHG1y0sj54jsnxmEmXcU/0nnrwLtT64ADPJLTEtIeArKF7wNsCiCH4lPYJ0Z/jRvWnd8LdQu94wpPg0pY/mqX31po2oDsROkCDYdakYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZcerJhnd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZcerJhnd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWO7Y1155208;
	Wed, 22 Jul 2026 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9m7JLQUoTvBNlHNB4ZSn/XnVf/99ICJmCO1B0yXyh3o=; b=ZcerJhndXZpktCmt
	Hc159U3hQXH6cH+BZzZjPr7em7z4Y+Ri+L31X9VYdzzXZbLrm/KMjsxbv2cTqPyt
	erYhHCDhXdiFPQN2sPnBHiZ64FvZXfDcKRterVZveyr1Mh8+OgxeU6Em1TDaYT0T
	TS0Fg/MkrVYTk4GrQslqAwv5iDde0SgTOd80DJgbiE5BjpoemYsQ/D8jiiVgdNjr
	AsGMEAj6cH809IRVCKpniwxRhCUQA1Spn/nBuxOswmDAbVYVxS7bq++uKDN0nDJ+
	9sqQ58gQ7wUO+I1LlTK3eOX5aci+eul4hoBF0ejogZNqVAVrpSd+kgCCKKqjI3fd
	Kx44aQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt23kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:13:06 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFD32w008354;
	Wed, 22 Jul 2026 15:13:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fgj3wkww7-1;
	Wed, 22 Jul 2026 15:13:03 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66MFD2Fl008335;
	Wed, 22 Jul 2026 15:13:03 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 66MFD2oF008314;
	Wed, 22 Jul 2026 15:13:03 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 20:43:00 +0530
Subject: [PATCH v2 1/3] power: reset: pscrr: add kernel panic reason
 tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-pscrr-reboot-reason-v2-1-495ba3005953@oss.qualcomm.com>
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
In-Reply-To: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
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
        linux-arm-msm@vger.kernel.org,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: ZV9FowBpCHdp6FPmHm5bqcsAPn_Q2fCZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX0SZXPnf2UxUW
 TC3XB03A7i6TKmRWFRc2x9naKDOY3+u5mPaNr9NMXJEUOPbMk+rKE38QapbVqRd61rz3kNNKMky
 m7PXiO/C7g65xArBNYV7LMKRwK7sxrbouZiI1TBueGklAhz1C0XqrVZM7nNTNv6zZ2ZrHnlGG5m
 2k9IqTj5vQoZaubL0H8ZjBNG3Cp9Tsa0wyNH6kTU53gwWe1+pvXag9w5NYAoF/Jth7vh7qaophw
 tJH4RZCS4UtfSmuSCOzO49d2lOB60USJ/pPPYLmSfsIp9r4RQ8nG39BGkAZHnde5Quflf0jgDw7
 0pOwu+2AbFtACl/4Gnp9/qykXJJ7JlfNNepKUD7Qaf+bf7Mf9hhxcRCpewA0Mopw3WiRZDa8Zl3
 M6UMX0ARfk9pJtcor4lTCKmyO4+GPNc8jc3sIkJL1oiVjFBdrbLs4O0cmVeY97Hl9xk1ce5+YeD
 e4TJiAA8iGhb5MJBJFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX9nUsjz0V6ZYM
 YdJfY6nwCOX2/Z9ayvV0udDvvMOc5a/0VszXJxRrnX/G0fYxRCcQ6Ti82OAREQsECCtxu+QX8JW
 dREMYPzN0a721LxBS2C3L3PVeWIjVrQ=
X-Proofpoint-GUID: ZV9FowBpCHdp6FPmHm5bqcsAPn_Q2fCZ
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60de03 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=g35WXu8YXKVBwXyYHpMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

Kernel panic resets are not recorded in NVMEM, causing subsequent
boots to report PSCR_UNKNOWN and making post-mortem analysis more
difficult.

Register a panic notifier to preserve the shutdown reason across
panic-triggered resets. Add PSCR_KERNEL_PANIC as a dedicated reset
reason code and its corresponding reason string to identify kernel
panic resets on subsequent boots.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr.c           | 32 ++++++++++++++++++++++++++++++++
 include/linux/power/power_on_reason.h |  1 +
 include/linux/reboot.h                |  1 +
 kernel/reboot.c                       |  1 +
 4 files changed, 35 insertions(+)

diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
index 92e8ef97421c..b5906f127e88 100644
--- a/drivers/power/reset/pscrr.c
+++ b/drivers/power/reset/pscrr.c
@@ -60,6 +60,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/panic_notifier.h>
 #include <linux/power/power_on_reason.h>
 #include <linux/pscrr.h>
 #include <linux/reboot.h>
@@ -78,6 +79,7 @@ struct pscrr_core {
 	/* Kobject for sysfs */
 	struct kobject *kobj;
 	struct notifier_block reboot_nb;
+	struct notifier_block panic_nb;
 };
 
 static struct pscrr_core g_pscrr = {
@@ -136,6 +138,30 @@ static int pscrr_reboot_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int pscrr_panic_notifier(struct notifier_block *nb,
+				unsigned long action, void *unused)
+{
+	int ret;
+	struct pscrr_backend *backend;
+
+	backend = g_pscrr.backend;
+
+	if (!backend || !backend->ops || !backend->ops->write_reason)
+		return NOTIFY_OK;
+
+	set_psc_reason(PSCR_KERNEL_PANIC);
+	ret = backend->ops->write_reason(get_psc_reason());
+	if (ret)
+		pr_err("PSCRR: Failed to store reason %d (%s) at panic, err=%pe\n",
+		       get_psc_reason(), psc_reason_to_str(get_psc_reason()),
+		       ERR_PTR(ret));
+	else
+		pr_debug("PSCRR: Stored reason %d (%s) at panic.\n",
+			 get_psc_reason(), psc_reason_to_str(get_psc_reason()));
+
+	return NOTIFY_OK;
+}
+
 /*----------------------------------------------------------------------*/
 /* Sysfs Interface */
 /*----------------------------------------------------------------------*/
@@ -349,6 +375,10 @@ int pscrr_core_init(const struct pscrr_backend_ops *ops)
 		goto err_free;
 	}
 
+	/* Setup the panic notifier to persist reason on kernel panic */
+	g_pscrr.panic_nb.notifier_call = pscrr_panic_notifier;
+	atomic_notifier_chain_register(&panic_notifier_list, &g_pscrr.panic_nb);
+
 	/* Create a kobject and sysfs group under /sys/kernel/pscrr */
 	g_pscrr.kobj = kobject_create_and_add("pscrr", kernel_kobj);
 	if (!g_pscrr.kobj) {
@@ -371,6 +401,7 @@ int pscrr_core_init(const struct pscrr_backend_ops *ops)
 err_kobj_put:
 	kobject_put(g_pscrr.kobj);
 err_unreg_reboot:
+	atomic_notifier_chain_unregister(&panic_notifier_list, &g_pscrr.panic_nb);
 	unregister_reboot_notifier(&g_pscrr.reboot_nb);
 err_free:
 	kfree(g_pscrr.backend);
@@ -391,6 +422,7 @@ void pscrr_core_exit(void)
 		kobject_put(g_pscrr.kobj);
 	}
 
+	atomic_notifier_chain_unregister(&panic_notifier_list, &g_pscrr.panic_nb);
 	unregister_reboot_notifier(&g_pscrr.reboot_nb);
 
 	kfree(g_pscrr.backend);
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index bf9501792696..4ac1bdfdc211 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -19,5 +19,6 @@
 #define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
 #define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
 #define POWER_ON_REASON_EC_PANIC "EC panic"
+#define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
 
 #endif /* POWER_ON_REASON_H */
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 6477910c6a9e..a492b1652038 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -236,6 +236,7 @@ enum psc_reason {
 	PSCR_REGULATOR_FAILURE,
 	PSCR_OVER_TEMPERATURE,
 	PSCR_EC_PANIC,
+	PSCR_KERNEL_PANIC,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 61e0027b7550..f1df52f8773a 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1065,6 +1065,7 @@ static const char * const pscr_reason_strs[] = {
 	[PSCR_REGULATOR_FAILURE]  = POWER_ON_REASON_REGULATOR_FAILURE,
 	[PSCR_OVER_TEMPERATURE]   = POWER_ON_REASON_OVER_TEMPERATURE,
 	[PSCR_EC_PANIC]           = POWER_ON_REASON_EC_PANIC,
+	[PSCR_KERNEL_PANIC]       = POWER_ON_REASON_KERNEL_PANIC,
 };
 
 /**

-- 
2.34.1

