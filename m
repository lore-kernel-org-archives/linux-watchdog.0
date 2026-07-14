Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858A441044;
	Tue, 14 Jul 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022820; cv=none; b=NwrROTLuAKYH+anV4pw4Ffov2bHIp/rrN0fNRgxIsd/QvY3+67K7TVr8sjuHl8nHLIxCcUayh4NEhTLH0qMtvAK1ZvKObzRjdtkWGWfn2VME9xsM30rBhEY2a74pCuw02/6c3aUGdmeoU5kGYJzanu7dLeswNbZmhY/vrGaqHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022820; c=relaxed/simple;
	bh=rSMTp8ISgDn/bMjuKIZ9KOzbTZ+NXIxUne6k407nwUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9mlj2RpFYOoMkDY44wMmXrklTLXfsf2CK5mHu4WnzeYSzohsSD2nE4S2IbB3pSjCOetfdcZC0fEZEdm65j3ERUQjZPePfZkb1KOOyPIBaRfywm+9QNkHS6UA8REF44V5px2mV7H6zUie4J+hsf8Elu1ntf+3RungqlKNdRyzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WM3MAL3h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WM3MAL3h"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SdcW3887447;
	Tue, 14 Jul 2026 09:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9kNdjl4bFrLdaqYqjwnotLnVSZPamlRAALmesQBPyfA=; b=WM3MAL3hfxmr0XGU
	g/4+/U0p6b/2hrN+epduok/QgItPJ7Ypf9sPWmnHNEpvt+o55adKFgJKspj3rkBN
	zBQYIwopkmdJEQuh7GKanCA+sbSyzVeV1KFTTQ9+bRD8it5TuEhVVbtRjSjfFgGh
	MCWxyXwSaaFDDDkmbtjHFg+xTI4rG2N1cjZ1pybqgcsft+8EEoxkiwMmupJECxeJ
	ukbnW6NT73szZOLncOgXaCHAJlN/VJ1ih5zeidxolgxEICWAbG5aEJ17R4e4jZnC
	oG2A5dKV3Uc++ZKHePn5lvLTfnLxvQ+5AQafy4mkfdKzVGx533jGcsjmWgBflLOD
	lfm1bQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr49nw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:53:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E9rB6Y014868;
	Tue, 14 Jul 2026 09:53:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4fbewjn02m-1;
	Tue, 14 Jul 2026 09:53:11 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66E9rA3B014765;
	Tue, 14 Jul 2026 09:53:11 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 66E9rALd014592;
	Tue, 14 Jul 2026 09:53:11 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:22:34 +0530
Subject: [PATCH 1/2] power: reset: pscrr: add kernel panic reason tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-pscrr-reboot-reason-v1-1-a09f23b12527@oss.qualcomm.com>
References: <20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com>
In-Reply-To: <20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
        kernel@pengutronix.de, avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: qZii3c7XpnlBWdFuTzOuXgeTFq53Imxq
X-Proofpoint-ORIG-GUID: qZii3c7XpnlBWdFuTzOuXgeTFq53Imxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX3UYSnlMbIS8U
 IY2F/c8yOGQDPuhwRCRHaodAdLr67Y5OqolHaAPu9brB7GHacy5LWyg7rpHE4APhlSrEw2G8zT2
 FNQ/FYQso/ASR0ZiV+Yvl8kPUdMAgxoMR8gMJ/k8GqrERZOID+p8Ms/wsNWIXJGbdJn/mHgHlHb
 0JyetFpFEaSNNvRetKZltR6GR0lHOD5vJUwPCte7BCmeOumX1Y4LOUFo69piqma8shnNT4W1Zt6
 QyPHgGViFsbuhFSry7E1NCzfNXWHVbhvkQIVov0j9y+cFvWke/np+5S0rXqpqhlw7GeZGCo1r9/
 00yEImpdbTRsHt9LGgyMOMZgGbINdCK/xy01+3MBSyNnWzkLRA23mhw95GGUkAEw1niUOgWHVPm
 euaQbCx9UDmh0baOECzDpiGCb85Ky+wWvZruJIN9jp8w+r+nclgBsoEMwKtt3ksYyfHcu4A+3Mp
 1ZHg0sS80b4Vi2GHTOA==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a56070b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=g35WXu8YXKVBwXyYHpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfXyl/frrX5/WOs
 u3eZZGFcBaLT8LadHPbpRtAXXv8o2j+j18EEZNhJLjR6pVEy6OuItrVPeU8lH8Qrz1AuXpPv3D+
 WFqfj2gidmNepHNn/sh0cbjkCBXOqcQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140103

Without this change, a kernel panic leaves no trace in NVMEM — the
system resets silently and the next boot sees PSCR_UNKNOWN, making
post-mortem diagnosis harder.

Add a panic notifier so the recorded shutdown reason survives a kernel
panic and is available for inspection on the next boot.  Also introduce
PSCR_KERNEL_PANIC as a dedicated reason code with its human-readable
string so userspace and bootloaders can distinguish a panic-driven reset
from other reset causes.

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

