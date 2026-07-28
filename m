Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895A423EA4
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236302; cv=none; b=W/RIXWu6KwkGLbNMKW0+9m5cWCQvdmvRayopW2qgcLLqA6H2YSgcPQ87vx+Iy4ho5C7cy9R4QcYwgJvMlpJYyrzkjjUknU1HlP7SnTlcotgzvqmEvPwypEK44SvjfMT9cF4JE7ZPuEsdgbKcxQXpyKB4kKPG7+Fw8fAoelU52hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236302; c=relaxed/simple;
	bh=YcfIyQ7phpzgDR6Sj0LcOKmnQuVVnjn7mGBSvd7KmOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGUxkfnUatBPagFxtEjRP7QbrjaZlEGuqi7l935C4yaxzevmvscz75JJxa0w/etdRaie9LrYA/4VkMtGDr0gVXxzukCXli/iKTZXC0bMBFdTWC2U/POpofNDgEvPuz7xkSCQeGrQJDy+nwADaxsyiyNSKhgCdK1WZIbRhzqoNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NH9bA6dy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kj1/F6Wd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NH9bA6dy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kj1/F6Wd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SAgg8M2861915
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pakv7Ob2t7cxw6cZ+F10BS0e+WczfsQikxrNu7YI5F4=; b=NH9bA6dyKCnB1WMd
	v9vPjQwjeiGMOXir2zSIygNblfPP88WN8L8vvU8P6qa5x2YKzbUpau1poJ3kH7uO
	zIX6qE1LXblgwN0WeL3m47u48mBu0Vf30OwrXLi9DGypFf8QjBJrxF5dbIRw2CcV
	Ut68r2nBqZ3lmN9KP4LTXzzK70yx80FttNssobMEJLdnU7KRYSA3EIpIIUicwFmB
	GcoZ3rqFPin0Rw4GZlXp8+Vg0cAn+Xi+9Y6e9/lF4euJmGwb5Iz1lsAsXOGWrosN
	0W0xB2JLLcdDeJhMHmSuzyUJuQVzHWMJ/yHe2uJ/La6iPEoA0jXnbhL8oJAtGmbr
	plcXsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy11ktt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 10:58:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so103828285ad.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2026 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785236298; x=1785841098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pakv7Ob2t7cxw6cZ+F10BS0e+WczfsQikxrNu7YI5F4=;
        b=Kj1/F6WdIgrR1rjfLJkzhbuO4H7/M9yZ/6pZtly2iEyuX12DezZsKbKwr1V5EVDiAt
         G5M8/a5mSrOukyrVb60yA5xQPMKd/aGGIsP2wfr0bYO9opZ5zmkze94zafoXmVM1INm2
         1MFA9csOOA8WRLAUJKn0Hex+sdCk3OSk2bcNq4XaKE6lXudBihgHzgnopjzF8hLAPp28
         lgnnhLhKMA2lghy5H1QjB4swI2DBeyXQtim31OLqfFDtpCDPdP+7Y/c3Qnl3D0flbmIV
         rthm0lFX3VRJ5kDjypE+J12v3ImE+9zwNBHPMTTZGmhD1KaBGQVYW5SGAlnnNf/D/M0E
         E5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785236298; x=1785841098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pakv7Ob2t7cxw6cZ+F10BS0e+WczfsQikxrNu7YI5F4=;
        b=cV8Fm5mnZRl8tad/l0Zq+UXAVB8FQNjit7X0NgxSfAlymeqA3Gqo6Tbfbo02iNoRPE
         6mlJCU5qxH3/dQnvCJC3GiQ+g5mT1XYQ8eVmTUophg/pkhxOrFl3+8J99Agjj0RMJFF1
         obEnAbZRqi9j09x8HrycvNfnrCchmLu6Ld5co/eZwXUc0V4icMkEzGLEMqsJXi1WbOAT
         AwJG3Ag/Z4Fz/bFrMZJwGHtzP7+oOJQqhWpdalpHEvCCWQTsdCWBE5WB/QW+U50cjK/i
         LJKGjH2QZFGSGEjBlJvUJAJAxP9ahJmke2lhSYBAhp77EVUggr3hJydzjlH364+2wRYc
         vUCA==
