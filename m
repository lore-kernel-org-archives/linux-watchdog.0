Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C312423EA4
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236298; cv=none; b=kZMImKbuwqbXqWVLmhz07kSVcTMbPNB+S79Qo+eggeFoRkckrIrQ7gQtDOwOaT5wjG6jqoXtoC1iLRu5yAljUVQJnIoUboTurnWTH/wHeqov3S2ifigTDX4di3uFueNA+JPGLVxUeBkhYUotG1z9+cquKYzPcUeDbSYEfm8/vt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236298; c=relaxed/simple;
	bh=5zx2ofaYUI00OPGY3EucqyCGbzuEunr/MYv2rozPK20=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PJ7HdpFHAM7EFqLDFf0AQ2T14stWnKeCVUZD1oAHDyHPw3/ZhiTx+Jmwv78i5IlRnYYriBNlH4xyxlQyGukVTGLZ4yf48DTs9cCjPXY2Er4apG+vWSD9kbfB6FxTkBR9iDGyyFqmLpxT7iS9ZKF8knoICSRYM5mn9Ym1CGtF9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DcfOAk/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMeeV7li; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DcfOAk/5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMeeV7li"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SAgWKD2861388
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ErdR8C7yXGHX0KEoDnDmVw
	01GhSdYqhFnFaz5IIoFNA=; b=DcfOAk/5R2WPHXpcWCobYfh+Pfn5El1+3N55Ze
	hPslQiwF/C9kW9V0GmSz9UlZ+besbUbLvPef5HB6BoPqhx4qRtlgKcIUQy5ubjL6
	JHa7ZicKmSMInlQ1Fw4TfvXMJxDIShKcfJ+bsq3kmlG7npZxGRYnK8coHJkvEAr9
	s6ud6FWkSQRRbeYKB4Y+R7Vh5Z2MRDQobzfh72mpTXMDYyL1Gg62iizJVdz6lPQN
	nVGMtIioanHBrDQXt1XgeHwuH4m7Q5eVYznFFBQRSEbOE9zIXoyHD82vgnf9xz/o
	h0A1I7WsupqCBNQCiIm5/Nrq0T8pyxLLRbIoYnS+K/1FRakQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy11ktj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfe48ca1efso38673365ad.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785236294; x=1785841094; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ErdR8C7yXGHX0KEoDnDmVw01GhSdYqhFnFaz5IIoFNA=;
        b=HMeeV7liJTuWNtAOy2JizDtxF92EgNGQfqNr5HvWqZSUZ4HAfEJ+otcFLq9dqtI292
         TyzRMI8KYZvLrmcwrnjxI+swyaFEwL0CXiWwBItUHARVim01DlTuFQOsRrRo6HxP6E3H
         lW9dSO7byOeV7JbDBaUUQ6CWkCCsKg9+IqIHKNhMicfBljeb53T5IEaeBfyBS+uTM0iA
         Z7IbyQWTL44CaETWQW39emV6rzw6864h6oOCCmqq1rr92zNtKVz8EFJg+i+Ox2vKtssv
         L+KufmJEcgHshsXsFhFLsZHwccPq7nGtQwPi1FSbdOypuCDs/vaqJ4itRZHG2dlWje+5
         jFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785236294; x=1785841094;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ErdR8C7yXGHX0KEoDnDmVw01GhSdYqhFnFaz5IIoFNA=;
        b=blDVNwOVLoou5L0ZcwUGUVKoxAimSsjiTvXdkKXY9/gNpSEOqYxw3yB9gH7soZeaWE
         JIve1qbWgS3+GWiEC/K+2rHapqv17fTO2aGFn9Cw4JpjQoQeON9UuSw7jzFMAkxcjf6w
         OgzIV/fun6NfTiS8HjlvI55N+tg94p3XoiP5BWzXedyovdKG2DO1ERmhA0hrWIWWJiuM
         3pVA58ERlwSm81iGc34kZ6Ud7XDu6MBmF1iwA+HoHQlvViUvpxabT+iJrhOk6NSMyu5G
         EbPyu4D0swA/u7/zADUUq3GoxYIExscRaPHUqw21friBsclCztD/r0UKtJHkXgyk96QL
         o8rA==
X-Forwarded-Encrypted: i=1; AHgh+RrzBD8mO8XUqtwLq/lmGap7buKBcE5QefyGVkMEAiEL6YCOOkOUBpHUbaShVY1SoXJP5gSq63TbLcYES+Piwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjv/yV+iuW8VmLPULVriwzbkWzi5D3SzWbQ9p7+20HoKMvP3Y
	qDk5MmjIzXrl9s9vILlENVawe6M9kuUy+wfvgBgLiCDYWkqt3VUBub9EZL6NvCEgraT13mGQATr
	NZEuvQI/VQ6ARf8CmFAikuxqlKh2XirFX28/aw3cZb5x7/2+ydg9UM+aeK8prWdYRLjuTWw==
