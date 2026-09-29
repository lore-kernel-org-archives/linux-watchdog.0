Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583E513573
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677917; cv=none; b=CaIEk0vOTips3QQFt5jGEJ1LuVn7FR8pek64LDKedAHv0Pxruv2xkVVwgZXW6fWqXNccR6CyFFF/jfqHyWTGivMpUNEUop/tZV95TMhMtwhSwCB/yhd6Yhq7hKwHI5k6BCo+q71ovMF6UM9f4n5uDCyOi4BeBVfSpINYn/8xRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677917; c=relaxed/simple;
	bh=BrnO3ltS6NV4yLZtRHYLLWfpk7ArO8G+eEJqckc1+jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbCV97PiyBklkT7k3Pm2y7my7UKO8JbyCJouAjg84TZ4KAi/Thkpx9xevq8hpUZGHEaPNbW5mokncGhdqzHi7oaQ/oHTDg6cIvbR4Mm+HJvtQvKBe2yHgJeKvLWl9+W96V6/G/wbBS/1+c0OJeMmms86MzKX9foVenm9+30VvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3i2SMJs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BJo+zuVD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3i2SMJs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BJo+zuVD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T9lY4C3437065
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y5QaZCWfUf8xqRpLFDNwu8eJzJAbsRzrLuo3gbashtw=; b=U3i2SMJsAl7uJ+W+
	pt7ZhXzXjgbPcQSMJqBB1E9OZWeoQj91SLYBR915h50+cG8yzg9oXdE37OBdZmjS
	r/saB70hsbGJBO8Ad9+8m3tiVAlZpz6ELXQNzWVxkq0VMGtNu252Wz5CKpMqS15G
	uY0LTFe5v0zU2Hm08ifhKjbhrMvwACaJVnXz2ux48t0dG+Btdn/E8ytRO8l0/2+6
	Q5xy+LQuW1flJ6Nag3V/3zvADn0zwWEL47BintFK6FW4C5uwXTNLlyIwtlttJChU
	M5whmfI83Ogvfmn7nK2UQzjzv3G2iGxu4e96BiUYJuUfXuD2cVONb4pojrhThs69
	KFF5cQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0v85r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:31:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so3839932a91.1
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790677893; x=1791282693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5QaZCWfUf8xqRpLFDNwu8eJzJAbsRzrLuo3gbashtw=;
        b=BJo+zuVD6frneqN98in1ktjZzyt5Px/yng+gdPx6s5d3fF6fa9LC4XETdgozf2mM0B
         qhEIa7sfswCLzIF2/rtfSpnWtJumYOt3AWBXwgUVHuMRnMi0TcDpdhGAP5Y3IuQE7ai+
         mhfPG5h4XeCM+DVbBl9OqIZdahpht9bqoViPMP/cbYuw2qj3EMmr4jnxJYhC0UzYSDTs
         7JVAizMIJo9soLvg01+G8xZNFqRD+9fEvZlx6yaGjoy+RnGIcFISB1sP+eyLYhuIqMtf
         iHmZH1akclxUzsPOGkV3zjv9wgWO1dtbcJ/oSQoCf7bQONAO3XA9fE3l4tuFQaaXLLFC
         OkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677893; x=1791282693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5QaZCWfUf8xqRpLFDNwu8eJzJAbsRzrLuo3gbashtw=;
        b=Z34Pov8436NnB2l8qYKlp2+iFARqlokR4pye6KurusiTVwZP+1HVL1yQdHruh5mUh5
         vhe/Mq7IrSuIqvAO56PxMc0JGALWmNm2H36RvA5r7/XxhA3QycN1ofFMHm3Mrqd8U+e5
         59FKFak0f0WGzCaWu5+TwMxoXlgZNjyVuHTuh5pCJPtsqwX/V7pwZFCJfx9S+rFKW8rd
         h4tj7jT7RH1wJFFwjU6uqyFL0B2fGGLEnH1yUKzDcF+uMTcYGKfYKqZFfXCJ5c40XNd2
         e66Qkf14BwUvr8zgMDPUoxLkn9w3pA/ReigNL2Eom+NowjeYON4ZXkFzePjMbtuDZMBH
         vEOg==
X-Forwarded-Encrypted: i=1; AKwUvBzGxpEt+uQuDtnGi4nA3NgAO4jGXy9H6PSuIJFS7jgyQR65nakIfq39ajcfIt9pke6BhBC1rPJBI32hMTfTpA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLoFTyB+dLZoyfeGzFWCOxv5eYTWjeSw5CLrFENWhRkLb2M06Se
	68Qrxz6szf0uouHp3GnUT4x9Uo1UeXbx2ZpJF0kt6my4nDfBItt1x/bkDpUYGCtIZQBpTstLvcG
	AkqOqy9lA9XvLLp5MHvZe7Hb7ZRs8GJRzoYCDL/AP02J7xXJQW4NywHznrqd8hBzbZrqWRw==
