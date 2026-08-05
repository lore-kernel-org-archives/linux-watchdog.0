Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF23EDE54;
	Wed,  5 Aug 2026 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920142; cv=none; b=IHTRpX7QY1eA3lKj0p5jMnef34pjMnaP9WPGMGH/0C2Kx8lgYn6Satt52iDj1sFWrnPl2dBqaQYaqKctMfD2u1ikKIDYOqttY7Q4Xm9MXT0134+WBZdBXGhvLV7OxvMTT4Yr+/Sr3SY4f5DO7UbimwzWBUmhTh86LtvkIp4991U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920142; c=relaxed/simple;
	bh=NjF2VU9Ny2tzC6HpF2Z0lSuw54Cg6Xb1lz8yuOc1+7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1thqNCB/oSaS5Z+59bifKZctsHbgUN2I96AaKL/fOMahLNAQg/7nJj5FLoVz7tyoAZyt8R3wNmd7e4sO1ibxhLznQCvvxXxibC8CfV5rdhrDaqpmbHa+y//BbKv6Zm5xhgiUh4LM0XHMSRH0HLUzuERhFzhL4o+cw1VN1Ddb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=afUez2j6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="afUez2j6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dGK13540227;
	Wed, 5 Aug 2026 08:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wbmgDVw4Px5OxkOJSyquIQxe/s4Q8SySnQtsDIoAxD4=; b=afUez2j61Usu80m4
	+W83yAx6u6VdUxtN3bwpwRi4F4/Y8F1YacijtFEXE76yGTLLuKlgprnRDKyupYdN
	+/3WzE8eN9N5p4Fqc84nsq+BQIFzuGcBWSmb7yfE9nzfVyfgNrxxkp8yP3t5DHwv
	W2St94lxMvgM4l4TUF/W/JL/NfBANYAsxCFuKqDpMCiQxUy8/BpqBb1+UXe9mSfk
	NJtJBQf2TE8m1MfiekckuDcfpWUJXEZttBKRSUzfefdU4PRAHMOWgqyEP4CA2It3
	mPqvpKL3y+sATtsBEkEqmybVByOtnhororCtbmSHKVMTuwgnhrZHth3yyqSMeyAb
	sRTyyw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuu3uhryk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:55:15 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758tCt9007341;
	Wed, 5 Aug 2026 08:55:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vje9uf-1;
	Wed, 05 Aug 2026 08:55:12 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6758t5qH007272;
	Wed, 5 Aug 2026 08:55:12 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6758t23L006999;
	Wed, 05 Aug 2026 08:55:12 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 14:24:56 +0530
Subject: [PATCH v4 2/3] power: reset: pscrr: add watchdog pretimeout reason
 tracking
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pscrr-reboot-reason-v4-2-54ef517084cc@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX3tqEYwWxWSTD
 ZfuYyAwdfbTU/qfSMwOchuhdva33gx6d+AUhOTviRm4K4kkG6HfEtYj+AcHG0HN0TJCLakXLgVE
 DHu8PJliWAYtXJF1PIsH/gfc5Gtb/Ns=
X-Proofpoint-GUID: M_vJUxkXNkwqrLn46A89CFAhJIruwJN5
X-Authority-Analysis: v=2.4 cv=B5aJFutM c=1 sm=1 tr=0 ts=6a72fa73 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ynidK1FTdYmqK0Z_2qMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M_vJUxkXNkwqrLn46A89CFAhJIruwJN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX+k4Tixd2TSpD
 5XXdISWYJ868PM2ITV03t9Q+B2PNzRMQTtpYIobQ+sZwci3DGj/XRadpOetojaGsmC29FyFsCi4
 RxzIq/jMWp8j2mYSv/9O8pKBvTJ5xFclHunp1hCkq+XjXAOo9spCJQ+B2t1Q7PQqmZDYiEgsd4u
 VJROCOL0ryLHihJ5kKBCqojQij8e3Xz5lx14zC3/8EETX8NdfP8uSCXx/4ybHhS0I23B63NuvPr
 EXLQTRy4lEBUA05B8+CVRPnfvBi5C0e0/FWa6nQuOqZOWyrjMEC/99FMLygTTieN6SyOoPCup9o
 jzj/w8kwykIgYiDFK8P/obeBW55EhuiRaCjyRO25UprhJ0CxoQG09Q0bTaxHGsKEAV/KGhJgHPo
 MzKk89wfruoJs7jncxz13/h1UAYqU7mWqKUDk2vJnbULkR6sAA+ndW55UVagHd0BYVOighO0/4M
 WqGsCW/sWdlvudfTnqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050069

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
index 8c45b84059a9..b7e6239e207e 100644
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
+	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
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

