Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374110;
	b=OGJD70W7GKyfhus0sMeZ77WP4rv6yU5B8m0JgbIA8gcu/uatHtMVxUBrx78wsEhnJkN0
	 QtaI2/1LBMr6jUPrX/S9BEUj52LF0H5Q7eoIapDP947RYbY/eS+4eqQzU0k3BNjQcixH3
	 L+OzM/AwxVqDtj880novt22sGdN760RrRjYr61B6Y7y56jVZMnIOhkyxwRxIyx/r3N+Ed
	 mKitBMSvMvmzBJ0oc5liED3KI9TRygM3XNHGSESpNyQ6t7Z5CPKqFSi1/QolLBcCr0GBO
	 oAZ4zaKhhGDBibjwAH3Iws8QJ3mgLtKNv9L5374yDzpAn1axwLDLbDe5q/XoeXFvgNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374110;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zbO/9T2WTPunnoMhOWAiSp41nG3mYh7EnFdKhIIYMKc=;
	b=zVInPP9njjvwP+IqnPlJda1CHbi94clk+PfaVn+E+Pp+yc67CcnVySqLh1NpRNogIyhH
	 AHYrkj2GOi5vqc9b7k0QvjQtR7RrsbRGYA8jGoaf4Ftz7LIot/ySqxzDsWH0cbij3RvoH
	 c2Mf56PXQfpf61C76jLlypu2C1Kky8frIheIXAFiP9C0JdSnn1wCTj83c6m64j+hfjZXk
	 T+uX9kCBkGb/dwsgLgSGisHrx5qfQrnUlxapDChj59M6vcYq6GitvXvwzJEcxQZAnz2BU
	 Eip6V6X5FySrKc9DMPHlaDpE9iufvoETu/K6dIufScsW/qC+BKaL/1Lk/QUyYGm65vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U+3+fxFw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PJBJUxWC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06F606A31E
	for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2026 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C06F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U+3+fxFw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PJBJUxWC
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERFOQ3515574
	for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2026 15:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zbO/9T2WTPunnoMhOWAiSp41nG3mYh7EnFd
	KhIIYMKc=; b=U+3+fxFwbUycfEfDWzdEZEkezQkkmX5LhHYrXiKTKDmXAhAZAmX
	Ouc0e4EpDLJZ+tRPg5gGMM0QOnCKLEHj2+0TtUo1I1zMZ0ISFR2xN66sXTJzP4YW
	LoeoUnS8frQyxbD65ILv9il06sYulY5YGkY47LHB8VANKEN+T17I6C4AvklrZ2+E
	ZZOLiATmnONCPYJeFcHYab3hmFG7ekIH4KdEFn78kcSqgoBF8WRD15e+Dw8ITAp9
	5x4d/70RGHVNITYdJrtQY1t6KMpgqxyFZXE4t6CT2ntYHwPp9c1L+QaV4cX9QRaE
	Ski4NR74OILZ29kreLLAGIo0TdXc7iSxxkw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qksrv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2026 15:28:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f33438950so159147385a.1
        for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2026 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793374107; x=1793978907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zbO/9T2WTPunnoMhOWAiSp41nG3mYh7EnFdKhIIYMKc=;
        b=PJBJUxWCSeddLwqBOYIAmY+HKbiV5ysm4ZyXiBPKK8BAIgKIyB/jy6gqpjmodHvrhp
         t+syQ/KmFi+6sZeB06BL1Oe0Gv2mAoNV6+hIcUpMsP4IHU4C9ZV9hKV/AVE5ErxLOiQf
         7kPtHR1nbVFoASXJIY1SQ7uxhmkWBjYabrtS+nJd64VV6kTue3Fpv+DSEZjxb6kNR51G
         MpI+i1kMcC4FDRDeklT4xtVkWzsCup2hY8+FmMFEawPh2ZW9cRehYgMI2GBPS+6PLvaN
         +0QD/hskz++ANrbW5f+JofVP9Nr9wKu5n53hOCejl5saPvg7RumWJSbxpejZlznrNeFz
         GTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374108; x=1793978908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zbO/9T2WTPunnoMhOWAiSp41nG3mYh7EnFdKhIIYMKc=;
        b=GPGqLAsx6ceqTyj8FNKBZBsdKyuC8/68/w1ERlL3jW3Si5WVwdQd4cP9dpa+D845E7
         zYxgj0mYCfZf8sbEC4nK6NFj4F79GKLQK8e1WvCkNlNd7hIbP1MnWiLx1D31PW40voDx
         SFr+eAlAPtlHMD3/IuXXpvtlZej60J1GSJTJmJ8fyNa/lJwQ7UuQ8cYjbBQqcVVbJELk
         drgSqicYfCLmcgKeEVKuL1PX4uIpaAL4Ok8nPyTsedwa7W9meODEDZNp7mzcTE5HaBWf
         udMWNhL1X6LB8SgAEHsg0C7YaRC0WSq/pclYXIrNMs5difEG136XA+mLs/A7HNTCWiRC
         3cpg==
