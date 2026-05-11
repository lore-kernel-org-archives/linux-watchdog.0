Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAF370D52
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510436; cv=none; b=bpUxqoifTiWJJo6G8CqdEqK88NGXtdPDykwdoZxzAJ7Qz1N39wPdIknTL+nDuZspSFYf7FBtUmMeTmXFUyn8xzPZzetbMdZ2aeH7h6P9fyWzuNaxqvKlReDRguLh4z6g76vtfSy5qV3bY4uClyfgdLExuvgrOlBk6dHwZz/Gs0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510436; c=relaxed/simple;
	bh=JFB7JC2tVqIvLepWGTYj7+r8PPtD5vD/Hp89OUL7d8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V07yzhnc8dVVgyqWn9uTnMRmLa/bKy5OjNRTR3EU4DH/H0SRuEYqxiNNgCvV56qZ65lFmmxk0cPtusHM4z69QR+alHzm/O8F8gdjCxOMl2UmlhYyoaKp6g5AtbnHJ7Kg45/m1yQ5E3nrDf7cA/cinKsgAnMSH7nNqQcTNXapzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b520J/ms; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cHsZ8EYU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b520J/ms";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cHsZ8EYU"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BBpHv33163614
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CKH4pqHO7nbXG8yzTHWH0x
	Bt1rF/NDK+c6CZIGwQrUw=; b=b520J/msy5qlRglrR8tKuJZ3BkOhRkysrDU5of
	YGFVtPKWYR2VfE7DIEMwqWKxiUwa4ygvESuPEXb/Q45ou/zYR/s/DuaH+pp994oi
	sX47APYor2ynffTcgWN+O/60CoyT5i4Uq/Ai3mqb8BgokgZQK5Bp07wqIGeWv/3v
	Peu01wmcEVHuNu1tyuDg39c2RCUH0sf5z1JRJfrHlU+zQ0GB87U0eU3gzJBcaqKm
	kyBA/p2YfKCYSiih/hmrw83YHDszh6QiCNTfnD6tlzwUmUKZWUrIB3+HQIdOKPCV
	OSTa7JyJDzSQhnqVbj7fNgH6yzMqxsvSj6MAbCh6R/oX7jUQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e2dksmrjs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:40:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2babbeff9e4so51688085ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778510434; x=1779115234; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKH4pqHO7nbXG8yzTHWH0xBt1rF/NDK+c6CZIGwQrUw=;
        b=cHsZ8EYUsPu2rXAaHoFDDmBECaXv1V+n9M3SXQfzO5HNSP3G6PKsRarvE/FdGufcY+
         U2U3W4lhrKOZSiuwbEgZydFsrJ1I8GB15aPfVPwkAN+m2gmk8iygKr4b/IpfY0eGvCbW
         OqojgU7ISU4zY5oK0kF5O5hm1g2t9pxS6WvDqMC5nODuOX3G9aJP16WVW2ttDX7k53BH
         FXWIWdT3GKz7AxYQgJTifTQXTR/tCdXC7c2Apzzq3z0qldo13FODr3byaMEY8JQyPTD5
         A088Vo87xAat90MyTw9+Un40/YVPYLc2rHVXUYIeqaBO3FuyearDYs4I8MvN4GCuf2Ky
         0Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510434; x=1779115234;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKH4pqHO7nbXG8yzTHWH0xBt1rF/NDK+c6CZIGwQrUw=;
        b=cwv6y8rhdlYJPqFs+Ombd47X/6hBfViIKooZUx6+beH5x2AxBPtTRCRIbgNWzx3YhK
         KD1xCo0Y7lBWeex/Of+/JfE3ORD/4TQ/snk38BbGT8/p46zfK5m9fUT5DbRojB0nuRTd
         pjf51n92WHL0L+Shn6/KB8BCBBUfuBOYKzU/HXq1GB/CIT/rsuRJvfiQJi9z6sed9/7V
         0dwHxAvE0v7ChmMnOUqUyhvQ9Vqo2FduL4kzNNy9Le2JjnuCdJRATwOFPK8GFprjjxjx
         ua5RIZygig+vu9RmsOdwuQ7Hg/QEoPCdwmvGLqusSUN6j1ioBvZE/dFcBrtn94OnyaO3
         96Yw==
X-Forwarded-Encrypted: i=1; AFNElJ97ml01vbSJPyLFnVKFJhhXJsKR4DddBsK3O/Ep5oFGgj5gQSRurxUlDSmSVBDaXS3se1qInnssEaqR8NBCfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySdSk6iKzJfVzxhaqpJll3XCNN/bLjvKsEcgauVlQsIFtexu7j
	5jARCAgeRfT3V8JqcYg8G8fCpb7fpJTtD2PanEflLKqMT+1zjGe6fQJyyYYaZ1wzsnQj2xW+3xW
	a9vx9ejoo3X7KnxbfgvDrGR/Z5tpeY25bgwxNxVFAEWo0dlu3kq/M+RcKm9wvwM0ASeJUCA==
