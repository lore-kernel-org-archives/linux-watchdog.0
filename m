Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A037646C;
	Wed, 22 Jul 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733219; cv=none; b=NLyDcmX0JIsnAhyNkBHchLAW6GxVbgZpMgnJww5hiMrDin6E1UPsrzDnMUB3jbe3s7eB5W2gH7QSovxRRSv1kUxBHNhmDoTkarJ3AfwBjL52fpSHzITeZdbEX++ZXRx9CX/PMogXCKJFdo5RIDE9FSRpm4ucpv289B2Nzk1X7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733219; c=relaxed/simple;
	bh=ndjeGxQkD4uKKZwGNqT3Zawn7Cw0coTQdfp90BYZHR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fs1BP88ipxR0yIPQcmzN5AVu3IoxCkdPxVCGi102oPZnf9/8ENaE8xb3VBkZe975DTnb9pnhhGeL30ljIDS3FKHabl0hY4MxkDnbwYUURsW+bskwk4eikv/alP09wq+duvUyJm8qVO+fVTesYF6AQM8mA1qUK+DokKdvB444v9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvLLz8BI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvLLz8BI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWYaT891466;
	Wed, 22 Jul 2026 15:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Naf1jXaUY7FsoPBxaL+DYSY1VTGS3cISXibfNYXEmIo=; b=LvLLz8BIWMr8/gfW
	pcQoQt4BOsm1bfelBcIyoT2Nh/nYwGPrpWPlojrUT2VRv8eWaWA/ShD2OMLDNjMN
	Fo2y+ybDZCFUq3yXSejfNiML3amlFCAb4UjQjd++4W+EGtdes2qey44A/inJgiOY
	VrFcmMgXj16RI57WAtZJSWrIACAB8tLsGCKczIRcS/20nYy+OrWJNl8b9bJNvVsP
	zZCZLyouqHiYkhHBJo61GTr/VsZn93Vq201ga186eDG/h5VCvETrNLrMwgKSAwpY
	kVIXygY2KPFCOMuiht+LSiv/ptZ315aUBQyKl7hTmA+jiwyqdiL0x+EWBoHvUjNS
	181kKQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm10gue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:13:08 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFD3Nt008341;
	Wed, 22 Jul 2026 15:13:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fgj3wkwwk-1;
	Wed, 22 Jul 2026 15:13:04 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66MFD2Fp008335;
	Wed, 22 Jul 2026 15:13:04 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 66MFD2oH008314;
	Wed, 22 Jul 2026 15:13:04 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 20:43:02 +0530
Subject: [PATCH v2 3/3] watchdog: pretimeout: record PSC reason on watchdog
 pretimeout
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-pscrr-reboot-reason-v2-3-495ba3005953@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX7ty8fhFTmhr3
 W7zqqIDs+I0Motkd3awLZ65Y4y9TCY6SgoZCRPqUIPp8j5Dscrsu47n+fGmv0yquajs1RWOl+Ta
 GtDUS6GEtfZbkmuA0fNdb0IkcysnGFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfXyQArMejeT2l3
 zn4wn1aBgkNTjpJW8T3aA0KQ4lT4UhQDfdWf2lXHG4r4+b3NpYciIc3eWKhyDDhDGDNBcGV2KmL
 Q6hbsH/ua6donP/PglFrr5mjKVOlCWVi2R7sQJLk8E22YuonT0W31LE80INQWfjF4SfynKSn9py
 n4n1+/WD7piDV/kRy0v4OhvXTz5YmwqGxvM5sPbWp+Y0jif9dp/1Tiem9m8HDvM+wlqkFSmgkfY
 Xo3j2Q65zjoWHnFe8tR6SRVt2Oam/Ky0KOafY+CqhdEiS+g+NscyosZooMkBRjHEqeg1/lFIh/e
 FOzj1TA5pd+R/ILzu0R5uMHFipE8Lyr3l76c5BWgq4AWf8QQaIFcMgrV+5B4onlMIWhkujJRVAK
 2HRk8aoRgZZ8pK/aeBF87/KLPWjbPaG0rR6eP/B1n9iQuBkSDD38u9Pgsdu0jQqPxkt+Bs5CVDX
 pZFR5TOvC7MzRxZIXoQ==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a60de04 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=u0fiqyGv5R-uId_FV4oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JiITKbEK0NW0dweN4F1L-azHAo4IZkJo
X-Proofpoint-ORIG-GUID: JiITKbEK0NW0dweN4F1L-azHAo4IZkJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

Update the PSC reset reason by invoking set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT)
from watchdog_notify_pretimeout() before either the panic or noop governor
runs, so the reset cause is committed to persistent storage before the
system goes down.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/watchdog/watchdog_pretimeout.c | 3 +++
 1 file changed, 3 insertions(+)

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

-- 
2.34.1

