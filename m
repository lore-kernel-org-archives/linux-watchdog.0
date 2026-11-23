Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417550;
	b=k0cgkKaar2xKipE4JpkSvvs5o8+W3L7lDJbDz+IuwDDGZGGMT7OhxqijrZ/ITFerOvHI
	 5xM1r/teqCZpcg6SzMnf/TT1z5qxzyZ06/7V2rPsEJuMD3Bd799UTs2cJuRIrKixANXm1
	 sS6P4qGlLyejUkhExVCbkfDNupp1SFRr8zd/ueyrr3Sn29aGH8llJsjyD1hxOzTqiXUJk
	 6k9a6u6XP/jDHUkdnl9b+7YWf2BsvU/kYp+Lf6IRpbuyObsAcnlSEo4aWQQ+VL+hgooPo
	 ClfRlSbAQJ3oSJ3u/hhlRSdIRHXbvlA8dXFsHmVIN7nDrK3Agr80H4FG3/ZfGDWyIjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417550;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=73qkdb0vuDKVHImBYvoSDVsRWYaA4I4cYyEBvcpvby8=;
	b=1tCsd59+ozJEAXSQ6INzENUe831ahdb/+bgHdDwrd7tD3W8wLet8qX42ru9QBQIHjqz/
	 Qqas8eq3ZZu4gs8ALEZ/8dVl2dmgKq3zk5w+wDYdcvo+qhWIfyGH1wk+qQkD0pqTWqNkl
	 IXn09t5EWnsGinXOU0LPGFuVdiMnfGo+Ot/Yy85N8fP0ptvuqO933ix+o5pQowsf/yrC9
	 5UN/ztV+wjNufYSBCktIW4Tfq2b35q1uoX2vxQNIluZKhUIg1EQYCxQmfZWEMUXD4fFQ2
	 NJrumv6cCfXYTF2Uz0/PIWupbyGdkRHL7DpAaXxS5oaUGLxPmfOedlfERMd5rsrG33w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bKR+HsUd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF3606A681;
	Mon, 23 Nov 2026 07:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CEF3606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bKR+HsUd
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN69FTR1011324;
	Mon, 23 Nov 2026 07:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	73qkdb0vuDKVHImBYvoSDVsRWYaA4I4cYyEBvcpvby8=; b=bKR+HsUdpKaDDy4F
	m0UN4zPKKtoukMONWmxGWxwaDMtDlJ8xcGXPUxxbtp3WqGzomWlO4+PzkCUFLG6O
	KMSHirNNQAJzOEvfOpcsPX7Va6mI5WTtgkAnb3aJUuGhZr7yLJ6ohpjEMUOrhJIm
	GcOWqtXQWeOjQSFRaY92Jl2D3/WME5XHIepXcffALewb1PXTxc0mtIPfwWKyQapB
	x6JX9hIjjVV0vrjEOMhXwzrqG9OIh68aOybo/iTCzVOoPE7DMiK32Q7EeC6A8ngB
	pngdUhMyOWNvKRqwlizl7J1xthpP+bQEJic0j/9muVD2edU0+nDAtwwc2X4f2oUN
	ZfJZoA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fyh063s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:05:09 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN7562Q4185185;
	Mon, 23 Nov 2026 07:05:06 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 6AN753Q64185090;
	Mon, 23 Nov 2026 07:05:05 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 12:34:56 +0530
Subject: [PATCH v5 4/5] power: reset: pscrr: add kernel watchdog reason
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
Message-Id: <20261123-pscrr-reboot-reason-v5-4-fbf3c7c92772@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=NM1AaE6g c=1 sm=1 tr=0 ts=6b03e5a5 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=uGZmaWCuiYb8ISEHsTcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX+WXh96U4J1MH
 /KIOE8RQkLxvHEH3jTVxBgadegXGeQGcnQl8D8w0kEWfn+FU15bCmm4ahc/Lvd8kfWkedQo68D+
 icd3G5WYhyw9ERpy01QKQrLwoV6Olmo=
X-Proofpoint-ORIG-GUID: tBDg-V36j994N0lxJe0Re5NekDyEILZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX0wsxh8LFO4Dd
 23eCO2M0FfQKOyBHvoRLXNTAtTrMHrT06QDomTicfxMAyt9bBYjORFLBnE4DZgP8yzHJue7PPyu
 Ih7z7D1kWME2A+riWyaB3uLzFO5MAjylRJ+MwuLwVWC9tc4anXjJhvk2EC+dbOwvNhybaOnt0nb
 s2f5Hi1ct6jXXIJL94/wsEcoSFhmU8Mqsu0ZwpW+7dN6t+vww9ETPtmkUb/bpnmK/V+2TOqq/ZC
 khdB4TWQAPJnyjfN3ygnkegmwl6eAraOeCW33Ylu3abAb35OmISb7ojY9NTmAdwOvTBIUES2GMY
 6ri4Dv+ZzuSCKS1wyrfMUznFYFqMblQoyaFpToaNQUl7cHOCY8p+DA5IwEibP/1KgGkSfvEwLvA
 gYwfaTBnCmYdz2GQysqr+dBo7ZBsAtMEa4BbQMnAcLojOZHiM6YaRIEIvkBMkBbsESOR40Bziky
 X5z+ZQCe/1ypRcVob7Q==