X-Forwarded-Encrypted: i=1; AHgh+RosJ2YeFkSKIf40jRYQcIIt+NsEWYYRhXE3ezXyx5Bh1dYcZPTkDNZQXLkcNF3Ks6/hLAJk2sWW5mdRqx0D0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2bliPAbf6pbhRRQ8xsRJZhdTcsqQwhxG3lVXCTrYCEdL9GNFH
	hXYsEDSjDaBO6xUyrw8vzeQNWz9Veo002hfwkAjxlFHzBPbEOrin9rYH3mhLmi11RIThsZATpLd
	KRnrwdrmesiRRElUjfo5q1aoxnwtCkbxfLoBM01ZD4qDlcb7tRt5xt0P68jAUX7bJUcSQMw==
X-Gm-Gg: AR+sD12RcWelBxg3zln6yxFaBwNAzr+jpqHZN8lI+Lmwf8inZUnE9o5JVRAAdBkW4to
	+TCnQpaSXhEs2Fy+1XVIZJi9qQdszoNk2b/5eqArzcOmri/FP3/jXARnyRGpaLN8ldXlUBCZonT
	8apdaRazVy5uXMFRbWQAfs50zt7myU6UXyfYjr6nsIDGwo4eoc9ne2PyPk8V/oNS1WWj//rPp5G
	fk1bnfBmNm2ElYPp2C9Bs90RkJCMvBPO95nfDPTARXA21AWzVbaiOeiE39WmhTlx7leVuaEE57C
	UDh0R47q8LqqUoaGWXtOoUz4no97r5tGq6Rlb+gbINFPjXLWTecMOXRzKqpnfFIRVxLDu/DLijx
	G0nwZyd+VyTVq3h4/WcRlKceHAsVTyZoxcD6LGMpF+XkXMBIwvZEwOIHL3yRPVek5B/dyQkSTxz
	NRjtZU6vcp7fuxjBbLHZGeFtkq81SBPcqeiIw=
X-Received: by 2002:a17:903:2b0f:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2d015c9c4c4mr23996345ad.3.1785236297766;
        Tue, 28 Jul 2026 03:58:17 -0700 (PDT)
X-Received: by 2002:a17:903:2b0f:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2d015c9c4c4mr23996025ad.3.1785236297364;
        Tue, 28 Jul 2026 03:58:17 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm42192544eec.10.2026.07.28.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:58:16 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 16:28:02 +0530
Subject: [PATCH 1/2] watchdog: qcom: report WDIOF_POWERUNDER in bootstatus
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-qcom_wdt_powerunder-v1-1-de8d9e964e7d@oss.qualcomm.com>
References: <20260728-qcom_wdt_powerunder-v1-0-de8d9e964e7d@oss.qualcomm.com>
In-Reply-To: <20260728-qcom_wdt_powerunder-v1-0-de8d9e964e7d@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: Jwngak9MsIPcRAexfIF5K1Ch2PC-4mgU
X-Proofpoint-ORIG-GUID: Jwngak9MsIPcRAexfIF5K1Ch2PC-4mgU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5NiBTYWx0ZWRfX70PvbeMAg39R
 V9+6GSpWAzFy+3sBEXgG8voYzH+vQxX6wfx1/GzdfdNrlSDY2cjVco+QZ+FbAsFx0QU6rl8itE+
 PK3ffk8GC3bxC+3t0PLO8HTjFvzfqLfA+KVgee+RSqrED8RA946NOyspLJf4adt1ECy/bgrDA0A
 cQ0/S4vWZPimhmWW15NxN8m/Af7+Yji5fi4dO05XZZKMN05qHxqJnad+8eI5eOYXO93atf2m/U/
 8EnVpq4QRWycGetp8xKVh0iUrqdddBITafZe/0/N/KBd7JAr6NnytYBDA2cer5WMqvTsSlet+2H
 QE2srNaziAWORRRvKaEMpFumiqkj/GtQzpSKFVyPE3hKK2l5G6h1U110JBffq65h2OTAJJOVC6r
 yZi//znGxR69krdd0nwh7dOr1H9HDm2DEBjV+sHbYK23BFg8tL9dRRNs9LgGCPj6cTVe82TEYEG
 ZxQQpA1OEFvSvUBaRIQ==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a688b4a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=r3dvFDkSt932AH7NsF4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5NiBTYWx0ZWRfXywvRDUWWvz9t
 gmczn6fCUM0Np85xLEcVevY53htsBgrSvCqk387BUoOGVVe9Mle9cybS5jfD0k3ZiYxfRCK7BfI
 iaGt8Hfgj4eolH17Quy3j7KwKLnZ5u8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280096

