Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88364418F2;
	Tue, 14 Jul 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022819; cv=none; b=MH0FMntkE2+sjJ7FWp4z4BJ71PDiu+uc0M9KCxP7xhYOzHSocpmYdx11YuNBAHfA17ZEpvdSmzdn/KH8iYs7KjpJo+aUQtSHNgy8vhJqtbQIZl/KCucgjBXLFGJOia5xF9EarNxawSGC6/Xru8Sar8d6CFpcLq3ZhTkRtss4V+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022819; c=relaxed/simple;
	bh=Ea9nVF3v7YJOTWAbklqJ7Jx4NE4Tu2DW9mMOQnPQXJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VnIN5M+jy2VMgv+l2NkVosEq1HZYxerjgCMuZLRdMgrh1HmZ3gNpnfBdb6AaCIeB1jFrvjh52pBmQCTu4oUASoesE34z+NKOUfrg+T+CVovgEyBVe718soKSmYkM5k6S2bn5qtAz708oegJVY1lxbenmQTr4Vwo4mZ1aKPxT4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ikihcJns; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ikihcJns"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SdTU3887426;
	Tue, 14 Jul 2026 09:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d9a4Vj4sY/FkqE2NknRGu9
	I1VGm2KIU2GLY4IKpxd74=; b=ikihcJnsNccf8hfHr9ZRnWx43AkwxsMONcLRmk
	9Iri4Oe4zLsnnP4N/jaS49YgeEMzEo3YiY4peNCCwL75lAQjhuuMSD/TAtH0sB9z
	XD3fMGAN512ULsSmZQDUJH/jjENrWxYvi0ZMa8QqsHlbTM8l6IN+PsJt4tyoVEEM
	zCVNTVKr+ChpYCGInz9xBkFB4BEqtkPFvsziLRTYTZnyNnVD0mWoz5gbER6L/OMR
	mTQta3dv2i0HS6I1JTQe66X9elhFciF+j4NkjCz5Z3M/8mO/ODNQFi/cbF4O5oKY
	wRrbyu/f8BP8kuyP/Lo+fQuf7uNXSkpomx/ILdi11fMiBaUA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr49nw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 09:53:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E9rBrt014813;
	Tue, 14 Jul 2026 09:53:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4fbewjn02d-1;
	Tue, 14 Jul 2026 09:53:11 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66E9rA39014765;
	Tue, 14 Jul 2026 09:53:11 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 66E9rALc014592;
	Tue, 14 Jul 2026 09:53:10 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH 0/2] power: reset: pscrr: record reset cause on panic and
 watchdog pretimeout
Date: Tue, 14 Jul 2026 15:22:33 +0530
Message-Id: <20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOEGVmoC/x2MQQqAIBAAvxJ7TlAJi74SHdS22ovKbkQg/T3pN
 MxhpoIgEwrMXQXGm4RyamL6DuLp04GKtuZgtXV6NIMqEpkVY8j5avCSk7JhQONiDC5M0MrCuNP
 zX5f1fT8wNIqZZQAAAA==
X-Change-ID: 20260714-pscrr-reboot-reason-2b4e16ccb6b8
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
X-Proofpoint-GUID: 555Mh7K-5fHoX7SXIUzrgXv2z-MYTKU0
X-Proofpoint-ORIG-GUID: 555Mh7K-5fHoX7SXIUzrgXv2z-MYTKU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfXw1QY96ErNgx+
 By0IMoiak8tG/h2tNrYme29ocgx6iIdUgbkYl/oCJIhsh/f0Q8H/NnbgTiQimYvH87Rimbd6Q8j
 8kmFrUozUJ0dGxYKlAVB5XK5KFlwKAGB4hEyNy8lkCXfsfRFSYoiFndPUySu3rMpq3VuJtLcjGm
 UUUGFb1pEulfrqCdC/FCUW5ifMZkkOfyytVpkdTHlc7CWHJeV/YIs+rcoK9MELhtC93r6vczSPO
 zjM100LZzZLTwHIoGA+hIx47+H1akrjKPbZFEYB5kbE0ZShhwdrYxGfAnkQFA68T6aZaUpbkUdk
 6KSqx1ZJtzMRux338vWPvR76bBpikH0PBzHVUDoG2ltlBjUfijlU4pdPJdzMUTTtq7AHgYojeEz
 Vamp0y+S5lPql4H1rXtclOjczKxPckaPUpJE0uePrPzf02/ic10QeGr6yWwDVQ0EONc0jwTRNQy
 Cvdg8PN4qmBzcvVmicA==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a56070b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=e53pv_uEAAAA:8 a=_jlGtV7tAAAA:8 a=KKAkSRfTAAAA:8 a=cm27Pg_UAAAA:8
 a=olQM-LvmAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8
 a=Z4Rwk6OoAAAA:8 a=EUspDBNiAAAA:8 a=EEA8HsFUP9NfE918zwQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=i2WUat-zol0iyFTidwVo:22 a=nlm17XC03S6CtCLSeiRr:22
 a=cvBusfyB2V15izCimMoJ:22 a=K3rB23dPQrtErkzMxmQQ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX2Ju1+HhqvhZE
 xSRbH26PHWHbne2wWiPJAgyEw0sVfOAeE+f6QX0sAVvnodkcViePWCMHoXMjJVSyJ2y8SikC3Iv
 C/GhrpJxQZkUAKSwtDAc3V3xlKXl6rI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140103

This series extends the Power State Change Reason Register (PSCRR)[1]
framework to capture two additional reset causes.

  1. Kernel panic — a panic notifier writes PSCR_KERNEL_PANIC to NVMEM
     before the system resets, so the next boot can distinguish a panic
     from other reset causes.

  2. Watchdog pretimeout — set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) is
     called from watchdog_notify_pretimeout(), when the watchdog fire its
     pre-reset notification before resetting the system, so the reason gets
     saved and we know its was a watchdog timeout that caused the reset.

[1] https://lore.kernel.org/lkml/20250618120255.3141862-1-o.rempel@pengutronix.de/

To: Sebastian Reichel <sre@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Benson Leung <bleung@chromium.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
Cc: linux-arm-msm@vger.org
Cc: kernel@pengutronix.de
Cc: Liam Girdwood" <lgirdwood@gmail.com>
Cc: Mark Brown" <broonie@kernel.org>
Cc: Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui" <rui.zhang@intel.com>
Cc: Lukasz Luba" <lukasz.luba@arm.com>
Cc: Søren Andersen" <san@skov.dk>
Cc: Guenter Roeck" <groeck@chromium.org>
Cc: Matti Vaittinen" <mazziesaccount@gmail.com>
Cc: Ahmad Fatoum" <a.fatoum@pengutronix.de>
Cc: Andrew Morton" <akpm@linux-foundation.org>
Cc: avaneesh.dwivedi@oss.qualcomm.com
Cc: Umang Chheda <umang.chheda@oss.qualcomm.com>

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
Faruque Ansari (2):
      power: reset: pscrr: add kernel panic reason tracking
      watchdog: pscrr: add watchdog pretimeout reason tracking

 drivers/power/reset/pscrr.c            | 33 +++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.c |  3 +++
 include/linux/power/power_on_reason.h  |  2 ++
 include/linux/reboot.h                 |  2 ++
 kernel/reboot.c                        |  2 ++
 5 files changed, 42 insertions(+)
---
base-commit: 9696e3e0e12695f18c26e339bc609a2d56b51c5a
change-id: 20260714-pscrr-reboot-reason-2b4e16ccb6b8

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

