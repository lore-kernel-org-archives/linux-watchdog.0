Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6073FE347
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510235; cv=none; b=J8qDw61VFsrO47UGECmB4WeO3qu3eQw0nur2QryHTdCMUsrX+GM1k0buesN8C0hmPMJq7OmFYcPOGAnmoMK+7FfJMgiZc2Y58+ea/gc5zqbMFMmKsEV7jPbGTN+xyXQn5t0fpk/cXmvzS7XqS1lc1PKMRKoanGSOBqOcvlQczpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510235; c=relaxed/simple;
	bh=p5Kug1tNLTgkIN4VM5MK/PJ60rtDv5/qU/L69mB5lIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SnrtkTPz0XXaVeXq+K6mFkvEKQaMVO9xfJ87Rs0FmJruJMa+xN0CN5xweOkRYC5Atjyp92dzR1tAHc8fC7pPux7CtXqo4ikP6+91p8wydmRDB2QA611bVgu/dHgMaoZIUmndX4Vq4p9ab9n0nkN/XFz3DIVSDbrI39uTvaNc78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rrh98Mne; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dAFTkcdp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rrh98Mne";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dAFTkcdp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BDALiJ3333585
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HULKX73qzdciugZvR3HKlS
	qQjAScB/2pEIkvEnaSpo0=; b=Rrh98MneRojJoTERz62lWZ30sCZKINFg0qgPWf
	Cd/7vM6h+Rk4bIFztJlrgqy7n9f994HKe/ATF67wDo6XSUoXas+FAC1oq5Ukti9c
	lXpTjI0t9KnEnBQi/s9TghtZcaHOdM/6CEtkfWH1wT1wCeaOOxuH0TqhCWcED9r1
	XSiNKAA+g0KMTxT2r7FtI/5NKP6Rjw8fArjkbadXbPig6Q7FaGh0sh+opuMj8sIr
	1BV59INPD8cs53HgxR1qHkAqJ5/FaCI+RyG8VOlDsNfTtqNSHTReoHuU9iBtXPmi
	MJoPx2FYWJ++mYBG5xaU7yU+JsvNhbS1512jHXOMR5kXwzJg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ajgsm6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:37:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso7332396a91.2
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778510233; x=1779115033; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HULKX73qzdciugZvR3HKlSqQjAScB/2pEIkvEnaSpo0=;
        b=dAFTkcdpVKAId4OM5+Sr6/AX6bQ6z4Vg5e5BrqatjQ2u9X+pvUDsIRpIekmh7xO0Eg
         pyJ2R1VTkiAjduUGYH4d8+3BVZ2IiGQqO9lhu7WQMPQFOjWEgd06qu3JVsjyKZLqXwza
         LCOtf9bfufc347/qaBPiWjk8r/nlbrsMu0Y2jByoiP9i6Gtm5ZZkBq9DxaEQfVBhWeZL
         hWZcTJ9BJjijkuM+gkbnp7NYGggFKuUg69YRa159nLKkSROz/ryzFEMcv5JcnN0K65F/
         2I57IWveXoqDpGqNZPL0RChQaR3NHOLpLJtknZ6gHaCYO/mvEezUOcJtCPetzidadpcY
         kIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510233; x=1779115033;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HULKX73qzdciugZvR3HKlSqQjAScB/2pEIkvEnaSpo0=;
        b=rY6D8nMqPAKREj4P+2odxQX2/utK3JepGfVFRtnFkW8ikJrxDUjdq1X2TsI6Sa3gLH
         m5FqJmHYe10xz2mBOKvJukCMm3DrzkDttLrwypu/mNoYcXk58278nz8LqSpbbszYwf5r
         gj4gvLk25jGUKK5L6eMCtN5le0vnbMkXR5mMMvM5gZobZrP626nqCbti2e3g/f49xoJm
         6YRosPHskWFmIOBJShkjFLkq6dGOiA92OeEGdKOVeLTREn7a0ncQ+kuEsQB5pXVe3N+d
         YNpp1f1iq7Cuso7KKUCcmF0lz0P/jBBIKJXOU77/X8XIAPeOsUKx7kmXm4OOOvakLR6Y
         6T8A==
X-Forwarded-Encrypted: i=1; AFNElJ8Jf22w+AHEyGAPQJPXufhISfZayLN4BOygyvI+z9QeMKjlCoPoie1dvsN1pkBAxMsMP/eaNsdXCbuvVOQUsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2t/a5j30gbdHHquoGPTM67L4XG2BZaoP9N33XjFqmwUYVk3N
	11bzwzcn6m9k1qcQiojL4LqBpx/gXyO6iqEeYuw/bR1U25Yyn/nZtRuFLOFma+D2tXefoYw/F7O
	oOd0ZcjzvOAIIGJz+InqHS76D1MxDXyKkV8xW1zpyIPA94pk2Pf8fz54Mm/HZsX880bP3Ew==
