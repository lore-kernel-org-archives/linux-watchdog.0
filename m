Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417548;
	b=Hy50UDMiELgkB+k2o7XmNx5xx4nO7Ntxj/RgMPA4Y+wkIoJqbQLFFbJkDw5N32OYJHoZ
	 mI033fCs0OA06kE6Qb78VgEW63A3v1DdK+N3bBQvY4v57+jgTECf+R3ttjH3bE1GD4+1J
	 qRWDxKW5w8CNKxEhBaU33XT9hrFKQB/0xa7RY/u/C7Q+I20D0jE6c8itF/KR74Ep4Qar3
	 Tpg8M4V6VGz+NXO3HPIRLMvI2yHZEXRbSqCLGoro86rOGx3UEFXBy5P78dKuZcRq5EyWe
	 8NL0Q1qm3mAznRcDsekwseb+8QOnrL0h6wEIhk8cjnmO0PX0fR9olyLJX/GJJ9KqKCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417548;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=02+0c9uUYZr0IDKf/PHcy8uabL4K0Ppf1rZOl/zGWnw=;
	b=LHz1JNCwW+3p3EKLrcUtRsyxVNGHxyoTlkJLc9NOgQRNQBNGxnmWLsVZ4SgTMff+POq3
	 lqt4x8ylJ8hF5iHhDqlhOzkP+F5x0OFAyZem+lBf0hUWSFrrRwiJmwdfT+7RT6yfxWVP/
	 NhLHGghVpA/jMGGoDvceHZK+yboc/DrFRlwYy31CxOGDhNLo/vPX15FB0KC2/cBi2mVFj
	 NLxW2zTQ8kju3i1Zu9Aw5zM2TEU4GJ/wu0WENAHIDS+rhdNjTUGXuCUfDAswcvogVoOc4
	 RKSAREXGPTXyFdPptAIStIrOZ41rLMTQ2JER9pbsbMQv8+ipkBmz6YQ0tRC5p1FRzUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G8hGcsBP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E9606A68C;
	Mon, 23 Nov 2026 07:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7E9606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G8hGcsBP
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN6DYmW1490120;
	Mon, 23 Nov 2026 07:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=02+0c9uUYZr0IDKf/PHcy8
	uabL4K0Ppf1rZOl/zGWnw=; b=G8hGcsBPqvUyLTpasHaCSHYSFlc9onNpKltO+r
	ZaYkUp5tMIk6f0FeyuC4cvXUJKiymMAXtioFLDvvN03/LJ+5v+KIyqQUKqH1DSfB
	0SHW4M6IGD5FRMTd/tYtNjlK8f5edqn3jH2Adi5OFxbt7VodHIesycgLgrLENtuy
	UqCj4mI9vTlYf3lPGCF40JMZvr3FoEt+rhxIhajpK9yec6Qq0H2euWyWEgbxGvp0
	JcKVRnMooWV3hEhu38H2v+pYlykHIqcBLWN18rZRhTHzNkc+72ayENj36m3XXGcp
	3h25tpLcvwcOstWvqPjxgqUi/LbOSI0sSoE0lkst9nsuiJZQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k05u5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:05:06 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN753ws4185126;
	Mon, 23 Nov 2026 07:05:03 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 6AN753Q24185090;
	Mon, 23 Nov 2026 07:05:03 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v5 0/5] power: reset: pscrr: add support for additional
 reset reasons
Date: Mon, 23 Nov 2026 12:34:52 +0530
Message-Id: <20261123-pscrr-reboot-reason-v5-0-fbf3c7c92772@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJTlA2sC/23NwQqDMAwG4FeRnlep2lbnae8xdtCazsK0rnFlQ
 3z3RWGwg5eE/4d8WRhCcICsThYWIDp0fqSgTgkzfTPegbuOMstFrkUlCj6hCYEHaL2faTXoR26
 zXMmzVmBEx+hyCmDde1evN8q9w9mHz/4kFlv78+ShFwsuOJRCd601pdTq4hHT56t5GD8MKQ22s
 VH+U+qYkkQpCVZlpaikMQfUuq5fHMB3eAgBAAA=
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX/Cj4jlYJF7Yw
 F4DZDLA2W0du5dLSvyL9PeBKoeAgBo/j6xH+xJY9yMQqjtgr0LDhrvDDLaT+D5hC/2e0bMl5j5Y
 B01Un+GhnH68wXmcrcFkrC3a/4kph8c=