X-Forwarded-Encrypted: i=1; AKwUvByJFc8FVT7FxvVHyhK+YkGHdNox7v34IBbUbvO9N9FzEIjwPd3E/eCV7Q7A2lxiTodp0oWzpLVGyVDX/1mDQg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLMDIr9wp4rOGplU8/EwfL2tWxngF9ZTXpauP23sgecQAlnNmTH
	oKeQJKAKwmw3Jw3S0XSK1kVZYMloHg7q7KgMrU7dz7viMhnGKCsgVdWNIyBRcaWkCKq9EFil2W4
	5N2JhK0vgdB5eGob0M53Mja1nLpTqaT4urg8zxC8N3Ypma0qxWeQHRuC5XYHEm9AQ0Fi6tg==
X-Gm-Gg: AYBFou1EFgsD76o83fvB3+oQdrL7q5V3AWkGjip4o98KVI6Q3XR0gPJwoKRXUoGS5fn
	78I+oPEIN15VIpZtrbyYntRmagli7H0jzBYvRXgjSrqAUh+hDRrPxyR5oQEud4WPuOP5oUKSeCx
	eZcFsCq/SnBZK9m9wQgg8KrhO4kzycLdjUsI8zRyfI54IiE3+AoYLtMnguSs7maKXB1ma6ICzpl
	OIQ/KJauzeicRIYcR2cj9eJqc50PCBOkySvnl7uDouimxcZZl7cJbNu8jGc7hg5BDZvCRYUMfAz
	ItdI3VZHJlK2CJtaT1QvS+c0www3BLTwQDkYJwE5HNw1L9Hsk+EsmDlHI50UEEzBhjlGeDHg5aY
	8+vlUBVC0whus28sNh1H+L7ucTI0U27BtYzugqsJSXrZ2OFJrNZpnZz6O2qZbfg==
X-Received: by 2002:a05:620a:480b:b0:93e:5fff:db07 with SMTP id af79cd13be357-9442175c1bemr457806985a.40.1793374107370;
        Fri, 30 Oct 2026 08:28:27 -0700 (PDT)
X-Received: by 2002:a05:620a:480b:b0:93e:5fff:db07 with SMTP id af79cd13be357-9442175c1bemr457799685a.40.1793374106734;
        Fri, 30 Oct 2026 08:28:26 -0700 (PDT)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf368bff7sm68611655e9.2.2026.10.30.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:28:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: mfd: Drop MEN F21BMC (bouncing email)