X-Gm-Gg: Acq92OGFpB2piIQN3msv1z2qIGCaZnW1HHcGO50E4+n9pmkAxspssHaQZxQDhR6SisQ
	Lx6ERmvSGJye9UGYGxTgvEpCoBl9HfoFCV7FEInEKuLm7swJx8sxmU4fHt3dk8lbojfa9k4V1n7
	SfB7r80BbKhqxXyHMvDSQKl3I+k7yz4rimJK8smCRaQnHtekuerbiS4JqJgzF01H6nCK+9b1fzh
	Q6b9hTPOdb5/U7nVlvTG/FJOwayvLghIxaTUyV1w9sK38aMDeux0i1nAmJ24Z+YbwbmSLlQAuGp
	+AlLe5RVU0SVDVIuaaQLavmVWUaFKhGtJ5U6eonLPFQ46/bfhYnX5YcUDpZQd15gqdCrz1qhmOI
	okdAJXJqV/RMBg0MDAubOHJ0HGHUbGQQ8PEk0o+2f8RprmAhOpXhYpiijZu8GiBVkYt50V0qz7m
	jsgjivIyvylMPkNCAZ0mBeD4tpFwJFp3CkfeybqCiGxvcEtthahPaY6u59
X-Received: by 2002:a17:902:8492:b0:2b4:68c9:302a with SMTP id d9443c01a7336-2babd4a48dcmr116656185ad.17.1778510433692;
        Mon, 11 May 2026 07:40:33 -0700 (PDT)
X-Received: by 2002:a17:902:8492:b0:2b4:68c9:302a with SMTP id d9443c01a7336-2babd4a48dcmr116655865ad.17.1778510433189;
        Mon, 11 May 2026 07:40:33 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35eb3sm107928495ad.41.2026.05.11.07.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:40:32 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 11 May 2026 20:10:23 +0530
Subject: [PATCH v2] dt-bindings: watchdog: qcom-wdt: Document IPQ9650
 watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-ipq9650_wdt_binding-v2-1-dca22892d3d3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFbqAWoC/32NTQqDMBhEryJZN5IETGpXvYeImD/9Sk00Udsi3
 r3R7rsZeDAzb0PRBDAR3bINBbNCBO8SsEuGVN+6zmDQiREjjJOCUgzjVPKCNC89NxKcBtdhwm3
 JJddXYhVKyzEYC+/ztap/HBf5MGo+ro5GD3H24XNqV3r0/htWiinWTIjSiIJLK+4+xnxa2qfyw
 5CnQPW+71+42xQHzwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778510428; l=1233;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=JFB7JC2tVqIvLepWGTYj7+r8PPtD5vD/Hp89OUL7d8U=;
 b=hht1YkGSLtojsMv/3xTmaizOwbThS8DBBSya0UxtUX1XaR5ZMyREBH1czdCueHIa+OG5heENy
 d19L9M0eSfPCZUZcw3g5Yp5XXjrqzKEibLBrQDZxIRfQoV5ok+tKfsr
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2MiBTYWx0ZWRfX6uiIGgrQczh/
 G0RHaUvjocws4KD08so5iECe7bAbUxGjj5uuPvrVKZc3hVBOEbTjG4A5epqFQlhM6TAeY6Jo1d4
 Ev+PlhCC8vJQs7OvboRvvV3r1mHQGFl9tsvp0TI+TN0cEWEtdnLXTliyoH4GH4dygRVfwZ0ysJ0
 UzoqDxOJIUoIbvXMmE6GXiJlw1qoPx2Legxcoy+8mJlvi/A3lRvHqyBGZLAr4rHI9o2w1AazbgM
 U99XtvoziFBZjcbHG48FuD4QYzatNxzFj6uGgdTjVa3tAUPmFnGa7lwAYRSlJSYfI85c0+QqqMj
 bS/ngE33rvQZYQ4SgqTDqIEI0y5jnYs/EM9WFHxu4Mz8td6PzH78alwD3KpkJSIWKANDunUWZ7t
 G43lKdwR2AZscrtz6dGqXJXNpuFPzj2TIcV/YRsZ36ThFGGgY/p0/kFErAFPBHsPtLZ5hj3Ex8g
 DQ1+jopbl4IX1FbjAig==
X-Proofpoint-ORIG-GUID: yY42munXs1lxJh_1Ca5L8wk02AtEcP8Q
X-Proofpoint-GUID: yY42munXs1lxJh_1Ca5L8wk02AtEcP8Q
X-Authority-Analysis: v=2.4 cv=cKjQdFeN c=1 sm=1 tr=0 ts=6a01ea62 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=w4RUFeMe5Se8zSgF3B8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110162

Document the watchdog device found on the Qualcomm IPQ9650 SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- Fixed the commit message title
- Link to v1: https://patch.msgid.link/20260511-ipq9650_wdt_binding-v1-1-d2779e756bf7@oss.qualcomm.com
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