X-Proofpoint-GUID: BXlYNu-CbUMVHgSb71xFTQyS5mi1zOBD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX6mJa55oluYIs
 JrKmnZft9JnXRdWq02e4IRx9/uboLH5Zjd3NDwBbC0YYnFdCRhDtc7cD93rSsM63NBOJmkx7lbv
 fWuvnkTDWOUWM+f860C9ptDnmDfSqmilgvZRD63D6xzAY7eHiTcM1XsHp81Dhue1c9/Sq9xEwaX
 +ffsB9qkonlCuBU554W4KwnRptBQipHzBQUueYnuF6u+EK5SsN1yIF69bur9J4G0rX24BPS7G1q
 yAZMAIRT48UUQV5WrPfnu0yDGewZNK3u//sB0JKGdr1cUacqg1/Bc8LZfvcY2dCrGu7B+U6Ojx1
 Q0Nn37i+VvnvNA15Lij/zn5NANuybxJ25qWN7S0ellEEj89Ju6ykex7u/XnGPSSNSqx8EnD7gNS
 4a6m/nj0FqFhd9tea6KwvTEH0nJ27KmHh+ZXpx/dpfi+JPTrNcM9Lk8cgIp8ucv24RM8UvGnGPk
 OeAxT329gybvi7/WDPQ==
X-Proofpoint-ORIG-GUID: BXlYNu-CbUMVHgSb71xFTQyS5mi1zOBD
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b03e5a2 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6f3ol2dHzBwsJ62igXgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

This series extends the Power State Change Reason Register (PSCRR) [1]
framework to capture additional reset causes.

  1. Kernel panic — a panic notifier writes PSCR_KERNEL_PANIC to NVMEM
     before the system resets, so the next boot can distinguish a panic
     from other reset causes.

  2. Watchdog pretimeout — set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) is
     called from pretimeout_panic(), when the watchdog fire its
     pre-reset notification before resetting the system, so the reason gets
     saved and we know its was a watchdog timeout that caused the reset.

  3. Kernel watchdog - Dedicated PSCR_KERNEL_WATCHDOG_HARDLOCKUP  and
     PSCR_KERNEL_WATCHDOG_SOFTLOCKUP reasons are recorded when hardlockup
     and softlockup events are detected by the kernel watchdog, allowing
     these reset events to be identified on subsequent boots.

  4. Userspace-initiated reboots — add dedicated reset reason codes for
     bootloader, recovery, OTA update, EDL and factory-reset reboot requests.

Changes in v5:
  - Remove the hard-coded pretimeout check and use the generic - Daniel Lezcano
  - Add kernel watchdog record reason patch 4/5.
  - Add userspace-initiated record reason patch 5/5
  - v4-link: [5]

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

[1] https://lore.kernel.org/all/20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com/
[3] https://lore.kernel.org/lkml/20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com/
[4] https://lore.kernel.org/lkml/20260804-pscrr-reboot-reason-v3-0-e706dbfc7465@oss.qualcomm.com/
[5] https://lore.kernel.org/r/20260805-pscrr-reboot-reason-v4-0-54ef517084cc@oss.qualcomm.com

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
Faruque Ansari (5):
      power: reset: pscrr: add kernel panic reason tracking
      power: reset: pscrr: add watchdog pretimeout reason tracking
      watchdog: pretimeout: update PSC reason in panic pretimeout governor
      power: reset: pscrr: add kernel watchdog reason tracking
      power: reset: pscrr: record reason for userspace-initiated reboots

 drivers/power/reset/pscrr/pscrr.c     | 39 +++++++++++++++++++++++++++----
 drivers/watchdog/pretimeout_panic.c   |  2 ++
 include/linux/power/power_on_reason.h |  9 +++++++
 include/linux/reboot.h                | 38 ++++++++++++++++++++++++++++++
 kernel/reboot.c                       | 44 +++++++++++++++++++++++++++++++++++
 kernel/watchdog.c                     |  9 +++++--
 6 files changed, 135 insertions(+), 6 deletions(-)
---
base-commit: 551961df5728932d968a4aae534714acfa43f3a1
change-id: 20260803-pscrr-reboot-reason-f1254965ec0d

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

