Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48292EC0A4
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208004; cv=none; b=Pao57TAzJKbMnxImtmAaoGODmxNg/JZlYbC/TMRX85oun3b0m0pio75CypQgyDNOh6kpKsdg59qVv92Yc2WiKqVzhd6/zc/auiDuYLnADTKFcG5lN2yDuffw4Uuof1Ggh7pIHgdPPOmhTKHMz6nnAOKfnayPCR5ZszUYFBmkAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208004; c=relaxed/simple;
	bh=iguH8XDPSekwCbNvLzdbE9/52s4hYfTzQ5S7iKLMu7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z//ftbdzNSX2rzfNRpR/ZAc/+PBmfGo5fBsZdGQU42P9ao7UIsu5fdzyJ2U/BIaGw0uTjH2EmspzK3fhJJl4w3msyN+arlOO+v/ITkuNLb8yXFQ99WGIahEwDFWsIk/NhFdWWAUnom/iarxcl4WxxLyaMCyTVGWATBqxm35w0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWt6ArBv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gnFEr55x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWt6ArBv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gnFEr55x"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B3wfe53419279
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 05:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=76e3Iqlg99CdchD8Hdokgo
	bp9u20UkSViv6UMrsoxZ4=; b=PWt6ArBvXlj/E8ptGPYWhzjS7CLnL3Td+yrJD/
	8vdjNlXq8hRYF7GMiDHULup03gJVXQ5DkLyFZ8zFA0P2UlAqhH4i90K3rJl1G8We
	5ANaAXxWo+m2mY8sC0+p5TjyD7SaU4oixnTHZuu0lyKvV00d4djkzjaQAk/nL1VF
	5wlWAF/o24guWPW08+9cWHKYzNc+B7FbN3xkEZoW8PZsRMtbQUfb6DI/3vYSwg4I
	Jj28q2tU2AZ1IyWyDr8KY7SbrJ0rtNnw4uWDNGAwwryIXCNjF9cpz+kSjAmQwSOG
	v7y46POJZwYnyiZyxAEw7OMoEgeCSY9p7GnuJRAd6Y8Rt4+A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2bjhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 05:46:41 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8299c57642cso28928965b3a.3
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Mar 2026 22:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773208001; x=1773812801; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76e3Iqlg99CdchD8Hdokgobp9u20UkSViv6UMrsoxZ4=;
        b=gnFEr55xBNYtRPykcFd1Pv8KLv7k3Nbz69av5cYPpXGT29v6UGJYLtlJq1SzT9lmNX
         f+Pz1yqyii44dGR6mKAvyvo0cu6Pv0LHhRv+KqvyUntH3LXkTQszH48+2caAUapAKJ2p
         rbH/NxqD7FfoWHlIUaTkSjiOwLjqEM9tsEImmjct4VXflEh0ek6xLNBY4oAptC69Rhpx
         KnnZZHA+9VwCh6lVaj++z/Jqh0vOSHg8CcngJ6uYJlJo5RFtkQqvGTnaeNUoh7tR24vO
         +wvfgX0qIt/CJ/0pumI9eznNnIuGBq2olzRXSDyDnU4DmKKyHdZTsKh1Nhp6GNz+lsD0
         wGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773208001; x=1773812801;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76e3Iqlg99CdchD8Hdokgobp9u20UkSViv6UMrsoxZ4=;
        b=N6cwIJzNbZNctZl4ryxdm6t6eI4KSO/ByTJ7BBCK6V9+w6clbZJ4VJOwSdD3lvgG7f
         CNWElATTsjHhqwMPlJCtn90Ax+MMfdHT5wtLGlDfnZk3jSKFiGUTCaDc/mo63bt5ETp+
         VeHHmplh5Si08QvHFKdvy7+2qYTnJu6qtuw7Vw1GWOR9CBFIHWcBv5cfOSeruAq7WFYL
         K/b8gD1wE2SYuXd000WgYmcHenSXk23JB8tfTGhbJxqzdJTON1oTkxkk/zWO25IwoV++
         GIC0AVJES27y9zN2Pc8LJIL0+laZ3JARkH+CF7qVc0jv2aTV9ieI9xrI+N10swYxqY5K
         3eHA==
X-Forwarded-Encrypted: i=1; AJvYcCW5X2bSyaGVpwTqOba+1yjtIDkjUx4HbxbNMRllV7xt3J5nqtw3Ilp2R1U3c7miNNymTYUEQ4rjwmoSQupdqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGINuq2r3rYOfWdIdHjaksV3H3eE2LbnbffFOrtxwQcRLqDJj
	coS1RAhrf1W0FiEd4za1v+UrMrz8+CbPqeqYWSfnArA2vpT9SzQfOvSMlCVKT9jaN72fvwjUnET
	EMd9OgrqMFBwNr/1hyVF7n3yNELl7F+OJe+xKArmAubpd2gU81Y/PUKaoI6lIDRycFWr/8Q==
