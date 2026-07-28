Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC8941A540
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236305; cv=none; b=G8FLR7nqUApHX+kXBCJgczTAz+bZbnNhYbz772qSqILHFhpbBIMg4G2JqCYBxmmAQLniREyJ9fyzTUsZj8ukjt0AU1dVWSPku35HnholT7iv/Akp3dNiBc+XgqYu7X1yYuuhlsLQqoWqTUZd+0F/z+JyiGMZbVxdxpljHOj1l2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236305; c=relaxed/simple;
	bh=uLDw0Zs08NHNk6dDgp+oXaxMz3h881fB7fddtQR4KN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vb5XeWmxcc0WO4CG9s6wZwkWTXVfZMSXgTwiYdQDJK4s/+cazBBfX3oh+NCtrU5EW9yFvMcvo4juF9FMJk6qKVHV/DqeAHsXBsH+JrmSn7944Px3A0zz86Caq6+bTjqabIAn4WxwXpSiw+UOgvCIRcAKW34+hHUlrqGDzFqEFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pg+/pui9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YITxYTh/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pg+/pui9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YITxYTh/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SAgWKF2861388
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4YBUhETsXSgn1p2YgwuvTVha8KfV4y20l5FdzlOiux0=; b=pg+/pui9B9Toj/er
	DE/VrcoOqmQ2DnWBpgAf8GNrW7dK+Kpdy3lQJjmFjfY+fQ35zhja+5kt/1v+BGbO
	oAeNW2vIXxgqsRTISm9PEFTc2CSFi6NPqLMHZ1b8OunRNzjll17XGIsfnZw7OwYm
	ZjvsfnnDSW7EXewD9FhJlrqMF+j3hyDp8ynfNlsDEmyXWkDZR4/81B/DI9N3r0+V
	Li3+WDHFg1if8ESSzAZZqyMMHUCUxtw7bmR0N+M0Ff1VKAYyPYnUfWslnUasT8oT
	+vjY5bpT4AqfF43Z44jAm4AqUZE9qeBSa5wBhy3NefNA/jaxLdvjdvv1BXoN5gny
	jppcjA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy11ku2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso2897842a12.3
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785236301; x=1785841101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YBUhETsXSgn1p2YgwuvTVha8KfV4y20l5FdzlOiux0=;
        b=YITxYTh/UzXfioI/eOV2SlHmB1wcDwDpQ/2pCnDXfLx4/LzIxjVw1tS/v04XPJK/QT
         UCzDrIme/dtnzTpC5rVmv36CZVFqL/dqyP9+cSdnWSC9iSxsO1L2d1KS0ihqTf/ZYf1A
         8aUdRzt7r4OHEkEY74xDs9lyuSjdasCn3LKWWef5GE63bhTXEmP21Dn4Su2aZLnGBBxr
         j/VpS1IqodLKhrZLk5xphPSL4VlV7iAxGcXO+iajKMSo7a7k+DXxMHyKV9THJ9yn8bBZ
         Gt6fiGOLJKK3bLmH9yDciLx0aHAXjFnZDAQSBJ1UiwL4sW5hsAI503f+6vtqeRWhYeh4
         bqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785236301; x=1785841101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YBUhETsXSgn1p2YgwuvTVha8KfV4y20l5FdzlOiux0=;
        b=E+Nb9xZq2uci9rme+5WwHOGjpXtZIEALGNIzc9PvhLadsIdprYz769CyRK+QVk4uLa
         dNdvtzlcgFDWT4PgYsdgptmaDXsFe43CcskC6ZT8aMY/btM6W7leH4HI4a6fRqEER1Hd
         +3/cgx5zE+KNj244uQa8GOCaABOjC8G4cZIaNGbq2bSMR/6y7GVu7jT6epyPmTqICKM4
         qaCfOrTme/jTIy3UGT2dYjlQb3KbRkqedYZtdjZrJHvUEYEp7EpmN5gjvCO/jP3rRrWB
         ds18KLm7HUZ+CRXOUPBo2lebKt3NpGYgoN4dlVCRP11xUF8wOrFSd8ssFLj3nDLKpPnP
         jANQ==
X-Forwarded-Encrypted: i=1; AHgh+RoypdjZFRDOVKt3A3jXp7HP1pWabaVl8JLUqv05HkobwjLVShU763wMieDUkM0HgM9zt5eug1+PFmUG1qixeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPM9cu/Ej9SGZ5aNZJZIDhWTwtDcitDu2rBYQq86zTXvXqnx4Q
	iq8AscEA8oMUYi3DQkVQZwuHvwJvc+uEFHGo8rAF5U8mOoQZlfgMzUCxrETyOH7fqmQew+JY2ec
	m0eSrTl9KetoMZaKH16830+rWtOrHZPgSzCsPnLGofW1D+ZZtmBPYCdLYEPxffMbrfvU1vg==
