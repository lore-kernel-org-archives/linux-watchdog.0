Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4194E3258
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773347; cv=none; b=MKzyRgZcQ6eYLsLQAXjKqAoK4MPxm13MEdG+LkIet7Wy/hkdhg5KG3GYpbVmdpoLjEc6FFcJoft8Tj5SEM1VWZHyCjP31Wm9rP9xwdTg9p7uXosSiAiG96QczhAEj4sOdH9SlZP7nMdA2fFhgSi5rR7zcYdvLw2n+Txrf9GztK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773347; c=relaxed/simple;
	bh=1oLmRXw1aiff56t97MyiGav/WunYNGWzsBca3a4STBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8McFAgeHEPAvXU28Fi1XeBehc1P0PFcGWmbFxxUz/ycY00ZV7J7vMmg6W74IyBvyFYrNL6bm+yKy6KjZsk2V6QUiRdXKjOlL+R+d5+NlWvzon6tyKcj4XImQ7Yxo9tS66yqC/NXGqdgigbZr7SGW1kUcFsw5DycfFWN380xyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VQB/Xu+h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GMX4plLC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQB/Xu+h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GMX4plLC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB7NYS2019444
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 13:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XEbaopQ6+wW59DlyxlN8ULrKUgq+VC36bqIr6pLubcc=; b=VQB/Xu+hjhRbYze1
	7uWeE8uD8dtOSe13EUfXkCY5CHOs4ywen3CQXfAxLRyBNzYW3XMfgWVUcmjBA8qJ
	mJhNM7cy0bhAaZS9e47hvVQj66DVFrZyV5i+TSrlwAhRUV/0Qk03b8gFLDWBRPUM
	L6URpiute9puGt3lWnepdYv1J5KZh5ybVRTEEx/YMVhRZRaUqrL/t/cLcgnLEIbF
	QpSCnv6ektqhKfMDZyn/O/fLuq1t+/8WYgjnQDg+M7pEzX7Ex7AjLFrEJmsXKhY+
	VNs88j0waaf7/MhrfahZHFfzjkiVPHAge50cUmrrQ/rKYQ2foEprl6ouo4e61IAm
	jDZxog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x1c1eaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 13:02:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so8800230a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790773340; x=1791378140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEbaopQ6+wW59DlyxlN8ULrKUgq+VC36bqIr6pLubcc=;
        b=GMX4plLCTX2CApNf0PhAKpCkkqsAwpm8jycexTAw89Irv6MpvYcbhzEk0s1GQeNwXI
         Dx+/uIbj8Jz8JPKCkuIK492jr+9u8ABCJyUkPYeKFCW3XnBpEwwVN6hKnKyWXTigY6V2
         aNc0V5hztuDopip5KBgilTeZBvqWnjxxaQkUBIa1AaqRsqJO0OKkiE1KJVbmWF80lVJr
         dVzGmbecZSZGsL2rXNxpu6AAmsmkiRsh4mdjPXFwwiRFvvdW9g6cRj54jZkZD8CuS1Kk
         vbvIVjLVB95YQAQ/mD6D4mX+BYP6LUN3r4xuK6e+/Rl+J/X9gOvoECpbIjrMF5Ju3Bie
         /jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773340; x=1791378140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XEbaopQ6+wW59DlyxlN8ULrKUgq+VC36bqIr6pLubcc=;
        b=cLb754ufpmqNJrlzQe7iFPjaO/pVualdfAN2zjBfp413Ond7KU3+YN5NRpHVEFxrHG
         JIGXJCO/8sUTZVNE7VeEYcLaRU2dDFNuSactNbYzVqzaco4GoODnf62TVFBHlJEPTgDb
         JXg64xe3ITMbfFPNdd7zwK5bJcQuvMyMjCMzx4km5OYLIF2MAhhN+GAjUPKWSDnbEBP5
         ADdKYZgq4xqgNz1MeOBwkOjGj3ZuMuaXgUJ/UHH9y520/W8ZjX0AYTUyvOHo+TD2dKvB
         /nBisyF4H2bQp1R1ZRXiuLi9Mi9m58DNu0ZzhThU7LpxBYpNjCZj65jJI9QLdSdJuUfw
         SFuA==
X-Forwarded-Encrypted: i=1; AKwUvBxx1kCkatsg0k2egpSV5pOuZLJUjA+8YcMKCa+VHbK8cuLpk1HmzWh9K8XcJjbo0zLOFoaqCJlvRT/iBFpL5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKeHdFAthjBVx1rQAhvxX/eu4GU7opdHXlVIpBkNN4zeil77qBf
	z/c1XSIP0Tn87bE6MpD+4Jx4PPkKYGMo3qDAtAEiCQFjd8uhXTWYhkMHnhJ+FgHjCui+0CpBnia
	sbAZYw3h75I8odu5VRGV+WFM3VlIqytHq5Ssm08ApD/j/jPFzS8hKZNkllfauxKZZ9tNrYQ==