Date: Fri, 30 Oct 2026 16:28:22 +0100
Message-ID: <20261030152821.283215-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=kmNdPJPVrDCm9e0u73KRmJcOPX1/jig+MXW5yF+K7Dw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq5LeW67VWmOyJl9abzEjB7AZHf33RHGV+iUb9V
 o3xT37t19GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauS3lgAKCRDBN2bmhouD
 12TLD/9UHhzB9Z2iclhe4fo+vxrjjRArNxuOUcSc99LCrx/pP6rmMi851ehP1mZm9863/6NI7rP
 9JiIol3rVgs1ak+t8fTNHW2KmiTKVUV/KUrAwjnee74F4/yfn92XwfJuQ+oPKHiVAfqgOkpaWVD
 k7zmsJrb2Bnu6KfvDzo1y5Oe4kjpsm7Un2+bHtPWBuuKi4T8HzcUSOn5xxLROvrp841M3H9j/m2
 0b7Zgr5LWI76z+ITgmpNINDoJtTbUL0nZ4ebxk+ShswE4/OjJ03C+Fup5LonLaoessEACzVXxaL
 J45SWgIOBOU0mFZCmcmwhDWZH+/onIumakKmocioSQEL8d80e44NlUyDehk4F5ZJMIoe90rAy6O
 tQtUtjoWjJiqLRWUqdosDwq077Zfw0QVavmXC8TXVPf/tuckcEHtoEPxzumhWDDYTJOCquBXRxx
 wOdVRkcM2beCYpoZhSAE70Flps6QGuLQCsZAcAyiXCdp97MWwQxMJV4RDD111RKbDehYwYxUZkJ
 0IijTO6Sw1AgXT2oYulLQj5HNfV8tBFaueHE41GorN0ueaEjz89SwRb3yA3itaTTlnqcFiu2D0B
 cG+O5Nne8q2rMBNQE4Gr7OF+UKbpvo4rVE0xlUGgOlMbhH1ry+aQ8poskus8B0glPkvPHhV1RJr c7uOwSrR+EZvlQw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bhi5tR4znqSj3pXM-Se0qHOEDiKjBOYI
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4b79c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=2haQ2MhrNbTofsgfN2sA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX1o4Bl+natFj0
 Lu9QB4GQd6PFngA1f7xr/5jS6Sh8tFYGxntR82t7mnx9Rvex0nWLsdVRxlSPgFiwzVFvTyZ7Dgt
 WuEHVAAnlJ+Tag6JPVbZuUzxHx2dzCeXhvwp1B8TSHi5jo+EDRD6hnoa3B+8KtLdzyuZTpxHoCW
 G/PmaLUNtHfi9/SLx4b7Pbl1BCgJ7fSkMczntKbllZsn8pGMzkjrEu32kQOUwu+iapul9t6EhcS
 EnEaryZOLLGugZQ1XypFj1CPfTx0OP5lo+et7kAK09r9vMgDpFd95XgR9VoPEjRIJDnEm1bfduy
 rQpRQJwDlEJiVtg28dFvCww8qyHNnVH9CM1jdY8JegIG3rgGpRUiKAnMVZpfEduJeU07IqTn026
 RXB4ZoFpe7BSpJmVLKgPn9EYgWc8yvjlaXUE8tX81gYSh3iQY8lmAzi4qNVl+JlVqpEw/+CmWZt
 Cixxid+PqaQ50BdpV2Q==
X-Proofpoint-ORIG-GUID: bhi5tR4znqSj3pXM-Se0qHOEDiKjBOYI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX3j7RRAErwyGZ
 E+BUPZS1dw0pfa3bH75FQiAOM8ZMgrEMRtJUOdEmODBaS0qk3mzhhG/dLKk0rE3v0tHCLAqCJuH
 aTv10OQp5RV+rgsN4Zjc01wC/ekTnFQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300061

Emails to Andreas Werner bounce ("reason: 550 5.4.1 Recipient address
rejected: Access denied.), so apparently driver is not supported
anymore.  Last emails from Andreas Werner are from 2016.  Drop the entry
completely.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Maybe this can go via MFD tree?
---
 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 365bec8eb7fb..51673747ab91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17998,15 +17998,6 @@ F:	Documentation/driver-api/men-chameleon-bus.rst
 F:	drivers/mcb/
 F:	include/linux/mcb.h
 
-MEN F21BMC (Board Management Controller)
-M:	Andreas Werner <andreas.werner@men.de>
-S:	Supported
-F:	Documentation/hwmon/menf21bmc.rst
-F:	drivers/hwmon/menf21bmc_hwmon.c
-F:	drivers/leds/leds-menf21bmc.c
-F:	drivers/mfd/menf21bmc.c
-F:	drivers/watchdog/menf21bmc_wdt.c
-
 MEN Z069 WATCHDOG DRIVER
 M:	Johannes Thumshirn <jth@kernel.org>
 L:	linux-watchdog@vger.kernel.org
-- 
2.53.0

