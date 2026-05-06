Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E0C3E3157
	for <linux-watchdog@vger.kernel.org>; Wed,  6 May 2026 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055367; cv=none; b=nrWaF3TPMLnMZWMZN5QIEGiRXwE3Q4T9NE2/ZDZLbNw7PdLpSm0G41Vg2m56UAHQhFJHt+zU+5m7wWCREAzV3fUxO/p9/v79xN05imIxkNX88kgQYi33BTZ2PXpy/qsGo5tIOrReKRB99oIbpQF2bXR4URNu7LuRNId08cb972s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055367; c=relaxed/simple;
	bh=zub2Q8cERocuJ0hEH6jOZOlo2P12JktCfUJEYlrJA0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKfiLdI6QLQKqqYFQpfrkYF/u9pjpmjTCSxmmAbkjmZe494z4Jj+Jsc6fTyOzfe9nC8qKejuaL3u0ww8ur8YtXfsbC65PBMeC7mRX3QjMMCCnaCph8Ab6uUcr3cMfn1SQNd1yIXWfrPbsMCUwSVyeYZr+ncfUJ7eQ0PS2Gq6bVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imaKRPPX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZMhQdjB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imaKRPPX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hZMhQdjB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6467CYGt1527748
	for <linux-watchdog@vger.kernel.org>; Wed, 6 May 2026 08:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uNmI61LxIUHSJK2CEeSwEblF+d2ibXxgMjF
	CavBGONI=; b=imaKRPPXj4Q2d6JhOCUcO2DoRNmjT6+e9S4ESGJNHP+auXYpsWY
	I80UzinEIc1ZvKaIzVQwY7uDAzQXPbce35kT9YCtvvbU08TN9aXNAX0BIy0fTbBz
	kDcI/ERgNAcMSVNHa4Nmd6Eebaoi21UiqYan2u7C/tUdQxZG6theqPOCBsURy93q
	7LwJyYAV1ZPhmU5SS3R0YaLtM6ZeiJCWYNNKXV9niF4psD9zF2F11PBpnOyu2GrP
	SDu8RVedCp605k8uaIkHhveFOf1UGuVPys/tIGDyolk+sUlKyRIxNtYUWQeUKuwz
	4t+Hc6HF/1juqfMlad/M/aNJ1KPYP9ZKx1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128897s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 06 May 2026 08:16:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d826ed6f9so17718311cf.1
        for <linux-watchdog@vger.kernel.org>; Wed, 06 May 2026 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778055364; x=1778660164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNmI61LxIUHSJK2CEeSwEblF+d2ibXxgMjFCavBGONI=;
        b=hZMhQdjBQE+vP9dAAUC9adTYZ7vvaoOh/HD+bP3qhRWuQGCCl83N+gP/OtMSvJCCsV
         HSl6onn3XZqctSOIKPglzwVVyrM6LStFUB/Ykr55Sjrd75hhb0PZquDkhWluZdLG+iTG
         yO1zJG45TBXI75QRM8Sx4NduXAyUKSL0m7Z2e1oi3LCuUVuznwB2WPpifLsk2CwZZOod
         ZL8Rdafi/ZPfygCLcg8DK+3yom7iphpcN0F1t4/nUBeXsLKxqXpytBdmXzTvzqf/iFLa
         WlQxtsllP6pXWbkMIAZPXzsEtsYoktRKRnQUidLiBfeMQEq+59LrAgESYnRhRBFk8Ayr
         TcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778055364; x=1778660164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNmI61LxIUHSJK2CEeSwEblF+d2ibXxgMjFCavBGONI=;
        b=i3Iuu6tHkvGfujXEcWLGz4Q+szlaQCz7XDOEyXZgkO7JDifhwxkI7BzBkhm2S29z3b
         TNz66lh48MYH6tUSlUgokhfeu4flAj9qVB842gRBFGbY0yhQ+eGxcGUx4fGb+174x+Oc
         7KDf/GZPl12azk+JLM1d1I8AuDLlhGhb6gpUIviWedVGlRvY5anKTf08FuPdfAzHgLUT
         N6o3trgfeHyEqGNS0vtG/qxd8dP+aXJf6e87iFnpAbnTyI5kKxTDtFAwN8mBJhOUWf+S
         gzwBprOCf7uJYzNNZf60CYjVGRKW0di7fiUp1xY/uiNxTt4a3XKKuySBN5jiCen8bOdn
         mFng==
