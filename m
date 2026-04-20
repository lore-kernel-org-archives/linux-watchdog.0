Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED639935D
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Apr 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685802; cv=none; b=bbl4Lhs5PN5Nd1SMv+Viy4BaIBAaO+a6Vh3vDTo9mjCFLkBkLN2qtbahY+4ad/j2ezzVvqH0xLoZUePdNiWrELx3YYSpFd9Hq5qIavWEF39qybwMxcBRhskJMpVsPvSdNCt/ztAvMWxIHo9S6iNxqEjM7ntPvB8XYGkHfTF5G+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685802; c=relaxed/simple;
	bh=BhtVsvHqwipunR1cVFQzCSny4nImw5wDkPa6vKIEfXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9023Zwg1RaM6tbANYv9qho5uyJvr666kFTNv2kihS4EAy/RVgKHTZ7DOaLzExUtU330o9bqzYEBKAI3fkEBFiw5cQYh/U+3DRk6+as2R5TFQLR/wfnkaC36ac8aNpL3N2bhl+G2k2Ndkwk6KAnCDfMzpwXDTxvCcVnWLFJgHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VTpHXisL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NmLGfzOl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTpHXisL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NmLGfzOl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97AUA2755646
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Apr 2026 11:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gwv9Rp6MAzjqv4y3DbSzkzWs0vosbCAkTdd
	M1lHun2Y=; b=VTpHXisL8QBqQqas4ixUxRwIWPzD2Pm2lYcykie/p1fwScQqIMb
	ugVBfJ83W0j1T0x+hZTioSdb1p6naTMP9Z5PUPcj9L7Kzfc7UOGP5pq4U/15po5Q
	bWmCnDrC3ZlwK/xV4zIzSIx0SgVzNc0GulbAm/ct0bQpbkuP5rVBXKVvp2slmL0j
	zaUBlWZwQWFYK2Bml3Tc2fhDye7HkmLG9ztu3DiWmi+3KVZc/fztglJJDXS/9PUQ
	wJG/pLLVMG5+0WU+cG117OuqR/TdMrW1vvkCII0fWBgSOCSUV2zob4LsSozwfKq7
	Z5zWGEG8E8J/IxG5iEsd1Uz5WaB6uYgz0Ew==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh7xghq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Apr 2026 11:50:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d93379001eso2103152eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Apr 2026 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776685800; x=1777290600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwv9Rp6MAzjqv4y3DbSzkzWs0vosbCAkTddM1lHun2Y=;
        b=NmLGfzOljWPWoMdIrEfWBMQ0ovxVyDDgg9o3ov9BaHhDikYb/HO4AKCyaTlfsFmB2T
         FX25Tv6O+VtglPWSdPP/ZgsahTHWIEnOuEhENzv91/kB2leE0VEyaPgd1dcDe1/nmb4L
         dLwBeJEYOan6HWnmVDjJKDtzwGcOZh4i1NTLMXvABtXuKtJmNFoKfeO2FPsEzQ0PN9XA
         631R6A9bbl9ORqvDuXPCL0XA1OdEewt/JasUdRXG1A+yUrAHeVy1m+mOas3lPgDsDXeH
         V8LCtnpTr/vVmhGVWnyNF+prJSLrE8oxHILtNi91RCCQPxvwoiikNvIz4KnHakBd8a6u
         X5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685800; x=1777290600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwv9Rp6MAzjqv4y3DbSzkzWs0vosbCAkTddM1lHun2Y=;
        b=qcliQgZmJybUjsSKR0wAoatc0cNxawsiRwPwJraL0Rs0221Tp+5PfRmeblRlRy20yM
         BD5bvgeCJI+ojeFdzCMgX1vHxcie0T/wpJSvtj8SqJrL/fih2zweYn/+5S2XX9iatYz5
         9bde5BcrYhGyNaL1+8ZFfInyEw7/0VcJw7r5ME+FmD6nZ+VQrDGLjiLUN5/hkgaSciEb
         wCaioPaBbCj7+7eP8zJP8dnh0HdLgb+rBMe12PE5x2puljGfCawUuVxjuuO15INNilph
         5r/AXQ1ISIeriUrxG1SG9kch9/UBAi8Rshcq7h2COOtBZClzAeqPtG65cL3gYy0cuBy1
         H1vw==
