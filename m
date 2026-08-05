Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27123E0732;
	Wed,  5 Aug 2026 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920139; cv=none; b=UvjUvhiwmE3ozgnV2z9yrCwKtkj3TLcqK+6VbjbTLrRKO9nKZ1LXCJsWcsvTWxkd2TFQlJTFfDBXSwhA9kOaMd4CCpSVGsurO+BOXIvT4hjoBJnI+jec5252y57hJF9h6bvHuvA7szY+LzCvkq1usYHcrzDXyBI4YfUQHlS03G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920139; c=relaxed/simple;
	bh=sE/0UvB5QLGxX+DuvYe8wqB57lcWYQtBC2E9pMZlPlo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d1al97yI2Fky9SmhGbFjAbVnCcaWkd82B5Hn++0mEhXual4CTaNYk95gm3tbKGyqvzxRz7ADp2TtfcAwoJUyefmEOTQU+wlHbrGzzoFRXZTBlUT+pX+nCMnu3UuJyJ4WoQP463nb7Ef20nhK+7h/OlLdy+6I30e+EFhYyf7l6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W0QABo4D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W0QABo4D"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758d9Cj3540075;
	Wed, 5 Aug 2026 08:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=k9aAgEitHlte/JCOjRcOuX
	7RkvVSnpWx8Bnd/P+ko8c=; b=W0QABo4DSx+50ciDa7JBLbI4Gt7tNgO8W4IkF2
	coC/ipinaHrZ3YoqKPpPX2+v8udjEvvhf2JEMlWl2HuaDcx4LpavJG3hksUpfzPH
	aywWd3EgPqHw0NYSGvMSSgCCiYZoyYbkKgTiuEBexwXxqyCRXvsX3cd4qGMZeADG
	oaqn+rAJnCH24P8UigEg7Fr0f/Hqb/txLyJPf4ciMbmuqzIfJbHMVpeSUAyibbpl
	cBUsky0ZonCooh995ld+81vOdfrL5Vz5iN7VAXB877SZ0qDjCB8ro5yCDmxSyiJO
	QnwMu7iln0CAaDBF1LSUUCnlXqPldyr/G8Jz+CekeSEPV9cw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuu3uhry7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:55:08 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6758t5iF007279;
	Wed, 5 Aug 2026 08:55:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vje9tq-1;
	Wed, 05 Aug 2026 08:55:05 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6758t5qD007272;
	Wed, 5 Aug 2026 08:55:05 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6758t23J006999;
	Wed, 05 Aug 2026 08:55:05 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v4 0/3] power: reset: pscrr: record reset cause on panic
 and watchdog pretimeout
Date: Wed, 05 Aug 2026 14:24:54 +0530
Message-Id: <20260805-pscrr-reboot-reason-v4-0-54ef517084cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF76cmoC/22NQQ6CMBBFr0JmbUmFUpSV9zAsoAzSRBicQaIhv
 buVxJ2b+Xk/+W82EGSPAlWyAePqxdMUwRwScEMz3VD5LjJkOrP6pHM1i2NWjC3REqMRmlR/zAp
 ztgU63UFczoy9f+3Wax158LIQv/cna/5tfz7z17fmSisste3a3pXGFhcSSR/P5u5oHNN4oA4hf
 AAMteK5vQAAAA==
X-Change-ID: 20260803-pscrr-reboot-reason-f1254965ec0d
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfXxMr/9JXfoKif
 h1wgGMj0QPiY/02vVyDELqKZrb5BF1sFQXdHwUQNY2zHAF+rZ/QMzDJ7TrM4hX+Nbq3ytROnD/K
 Npy4ZcX5LegV3cK+JIjHVdApNW/O1Ng=
X-Proofpoint-GUID: Lvx5cyOiea91251lVOS93dDrF6fbtHgO
X-Authority-Analysis: v=2.4 cv=B5aJFutM c=1 sm=1 tr=0 ts=6a72fa6c cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=H8zf-Cr4Dfc6yz4jOpIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Lvx5cyOiea91251lVOS93dDrF6fbtHgO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2OSBTYWx0ZWRfX4XQjMIDiuR5O
 HAzNyyRp/fXl74ORV85zBCMxwveE08aGCcq31Eoyk3Y0OS+/LOTgMxACrYBR3MAIemBC6DJsvta
 QMzRv/3oOTPEZATQ+SZkrj8U/QQ/DQyxI8rozHqOnN/bjVDBE9wxYVM4abAOQIj0FrR2m80i7d8
 hhFxsoexUeaXY+wul554hZVpB7auuiKbvYCXwDSQEK5xNrjVkspkmLYCGMY4Hbb75csrf4XqLV7
 hQG3m0z9qUeSD9bUr2UXyMqvo/aAUsj9DAJY8IBFEdz2H5wO7grfo91QXx9lpy1SW9NGGpXHPkj
 YMv7dlOt3eSU1pLB2VTi1Z6rcLcDL+0R5saugXCrMhw1UlE/5YyMkXfKB0vWuzRiIETeuS2s/My
 jk8r1xgqMXJhs9/RUXH9xMWB6nRzwyPwYVJLU5S5RHzGWQ02yhwYcNyMiT+HpNGqyHh9mpjJF4i
 0k0iYxDhM9IwWGQCGLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050069

This series extends the Power State Change Reason Register (PSCRR) [1]
framework to capture two additional reset causes.

  1. Kernel panic — a panic notifier writes PSCR_KERNEL_PANIC to NVMEM
     before the system resets, so the next boot can distinguish a panic
     from other reset causes.

  2. Watchdog pretimeout — set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) is
     called from pretimeout_panic(), when the watchdog fire its
     pre-reset notification before resetting the system, so the reason gets
     saved and we know its was a watchdog timeout that caused the reset.

Changes in v4:
  - correct 2/3 patch.
  - v3-link: [4]

Changes in v3:
  - Update patch 3/3 based on Guenter Roeck's feedback:
      * Move set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) from
        watchdog_notify_pretimeout() to pretimeout_panic().
  - v2-link: [3]

Changes in v2:
  - Split patch 2/2 into two patches as requested by Guenter Roeck:
      * Patch 2/3: power/reset — add PSCR_WATCHDOG_PRETIMEOUT and guard
          panic notifier against overwriting watchdog reason.
      * Patch 3/3: watchdog — hook set_psc_reason() into
          watchdog_notify_pretimeout().
  - v1-link: [2]

[1] https://lore.kernel.org/all/20260731095959.296056-1-o.rempel@pengutronix.de/
[2] https://lore.kernel.org/all/20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com/
[3] https://lore.kernel.org/lkml/20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com/
[4] https://lore.kernel.org/lkml/20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com/

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
Faruque Ansari (3):
      power: reset: pscrr: add kernel panic reason tracking
      power: reset: pscrr: add watchdog pretimeout reason tracking
      watchdog: pretimeout: update PSC reason in panic pretimeout governor

 drivers/power/reset/pscrr/pscrr.c     | 30 ++++++++++++++++++++++++++++++
 drivers/watchdog/pretimeout_panic.c   |  2 ++
 include/linux/power/power_on_reason.h |  2 ++
 include/linux/reboot.h                |  7 +++++++
 kernel/reboot.c                       |  2 ++
 5 files changed, 43 insertions(+)
---
base-commit: 551961df5728932d968a4aae534714acfa43f3a1
change-id: 20260803-pscrr-reboot-reason-f1254965ec0d

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