On IPQ platforms, identify the restart reason as POWERUNDER, similar to
CARDRESET, and expose it via the bootstatus sysfs interface.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/watchdog/qcom-wdt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 49bd04841f0c..8e1fa1347343 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -44,6 +44,7 @@ struct qcom_wdt_match_data {
 	bool pretimeout;
 	u32 max_tick_count;
 	u32 wdt_reason_val;
+	u32 powerunder_reason_val;
 };
 
 struct qcom_wdt {
@@ -164,7 +165,8 @@ static const struct watchdog_info qcom_wdt_info = {
 	.options	= WDIOF_KEEPALIVEPING
 			| WDIOF_MAGICCLOSE
 			| WDIOF_SETTIMEOUT
-			| WDIOF_CARDRESET,
+			| WDIOF_CARDRESET
+			| WDIOF_POWERUNDER,
 	.identity	= KBUILD_MODNAME,
 };
 
@@ -173,7 +175,8 @@ static const struct watchdog_info qcom_wdt_pt_info = {
 			| WDIOF_MAGICCLOSE
 			| WDIOF_SETTIMEOUT
 			| WDIOF_PRETIMEOUT
-			| WDIOF_CARDRESET,
+			| WDIOF_CARDRESET
+			| WDIOF_POWERUNDER,
 	.identity	= KBUILD_MODNAME,
 };
 
@@ -188,6 +191,7 @@ static const struct qcom_wdt_match_data match_data_ipq5424 = {
 	.pretimeout = true,
 	.max_tick_count = 0xFFFFFU,
 	.wdt_reason_val = 5,
+	.powerunder_reason_val = 1,
 };
 
 static const struct qcom_wdt_match_data match_data_kpss = {
@@ -197,12 +201,13 @@ static const struct qcom_wdt_match_data match_data_kpss = {
 };
 
 static int qcom_wdt_get_bootstatus(struct device *dev, struct qcom_wdt *wdt,
-				   u32 val)
+				   const struct qcom_wdt_match_data *data)
 {
 	struct device_node *imem;
 	struct resource res;
 	void __iomem *addr;
 	int ret;
+	int val;
 
 	imem = of_parse_phandle(dev->of_node, "sram", 0);
 	if (!imem) {
@@ -222,8 +227,11 @@ static int qcom_wdt_get_bootstatus(struct device *dev, struct qcom_wdt *wdt,
 	if (!addr)
 		return -ENOMEM;
 
-	if (readl(addr) == val)
+	val = readl(addr);
+	if (val == data->wdt_reason_val)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	else if (val == data->powerunder_reason_val)
+		wdt->wdd.bootstatus = WDIOF_POWERUNDER;
 
 	iounmap(addr);
 
@@ -310,7 +318,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent = dev;
 	wdt->layout = data->offset;
 
-	ret = qcom_wdt_get_bootstatus(dev, wdt, data->wdt_reason_val);
+	ret = qcom_wdt_get_bootstatus(dev, wdt, data);
 	if (ret)
 		dev_err(dev, "failed to get the bootstatus, %d\n", ret);
 

-- 
2.34.1