X-Gm-Message-State: AOJu0Yx8wZK7AqFNB4lpKnBgj0zAdE0CPbSzpfmz/ShXHJLwz4jOm/GH
	wahDtDaWno6inw7o+8mDVaGxalK1bTpfDS3Fh+j+TQmDmNMw6qF/gHIitjKeog1nPBR928q4DA3
	F7OYs5Pkod+++Jy4TOYHmxSsJDRhQXtshxZaWt+JILSAB+rc+ZR8ZwsC/mApMZHkL4lJ4PQ==
X-Gm-Gg: AeBDies5smG80szG3JeWfQ8CA/xXa/dwMnleUeNZlmgJ6wJyKFT12QLsGwfk1h7+TOF
	01skDHXpy370akS9avuHcVFPEuvPnEWKUxLprZTt21WW/M+3TXeP+MBY/lTJeRYMUzCijoJpLvt
	rNBEFF0ICvYOOGaNiMTgWYTH2uHKbITkq0SJe+gF68pDU/XXtvgltSbDF4tjtCFzpj1zWlv7Fk1
	iEo+XbxUqyslojHsMKJ3oHY98FRuPqfKHvg9tVxQDuht83TXERmwC2D+iBGyo2ywAfPP+EbGJws
	1pIFOGJpRL+VscPbqFU1GxN60lNTOY4+KaQAEUlYV0wBiwDaq1eS67h9lvtzgvKlJQ3xqFE8kTL
	KOkWgqDmVxYV0avZfjL5BlkxS+zxmnheWXi53SeuvDl+Znp01azzbKRwFDsUR
X-Received: by 2002:a05:622a:2c6:b0:50f:cba1:18c4 with SMTP id d75a77b69052e-51305301395mr87933451cf.26.1778055364251;
        Wed, 06 May 2026 01:16:04 -0700 (PDT)
X-Received: by 2002:a05:622a:2c6:b0:50f:cba1:18c4 with SMTP id d75a77b69052e-51305301395mr87933251cf.26.1778055363825;
        Wed, 06 May 2026 01:16:03 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1cd7:fa68:b1e1:a93e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2203csm10858403f8f.37.2026.05.06.01.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:16:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3] watchdog: convert the Kconfig dependency on OF_GPIO to OF
Date: Wed,  6 May 2026 10:16:00 +0200
Message-ID: <20260506081600.4921-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wtuKz-y1tmrSbrYzrzhMOPuW8iJduzXJ
X-Proofpoint-ORIG-GUID: wtuKz-y1tmrSbrYzrzhMOPuW8iJduzXJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4MCBTYWx0ZWRfXyjaQ9l8FS2Tg
 lgXeJw69beWnJtSmWcEWkAqM31i06uIvKO0K4dABQbsDrg4CAi9MXADB6ITtrSBGHdMREDsBD8p
 +HVOmrl9DO5TLr5+QeJOyH+2OaxHWajBxBumi7H1Mp1s7bzBuEiAgVqCpgjMlwFyCQkQILmiti8
 n/HkU86FS/cVrk2/aG29MOB3QNfsV+b/sXMrcOWC4KzXhwYu760sd+Pv3U7bZs8IFaFnc7Gd6Jn
 RmpNSsE7WrJ32ScbZjja7jt7FvQMIHS01CTALt0p/WGu4KdsxVpWQDYzPQKmQomFJtdmT7aXEzy
 rG7Phl5t5USsNRSyaYGbF09fOk5fFgOcU26n6+EhaY6Jq83yWyPLwdlZyKIOxS0E0/ucTktno/M
 2AifhFaiSI62Db/P9qUpZ35p/kgfjVLLBK+XClp8JNRvcG0Lg7/1o2LzNPRn2LK5F6fafgV3KyQ
 +tDyVdhPIeDT0DlmpTg==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69faf8c4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_jlGtV7tAAAA:8
 a=KiQ1yeRyPa_UOXqLYlIA:9 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060080

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly. We could simply remove the dependency but in order to avoid
a new symbol popping up for everyone in make config - just convert it to
requiring CONFIG_OF.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v3:
- Send the watchdog patch separately so that it can be picked up for v7.2
- Link to v2: https://patch.msgid.link/20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com

Changes in v2:
- Make gpio-watchdog depend on OF && GPIOLIB
- Drop picked up patches
- Link to v1: https://patch.msgid.link/20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..ab1d5d6df5f3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -250,7 +250,7 @@ config DA9062_WATCHDOG
 
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
-	depends on OF_GPIO
+	depends on OF && GPIOLIB
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog device
-- 
2.47.3

