Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B44446F7;
	Tue, 14 Jul 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022819; cv=none; b=UnNYxIYaGfrbM1ZSNaWmjOKHCDRTH3GYY8W4Dcwbo/5OFWK242GbYA9TNGN810CODjybXq1iKTDcR9fUxw8DwoMifoagpoW1sSOxZ1RiXtun7dkBS/iPSl3x173Osjd98pYjQW8L0JDwvV6QXne0cPEBD4QWh0X0WC3XaOfD/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022819; c=relaxed/simple;
	bh=FKp5m29TOAQzde7ocGmTpd8DFthMLEJaCkRcIenZ9/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EuKaVRZrUd5t+TtOxnXJ9/si6qUINaImHhEzcIA1HRvVTmiHOjRnRny5dNeMV0seZsntX73ItTjkIX2UbnBarCuoJptMi7Z4PgSdND/FRvN+Wko3cacuaAewsxZknHmZQUJyy0x9mLscB9sEU7Otkw5mRhy3fZLUHXy1PSVf2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWxAfDTq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWxAfDTq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E77A9w3931648;
	Tue, 14 Jul 2026 09:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YYrmOD1ftJXGFPH9kBptAhVJWC0gqit7E0eJP3zdy9s=; b=LWxAfDTqqE2igb5b
	oRGb/GvPdqJs2iq2H1zu8NIzhdRzms3ZXa9jQkQvhuTQsM74wUL55ldkk8CxqdOk
	GNMxw6RycxgXRPQFNU/QeBMi+XDmlsnUHqPw4CaF0nGrX+2VrZTJ0CMHQShImAFt
	a6cs+FIm0fcXlJ2oOtGW4tzY0gJ6k37YQD/GlYIHVFkYtYdl11UymVvCf+hC93CX
	d/gP49rUvrQ177mdT0Fsxvahm0tu/oMugfT35t3hqWpNCv0FsBeCY0mafkYLdj0t
	uc+WTLbt0Q2jSbKemB9we2BQi7iGDic+qzWfQfZzoEPOfS9y84paBuL2jGr1ffQA
	67Vy1w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq0mda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:53:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E9rB6Z014868;
	Tue, 14 Jul 2026 09:53:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4fbewjn02t-1;
	Tue, 14 Jul 2026 09:53:12 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66E9rA3D014765;
	Tue, 14 Jul 2026 09:53:12 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 66E9rALe014592;
	Tue, 14 Jul 2026 09:53:12 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:22:35 +0530
Subject: [PATCH 2/2] watchdog: pscrr: add watchdog pretimeout reason
 tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-pscrr-reboot-reason-v1-2-a09f23b12527@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX14Pc6HYR8NYv
 gkNo2bgbbJOL62ofj1o8yOvp+rL6F75VjXyFpKwWubdkuD4qqslidmE6cGUvRFHZ1UZzM0eSYOg
 VlURkKNetNb6zRtJX/fFoq3vq5rhebv5L3YeocS1hZmZDkd8imTJpGOOw7HZAe/CNQHVASslfLW
 2ahnFY14f3O+nvjBBx5lfVLlvx3+1HcVvtBzRcExF4e6C+L39ufYA01Zvyr9VSojVT71TjjBlHu
 d0f+OmtxT5Byxphbpi1T1ihTVQVAHC8TIfr23ZkxyAMWLYYDOIXwqg5zE2bwIpH8YBqT9nG9Br2
 Z3LWu62GrafAxtJOmd6Du2P2YN4XDqfQlDQ9QPVFQJrzGzOLI5iVsYdoBgKE2RHLy8kGiSWeACZ
 eT1+aVphu9pNWS/U+F+duDh9t5uAGh+JhcezZFeDqbH0rcRYuPIHk3oZ3pCVQCBXiT0lBSjnFFB
 una/usN9QtW9l9CV6rw==
X-Proofpoint-GUID: -7_4Vg43VTS1JvLkBL_acYAXsVSiN-ve
X-Proofpoint-ORIG-GUID: -7_4Vg43VTS1JvLkBL_acYAXsVSiN-ve
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX0c90PwFMjy7e
 58w8eSpZkZfN10gn7abNs0xXaeyIkzjWbEUcKa5DXUVQfEpEJFiULpVLkdzPeISqYxgvF01qBKD
 cQFxRFGJ9VpkRd/bIJvsgPXX0BNIMLM=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a56070b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=msI2DHvZLTNjIL8QZWUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140103

A watchdog pretimeout fires before the actual reset, giving the kernel
a brief window to record what happened.  Without this change that
window goes unused and the next boot sees PSCR_UNKNOWN, making it
impossible to tell a watchdog-driven reset from any other cause.

Call set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) at the top of
watchdog_notify_pretimeout() so the reason is recorded as soon as the
pretimeout is signalled, before any governor action runs.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr.c            | 3 ++-
 drivers/watchdog/watchdog_pretimeout.c | 3 +++
 include/linux/power/power_on_reason.h  | 1 +
 include/linux/reboot.h                 | 1 +
 kernel/reboot.c                        | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
index b5906f127e88..36642cf9f27c 100644
--- a/drivers/power/reset/pscrr.c
+++ b/drivers/power/reset/pscrr.c
@@ -149,7 +149,8 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
 	if (!backend || !backend->ops || !backend->ops->write_reason)
 		return NOTIFY_OK;
 
-	set_psc_reason(PSCR_KERNEL_PANIC);
+	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
+		set_psc_reason(PSCR_KERNEL_PANIC);
 	ret = backend->ops->write_reason(get_psc_reason());
 	if (ret)
 		pr_err("PSCRR: Failed to store reason %d (%s) at panic, err=%pe\n",
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 02e09b9e396d..ea48d4eca4aa 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/list.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -103,6 +104,8 @@ void watchdog_notify_pretimeout(struct watchdog_device *wdd)
 {
 	unsigned long flags;
 
+	set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
+
 	spin_lock_irqsave(&pretimeout_lock, flags);
 	if (!wdd->gov) {
 		spin_unlock_irqrestore(&pretimeout_lock, flags);
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 4ac1bdfdc211..c5846c0ccde4 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -20,5 +20,6 @@
 #define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
 #define POWER_ON_REASON_EC_PANIC "EC panic"
 #define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
+#define POWER_ON_REASON_WATCHDOG_PRETIMEOUT "watchdog pretimeout"
 
 #endif /* POWER_ON_REASON_H */
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index a492b1652038..fccbffc9dbef 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -237,6 +237,7 @@ enum psc_reason {
 	PSCR_OVER_TEMPERATURE,
 	PSCR_EC_PANIC,
 	PSCR_KERNEL_PANIC,
+	PSCR_WATCHDOG_PRETIMEOUT,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f1df52f8773a..629002a951c2 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1066,6 +1066,7 @@ static const char * const pscr_reason_strs[] = {
 	[PSCR_OVER_TEMPERATURE]   = POWER_ON_REASON_OVER_TEMPERATURE,
 	[PSCR_EC_PANIC]           = POWER_ON_REASON_EC_PANIC,
 	[PSCR_KERNEL_PANIC]       = POWER_ON_REASON_KERNEL_PANIC,
+	[PSCR_WATCHDOG_PRETIMEOUT] = POWER_ON_REASON_WATCHDOG_PRETIMEOUT,
 };
 
 /**

-- 
2.34.1

