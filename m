Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56A313532
	for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691014; cv=none; b=CHwcMeQuOym3Hc+z1ICSep5s7CkzcbcXF1+DvQEai+658e8SasPYfoWrDn3Xp/xlkJ1ll67vNzSCDWn9NecFeN+0k7WZxpEeQLecN+UnKps8QdNydZqV4MiYI+/7giFYYAeEFYTLd2LyaXitmMB+Yv1wOMIKspwnJmYWZ6nnE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691014; c=relaxed/simple;
	bh=DVo2xi7RyBHNKdZAZ8GSGGWIbM7R2VtURBEfwF6e5DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mDy7qEImqzSnOB+w2YmG2hoXTwom0rMTnax4BBcuT5Vc9OIiqx7vO+tKmgrFa5xwuXs5Q6ZPrAouOnDqJxecAPIaRrPnjA0J6B36RHZWH+esFbdcZ0PjkowovaVE3wUZi9bczY+ekBRWD7NfrMay4Y4s9xhus5hZ9k+V4Jl5xfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mGczDeV1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IaTXbkc2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mGczDeV1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IaTXbkc2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P5URHT335207
	for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 06:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NOkeK1lAOdXCk7zOceGzmI
	a2wijOY9THVdbXy2AekNo=; b=mGczDeV15w8SQuG4qOOrciZtGIfJM1SUUI9CYn
	10Y+B8IDUPq8MhUyU+WAETrNSGIF77CY+waXxubH4vMvS/0yu0oUYEb96vbG51pg
	RUparnSoSlch9OaQafb22n6JPWfPqims8SiqeW8yaFwM/9wByXd33vZ7o8ZR93y8
	VGk9Aw53lfUjfL3ZOk280CvzQuJh9CsI78PcwCG4QjY0MbWUz8WlhE4yisnYaIWD
	T5Yns3sMXiIRiOCpeLpO/QWfnwElqJ8PVRJjgMNo75rRnRVTwaeJAjDmc1XN+Sgr
	D/jjmm81UIJRAaFOHPz04Ptg6qm6uurB8TRu+8aCamyks5Hw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w4u3a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2026 06:36:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so738064eec.1
        for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779691012; x=1780295812; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOkeK1lAOdXCk7zOceGzmIa2wijOY9THVdbXy2AekNo=;
        b=IaTXbkc25AEF2uPh2d6OID9ENv0Um5jRVd+iKBdl4eJmfeQLWmzUlSUoMEWmwAfm8n
         JGgKftPxi0eyw5HK72eHEVgfjJn/wcsTLJrjLalgAYYscM8lFQdjXtozdQkWRfErB04E
         7fZxkgJnJ3qiz/036shvoziOTKeO13LQj9o0uUl7MgXFyXNGE7hH0ufzpxHC1ysC+UTM
         RWEawmZ0jNdzrrO3DNdCSAfhXLMoEPqyf+b1U3T+uC6EcvijcpSxfNaGBagf3AC4BLMH
         /f6PuWK7swVaikMDm0Xpo//GUr0rrWK0uXz78AI65L7bi6Ps7dBqiG1FgEHxdTSx0diK
         V4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691012; x=1780295812;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOkeK1lAOdXCk7zOceGzmIa2wijOY9THVdbXy2AekNo=;
        b=Loy7++LsugATs6iajUQNLF1aq/Sp+O33bJN5jygyQwoyk7B82MkOOH5o9Uf6rDOkPL
         98HpbPc/gYXhis25Kxo9y1keevsl9Ax4k7w7AmZ7CfRgJvdIn8jKUtUdr1OjDzIyY7jX
         ImfQJE7SKMPhBsHw/xB3s+32BmWonZrV24a9CQr5f0qAEo3zQ1Fe5eSmRiiQ/vFFE5re
         mq7uJnuhKPW4ZAFZOAYbm9s/XKHbhPys0epUIZmjnMvkCJYx5Qy8wp48Kf/Qla00JY9L
         5ZGIgny0jD1Vitk8Z+BameefdJRiI0IV1dLToKVuox2WhCim40f70JJs41tHVxY1nkyA
         8Brw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZzJC7IVkugkjUDNOVZP83EurziytfaGJ36ZlA3rR6TndO0MI35dpbkdgn09PXsHtOOLTV/uPXXDS26bx1VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOJ+F98SV5cJ+7PTUx/ob7iW8vK1RzCNF4OubCs0UkuFNKUQ1
	1yCCNdXtioNGwADc0+L6Suxv63SgoGiK/HprKyaazOcLOVerIVf43UWzZojENguJIoAJv9jb6IV
	lTGYe4XsOhA0BxBDZ+yTEmwJEWHCJAATZy/m/u8JkMu06BwyCivR1HSOayKcC3o9GAqs+Yw==
