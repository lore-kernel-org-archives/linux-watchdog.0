Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417548;
	b=5KyzZ67cJIlNsz27tVj8feD320giRbDnjHGj743wOCPhYc2/t5bqA6hMuu8Fk4dACsRT
	 JIOZbcNzaOzFMiE3kn3qmisIJtqWlwuXt76hzuYmKNfHEadccEA+J/Pmv6QGTLviMMfaX
	 v2ki8+HEb3IDqmb5Ux3yLKb6xQBTMQbK9oGfi5Gu0OKGwlsRLg84SFcg0VuAhC/1y5KM7
	 fJG6W2goa+EYuhtSHCHddV1g2mfxYNtioScveQf8f4sYbIOkA6//ZSuus5V1rNqMjoGmb
	 oGZAkS3v8Uy9UQ2L+xsBYc2vw4LchjGGZx2U1sLUaia8MMgftSIUUJBmLvDtXDvJNUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417548;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W/SQVaOt4hQUDstRSF5z1Q8P4LWhMQSIvuQSidCmHrc=;
	b=0O/abWlEY+Q9xfE1D4dKbccmkCfUYt94e1hGnPG5aQILTD5KmPNUnR2CkF5jxXErK5n4
	 yC2IQruX3SjRf9OMtDTqom6L0SJB9K0p+fxdcnLXdH0s5MxieRHgcxDObeBs0ciHILakV
	 zKJRKJNpU+ZL8ddHZNMcG0+41WlunyjSLlUvvzQA2p9qM/RJRFzv4gDNH1KSaMn6yjO+9
	 A98RcwWeEX8lBjxIKKS57F4pJE119AK1uwspQuj6Lo6Tso1M0BHYI8w5fhk1pPj894MRb
	 j6IiUEY184F+aftwJR+ttfkkyiQepB958Vx2Lvoy2TSExYLLwd0HYmPYo/KIJBvgmBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f6AaDQ3n;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E4606A686;
	Mon, 23 Nov 2026 07:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 247E4606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f6AaDQ3n
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN6Ddpr1490223;
	Mon, 23 Nov 2026 07:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W/SQVaOt4hQUDstRSF5z1Q8P4LWhMQSIvuQSidCmHrc=; b=f6AaDQ3nrZZXe1Vr
	L/73gyCjozX1T5NHBzetuNE+8GYARVqs50OMS42KwMKuy7AJDILRz6XECXuR6zD1
	tvIA0e969Z6bUJP/nb5RKzvS3zwQBmwz1aQtCByzpbiVqnbIeiAcTWUzraaK7raf
	wHD4hqLJecj0gqEqThRgM4tqWys/sN6GfMwMEuPXSOF0E6HUXmTNM44YZzbk/Fah
	xZ6Ad1xaEPb7swVxP67Di1hucw1QOZebYPPg+bnhY82DcWMSvnraW0yDUXY2GZRx
	U+XyZOXLlr1zFkSjDwtgpw+vJMu+UbvuLY/X4uckXrBNe+wqCDTgpO1O4OHe/op7
	pnz9+g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k05u7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:05:07 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN755ej4185166;
	Mon, 23 Nov 2026 07:05:05 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 6AN753Q44185090;
	Mon, 23 Nov 2026 07:05:04 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 12:34:54 +0530
Subject: [PATCH v5 2/5] power: reset: pscrr: add watchdog pretimeout reason
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
Message-Id: <20261123-pscrr-reboot-reason-v5-2-fbf3c7c92772@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX/bu3C30cAFFl
 yh44MBnx0DYBf6LI+pvhj+c91pJo/7589c4qV0w1tfDWjVbcRIHc6GyC5NxnvSfvUAI4098/ppA
 FkMVsOUKY9msOdBW0a8L0ZGdHIlgvsU=