X-Gm-Gg: AR+sD11jcFSRf0G6OM13Nzmi8uIBMDp8odhDgkAJ3b4SIdI3ClPqFYURqj0OmANowZD
	UqKPAW0cR3DCkX6Dkpmp+TgtinzMSaWcAuMx/d11aCgOnOHNLngNTKFtSHHMGXFPcHCrjwGcKiQ
	w0s6+2A1UZsLp5As3BLorhMU10N3RarRtg49oasVPWsemKnebCEVyyfMjb8TBk5+yiUVQ28qLKD
	XIwGLs/r99bCiMA8Id2KwdLcZV41X+lhiWKIkeQnrgVn83ybtCXdGpFW0xZXPAPTpv7h6BwxNAb
	N7osI4A2clO7LHvaoJtDBquHB4+gl1bNyKimc6iUTKbQ++vYFIcjXL5oAUKfiAEDPW/rWbDRYKC
	NLVlNfiBdiKYtxeoelPZHpZpu4m1437X5MVHRJqMvbDqEtZNq49Uiu2Ij3bHEz5bv1aePjcMPlf
	uHX7DbqeRAODrx13F2Zl1708I+cTqWGmuKdMU=
X-Received: by 2002:a05:6a21:1393:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3c8b1bebee6mr2368815637.28.1785236301042;
        Tue, 28 Jul 2026 03:58:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:1393:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3c8b1bebee6mr2368782637.28.1785236300518;
        Tue, 28 Jul 2026 03:58:20 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm42192544eec.10.2026.07.28.03.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:58:20 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:28:03 +0530
Subject: [PATCH 2/2] watchdog: qcom: report bootstatus on IPQ9574 and
 IPQ5332
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-qcom_wdt_powerunder-v1-2-de8d9e964e7d@oss.qualcomm.com>
References: <20260728-qcom_wdt_powerunder-v1-0-de8d9e964e7d@oss.qualcomm.com>
In-Reply-To: <20260728-qcom_wdt_powerunder-v1-0-de8d9e964e7d@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: pGW4XQL11VQsY-Q1T-QdFEqHYm1LUVpr
X-Proofpoint-ORIG-GUID: pGW4XQL11VQsY-Q1T-QdFEqHYm1LUVpr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5NiBTYWx0ZWRfX2RiqEmeD1lK6
 x4lJK6csXe2gxwt8tTW6TVHSE4fHOuHPQaW6CtdOTaR6BXoqQJ3kaTtP0v1o17pkCW9Z2S2n8Uw
 QnMX1n0SBxYEjG8Tw7AWCyJbb4onZT7xjvUC86SmGL+HDAwI5jz2WuQiOCt/KWDHdBgJ8UVH5wa
 c9bV/p7/J77G2Q8e37PKbz0qGifULQrBxCuJtpzd3Ui97DAK4tPWUeiSo3czIytRcYfVo/ed3nC
 bEj8bbi0KYp0M2kyBrSj2IKfFLa+Bd2hfHj0dEQBf32y7SpWohRth90DIGWxJ3WHvXuG2rP8+UX
 y7sobI8diDT/lakLZCgQzy0jqReRzS6JHbcFcAH/4p2fGHM405fMRNAyL6B+EEeXYQJ9Dxx3Ftv
 Qh44wWimYybY+qCZ3JCMInQ3/O0Sk86IsywnyihpQqxf8feDk9Cn0xTFQDKE1omskiB9UXACa9P
 DMxTjuSChOfCWhs2KAQ==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a688b4d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=eb_Jq1-3yMf7mXF7YrMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5NiBTYWx0ZWRfX+cTjWwwwkMky
 Ty/MI2z+LJfucYZ3uvec5ek0jm0nIjPF7tvKpfvyWPRj0kNdq4xI7caRaTSEBmhge+okXFqFUp1
 7l4yW3ZkOV11Qoi2bYZQLgEJ/Y5MWtQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280096

Report bootstatus on IPQ5332 and IPQ9574. These SoCs use different
restart-reason values from IPQ5424 for watchdog reset and powerunder
reset events, so add separate match data for them and use it when
decoding the restart reason.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/watchdog/qcom-wdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 8e1fa1347343..a425902b9f68 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -194,6 +194,14 @@ static const struct qcom_wdt_match_data match_data_ipq5424 = {
 	.powerunder_reason_val = 1,
 };
 
+static const struct qcom_wdt_match_data match_data_ipq9574 = {
+	.offset = reg_offset_data_kpss,
+	.pretimeout = true,
+	.max_tick_count = 0xFFFFFU,
+	.wdt_reason_val = 1,
+	.powerunder_reason_val = 32,
+};
+
 static const struct qcom_wdt_match_data match_data_kpss = {
 	.offset = reg_offset_data_kpss,
 	.pretimeout = true,
@@ -374,7 +382,9 @@ static const struct dev_pm_ops qcom_wdt_pm_ops = {
 };
 
 static const struct of_device_id qcom_wdt_of_table[] = {
+	{ .compatible = "qcom,apss-wdt-ipq5332", .data = &match_data_ipq9574 },
 	{ .compatible = "qcom,apss-wdt-ipq5424", .data = &match_data_ipq5424 },
+	{ .compatible = "qcom,apss-wdt-ipq9574", .data = &match_data_ipq9574 },
 	{ .compatible = "qcom,kpss-timer", .data = &match_data_apcs_tmr },
 	{ .compatible = "qcom,scss-timer", .data = &match_data_apcs_tmr },
 	{ .compatible = "qcom,kpss-wdt", .data = &match_data_kpss },

-- 
2.34.1