X-Gm-Gg: ATEYQzzgwBJ5SWViScJCzwP0n6bJZcoIYGowNXCK5c1OQ99ZR+AKvvUZiYsGicwNKx3
	2+LHfIHGvcuWQ1sDSHwoU0SIBpydpRpobq8LYUoDyuVFPbZ7RjWNoB4YBviX4lWT/TyuZDeAavQ
	jDhb4ZOMF2Hdph3RY92vi5jcP9SX6W6yASM/Tz4paBBI9MQK3qJM/Y5ilHvN81MJRG5QHgEnl66
	whNXO7pvjhboo9rSUc32AtyKSwyA/lDqhYuoXdQPHgoujDVTxEtqE7fgSvaTM4geSxaR5OAsIGi
	RR+aKOi19HdUZUuSerIr0Tv+vAkr3cdnEPOo+7vFIPit4dcfBrx0GDraEP1QJZYjjxJQ6rJxvvw
	oJmi/HzxqQrE8NSN4Yhoj2WPm/lmmovy5LdIptRaC2lZ+5/84MHUsQiU=
X-Received: by 2002:a05:6a00:4b0b:b0:823:1252:9428 with SMTP id d2e1a72fcca58-829f6e932c5mr1531037b3a.9.1773208000621;
        Tue, 10 Mar 2026 22:46:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b0b:b0:823:1252:9428 with SMTP id d2e1a72fcca58-829f6e932c5mr1531012b3a.9.1773208000111;
        Tue, 10 Mar 2026 22:46:40 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebf43sm1114108b3a.39.2026.03.10.22.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:46:39 -0700 (PDT)
From: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Subject: [PATCH RESEND v8 0/2] Add support for Gunyah Watchdog
Date: Wed, 11 Mar 2026 11:16:29 +0530
Message-Id: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUBsWkC/3XQu07DMBQG4FepPOPKx7fETAx0ZYARIeTLSWKJJ
 hC3garKu2MyQCSTxdLxkT/r/68k4RgxkdvdlYw4xRSHPg/1zY74zvYt0hjyTDjjihkmaHvuL7Z
 7/bQn34WhpTxwLY0UNXJD8qv3EZv4tYjP5PHwdHi4Jy/5vovpNIyX5aMJlu2mOQFlVFjUhinBU
 Lq7IaX9x9m++eF43OdjISf+ywBjumQ4BeqMCRKCVFKxDUasGF6XjMgM6gBoc0wHYYORK0ZAycg
 cqrLOASKAALXBqD8GWFUyKjPSaxSN0+ig2mD0igFeMvqn4toGBk0drN/qplozsmSqzDTKg1LO5
 Jr/CzXP8zeqyIJiZwIAAA==
X-Change-ID: 20250903-gunyah_watchdog-2d2649438e29
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dd521
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773207995; l=4897;
 i=pavan.kondeti@oss.qualcomm.com; s=20260311; h=from:subject:message-id;
 bh=iguH8XDPSekwCbNvLzdbE9/52s4hYfTzQ5S7iKLMu7o=;
 b=Ro9OxZOViqWtDPyjOKuUBl3mCSOFV48+9LHQkWR5GG8XgnIBtB+58ErccyaXVX1rOF8HUYcFD
 Yi+kbD24UYfAs9ItmydJrCOjYtftjPLwGzWReFPF+uVEYP9mmYGOQ6Z
X-Developer-Key: i=pavan.kondeti@oss.qualcomm.com; a=ed25519;
 pk=Pdl9NnQpMlqbYaAGGkgBGpURTnZFe2de5LRZSGHkbHY=
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b101c1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=SB7onciJ_egD0uDeQz0A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: z4ZoABiVkt7YLHnccd2mzqzLNt1-gLDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0NiBTYWx0ZWRfXw6h0Dg3HBsVp
 yWIZA0i0yCHzi6nXPAYwpcyEnE7CU2myUKVvCddKXYSbnE5BilgpvPXcPLQ1w2KAoSwX7h9WndZ
 S6LL7uu2xkjHYmU5ZJaj+C521pWi+wPup5ARkPWjJODgFrKypN+ZCrp7xqjvqmwEPWzrq9i5V0/
 3NtoZvz6D7dJtM5mCOTjoHC2PxEdbpcOLVyTg1qf1EfdWt4zF7CLRO7QNaSc4plp5yAIxA9ErQz
 LlmV7m5OCwyhZmnEKMQKRRLjP3lkgEi9N9fR+9Zx1B5jhmYMJ6wJ/oSTTYAeysGhAGav+hxt6nk
 cAv+vWU8WZoC01apL158WgYCQSb1GCyEFt+SfqSH4bsUwgBAaQBKwaGCjVK/vdPZKQn1SFhJp/2
 FrtTMdyK4lCzm8o0gFwAWXPDO1MGMnvM0VT182fuAoqjcq4EGkhvmWXGDfX1Lw5m578uWMD3dRX
 O7GQvivI6IWDVRYug4g==