X-Proofpoint-GUID: eWQ4nhP-YmbG7NRtUREwmiErUQy1WhyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX/30V7i0NyKoC
 HN/MULWloPXfWpril7A3w+VCZejKFlzkdNVKD82Sd8PMXzMmw7L/j+sF0a7NI7w78jszZSg3D2H
 Es9XzjnftQduVyqvs4+93I6hsDEDychz4UJmsRKXRRXYZZusMb9JoDOGimcGmJgXyv2e2hVo5py
 QMr86g+vVvslPuJjbT/2CH7JR7tB1YZwARDFHagCvNR9JIfpWwxRcEUvEnWOi61N99cAMalR7KW
 NIuUOjZsy8iwIXSObP/6bIzDp4zRfA7T5pVUcPpHYGDmq5iRwNLQDf/X4qjHH1fFTdzLi+XII18
 g7mQV+DNn0iU2TqiOC95hZyuDLnAFHSa3CxslsLGXuwjXb1xS5XtaC6O+hkXFgFZZKDnXNa12WG
 pOg5qCWDiMRPqFQ6PXEsykqkC9RtWueQem+2Q7jlLrIcPPekhC4nU31K/0Kyq3aSu0HsqpBFiF8
 V5TBQMlr7Gh+uxDRdsA==
X-Proofpoint-ORIG-GUID: eWQ4nhP-YmbG7NRtUREwmiErUQy1WhyR
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b03e5a3 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=ynidK1FTdYmqK0Z_2qMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

Watchdog pretimeout resets are not recorded with a dedicated reason,
causing subsequent boots to report PSCR_UNKNOWN and making it difficult
to distinguish them from other unexpected resets.

Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reason code and prevent the
panic notifier from overwriting a watchdog pretimeout reason with
PSCR_KERNEL_PANIC when the pretimeout governor triggers a panic.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 drivers/power/reset/pscrr/pscrr.c     | 11 +++++++----
 include/linux/power/power_on_reason.h |  1 +
 include/linux/reboot.h                |  4 ++++
 kernel/reboot.c                       |  1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/reset/pscrr/pscrr.c
index 8c45b84059a9..9e6dd3e17382 100644
--- a/drivers/power/reset/pscrr/pscrr.c
+++ b/drivers/power/reset/pscrr/pscrr.c
@@ -529,12 +529,15 @@ static struct notifier_block pscrr_reboot_nb = {
 static int pscrr_panic_notifier(struct notifier_block *nb,
 				unsigned long action, void *unused)
 {
-	struct pscrr_provider_dir *dir;
 
-	set_psc_reason(PSCR_KERNEL_PANIC);
+	/*
+	 * Do not overwrite a watchdog pretimeout reason already set by the
+	 * pretimeout path before it triggered this panic.
+	 */
+	if (get_psc_reason() == PSCR_UNKNOWN)
+		set_psc_reason(PSCR_KERNEL_PANIC);
 
-	list_for_each_entry(dir, &pscrr_dirs, node)
-		pscrr_do_record(dir, get_psc_reason());
+	pscrr_record_current();
 
 	return NOTIFY_DONE;
 }
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 8c99bdd75021..8e3889fa43ef 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -21,5 +21,6 @@
 #define POWER_ON_REASON_EC_PANIC "EC panic"
 #define POWER_ON_REASON_EXTERNAL "external reset"
 #define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
+#define POWER_ON_REASON_WATCHDOG_PRETIMEOUT "watchdog pretimeout"
 
 #endif /* POWER_ON_REASON_H */
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index a117dd5eaecd..6d5ecc6cdc00 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -243,6 +243,9 @@ extern void orderly_reboot(void);
  *
  * @PSCR_KERNEL_PANIC: Reset that followed a kernel panic.
  *
+ * @PSCR_WATCHDOG_PRETIMEOUT: Recorded when a watchdog pretimeout fires, before
+ *  the pretimeout governor brings the system down.
+ *
  * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
  *	value is useful for range checking and potential future extensions
  *	while maintaining compatibility.
@@ -267,6 +270,7 @@ enum psc_reason {
 	PSCR_CPU_CLK_FAIL,
 	PSCR_XTAL_FAIL,
 	PSCR_KERNEL_PANIC,
+	PSCR_WATCHDOG_PRETIMEOUT,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 979ecf3b093c..fad4ef9681a6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1110,6 +1110,7 @@ static const struct psc_reason_desc psc_reason_descs[] = {
 	[PSCR_CPU_CLK_FAIL]	 = { "cpu-clock-failure", POWER_ON_REASON_CPU_CLK_FAIL },
 	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
 	[PSCR_KERNEL_PANIC]	 = { "kernel-panic",	  POWER_ON_REASON_KERNEL_PANIC },
+	[PSCR_WATCHDOG_PRETIMEOUT] = { "watchdog-pretimeout", POWER_ON_REASON_WATCHDOG_PRETIMEOUT },
 };
 
 /**

-- 
2.34.1