X-Forwarded-Encrypted: i=1; AFNElJ8bq5foLsg/P2gZ4WC7LzHldBKcri0k8zb4LR5Yg81QhNNWHHZBHFgHxSJjZI76rdi7q49nuJj+GO0K+emRgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTfe3G/fZNJ/5mxkYUphDyaR2YOoesFbwM+rAV8W380h/MyV2
	YdwoCxHJz1Od5d0jYK/z+7EI+CxkBEZ7qV8r6njMQXy6T2k2S0M2udfVHv1KxIxoaYNxDLCP5nW
	cAxFzJLCihU+grpKWNjczrQNHruaKl3VY5pspj2WBMhZ48YfMoVwJDTaQ8lQPOW/BsJO/qg==
X-Gm-Gg: AeBDies72VmnJIJQpmlExADfxyDC2h45Xg3dWZ5ooz65Qiq/j6DfpmBqLlN5nmw209u
	XBVqq5yMSyT/XP2a/95+GG+5iSQFresnuPPGiFdZM6OR9Ww6YH0EE5EazJQS0wohbtoIHApFNW7
	yv4mUTkwyBIKYSrfIPSJ2Kohaup6xb1RkRcCp31vJpzIB/IK/4SqUsPmsi1xYi9PwW8mF2tKFob
	KhhXhbRQli5sZb7Z4qKTC5arkpcnon6ipecDuw+G2GmR8cJsIQJcRyKK7lWjjTJCqGUUKB96lfn
	MASzaILiqGy9V4/ErNPb+36YBrz/hByngBqDYSvU9I/11rBLAS6maiYibtqcwJAmKToGnCeyXbi
	ZpvihpGKJD1rG67eUOkMRIakXabHBsedvOhJlodt1SKh0R02xpJKd5LUEroMiTgl6DEDSjie/hA
	tNMVgk45AuLHCPXaHl
X-Received: by 2002:a05:7301:578e:b0:2d9:6373:ad1d with SMTP id 5a478bee46e88-2e478c1f833mr7108116eec.20.1776685799833;
        Mon, 20 Apr 2026 04:49:59 -0700 (PDT)
X-Received: by 2002:a05:7301:578e:b0:2d9:6373:ad1d with SMTP id 5a478bee46e88-2e478c1f833mr7108095eec.20.1776685799305;
        Mon, 20 Apr 2026 04:49:59 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm13683810eec.2.2026.04.20.04.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:49:58 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: watchdog: qcom-wdt: Add compatible for Nord watchdog
Date: Mon, 20 Apr 2026 19:49:50 +0800
Message-ID: <20260420114950.1253792-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfX4MHCM3kjHOsF
 5m7q9K4s4N5GNY1IivLZCf3aosin12fvZjIKBDMBB8tceltHMMM6Mq3KYbXK5ocM3hZXJ/pIJSU
 GNjkQkekNNUHu/FLpwT097GMMHiBr4m0upSieSJRPZlM7j6Ms73Dg1EWYPUbcdRzz7tLJuIzQS9
 bWoK+HwR1NgFKSFzP27YNJeQIaX7d8opM40jZ5rqZcJLZbIDju/sbYMzPlIaGvXNXZMrOc+Spp4
 hdVOx9d7PDL4PdraeEtS2bOCeHdddUtW8CozQpp5VuUY5KJtDrA62FauMqY/6yYcY7DpCzfPTJ3
 w4XSPv1/PzvCd8GcAg1BObPR5umnUEYTFKTUUVd0aEzXkYaXjElU7fw2gey8iSrfkVpyaNgKKEu
 TDgBl2H0lmWIeMpJ5xLitgeisjlMH/t/1WtHq3VcjZNn0hR8DmevMSc+IGscEB5j1lqshNTg5VM
 T3R/pvA8YiMuxMAHJrg==
X-Authority-Analysis: v=2.4 cv=BPmDalQG c=1 sm=1 tr=0 ts=69e612e8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=r--zF035SsPxjZAzwykA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: QQ1We_MxSuWMh-A7PuCq--jE5qPphN0F
X-Proofpoint-GUID: QQ1We_MxSuWMh-A7PuCq--jE5qPphN0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200115

From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>

Add compatible for watchdog present on Qualcomm Nord SoC with a fallback
on qcom,kpss-wdt based on the compatibility.

Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 9f861045b71e..f2e6091902b1 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -27,6 +27,7 @@ properties:
               - qcom,apss-wdt-msm8226
               - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994
+              - qcom,apss-wdt-nord
               - qcom,apss-wdt-qcm2290
               - qcom,apss-wdt-qcs404
               - qcom,apss-wdt-qcs615
-- 
2.43.0