X-Gm-Gg: Acq92OFEzhN7Y054RzjZQb8yJWFwOZnBMzbXTzzzjrN1QjfcQs4nXkxiFXXmcP8fnYu
	Mr4wr3uKEi8xswKsXRa0HPUyakXBsqjT1C9euWrseTDHyL+nYd0fZUfPvXIqmKiR05y1vgWiRXy
	+BSL8zdgtWTjBMTxqP0XUxvImoV2+kKj8mk3XS7RcEBxDj22d8Axw9FIszZj6LiEmkoEn5QFHY3
	+nVMG+GoAo8tvnFDuaDcCBfDik14MPdEAQfITLiGs8UWDYAXczMwwlpvKmCf09mr3Vyt45pFUKd
	j6KkyA55t1lAKYw5/+F0nJrv3CWOXiYXDE+9ibLZlMdjlWRbboDwB6CKJ9wMNE0KTwSVVhKjCYs
	nB/wrRC3dYVBMaFKMKFLoABr6ZCyBrJFrTVCwkWBzO1voG7XtIwkSNoEMOJFupJD/kfs3f9fg
X-Received: by 2002:a05:7300:4305:b0:2ef:1d11:18ae with SMTP id 5a478bee46e88-3044912c25amr6303194eec.28.1779691011576;
        Sun, 24 May 2026 23:36:51 -0700 (PDT)
X-Received: by 2002:a05:7300:4305:b0:2ef:1d11:18ae with SMTP id 5a478bee46e88-3044912c25amr6303171eec.28.1779691011032;
        Sun, 24 May 2026 23:36:51 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452255234sm8860713eec.20.2026.05.24.23.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 23:36:50 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Sun, 24 May 2026 23:36:41 -0700
Subject: [PATCH] dt-bindings: watchdog: Document Qualcomm Maili watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-maili-watchdog-v1-1-f7efef781701@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPjtE2oC/x3MTQqDQAxA4atI1g048RevUrqIY3QC7SgzUgvi3
 Zt2+S3eOyFLUskwFCckeWvWNRrcrQAfOC6COpmBSmrLhmp8sT4VD959mNYFua9c3fZMc+fAoi3
 JrJ//8P4wj5wFx8TRh9/GFgTX9QU5CgDjdwAAAA==
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-3d134
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779691010; l=1021;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=DVo2xi7RyBHNKdZAZ8GSGGWIbM7R2VtURBEfwF6e5DE=;
 b=AOMlDdCYWLzUVN8VflDsm6CdAGPoXN7FFOxupsnJCEmrJXYSd5um+XYQ6lH1WSLBTPsnyhdBZ
 YYd58qUdCplAtIHIhN24PztfmaNcD13CRcuByqx1fAtCd8zU5XurIQq
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a13ee04 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=GWLaZa68QPV-koml5E0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2NCBTYWx0ZWRfX+X9nT3cyVigK
 FwItcY7X8it4g/bEEUa8ICXBI1nMjhbqcb5hM+1EiuRlYvExynENiFrQkyb/gAcmk7DUONPhqFx
 uQNuT0dbTU1dtt99+mEX6ISDWSZK7lmjocQyxyNidEFXmJr+tDj6x1k7hh1qBx6xDfkD2mUfno3
 jwd+qIo2EImF88HVLr/ytNzQXS1q2yadUsa3sj6V7AUIQ86Z9VNMWD0CyBQTbrICnjUXwFenxk1
 YTYni6OFJcXn4iR6f6B0H9rHcetvy4tBwA8fAWeG8QDKsw4umiaTJW0QYNMyzbIJu202cfK9Yvy
 tRCEv5vLkrpI7bZsaGvDFncZPzM6phncun8+Z4XFThkKMAxFQB33WLZTPjEgzPhX7/z2B/ChCp5
 axnfy2PiixqLcI8Vgvpa+QAWljxEtpMLcN132MMJS+6qGEO0mOEhq3aDiUjytEIrJRUbUWVclSN
 gWoPYu27gHFpgNgQd5A==
X-Proofpoint-ORIG-GUID: b9kw_RTx0lj_ciAtjT6Yz22UTcIF_43d
X-Proofpoint-GUID: b9kw_RTx0lj_ciAtjT6Yz22UTcIF_43d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250064

Add devicetree binding for watchdog present on Qualcomm Maili SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index d647bf5f19a4..074b98802adf 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,apss-wdt-ipq9574
               - qcom,apss-wdt-ipq9650
               - qcom,apss-wdt-kaanapali
+              - qcom,apss-wdt-maili
               - qcom,apss-wdt-msm8226
               - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994

---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260524-maili-watchdog-a831468a2f71

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>