X-Gm-Gg: AYBFou02LjTogua44qHMiggRfhmK9zwQd9onYpaeR3eeA54TAPmZeVUWVnWw+7VsCIN
	yfmAdVp65ZVYSgCfdY2TbPUZ1V5NEpqGbix9A+NEuiZ9f5BBlvDJKuQw3+CIjmwMvdFEyoV+Pcu
	LtuxJ6n0V4KmHQvUnOsvj5pULX3IPWXEHBvTKdOmS7B6FmASjbhNLl8WywYOGVBqdbRem1nKSpo
	dOXUl4Kgl88Qjqh66l6mHVvO7KGWDUMbDUECY2trhQgcq3dTQjqCtY1KsgCEyxBW0BgEWQRwOVz
	/zv+FzkiRBo1M6zNnrRDBEaFE6IAYOS1nwtrI37guxj3KBoX/B6/jSUon9zTReKtp8a0sExEj8x
	w42aGjMrzT9/SoUY=
X-Received: by 2002:a17:90b:5848:b0:3a0:4066:d3b0 with SMTP id 98e67ed59e1d1-3a4d1913a7amr1186251a91.59.1790773339889;
        Wed, 30 Sep 2026 06:02:19 -0700 (PDT)
X-Received: by 2002:a17:90b:5848:b0:3a0:4066:d3b0 with SMTP id 98e67ed59e1d1-3a4d1913a7amr1186211a91.59.1790773339389;
        Wed, 30 Sep 2026 06:02:19 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cdf25c6csm3426058a91.5.2026.09.30.06.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:02:18 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:32:05 +0530
Subject: [PATCH v2 1/2] dt-bindings: watchdog: qcom-wdt: Document SM8750
 watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-sm8750-watchdog-v2-1-b16fcda275d2@oss.qualcomm.com>
References: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
In-Reply-To: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790773328; l=908;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=1oLmRXw1aiff56t97MyiGav/WunYNGWzsBca3a4STBA=;
 b=qvZIWrmd6WOFbbn5yUQ7Okm7jBt5IvJQmfCDnDf77OvcRdlaFzEt+T7VxBRYDOFEt0SIwU47c
 ZBjZVyzcGW7DE7SFM8AQIxWXhz7r5v4l4J1bQGgmVoVB/n7kqROf/54
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfX+/vuC3dzzVYe
 PV63Ng0AzHaIA8boctSOodCvDil13KaKvyA9BPjhcxuxNOJYKoUGZNA0YZQcSZqCS+jUzi74m1F
 9o5apU4h1wTWaGJl6obCTnm7xADKiyg=
X-Proofpoint-ORIG-GUID: zA3W8k9EC-gJ4zDsJEmmP-YOGVU6xafu
X-Authority-Analysis: v=2.4 cv=VrC2kO2n c=1 sm=1 tr=0 ts=6abd085c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=-pL1Pet8fDdhfHljwFMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: zA3W8k9EC-gJ4zDsJEmmP-YOGVU6xafu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfX8effb60iO5qf
 NoJkq2JbBGleHDsgWTH5C3FIzFsXrnZcIJGZqozR6jLvs0Rd32U5x164IscjgSO79mZeIQH4C8A
 BDQFyPbOEZU8Zjs4un2FN7SY8mgs9cTahxt5EV6+MpBhaVwokXZd9gxmfPhZjQn+1D2rm7lJOVn
 iwiqDVxD5IQ/eJPpWZM5EW7sdmmmhXX2c/MVM+dhIlEozwjqJ59VmUgdHcGTzeuui/Z7W+cbrd7
 oIonpufNmu5/xmf71s1vnsQ2IWytXhzdu7awU4sbDCLSz7WRPG3hxD3Fmcm/xfck4e78lS0PZH3
 C81vWXnX17qQPsIEhKQQsiyzYIGFh6HE4CfI/GLJ//JWgJ+XHAhwLPHGJhLPcg1Wxz8jRffA1/G
 3xBunHLD3tqM7+8G+IORvwEMhJYnJL+QcnICFYkee2XQPS52/S+y5ZjM93etABZXoVFycqKGHic
 gxO6V9jKm1p8oqMQGHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300051

Add the SM8750 compatible string to Qualcomm watchdog binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 4ff61102e407..8cd8331608ba 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -50,6 +50,7 @@ properties:
               - qcom,apss-wdt-sm6350
               - qcom,apss-wdt-sm8150
               - qcom,apss-wdt-sm8250
+              - qcom,apss-wdt-sm8750
               - qcom,apss-wdt-x1e80100
           - const: qcom,kpss-wdt
       - const: qcom,kpss-wdt

-- 
2.34.1

