Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800D370D5D
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Apr 2026 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846465; cv=none; b=AO2YldHTJW0u59zTlKeWK9J9UweSYeOssiw00Gnn7yEeh1pTaGfKM/sUpVikWvdrcutY+4a3iHs91psastQkkLBAigciN2aqQXJbql4DsKwaMBTGbhEov1zt/bauQmw08Bxah3TcoQxMdSEaRS0ZmEMXosOgXpvp8Iqdh3owYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846465; c=relaxed/simple;
	bh=EyETeqefAqKuSOaN9zNOb4iPI5JACd8mo53FiagzC3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOn2I0fiKB11fWIAwyQs2vs+NSQQZ7hwBFMGzJHu+QJexX9jddRL5XHWT+cSGx9Sd/ZmdO2C2kcjhktv2hRRiaLD4Zc/3CzQZ82SH9Y4gpaIT4hAHh8jEy3Ym7vmNYIDS9Z58WcSyn0OCjT5bfNDVtbHQB0l7/8J/Hbi1ZGVxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W812tacv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MpQKpPEH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W812tacv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MpQKpPEH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M59GPU3377466
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Apr 2026 08:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WedYATfTHNtKBqWtI1UXxcIB5o0xBek16Rh
	s5kmzr0M=; b=W812tacvi3tg7p6jyFU92TZ1Lkj9rnU3SfaZUCrk6akwbR2OmVL
	I4tkL8Ex3ag1UN3oflatYpZK041u+IsnNvfzw6W2Ayd4pfnEQT3kVdpha21OIWpB
	sbSNlLXqPW8u4EoIOsPqMJS1hLzz+T5NfXDwiGgm/+r63dNL220/1j34fvNeFb15
	MQZ2avEd5A/d/71103Ba1kn3DJYR8+zPuxXaLIEAIoKmkbE7hZtRGeL2BiE5owEB
	EZsp8wnCnIyAh5lq9U69v8Cg3+f/G4n38xIgok1Jb1rhUdTQ2r5q+fQ5rjrDvvO2
	5JPYcrS3qT4s/ilmNeSd8TuyLhtMRqZWXvA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng2jnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Apr 2026 08:27:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e592e833aso36347511cf.2
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Apr 2026 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776846462; x=1777451262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WedYATfTHNtKBqWtI1UXxcIB5o0xBek16Rhs5kmzr0M=;
        b=MpQKpPEHkqLvJGEYhM6VzBkdhYYcF44IQwgZ5IGJ94f9+/0ZNVxCgxx2ZCruhRxEF7
         JbbTCpqbWvaodpls7/0V6XETTwEicnTfCWATA/4nUk1cn+wvG+pZ2TnwUHMdEop+zOdJ
         obpAK0bVvNv6JAyy4LLY4rwXzsd7+igueAeNfAOKUwGZQOTGOeOlgI9FaZce8SfO6UEj
         d4uf0ZQpJ/JBHB/uveZIECFHAwO2q8b1RYKRFJ6IHti4yf1NWEKf+gmu5AttIN1uDDfO
         GVKrO912TQ5HuaUIRGLsn/9yGDCYni7DrIYyivNXJsH8DikIdP5VYI/xSbhLo/CUxDRO
         0+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776846462; x=1777451262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WedYATfTHNtKBqWtI1UXxcIB5o0xBek16Rhs5kmzr0M=;
        b=fRygm87deADsqNMyvyEqMKf6YeG2plTXtSbp0k3Ajue2A+JUFOC4n+U/RTg1VIwXkV
         hIwggvtI9I7oKAR04vKqS+C2snWEtNWtYmJ8964ANSas3YuH+bQRCWmDBhd3LQHVFSzx
         PMdY6uvznWGIPP9XssYRB+13ThTjNbMMmfH/yXGRrV6avL2sq2B+61qHOHxu5j0BnD4T
         U/A3+Dc3C3PjxVxDAAz5QEiyjU3AGlxfKiY2Fxo6k1xTtVLvZ5OhgzNAQBe2k8EBdlAf
         t8uMu+C4Fe4tRs0ieqWh6C0nut+8ng6MImgyeEFQvtSserVXpzb9ITjjCwbKJVNo/d2K
         b4aw==
X-Forwarded-Encrypted: i=1; AFNElJ+mFFWWLqZ71iFEt04AOspuVX4+gXRjGgtz36pS0943DqU6W09E9M5z13TLkGO/5aSuj+iPEduOHPgdgT/taw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwADrBkCYJJejfpFVuxy3uae/beUZETKUbC2FmTQYXxAYYqleSV
	FsOFsMA7zrdAG5oQMX0ScF3/1hyx1BTroGZ/Bwe07sj4LwSD2dKP+NYNEkR0DAzkCkoO6lMth68
	pNO/om/k7mfOvOZa+0eRQZQsRTJALtmol2pu2zOSLxSiLiiORqWgcrb1v/mBqXR6WsSK9Jg==
X-Gm-Gg: AeBDietL54iChonclssTHMdus6KpdKRgXvJrk9EIrdvcLSNe4H0LPTddJL+V2s+ETMK
	qxMOtgZ38Tk3YT0QF0kRpSPcBRFWbot6JNMC/QauR4M4mhYtdAxvTI84ie2aRFI9rpEfDi76wMW
	FkKtEBDi43mypf5zFKPr+k21q29PjSa6qet0Q7y+4B5MUmSb3TemK5+budM+a/gH4X/A4xYKadQ
	kfkHgX4FYy/jbUnkC5cHqZxyLzB49KKx8W5tzXN2LKg7aC1QguNwPbSagC0oe82WQToFpQhcZJi
	0aD1ZIqqb74n+yh8lOt6xppCddo3XFi5waMX03raaXmHACVejWF46ypXe7FXELW4in9qWvlo6Lv
	MGDXxTz63agvUAZodFD/E0z16GfRKST6r19gTMrt0BKWqe2g=
