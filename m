Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA748F854;
	Wed, 19 Aug 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160150; cv=none; b=XZOO4gz8Zp9geNfrUJoVvt2LNbWTUQ6dQGqvdhJ9QBBCt7O/rzSX2d/Q1NW75aMzmoLuhnFdMKlMS0qy91QFYhVqj/n5u2Wt8X6vQx9YBy4HPPVo4nERyztGcVpgQVkEFF790rg6/8/MidYva4WGtmKfDU9SXKvSSv21YTdsJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160150; c=relaxed/simple;
	bh=dwTawBNesuaBMokAzyTLPswi0iZqjzgTfNRNZ2ityng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NOKTF+PBhkNXTJcKlATJB0AhLDGdf/J99jH0XZcVtozhqcpi2h1Oyu12WeYKoNU2MJzPZE4L9WnAeh3IWX1D1HDrYWpOkTRxt3P3jCEDzezA/trwoTp6Buy8wbD7GoyUC8VZxaNkYhZ3kTl+yQFSCs+86mYa920ovk0i15Js3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cyFx+RZ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cyFx+RZ2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF2PXL965087;
	Wed, 19 Aug 2026 17:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8kmUrXTEYzkwc+VX+HQo5Q
	LwY8C3KPNwPN+fUBA+3XQ=; b=cyFx+RZ2nEQYMu8f79M+2f8jSeCIL0MdDDuVwX
	V9LomPFnz/H51pipyo2299T6YvMPLuLzQcoTC0kMOgHf+0A2BnhBSTu8MUqyoDzb
	nztQGjJb1PvG+5krUqK+5HWyqbOPxHQAkrJDqn2XjGIuvvOZBIl93tC1ugzVQehd
	gHc9dPzGnc2c7Egy8UWDYjTN+6Gu1M1pVm+dIvVP5WfZpQGgPeYU7sLEMhwWwS7U
	AVDw3FVrjKpfMrv2PqV14LQjsojo3bPjySeoQLU4mxdQ3egdaTpGlUHm/cObmtk3
	mIZtY+e6YgKhZz1co1alXGLLNP83drzlajwHgbxZIF8jyj0Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es3grgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:21:09 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHL572027942;
	Wed, 19 Aug 2026 17:21:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4g2h6kdd8s-1;
	Wed, 19 Aug 2026 17:21:05 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67JHL5e2027937;
	Wed, 19 Aug 2026 17:21:05 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 67JHL5jA027916;
	Wed, 19 Aug 2026 17:21:05 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v2 0/4] power: reset: add NVMEM recorder provider for PSCRR
Date: Wed, 19 Aug 2026 22:50:42 +0530
Message-Id: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOvlhWoC/yWMQQ6CMBBFr0JmbWtbpYAr72FYKAw4ibZlCoSEc
 Hcbm796P3lvh4hMGOFW7MC4UiTvEphTAd376UYU1CcGo4xVtbIixI5ZBPYr9cji1Qz1cC11pTR
 CkgLjQNs/+GgzM05L6s75zKXqolVTpknTWFVaoYWXjN+An3tANy4ze0eb7PEM7XH8ANrQGw+nA
 AAA
X-Change-ID: 20260806-pscrr-provider-b9f8f451701e
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.15.2
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=UIrt2ify c=1 sm=1 tr=0 ts=6a85e605 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JD2JG8ErsQDY_eWNyrIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfX7ElfCC0snACz
 1RNAYTJpOZ2NnMTWmh3yh8+3i01NyCoPxQGau7ARYmkPLpcLJBecdweDT9/jOHSLXkT6TwWohns
 FkBpsNY3br4o6p8wBxcwSYwPx35qNTRbixaALZoWHj4TVZEpzoIrT770fwDWrQMbaAdgKiL4VED
 YuYYYx4/jZrBwTNdfmh+UpnnEMEjJHtUh7BdVx73AyXZSzruvd/Hdbk7++rOFNaeX+EJmnpcVzv
 cqHBLiXiWrd06NAIFVFiQmBGPCTiPsUgRZCmhdyn4vgl20CGtcIsYo05Nx+SvH/502BIbLQFqMr
 rHAQ1mm/TkGH3nRK7lgy8LKe5eLuxvOerEp13J9NY0UCtCy3TIKMkdd6pllVfgWsXGqqbOPrKuc
 bQSr3EMpCFXCXQR4PS/wpwrGQ06G8DtVMiRbNr0vUQHA9GveLMXfa2QS+w+wi/OFwhDxRiF4xEV
 6WmMI7pPe8lgLp3izxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfX/H2IegJZYGii
 QgGYPuFHfVlgsfNcD/2+BQb1wDkPV19Fypik86oZgu/DWRNHWgtCf+YHGbgDZqfuvv7lK9TCRr5
 nYbE2+TcQKkO0cn9oK6x26CE9Xe2/6I=
X-Proofpoint-ORIG-GUID: iSg2T0vksNwnRmsLk_RZGv4cvMx8wokQ
X-Proofpoint-GUID: iSg2T0vksNwnRmsLk_RZGv4cvMx8wokQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190134

The PSCRR framework[1] currently does not provide a recorder provider
capable of persisting power state change reasons across power cycles.

This series extends the PSCRR framework[1] with support for an
NVMEM-cell recorder provider, integrating PSCRR-recorded power state
change reasons with the NVMEM subsystem.

The recorder writes the power state change reason into a small NVMEM cell
(e.g. a PMIC SDAM byte or RTC scratch register) before shutdown or reset,
so the cause survives a power cycle and is available via
/sys/kernel/pscrr/ on the next boot.

Only the NVMEM-cell provider is included here. The PMIC hardware-register
provider will be submitted as a separate series.

Change in v2:
	- Add reviewers to To/Cc list.
	- Update patch 1/4:
	   * Rename DT node from pscr-reason to reboot-reason.
	   * Update DT binding example to use fixed-layout NVMEM layout.
	   * Add reboot_reason_persist NVMEM cell under fixed-layout.
	   * Update Qualcomm DTS example accordingly.
	- update patch 2/4 based on Uwe Kleine-König feedback:
	   * Remove unnecessary #include <linux/mod_devicetable.h>
	-v1-link: [2]

[1] https://lore.kernel.org/lkml/20260731095959.296056-1-o.rempel@pengutronix.de/
[2] https://lore.kernel.org/all/20260817-pscrr-provider-v1-0-88a318c13d41@oss.qualcomm.com/

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
Faruque Ansari (4):
      dt-bindings: power: reset: add PSCRR NVMEM recorder binding
      power: reset: add PSCRR NVMEM recorder
      nvmem: provide consumer access to cell size metrics
      arm64: dts: qcom: lemans: Add PSCRR NVMEM recorder node

 .../bindings/power/reset/pscrr-nvmem.yaml          |  59 ++++++++
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi         |  16 +++
 drivers/nvmem/core.c                               |  29 ++++
 drivers/power/reset/pscrr/Kconfig                  |  14 ++
 drivers/power/reset/pscrr/Makefile                 |   1 +
 drivers/power/reset/pscrr/pscrr-nvmem.c            | 154 +++++++++++++++++++++
 include/linux/nvmem-consumer.h                     |   7 +
 8 files changed, 281 insertions(+)
---
base-commit: be461b2185ea3ff6d9c92deedcee0a62a57e1332
change-id: 20260806-pscrr-provider-b9f8f451701e

Best regards,
--  
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

