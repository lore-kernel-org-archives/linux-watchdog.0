Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E837352013;
	Wed, 22 Jul 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733217; cv=none; b=cwFhBrTbyxnBIigdg4l5JfC8PAq+KUX7q/pWf75Wofax/8QcdUy9yBcqoPib8baYVFRdq6f1uT4EjZde5LPqp00oexKZ4I6QISWV+19Cvdwco013bW/Zi110uH6pkyQ+nTgWNrAw6eyLvuVFWoldu7oYKWW36p7QIp8gMwoHtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733217; c=relaxed/simple;
	bh=VLO+ijALXKG9yVh20Cn4OkuIWZC4PDs+M1yQuzydIbU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I77w/XRh9qx9XMO0joEGOgseUXyzNfaDkaXPAj0aPZJCHGKXtIVSuZWn2moeyoPp7YYNqMTvIFbfP8vbu7tjvQs0eH5jEz7VIG7dT5S2LqZ25FoxYh3KjmUzw6915WnRnEISw6eAN0Th5rT5rR7BoNzD8I9IOmlZVlbSQjOLk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAwS86K1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAwS86K1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWQrB1016991;
	Wed, 22 Jul 2026 15:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KqJrAKnP+L/t31buxKD7g8
	77rtWiNBSOc5qWVlUZEGs=; b=NAwS86K1b3HD1py1JmizqnYL8NaY0Cd2eQGSZp
	j4pMb5vcSGfExdBwJLYVZ4h+32He+2YvipxJctorbf1eC5ls+3skZNHeVTsaI6kd
	wdpw5Di2d6EmGNrYi1TlEm8n5lkwIkjstN1lhOMDeCfrA2jqvZXJhjSQZqL2GjlZ
	oUAlSMxopz1zhdwxw+ry5V3oVTpV0oAesI4SXr21pFe7LXo81Guag/r5ssfgv7OC
	Bui+Keo/7xVs0+bzq6GsRIufg6t3yGrhQ+ooWTs+9fGMo4w1U+loCADYVc4DJvzC
	Yd6n5FYFI4CfGn25/EEYe5o8cNZAQ5g1UFZ4XTXuciDGc1xA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjs92a0m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 15:13:06 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFD3Nr008341;
	Wed, 22 Jul 2026 15:13:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fgj3wkww2-1;
	Wed, 22 Jul 2026 15:13:03 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66MFD2Fj008335;
	Wed, 22 Jul 2026 15:13:02 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 66MFD2oE008314;
	Wed, 22 Jul 2026 15:13:02 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v2 0/3] power: reset: pscrr: record reset cause on panic
 and watchdog pretimeout
Date: Wed, 22 Jul 2026 20:42:59 +0530
Message-Id: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPvdYGoC/x2MMQqAMAwAvyKZLdRYFP2KONQaNUsriYhQ/LvF6
 bjhLoOSMCmMVQahm5VTLIJ1BeHwcSfDa3FAi53tsTGnBhEjtKR0FXhN0aBrcejQD8GtUMpTaOP
 nv07z+366kyN1ZQAAAA==
X-Change-ID: 20260721-pscrr-reboot-reason-2432962a9c4d
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX5fHRHrn5YKyl
 bAQncQdw2JYGw7L8omqc+/mk8wzFC2v9L5GLFoXhdRfuwt8+oyAdASwCHSO3LOZbqSw8zrAVwC1
 Zarztcd2JaDxnf/IWfvIXJmVYY84WjQ=
X-Proofpoint-ORIG-GUID: I0ekeKAdXUTVP4NGT279884HsSZMl_T6
X-Proofpoint-GUID: I0ekeKAdXUTVP4NGT279884HsSZMl_T6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfXzKCPknweyvi7
 q3ruZ8jHd4WXJQ+u25mTnPk6Qn0mbpwIv4QDfph76BMJI/3+JL3vHBlHxRDPYFdYwgpVHZno0Ol
 kAVQVkdZq+WPZuEdL6Q3gMBJM4YzPhitg+PvImS+RF6L9OQuFemB0qJqiSqhKqBeRogoaSKntHi
 j2fqkvH8C5BF9LN1UW1ReQhiHkhQxB3ERMH+xkOqIdVCHCNQXlzQodpwdmq+3ztmbkIkn4OsS6b
 w/pxbdxDmHTMtQq4CizTbqIezQNs9eDLZswqA45xa8FIoduSILp6s1Q83oc52uS/fVeQUHzBA55
 aSZAqHn2DnbJ99Zpjm+tXYpFxZF1BxFS6fKPkb4JUv5ExAyISnKznkcOCTsZTj4QWX/Gn+2UIS+
 JgKLZdLaGxRXVDcg13czSJLu39un8EplmnOEKr1urlzcet3EUAxmAyVzkOG3rnJKBnmLigfa6kO
 A2+FVSJsBOZRHo41TDQ==
X-Authority-Analysis: v=2.4 cv=QahWeMbv c=1 sm=1 tr=0 ts=6a60de02 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=BWyUJuuaSuU8Iy8WYiIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220149

This series extends the Power State Change Reason Register (PSCRR) [1]
framework to capture two additional reset causes.

  1. Kernel panic — a panic notifier writes PSCR_KERNEL_PANIC to NVMEM
     before the system resets, so the next boot can distinguish a panic
     from other reset causes.

  2. Watchdog pretimeout — set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) is
     called from watchdog_notify_pretimeout(), when the watchdog fire its
     pre-reset notification before resetting the system, so the reason gets
     saved and we know its was a watchdog timeout that caused the reset.

[1] https://lore.kernel.org/lkml/20250618120255.3141862-1-o.rempel@pengutronix.de/

Changes in v2:
  - Split patch 2/2 into two patches as requested by Guenter Roeck:
      * Patch 2/3: power/reset — add PSCR_WATCHDOG_PRETIMEOUT and guard
          panic notifier against overwriting watchdog reason.
      * Patch 3/3: watchdog — hook set_psc_reason() into
          watchdog_notify_pretimeout().

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
Faruque Ansari (3):
      power: reset: pscrr: add kernel panic reason tracking
      power: reset: pscrr: add watchdog pretimeout reason tracking
      watchdog: pretimeout: record PSC reason on watchdog pretimeout

 drivers/power/reset/pscrr.c            | 37 ++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_pretimeout.c |  3 +++
 include/linux/power/power_on_reason.h  |  2 ++
 include/linux/reboot.h                 |  2 ++
 kernel/reboot.c                        |  2 ++
 5 files changed, 46 insertions(+)
---
base-commit: 7715d20f91523e0189ba9d8813f03971229d5e90
change-id: 20260721-pscrr-reboot-reason-2432962a9c4d

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

