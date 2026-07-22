Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77F361DCB;
	Wed, 22 Jul 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733219; cv=none; b=kL3qtHzyT01QnjSRwBTxMxypoVWj2FToiwNnT7FX9xKKsFa3lIE9vacA3/onxJ5Mqn43T9sysAr1TMmqQ6/FDcLiSfLXmocmVUO/G0OthJro0tmhjA4S/P2V1M3ysa7KYhOzLeRhQgaj12gSye/e9qWcl0yOEQjf2dRqNlcBsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733219; c=relaxed/simple;
	bh=1SEAhKVvKPt75Kqu8x9U2ZorublhrIjQuU/b9rN/V4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBXSDQ2vmtXzdlOjITthrpgWfHlBAXRj+juYlTELw0Ovh5zu7JrU434bAcilHR9okiXXtUvAawZDuXAv1nqq37Q27+9PAOlLhShkXXrbzINVp3/jP9/YivApCvvkJE8qR+bz27xg8OeCsSsq/c88wZiWZinjxQ49oMM9JAn37Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZ/4jTSF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZ/4jTSF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWZQf974008;
	Wed, 22 Jul 2026 15:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	67DLzE/xOfBFWWlKYKzL9oJKbokILOtBIXG/f+P6T2I=; b=jZ/4jTSFBrmOKh2R
	tzoPUE8RG5G9T0/8VDdkatWyR8Gj1SS0K7yYZb9edtds0jkWBtVftDBYLz7qnkRZ
	up3PIGLV0Mm93awSbrolrO8rAPE+zxzu1HY61tWQkxwvCGBI8TaF0GOtf8E+6gm/
	qTZsGuTm7p99hbrDS43PjJi3DzDUEjGf48hOW1MV0KM0ufHTmu5WqGMVzgnGX8N8
	08J3LYhOSaEhTFJ8l7UYk9lSmqkrYrOg/C/grcp0gySiRaGOKoPQWOeSdMjQLY92
	oJGRjTk9lHBMonnsY+p13tVI1BcS4yDLypGkXPNTzUgrx5PmXMUtEOlCgiL9uLCu
	aTwKpQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjuu796ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:13:07 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFD32x008354;
	Wed, 22 Jul 2026 15:13:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fgj3wkwwe-1;
	Wed, 22 Jul 2026 15:13:04 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66MFD2Fn008335;
	Wed, 22 Jul 2026 15:13:04 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 66MFD2oG008314;
	Wed, 22 Jul 2026 15:13:04 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 20:43:01 +0530
Subject: [PATCH v2 2/3] power: reset: pscrr: add watchdog pretimeout reason
 tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-pscrr-reboot-reason-v2-2-495ba3005953@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: HSUbwy3rFfU0bnzqvy3U6UU8IadgTnxf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX2Fe3AubvUv7g
 nRpf1Yfzncm/xzO7ecX8oFquwsAjrlKQ+CU3hQQ4agvIh/vzrJ5t4WR1X4nDdjUPyRF2gFNHg3N
 pUnZzRhF9gvpQeMZngXMNBpoa22iZpc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX4QtQ/l6/+yFc
 CNWuKM0qf7lQgp04E0SSgXinNDAK6iDm1T5BlJSTqVudFTZwJwgrFNKfMahBxRVc5pEZtFhjzZ5
 /hngH+9zodE2jDycvirqY1GmhEjxPFtiQuYpG+VZecmZTDE2k6z84l5P4GtrYaPRcorI0ItfjQN
 L62h47oWylMZ1TbtUyNcQVCq1eMKu6KWwg6TAdvQs1xmgXRVAnu/ONE9ds5PtS5BQDVXdABGDaP
 6yvc62X8GFTffVs/m3D6bkSd4+7bDiamsBoFNwtYBh5AMBQz9hxOTWfcF3XmVvWc/hQ10z9wSO3
 7n25n7jN2rKCKn/Cz3tJ3JPTAnh3+a2pHucSAaljkz8FVjJi3EOEH9YQSRz3Mx7Lp8jvsUaGN5K
 G/Eq0a9MR3lWaI03ce14GzWNaLkuVRcXyMCp/0RO2BRtE/29KIgxsr8xFi7qM9S15evsVnAmYeD
 p4LmXvaiUUN4l8J3gfg==
X-Proofpoint-GUID: HSUbwy3rFfU0bnzqvy3U6UU8IadgTnxf
X-Authority-Analysis: v=2.4 cv=JuTBas4C c=1 sm=1 tr=0 ts=6a60de04 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=fOviudB5TvK5EqJ1EysA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

Watchdog pretimeout resets are not recorded with a dedicated reset
reason, causing subsequent boots to report PSCR_UNKNOWN and making it
difficult to distinguish them from other unexpected resets.

Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reset reason code and
prevent the panic notifier from overwriting a watchdog pretimeout
reason with PSCR_KERNEL_PANIC when the pretimeout governor triggers a
panic.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr.c           | 7 ++++++-
 include/linux/power/power_on_reason.h | 1 +
 include/linux/reboot.h                | 1 +
 kernel/reboot.c                       | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
index b5906f127e88..5b107c62fe82 100644
--- a/drivers/power/reset/pscrr.c
+++ b/drivers/power/reset/pscrr.c
@@ -149,7 +149,12 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
 	if (!backend || !backend->ops || !backend->ops->write_reason)
 		return NOTIFY_OK;
 
-	set_psc_reason(PSCR_KERNEL_PANIC);
+	/*
+	 * Do not overwrite a previously recorded watchdog pretimeout reason
+	 * during panic handling.
+	 */
+	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
+		set_psc_reason(PSCR_KERNEL_PANIC);
 	ret = backend->ops->write_reason(get_psc_reason());
 	if (ret)
 		pr_err("PSCRR: Failed to store reason %d (%s) at panic, err=%pe\n",
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

