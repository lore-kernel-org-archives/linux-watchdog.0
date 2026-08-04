Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708643CEF2;
	Tue,  4 Aug 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835329; cv=none; b=Y6VVAVCf22vG+HsYl40c6XQoL2w5eYWmfPRMfsPNQrAV5nX+GoyDuYkorBHz42JjM/Jl7P5qzGbZhfxsktJkzykQgS9UU3j8Btmn1P+aXe2ScJuf4kV37F3P7kK0T7YTG+ffi4h/9HPKJ1Pk8nZ/VJq48HMDsce/DNhfGEaNrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835329; c=relaxed/simple;
	bh=ARgR8aPbH4uU6yMM6lztEeNLijJyXZf2YV/9a0Is8LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSCXuNjDycgKdMqiBIUxWjObxO/wG6dQwC9hB2pbq9geYiCQReCoBN01xukYM7UVKQMbLzveHZAp0k6XPqvaWcA//v3neX1AOHHA7ndgCIktw3p9I+0HpxJbC7faw4u3f56qrETn9XJ/nRqfXfpnHsDvTzR8Efd2iGTuI9VFlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRH//DsD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRH//DsD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CMQu3300468;
	Tue, 4 Aug 2026 09:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SqqiIiH8h2AqcgR9DgbjNWCm4HTJ6T1Ws54sjHwyhZI=; b=BRH//DsDCbhIfuDP
	sDaPrrbDK3AMjbitqlE4okVUQJfVBeCFTvkE/W5zXknJleXk1CtdOs6cYvtSSTyz
	oYzr5MB76jKHExYhQHYkRN+l9nP6PX/DgjBuqfSiPA3LMreAitSgQw27MiafOM13
	67NtrvA7g4AQCrfxrX3phxM70RW565HuTiRTgmPZopYvKnYMFUYcf+q7jNS1PmmN
	9lrWOB7YO+ravzUeswtwDuSfPpbMkcJfNFoI1zc/sMltlfurM0495n1bvGGoFCFk
	tkBoCoP5P3eolzMutDVu9ZrE1IdH6N3jAKAnyPL/QVelr3br6EXPH08OdUM6lCjd
	cZaqCA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu1p8auh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 09:21:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749LaWq027346;
	Tue, 4 Aug 2026 09:21:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vjk7v3-1;
	Tue, 04 Aug 2026 09:21:36 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6749LY8O027285;
	Tue, 4 Aug 2026 09:21:35 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 6749LY9J027260;
	Tue, 04 Aug 2026 09:21:35 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 14:51:22 +0530
Subject: [PATCH v3 3/3] watchdog: pretimeout: update PSC reason in panic
 pretimeout governor
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pscrr-reboot-reason-v3-3-e706dbfc7465@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=A5xc+aWG c=1 sm=1 tr=0 ts=6a71af23 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=FYyizyoliohAzulCZuQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfXxBgajlnhQcXI
 7wQ9ebeYNA6cUpA3cn0mTRo27RHHV6tSaZKSyBUf5VNfviM35He/ab81F8xEg2W+4H6xXfjzavB
 q1aN3Lom8De280AwaAk11qwDyTrqnlmrnrdCKr22vsW4u92D9KciETj6DDB2ycgku8un3IxejzE
 xrkyWIb8A7G4Xjd2gY6dLIc1kOfaurfbh8T2zr8JIpkmmwHFCbEArPR/Glehp4oZ+pJLaNabv7w
 JlC3rYs5G9J0pkBku9Ns71vb5RVhxuxoFZL9gpHuQl3GA7pd8FwPb4367sYApWf79POQcKJ/7O8
 YzMaoMWk4iJhunPEYnzV8pfnRKQtEetvIOR0qaoEXHjju005uoPXZey3G2LqebZR/7OQi621qlX
 ihNEi2yjyrqn9kYSxoC+oFyLOhtmaXaX7re0P0SesRSWDfJr0z7HmTTH5jPvsiIU3ehKA5+1DWd
 lLmUvyXYKxiJ+Pl6zEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfXzGKZDv4041a6
 Ijk2u55T7GCFpxD7i5NxiHFpTLZwQpK38ejl6eeqlqMxr15A2VqCxdfKzM7xnekkc8qAhegaH0U
 d+Z9AaZwuPotb4Q1WJqnRCb1jJ9ha7k=
X-Proofpoint-ORIG-GUID: O-8R8Ss2-e6W8Go5svX2v1PRQW9s1qvW
X-Proofpoint-GUID: O-8R8Ss2-e6W8Go5svX2v1PRQW9s1qvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040073

Update the PSC reset reason by invoking
set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) from the panic governor's
pretimeout handler before calling panic(), so the reset cause is
committed to persistent storage before the system goes down.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
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

