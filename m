Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9B3E7BB5;
	Wed,  5 Aug 2026 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920146; cv=none; b=HldAP00NI2Ko4ltGlr5OlsWoczzjY3Bb8dQPE+8JgtbBnskViy/trj8JJ1B43IuP3L1IF1/rMyILFY2gunLLSAAyxArBDLauH66v3s1C++v9byBGu04lf/n2hHhOEH5Yqc9eiSd3xnhhmgLVvoOkOK4ofkKMAbT2e+L6XkBnR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920146; c=relaxed/simple;
	bh=+Q2bIZm/6vGOK6/QnjdCZNoOFsyw0U60p4/Bdc4+eU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6LPhh6fYZRXtsDeNemySbwEUNpsQT9szX3+GiP3ey7K+XPvGaqLZA9QT9wwYO9Vy+CTzKivKRFcMvibEjRlcVOuZ/crqS08JgCzBZDYH/UHBFn5prZnQpOSAL9rDBEd4zHspQi0UNKxdVviPm39H8p+qBtzW/+xELtKUcsOmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8PVx76u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8PVx76u"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dAO42128928;
	Wed, 5 Aug 2026 08:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BkTJNshVqHa3mBbTpFv2gIiMyHVHhJZBrdr/LAVLnz4=; b=d8PVx76uHxKOkalm
	HGCBtTyZGlG8pyXaIc+v1HxRzVvnTXULM/U5mPgRw0+ajZvpqZhvRaT8cSm+Bf8X
	qzuu6MfahyYphD0qfdCaDyAncXeuo4YZNF3JzW3SqR7+lj0k0A5tWrfmGnzzoVzJ
	HRl2U73a0zyk1uSuzXqnfdNDUVxpjHluwCxh/V/0Ex8tzr3BU8had3d3RdMSLjDL
	F2WBAaYNgHjPmwiig2SrTf/qMk+JT1xc76Uy/h5M0ywzuOfkkQQLudujUlKuFTXy
	4MFbXbPeyJXHDJ7UIgofvBUHmT4lw+rCdbbUgxhP8jjV9/n5PAaILQeLZIYBDjZF
	Y242xg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv1qg83k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:55:18 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758tGFq007373;
	Wed, 5 Aug 2026 08:55:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vje9uy-1;
	Wed, 05 Aug 2026 08:55:16 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6758t5qJ007272;
	Wed, 5 Aug 2026 08:55:15 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6758t23M006999;
	Wed, 05 Aug 2026 08:55:15 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 14:24:57 +0530
Subject: [PATCH v4 3/3] watchdog: pretimeout: update PSC reason in panic
 pretimeout governor
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pscrr-reboot-reason-v4-3-54ef517084cc@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=I+hVgtgg c=1 sm=1 tr=0 ts=6a72fa76 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=_jlGtV7tAAAA:8 a=FYyizyoliohAzulCZuQA:9 a=QEXdDO2ut3YA:10
 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-ORIG-GUID: VdTel7NyE5h9VEtV_l2cg_NPQRWn0vTS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX0nFr1/4VJHZT
 JfbuNvDC0MdjauioOa+7+prQV6enqkJvELI1R1FUJoUY5wnSyy8mQhhQPeFLS4F3X1+LxcPsbdp
 xrByrZ7TGyJ/hGN9am8t6D00i48j4E9qq7i8e2q8Kd8zapIVsoTBpDrWi+hKqSOKNt/aW8Wzj8o
 /R5aPot8y3xQ5orLO3qRxNNG0rZMfxqCgWUuNUr6/851X41Ss5+bs4avmwwGKMHfecDDTm/3BB3
 MHCGBYmjj9bSj3VKhe4ucGKXTVxMWK99jmyentfKeKHll3gywA/9RNrQn+BCQo6eGQHGigJ6Yqd
 R/oZIy8Pa1t3HlabCd5VFylCiXvnZLhqI6eiqyqI6vrNVSXsy7Xgp6p5izIgFhDhsTLh3mOmtT3
 Kiyh5E2wSLUcKaPNkdG3O6kb/KMLU+A9mYCcFBiEJHzuZSLeuQsVHDXpjogcLPFWdldt2PCJzR/
 XyNrzPHek+yJ3/+QozA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX4po1wMm8MEoG
 TZWq28k5jz73/C7U96sbX3bNpYiq9T4XeS369rKwxbc9MJF4/OmCtBzLTOEpc5L8JPeuWOmBqfB
 ApFaO4szRJ1Lwz+8mlBZ9l03VXrYsSc=
X-Proofpoint-GUID: VdTel7NyE5h9VEtV_l2cg_NPQRWn0vTS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050069

Update the PSC reset reason by invoking
set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) from the panic governor's
pretimeout handler before calling panic(), so the reset cause is
committed to persistent storage before the system goes down.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pretimeout_panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
index 8c3ac674dc45..819487b5e6fe 100644
--- a/drivers/watchdog/pretimeout_panic.c
+++ b/drivers/watchdog/pretimeout_panic.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #include "watchdog_pretimeout.h"
@@ -17,6 +18,7 @@
  */
 static void pretimeout_panic(struct watchdog_device *wdd)
 {
+	set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
 	panic("watchdog pretimeout event\n");
 }
 

-- 
2.34.1