X-Gm-Gg: AR+sD1378rMQ11NOU8ksEm2UdWLxzdk4lVoBtLg0ZuLzkLhxR631VHiMWBcM/6Q1TfL
	lwsbZlh0vXGTzT5DrawQFmoQdadoT2jVOIUjnxEbp68eEsUv52tSb14JKwkX/ejXvvDtWKlAdbK
	YILfsdy+xrzuzAHbx+P+t1bLFQTMMHL5uw4Rwumhinu9+0gfK8iLLzJCbdj1UNvObB6ooRaB0NZ
	2JBHCUgmoE9gLoS0oTXHNv+tRnt0St866uMhvTVU2jQ4yH3auN3lD1/o/mV1GytTlPB8rgRU+LT
	4RTup2ve+QfKHl7zqxdjiqteOb04tE8APx/wo2nVTizDlAFbUu0WXrU/0/0oIYUqk52nWM1j1V9
	B+FCjt+btWYJM3Xu3In3TdZHBIqw3bg833LEvPLYnYKABqo+gMGar8rffZsoMyEA+rN/b8amj+B
	aeMYJ4UBMvSErgJhpQ/d4oEHiHIrZzd0krd98=
X-Received: by 2002:a17:902:fda5:b0:2ca:20b1:3e0a with SMTP id d9443c01a7336-2d015c8fbcemr25029675ad.3.1785236294471;
        Tue, 28 Jul 2026 03:58:14 -0700 (PDT)
X-Received: by 2002:a17:902:fda5:b0:2ca:20b1:3e0a with SMTP id d9443c01a7336-2d015c8fbcemr25029415ad.3.1785236294063;
        Tue, 28 Jul 2026 03:58:14 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm42192544eec.10.2026.07.28.03.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:58:13 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/2] watchdog: qcom: Add POWERUNDER and extend bootstatus
 reporting on IPQ SoCs
Date: Tue, 28 Jul 2026 16:28:01 +0530
Message-Id: <20260728-qcom_wdt_powerunder-v1-0-de8d9e964e7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmLaGoC/yXMSw6CMBRG4a2QO7YJ7cCqWyGElPZXr4kt3vIwI
 ezdgsNvcM5KGcLIdKtWEsycOcUCfarIP118QHEoJlObc22NVR+f3t0Sxm5IC2SKAaKC7u1VX6C
 Nc1TKQXDn73Ft2r/z1L/gx31F2/YD5ROl2XcAAAA=
X-Change-ID: 20260727-qcom_wdt_powerunder-d1b7918e12aa
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: W5QEFf_OO2akTM9rSAclvmqAPEV5qzZj
X-Proofpoint-ORIG-GUID: W5QEFf_OO2akTM9rSAclvmqAPEV5qzZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5NiBTYWx0ZWRfX90rh9/1dcKyZ
 x0fCYDr9dnQN61tXHUAQ4h/5sdDdJKbVvY2xyg4wWq7M4Tjlwe/6PwGXyX69/cCv5CcRBCvi23D
 CddUFmysTU6te4V5OW4ObjOYkF9DkR7YhKutrR8SX1sTg0pEQjsZPDYl5d17JfACrdFYXkYEUw8
 3S0CYEkZsLZr2aAygJemjqOHlRp/ULpaBuCB235YknCiq0Fivqng6gGbBZIFJodI7qS/GWTyLLJ
 NQVlL+Isp7gSWYtpLixNVM4CMOZBNUw/VM7/lpCQbcAFyJODBIRQvd2pqo4rYPBEooHAMYeI4TM
 t5uNpQpaGlFMb37ixnfR8SNh64MnC7J/Pgg4Ve2kXSlIbiolMWrauSpBE5mezNtZT8X7gJoouYN
 Nwtxdo1TS8DwT1WhVJ34O8741w7i9VE8RjM62BPo0ZjCLG1vRyoYkwtQTOLkOXPZ/JPbP+RS0Ro
 56kilhGxZnNQ21v1q9g==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a688b47 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-yNzYYiF1uDR8yX7EwQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5NiBTYWx0ZWRfX5kKgRgD+x3lL
 z+K2F+LNB/joH2oeoNMltydmN94M2DraVw4ElafF7GVwQNAurztEhPxspoKNuoRp2JeGGzwQsi+
 QHm1bVPOtxZfpRRemizUbWMy0YvJ0Nc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280096

This series extends the Qualcomm watchdog driver to report POWERUNDER
reset events through the bootstatus interface, similar to the existing
CARDRESET reporting support on IPQ platforms.

In addition, the series expands bootstatus reporting support to IPQ9574
and IPQ5332. Since watchdog reset and powerunder reset indications use
SoC-specific values, introduce SoC-specific restart reason data and use
it to accurately identify and report the reset cause.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (2):
      watchdog: qcom: report WDIOF_POWERUNDER in bootstatus
      watchdog: qcom: report bootstatus on IPQ9574 and IPQ5332

 drivers/watchdog/qcom-wdt.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)
---
base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
change-id: 20260727-qcom_wdt_powerunder-d1b7918e12aa

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