X-Proofpoint-GUID: tBDg-V36j994N0lxJe0Re5NekDyEILZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

Kernel watchdog events are not recorded with dedicated reset
reason codes.

Add PSCR_KERNEL_WATCHDOG_HARDLOCKUP and PSCR_KERNEL_WATCHDOG_SOFTLOCKUP
as dedicated reason codes to record hard and soft lockup events
detected by the kernel watchdog on subsequent boots.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 include/linux/power/power_on_reason.h |  2 ++
 include/linux/reboot.h                | 10 ++++++++++
 kernel/reboot.c                       |  2 ++
 kernel/watchdog.c                     |  9 +++++++--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
index 8e3889fa43ef..9bcce23c81e9 100644
--- a/include/linux/power/power_on_reason.h
+++ b/include/linux/power/power_on_reason.h
@@ -22,5 +22,7 @@
 #define POWER_ON_REASON_EXTERNAL "external reset"
 #define POWER_ON_REASON_KERNEL_PANIC "kernel panic"
 #define POWER_ON_REASON_WATCHDOG_PRETIMEOUT "watchdog pretimeout"
+#define POWER_ON_REASON_HARD_LOCKUP "hard lockup"
+#define POWER_ON_REASON_SOFT_LOCKUP "soft lockup"
 
 #endif /* POWER_ON_REASON_H */
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 6d5ecc6cdc00..45e64bcad37e 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -246,6 +246,14 @@ extern void orderly_reboot(void);
  * @PSCR_WATCHDOG_PRETIMEOUT: Recorded when a watchdog pretimeout fires, before
  *  the pretimeout governor brings the system down.
  *
+ * @PSCR_KERNEL_WATCHDOG_HARDLOCKUP: Reset that followed a hard lockup detected
+ *	by the kernel's NMI watchdog (kernel/watchdog.c), before it escalated to
+ *	panic.
+ *
+ * @PSCR_KERNEL_WATCHDOG_SOFTLOCKUP: Reset that followed a soft lockup (hung
+ *	task) detected by the kernel's softlockup watchdog, before it
+ *	escalated to panic.
+ *
  * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
  *	value is useful for range checking and potential future extensions
  *	while maintaining compatibility.
@@ -271,6 +279,8 @@ enum psc_reason {
 	PSCR_XTAL_FAIL,
 	PSCR_KERNEL_PANIC,
 	PSCR_WATCHDOG_PRETIMEOUT,
+	PSCR_KERNEL_WATCHDOG_HARDLOCKUP,
+	PSCR_KERNEL_WATCHDOG_SOFTLOCKUP,
 
 	/* Number of reasons */
 	PSCR_REASON_COUNT,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index fad4ef9681a6..b748153d18cc 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1111,6 +1111,8 @@ static const struct psc_reason_desc psc_reason_descs[] = {
 	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
 	[PSCR_KERNEL_PANIC]	 = { "kernel-panic",	  POWER_ON_REASON_KERNEL_PANIC },
 	[PSCR_WATCHDOG_PRETIMEOUT] = { "watchdog-pretimeout", POWER_ON_REASON_WATCHDOG_PRETIMEOUT },
+	[PSCR_KERNEL_WATCHDOG_HARDLOCKUP] = { "hardlockup",	  POWER_ON_REASON_HARD_LOCKUP },
+	[PSCR_KERNEL_WATCHDOG_SOFTLOCKUP] = { "softlockup",	  POWER_ON_REASON_SOFT_LOCKUP },
 };
 
 /**
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index e5134ad7b663..e05ae3cc583f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/nmi.h>
+#include <linux/reboot.h>
 #include <linux/stop_machine.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
@@ -287,8 +288,10 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 	}
 
 	sys_info(hardlockup_si_mask & ~SYS_INFO_ALL_BT);
-	if (hardlockup_panic)
+	if (hardlockup_panic) {
+		set_psc_reason(PSCR_KERNEL_WATCHDOG_HARDLOCKUP);
 		nmi_panic(regs, "Hard LOCKUP");
+	}
 
 	per_cpu(watchdog_hardlockup_warned, cpu) = true;
 }
@@ -903,8 +906,10 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		sys_info(softlockup_si_mask & ~SYS_INFO_ALL_BT);
 		thresh_count = duration / get_softlockup_thresh();
 
-		if (softlockup_panic && thresh_count >= softlockup_panic)
+		if (softlockup_panic && thresh_count >= softlockup_panic) {
+			set_psc_reason(PSCR_KERNEL_WATCHDOG_SOFTLOCKUP);
 			panic("softlockup: hung tasks");
+		}
 	}
 
 	return HRTIMER_RESTART;

-- 
2.34.1