X-Proofpoint-GUID: z4ZoABiVkt7YLHnccd2mzqzLNt1-gLDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110046

Gunyah is a Type-I hypervisor which was introduced in the patch series
[1]. It is an open source hypervisor. The source repo is available at
[2].

The Gunyah Hypervisor doesn't allow its Virtual Machines to directly
access the MMIO watchdog. It either provides the fully emulated MMIO
based watchdog interface or the SMC-based watchdog interface depending
on the hypervisor configuration.
The SMC-based watchdog follows ARM's SMC Calling Convention (SMCCC)
version 1.1 and uses Vendor Specific Hypervisor Service Calls space.

This patch series adds support for the SMC-based watchdog interface
provided by the Gunyah Hypervisor.

This series is tested on SM8750 platform.

[1]
https://lore.kernel.org/all/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com/

[2]
https://github.com/quic/gunyah-hypervisor

Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
Signed-off-by: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
---
Changes in v8 (RESEND):
- Since Hrishabh has left Qualcomm, I am resending it after rebase.
- Link to v8: https://lore.kernel.org/r/20251118-gunyah_watchdog-v8-0-e5de12e2eef5@oss.qualcomm.com

Changes in v8:
- Fix error handling in gunyah_wdt_probe() to fail silently with -ENODEV
  if WDT_STATUS call returns -EOPNOTSUPP, indicating support for Gunyah
  watchdog is not present. Fail with logs for other errors.
- Link to v7: https://lore.kernel.org/r/20251114-gunyah_watchdog-v7-0-f5c155b941d5@oss.qualcomm.com

Changes in v7:
- Convert local `const` arrays to `static const` to optimize
  initialization and stack allocation.
- Link to v6: https://lore.kernel.org/r/20251112-gunyah_watchdog-v6-0-38ad01f8dac0@oss.qualcomm.com

Changes in v6:
- Fix build issues reported by the kernel test robot on PowerPC and RISC-V
  architectures by adding IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) check
  before calling arm_smccc_hypervisor_has_uuid().
- Link to v5: https://lore.kernel.org/r/20251107-gunyah_watchdog-v5-0-4c6e3fb6eb17@oss.qualcomm.com

Changes in v5:
- Move the gunyah_wdt device registration from the SMEM driver to the
  SCM driver. Add additional logic to check if we're running under the
  Gunyah Hypervisor.
- Implement .remove() for gunyah_wdt driver to make it not persistent.
- Link to v4: https://lore.kernel.org/r/20251031-gunyah_watchdog-v4-0-7abb1ee11315@oss.qualcomm.com

Changes in v4:
- Move the contents of gunyah_wdt_init() to qcom_smem_probe() to make
  sure we're registering the watchdog only on the Qualcomm devices.
- Link to v3: https://lore.kernel.org/r/20251028-gunyah_watchdog-v3-1-e6d1ea438b1d@oss.qualcomm.com

Changes in v3:
- Move back to platform driver model. In module init, determine if we're
  running on a Qualcomm device and there is no supported memory-mapped
  watchdog present. Then proceed to register platform device and driver
  for SMC-based Gunyah watchdog.
- To determine if we're running on a Qualcomm device we're checking the
  presence of "qcom,smem" compatible devicetree node. As an alternative,
  we also tried using socinfo for the same purpose. When both
  gunyah_wdt and socinfo drivers were made built-in, it couldn't be
  ensured that the socinfo driver probed successfully before gunyah_wdt
  init was called. Hence, we resorted to the devicetree node approach.
- Limit the errors listed in gunyah_error to the ones that can be
  produced by the driver.
- Link to v2: https://lore.kernel.org/r/20251006-gunyah_watchdog-v2-1-b99d41d45450@oss.qualcomm.com

Changes in v2:
- Move away from platform driver model since the devicetree overlay does
  not happen by default.
  See https://lore.kernel.org/all/91002189-9d9e-48a2-8424-c42705fed3f8@quicinc.com/
- Only when MMIO-based watchdog device is absent in the devicetree,
  proceed to detect SMC-based watchdog using GUNYAH_WDT_STATUS SMC and
  initialize if SMC returns success.
- Implement pm notifiers as gunyah_wdt is no longer a platform driver so
  dev_pm_ops cannot be used.
- Pretimeout IRQ is no longer supported.
- Remove struct gunyah_wdt since it is not required.
- Move the contents of gunyah_errno.h to gunyah_wdt.c.
- Link to v1: https://lore.kernel.org/r/20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com

---
Hrishabh Rajput (2):
      firmware: qcom: scm: Register gunyah watchdog device
      watchdog: Add driver for Gunyah Watchdog

 MAINTAINERS                      |   1 +
 drivers/firmware/qcom/qcom_scm.c |  53 ++++++++
 drivers/watchdog/Kconfig         |  13 ++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/gunyah_wdt.c    | 261 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 329 insertions(+)
---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20250903-gunyah_watchdog-2d2649438e29

Best regards,
--  
Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>

