Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194C43F094;
	Tue,  4 Aug 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835336; cv=none; b=XVI9ToHwT9i8ZyY1bEaRRkDTBO4MKDc4gjdE6b6Uic7NLxCJKf9q8+fUkHomhGuDnt3VssEQDcdjCBMsPguVfpXed4i66aDe7BA3JYJiYPiQkQsox4xjVvN6W1ZVZABGTzf/Q8wGFp6N4NtAIhEAHCevniNJcMyNDfCPOQjNStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835336; c=relaxed/simple;
	bh=GFT5Quyvtm2AnN6GjRy0E7fQDV03fynTyPPxMNj00P0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gLszbS4OBdQwzEse1CdOCgkXn6O6Y6E3Fx9eeX06czvGB8LL1QG14WLSwHW1EHCZn/kMgCAYNscuob9ltPtCvKl2RJrMrUoCxx+08g0CRW5XZXCo/UPZdonD5JH1H3RDw+8DSclSQNsvUnAl1khRnTFJhXue7CiNiwDn37TG8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5/jam2w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5/jam2w"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CBrV2978751;
	Tue, 4 Aug 2026 09:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=E8dSVd/EBkNeRd08/l7nqW
	Wx4bVFfiJ2ZMYPS9Fkn9g=; b=i5/jam2w1uhxdj4Q6TRo2x9WQ/ODr7O7XVp8w7
	KxWJJ6DUWxoA+ASsKVXIW1IQLKP2onnsH2vUFgUaPM0HlfPdJwhsv0KufKuqp5nU
	3JonxjStRMyXYfrzFpAazO/AMPShanK+lHD7ya3aTx99KcveQdV7VpYaPE2jofac
	B57Z7PXxZ2DVgDqpo+btjDglb+hhB73GV/CmCTMazIpkF5GdUzEI+civ4Rv2GWBe
	q6zmoIOYbhNKxSPk5maES7gcReIQLq1+l2V0dtTdAEcOqI8wX2ZOj+RDsg0SfaOY
	5kJhpYQVJg9QBxmqt0wDQpYnGSPEm6u/g/HH4bCoDaZGB0nw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu2syjg7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 09:21:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749LYVG027291;
	Tue, 4 Aug 2026 09:21:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4fs9vjk7ur-1;
	Tue, 04 Aug 2026 09:21:34 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6749LY8I027285;
	Tue, 4 Aug 2026 09:21:34 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 6749LY9G027260;
	Tue, 04 Aug 2026 09:21:34 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v3 0/3] power: reset: pscrr: record reset cause on panic
 and watchdog pretimeout
Date: Tue, 04 Aug 2026 14:51:19 +0530
Message-Id: <20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA+vcWoC/x2MQQqAIBAAvxJ7TjDLqL4SHUrX2ovGbkQg/T3pN
 MxhJoMgEwpMVQbGm4RSLNLWFbhjjTsq8sXBaNPrQbfqFMesGLeUroJVUlShMbYbe4tOeyjlyRj
 o+a/z8r4ffPNJgmUAAAA=
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
X-Authority-Analysis: v=2.4 cv=TIh1jVla c=1 sm=1 tr=0 ts=6a71af23 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kGTgZ7n9gimcELQYmocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfX4CLMap/DvE0J
 trdAu25uMxZwI2aW5oOL3lOeY8yQN4PTrgjOk+HZXwPR/gXwtMiEz2B1aefBhGpt2jnPx1nNGPn
 oz1D3u+8snfQ435aRcRK7qtA7+p6Xsk=
X-Proofpoint-ORIG-GUID: Fgu_5RzkI5mndqgFBUSh-CjtCPO7rYc_
X-Proofpoint-GUID: Fgu_5RzkI5mndqgFBUSh-CjtCPO7rYc_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3MyBTYWx0ZWRfX7GyFyW6QehqP
 9BtvK2KFMNVBOKL6mWKF5hYabau89QnpfsB9vys6I3CbwbK8xYhjrED5B82CLPdCfRA1cMxMDHB
 s6ibECtL6N9Wd9dbKxuYYAPbTmR8/ly8OcX5TBMK4n76mb+ukk3JF31Mif1CVVsx8vobu3VXOAL
 EWCD/1xvwL57mbBqh3322jfY4tHhyAEOItsZPoft7FTOdxXRYxIzWBHpRzyAIJDwjf4Z16zmFNH
 VqtGCYn/f2plD6gFkHIii4g43kIrzCTIEkNeAE0ppMKEX6cXQb+H/CmVKxb1rkq08pHWGGayOBc
 4faOoyW9WOxZ9qC0FSSk4aOOEDoeR/zgcVvNCcN+bVPTLKYKi06DeCpBpD/SpWLn8f57LhENqKR
 /iPdjK6VJgzaRDXaU20wwAhOXyJ4Cw5guNoGiIfcKRh0JAyihqgIrMPvgqdPobrTrjFLjkUcw22
 j1gXysy7anTvYw0+AfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040073

This series extends the Power State Change Reason Register (PSCRR) [1]
framework to capture two additional reset causes.

  1. Kernel panic — a panic notifier writes PSCR_KERNEL_PANIC to NVMEM
     before the system resets, so the next boot can distinguish a panic
     from other reset causes.

  2. Watchdog pretimeout — set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) is
     called from pretimeout_panic(), when the watchdog fire its
     pre-reset notification before resetting the system, so the reason gets
     saved and we know its was a watchdog timeout that caused the reset.

[1] https://lore.kernel.org/all/20260731095959.296056-1-o.rempel@pengutronix.de/

Changes in v3:
  - Update patch 3/3 based on Guenter Roeck's feedback:
      * Move set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) from
        watchdog_notify_pretimeout() to pretimeout_panic().

Changes in v2:
https://lore.kernel.org/lkml/20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com/
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
      watchdog: pretimeout: update PSC reason in panic pretimeout governor

 drivers/power/reset/pscrr/pscrr.c     | 30 ++++++++++++++++++++++++++++++
 drivers/watchdog/pretimeout_panic.c   |  2 ++
 include/linux/power/power_on_reason.h |  1 +
 include/linux/reboot.h                |  3 +++
 kernel/reboot.c                       |  1 +
 5 files changed, 37 insertions(+)
---
base-commit: 551961df5728932d968a4aae534714acfa43f3a1
change-id: 20260803-pscrr-reboot-reason-f1254965ec0d

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