X-Gm-Gg: AYBFou3YxZALfrcLoI8c0NWoiPDygWeY6RUjOMXHEg3zQGZIiudAkOhrZvjX8pWUoST
	GaD00Vic+JWCU2MwdPCsB6+86XbYnsKV3tjA8T8Nfo0hk4qU5EKZUuRsNUofnRDmIfLJtttZXmr
	mrKNSxzfWlKGns0OCU4BZiouLnbrPUiiXGglB9+z9PJlgze108cdZoZhGp+4orQkNY15m5EfDYH
	DGlvgQcQjlOUc1QpMo2Ji9QsDW1a849ymQA9m7t2IGp1gDl0+yNrFG+OYOSWPi+alDNN/M1ss76
	t0mzRoFJSzqTAO6uSsJn9ieO3zNHBrHng+8JLD78LeO8wvFjThgoMs085R4JNDnb8y4SLOKqVKf
	5imlYc8s4dofgpg==
X-Received: by 2002:a17:90b:55cb:b0:3a2:a185:aad6 with SMTP id 98e67ed59e1d1-3a2a185b31bmr5704065a91.23.1790677892903;
        Tue, 29 Sep 2026 03:31:32 -0700 (PDT)
X-Received: by 2002:a17:90b:55cb:b0:3a2:a185:aad6 with SMTP id 98e67ed59e1d1-3a2a185b31bmr5704022a91.23.1790677892407;
        Tue, 29 Sep 2026 03:31:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492dfc5absm2470791a91.3.2026.09.29.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:31:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 16:01:21 +0530
Subject: [PATCH 1/2] dt-bindings: watchdog: qcom-wdt: Document SM8750
 watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-sm8750-watchdog-v1-1-ea06d5dc7e54@oss.qualcomm.com>
References: <20260929-sm8750-watchdog-v1-0-ea06d5dc7e54@oss.qualcomm.com>
In-Reply-To: <20260929-sm8750-watchdog-v1-0-ea06d5dc7e54@oss.qualcomm.com>
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
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790677883; l=838;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=BrnO3ltS6NV4yLZtRHYLLWfpk7ArO8G+eEJqckc1+jo=;
 b=QPEuGA8zylMoc499k6xXt9YD+6EwzvyphC/Sf5Zqh+M+hgR/vVrhTgYHlFi7Tkq+nUdFnFBAx
 TlhsUca1snSA1XIAusr3vWNDMV+hZHkGBaISw8m+Jo1Ic6EFN7PIaaF
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: ncVxK9RohXkKvr_TM8aTbmGSqjwT24xc
X-Proofpoint-GUID: ncVxK9RohXkKvr_TM8aTbmGSqjwT24xc
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abb9386 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-pL1Pet8fDdhfHljwFMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0MSBTYWx0ZWRfX/0JsSC0ydxvU
 M5SAVGowrHLERt955Pi+YTO+coz5EJPcw7VugzPHzjeG2ooc8YhIK0QAmrC88VxDSYuZig+eiIa
 qn9ev0y8QxxqJtOuYLr0bw8WLMMc+3DKdruvHochFbqtO97sqxHWGnE4FMO8GA+TMTtGDmkYceY
 /Kjcz49p61gb0hmw5UObtMMTV9vmfyolm4pBsIpMfBY/QwaKvALus/t7mdS3YOs9kQ4rV+K+6iY
 WvPDD11CfHFG6wI9fgl7PIUQ6nOAcwViUf0vVXhh91YNW5A0WUrD1d7JtuYnsqR7hkg0hmlrx9k
 U6vlsXaavOd83cQJMBXK5+tnXUfP0cZan3XcXYK4FyL2XqfIEY8wZv7IcoGWrP+w1wFvhq1f3d6
 heljndIJNRJwss9UYrgvdkShloKiVizYPEOkzadjIzfvg7AP5sdtJz2X0LvncUwFpu82vxfOAjn
 C5aTzq/nKspsAxK7ryg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0MSBTYWx0ZWRfX9ldeMNsH7BU6
 3DXVDfvj2G6y0RRBXyagOmpBBV9FZmYBKLsI7lc8A4tzPLrJYZiW02aHFE36uRpg5F+WL2WJ9gZ
 iVu7+AH0Hx89HpkQcbXuSDC+IBqxgwQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290041

Add the SM8750 compatible string to Qualcomm watchdog binding.

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