X-Received: by 2002:ac8:58cf:0:b0:50f:be4f:465d with SMTP id d75a77b69052e-50fbe4f4930mr44344621cf.46.1776846462603;
        Wed, 22 Apr 2026 01:27:42 -0700 (PDT)
X-Received: by 2002:ac8:58cf:0:b0:50f:be4f:465d with SMTP id d75a77b69052e-50fbe4f4930mr44344451cf.46.1776846462204;
        Wed, 22 Apr 2026 01:27:42 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc558f2sm289231885e9.1.2026.04.22.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:27:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] watchdog: qcom: Unify user-visible "Qualcomm" name
Date: Wed, 22 Apr 2026 10:27:37 +0200
Message-ID: <20260422082736.81981-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=EyETeqefAqKuSOaN9zNOb4iPI5JACd8mo53FiagzC3k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp6IZ4QymeOv5gIcl5vB+K0tSAr8qyHiNbPOY7b
 f4RYYnK9wOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaeiGeAAKCRDBN2bmhouD
 199yD/9pkMhXj5EQOGENnL3be9bAZmm35xYe8alclqrEk1NVZBu9E86AcLz5zs62cavKyuwwl/f
 8cZlOY3nmIgFAKZA9xRHBtx6qy1Gn/XzodgybYOHtu0JQeQ+8GyFdDEm8r9PE6NJzHtXpM5qyCj
 6AdR7WtLLxeoP55Mncnzk9aGZnT1MA8A+xajv5lZEwC9f9AcJBXlruVfFwZ8Azdrwb61H3tR91Q
 Gev5/pMAgeFGViSh2X5GSBYrijPW96MfCghlqYJQc4+ol9Ud6LJRWszmt6LN0tyKtGKel43nhk/
 uiTtPD6H8LXp0e+PhuMwWJY5bdd1SyXQrlKre5s2XRdJoKD8hXdNGsYPRiPs7lTgWdrp/1AsbJs
 tEQ1ppIIavpsLQSvA+42ouiIIereMGzYMyK5L/75x70RMjZCgXDWgSABgygPCJBRzYZfMBsPmpt
 Tzal6NBvrQfXq5D+luFu90xxVlYoFjxuwxMMU0mblqYFbqI05ZN8zUYGkmw7xIc58uSQ4adUjM1
 fMKYYMrupHM2e7fn/fI+DPQ1lx8bXVy0pD3MZGk/jx6dCuXPCU7kD05loQY8KGY/2hxv/diYwmF
 TTbVRG08aEO7kCjbmcVZGteI94qPDdwyAwXouwDcr822M+8nWh7CVneeQnDDELl3Pj3w8DBvYD6 tkdsl3HQCqrsFZw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e8867f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iFGoPWVg5XqNsShY59gA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: EAUnNPaqQ8-srfT4TL7SVXv5mOjToenm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA3OSBTYWx0ZWRfX1T4UJLQ6I1k8
 4yvdVKq5G2t+gZAsGuARcOXCgWoLM8LwcGxQKU0PtdQzOkJ6Aod7EYyQZnV4efjGryXK2KsTFs5
 2Zfw7/1kbWSQ3FePZkupR+bBc5+IqMbfHwYReNbQoUUe2wP1xuRWl2Mxri7FQKsU8MtYUxG/63M
 kBeIRSN0JoYW0FKNNL1gQf3OpyH9HKk6yaZyRlO9V4+T6hrZO5c+e1abRtZMRPYAg8aSCC1fPxl
 2zB+KyK0adlNuyX1g6bEhvm27DLq5dV5BJiH3lblUxKWtxM5xOIqffE9LdnbA46TXRscwmczYxu
 YaJ30HEWF2p4b8pAR82/wJLOap/Qm7d2cyAgTm7oI0u2lkEpMs1XLHW/2yZLvDzIAOFCmvnOvs2
 bfW31D5CJcfJ1wUmek0uposJmxOCBQFz0S8kEXY72JfxQ3cLR0Jh8eA1Wdsv4Ftn6U7+HvfbGh9
 vFA3s3WbBvF7vBmJKwg==
X-Proofpoint-ORIG-GUID: EAUnNPaqQ8-srfT4TL7SVXv5mOjToenm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220079

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/watchdog/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..2d3b404aee7f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -882,7 +882,7 @@ config TEGRA_WATCHDOG
 	  module will be called tegra_wdt.
 
 config QCOM_WDT
-	tristate "QCOM watchdog"
+	tristate "Qualcomm watchdog"
 	depends on HAS_IOMEM
 	depends on ARCH_QCOM || COMPILE_TEST
 	select WATCHDOG_CORE
@@ -1093,7 +1093,7 @@ config SPRD_WATCHDOG
 	  by Spreadtrum system.
 
 config PM8916_WATCHDOG
-	tristate "QCOM PM8916 pmic watchdog"
+	tristate "Qualcomm PM8916 pmic watchdog"
 	depends on OF && MFD_SPMI_PMIC
 	select WATCHDOG_CORE
 	help
-- 
2.51.0