X-Gm-Gg: Acq92OF0rDd2tZrnP3VpVeM1SsO3h49t6fI1Xi61EukD/tTzdYPAt5ZNYE+wT/rvTyu
	zEHPpS+1XAusvOPee7f8sBbiwclenEEzmyxywOrJj/8cdvr5vPryRL8WTS4ylnaO0/GfpfIaA3x
	YD+OQ5LP7UFP/0Ez9QFz8cEkrCTmvcCS9/l5Ipbc1XaQ+scvNyTu4IZJTDSr+i2P5I9j3YOUOsi
	5OQy8egKSwtsITm/+aOU7jpRMLrheAR++rNBguEos9KzY21LMihO6KEtpl0A0LVcsIwRR2AIQFb
	LYZ+M3ow9y9yLrJZHaLGK9sojjLVp9+12z0uD02vVde4GkK2ShSMYtSrnDinne2n4zbsPswKALr
	7l6f20WKCrVzwDWXZh/6w5YAQGi/KIJI1aLf/1fwayqrPEUPlRPlG3dOy+DsAU9j8DzCwUEMzcK
	qcJ7/l2vvCWoQ8YhAoTAxXgMZv9955qdtLyyIPNrBv4lpqXq/1LkgEIukBRT0LuqwG6e8=
X-Received: by 2002:a17:90b:2248:b0:35f:b348:63e with SMTP id 98e67ed59e1d1-365abbe373cmr25939269a91.9.1778510232362;
        Mon, 11 May 2026 07:37:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2248:b0:35f:b348:63e with SMTP id 98e67ed59e1d1-365abbe373cmr25939220a91.9.1778510231745;
        Mon, 11 May 2026 07:37:11 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367bcbac3b6sm3059935a91.0.2026.05.11.07.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:37:10 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 11 May 2026 20:06:56 +0530
Subject: [PATCH] ndings: watchdog: qcom-wdt: Document IPQ9650 watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-ipq9650_wdt_binding-v1-1-d2779e756bf7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIfpAWoC/yXMQQqDMBBA0avIrA1MBIfaq4hIk0zsdJFqYlUQ7
 260y7f4f4fEUTjBs9gh8iJJviFDlwXY9ysMrMRlQ4UVYa21knFqqMZ+dXNvJDgJg0LyDRlyD/Q
 WcjlG9rLd17b7O/3Mh+18reA4TmOUN453AAAA
X-Change-ID: 20260511-ipq9650_wdt_binding-06f96b6d80fc
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778510227; l=1074;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=p5Kug1tNLTgkIN4VM5MK/PJ60rtDv5/qU/L69mB5lIk=;
 b=ku2iuQdaoyIH56leKRoFmsG/f+nB4AUsdzOR/gXGGTMazNIg3fpjYwO9GSSyk6FQ+Uz/X26Pz
 dWD5rSIa13vC9IwF+qQh4aDGYwPl5E4f5DCb0v4zGPHdvkLBiFlSpDZ
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=GfgnWwXL c=1 sm=1 tr=0 ts=6a01e999 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=w4RUFeMe5Se8zSgF3B8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: raTjP8b3CsOSwDEdHZpHPMBZnGBab86O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2MiBTYWx0ZWRfX+mWytgPVFtkS
 iX2hfc9h6DYJ/n1tdYcIAei7L/HQ4oHE58s7fyuGPw1yjE7MsVr6bpF3r5SQYukl7zV3EyVELfo
 X19OlKrrHDC27Lbkd7IwEaM4XAoaOAoc4p9QnBNyDxl9LNmUSq4eV8cIWk6YREzK2yKbKITf1co
 pjZXymXOGaCf4tRymX75CwskFBMtP2TLe0BW003saEUh4/GS9WCuiaFp+g0hJPMEIYqIkGC5loe
 uDYl/CNpMYP6FTgaOnpLizgVTwVTntWuPw4t1aMpIdMu+CvoVpoB6qziedRHPDfDH11FuUzgf5h
 qJ/uMauvWb5qTaSLsMdoezFARze2fpKfxWWuQRuGgLiXM7CMi8fcRpAxfu9j+sRsx6lHbspPilS
 9B7qGyZpDo3MGhgGjRG20KQJE921SABw+pDMGZHoxdB04dTUFVHqvtgvWjvkyL2Vqs9B1Cg/7UC
 7fhhxycEDe0odhb9fTQ==
X-Proofpoint-ORIG-GUID: raTjP8b3CsOSwDEdHZpHPMBZnGBab86O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110162

Document the watchdog device found on the Qualcomm IPQ9650 SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 9f861045b71e..54b2378525c0 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -23,6 +23,7 @@ properties:
               - qcom,apss-wdt-ipq5332
               - qcom,apss-wdt-ipq5424
               - qcom,apss-wdt-ipq9574
+              - qcom,apss-wdt-ipq9650
               - qcom,apss-wdt-kaanapali
               - qcom,apss-wdt-msm8226
               - qcom,apss-wdt-msm8974

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260511-ipq9650_wdt_binding-06f96b6d80fc

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

