Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAC3806C0
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Apr 2026 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640296; cv=none; b=WGXLxLJscsAKiSmAGkBB4UxLIqKBS58NMFljH2OPNJa9H9j+33F3M8Xl0AoPEs41bv40ytZjv2evyLw0PfrPXeuAdxCudXmySTQOlbWAR03dW8ZKXpFJH1xRXdfC3QD8FNZoI31mgPyw55O25eudQ7wtqL603nCnJHpfPrnwCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640296; c=relaxed/simple;
	bh=CyI3VfpN7ZvgkmfHWVT3f4/oL+YMTP8zz6uM1V5D2I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3MF3uDsjQ9mzyO82SM+kLAQlke7lEnxd2kG/cOW+4yRGqzRlGFV+t5jArzbv5YOhmbi8eovx/A0z9iK8bHjg/jO6YDji6z3J6Z29wFY1NsJajOet72Iljt6Ga6isnWtfyLgPL2N2tnVtkc7qfR5watiQYG935ABQcp2MdR7Spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ckYXAHeX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jnZcUu3d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ckYXAHeX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jnZcUu3d"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6388MilA1796280
	for <linux-watchdog@vger.kernel.org>; Wed, 8 Apr 2026 09:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sDvhAf2B9DrbLm4bHF1kl57Fvn2pa47nhjegElwkOHo=; b=ckYXAHeX2DZAVL0h
	T1oL24KRmw433Q2fXGuZzfpimH/Op1Q7IDiKVUyjumU5Y/E6bR4VkMMycXfJPKmE
	5Vl8Q9Kwt93tvKNyorZexvZMtxICZh/EZ4l1ec/4I8eJLGRBFnVhLhxSjf0TZ1Xl
	mMgOXBY2Dd1u8gaQPQ9p8NfDfvp5VUiyQM1vsKGTl92S5HZoNSJxbwUa8dy4Zti3
	XRtrsdWCHWxP+qsC7iLoWJC7FlxEYgklG/eHGmQxMtmsj7xxGUuwdLfWxSQ0Tur5
	/noXrfEI5Eievoa0pHBjUyV0N1wF4mpntXnqQ1kfxPM4JCJl585h5rqLnlo2ME/8
	q4/MGg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51dbdkf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 08 Apr 2026 09:24:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62da7602a0so3935369a12.2
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Apr 2026 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775640293; x=1776245093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDvhAf2B9DrbLm4bHF1kl57Fvn2pa47nhjegElwkOHo=;
        b=jnZcUu3dCLN08uKd2F5HpVj6ibdNjFLMFPxBdRYqAx7SwjjeJuIwK54R0Ej1Y3fOMS
         VTKWnsC0XxNd3/yskX0VPMv3xopWyDZEu9NuHvGySzKSNh7XAqJ8/Oiyhnq+QYv+EYf5
         ITp6Qur5HDuYgnx0VzQPx9yq8uFsxy8tRBlx0/uTXciCszM1+7TkIPj4y70IwCjrSl2t
         osCLq6srSmhlkoq3TimAojs/iQhSWJH0wwZDeCiTsDooZkuyCKXjNKa9GnQ62QJSOZEK
         UwAQ2S+oPJUgDO6K+FsAhJgUQgg0ULo7drhhyJ1MLBCAjI8dMSbJyZjWusrncV3NaKfU
         DZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775640293; x=1776245093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sDvhAf2B9DrbLm4bHF1kl57Fvn2pa47nhjegElwkOHo=;
        b=FGhXHPGbq/3LEDnGt5YYdeHM+m6dYTw8Tj+HACc/PtSE9OdYxiaBJwGSJuFxSFe5tK
         XUAQCnJC9iddohClwJW9a7HldD1ASEIfw6uzvi4SIGQV6oTb04PUxOUSPVSvHULC5OV0
         gOlWS2KGTBmGUX8Y8g66E5YKcx1WRjZNQCe+UKZoWOnTMp9tvCveUn7rLw0FrkWcZxVx
         hcxeTEi2uLfwclhuFoa4luoGdidkqgG1m7jxlTqXhxbqLp+AsvqzpnPmN4kgHUYliE8C
         gCFcaBLM/WfzwqWOKD6CJO38dGYuKwRkzZlPebGI7kjxJ6dz3fYMnJ+QDflwmTKeNr4E
         m2BA==
X-Forwarded-Encrypted: i=1; AJvYcCWUb0YwXbfd44gTxPxAzY3RuzKy2bBj4sfut5lwmbAKdklsGmSgYO/rddJ/3OS7RSzHzv89RjJzoc+FbykudQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaa1oC8bCANN1WWSu1yQ9HkLXasaxmja45wpeVtVwA8LjQjfgK
	hxmVL9XfJHwhJG39yhC37Xe65SRJjIIuDQr8CdNfvcVOzmTOT0S9uL65h+ZGLIGRX1HS5suepZ4
	hqybaXhzM4xSNmbhnfLf5sXlCzjxFAfDfKtX1kALMh8UfLBNd/iT4CO8f6QMY3LAO2xEX7w==
X-Gm-Gg: AeBDiesqg1iNYBrhEupT0xLTIBrwLUY4fGIx3C6QLQBtA1ehSwZ6ZUmkktzYAGDcALF
	wsBZVvqGF01gve71XI2MF9QscsY1CuI5W2cCgbEN4sgb5tQxlDIq/l5d1qwYijhmI+7dru6jnO+
	ycdJ+okzdUTGui5ExvHXRSl4GCe0xkp5HSfyI7UfAo6ug16LVsN+l5Nw3j5JUmr3dgbQI1MPBmX
	fSJKBmDTGza9tqcFStnuWGJElIe8S0+a3QyCn+0xSYhcL1Mtm0T2lbNCo8ULQlBFSJR+O7PvJpO
	Jn0KSJlOpVSEz0rP6FRTtERe/DlNg7ScwUyWrXZAct+I4z0482K9IMS5FpuEtysDCaTjQhtz5i0
	W5zAFFe+y0d8ECuGkGWjmjm6aLG4QlVEQZWR2juJKJH0jmzSx395j8WoaAoAyaOn3A4s4LDjdAg
	47gVudEm3aC+M6it2ufMjmNLank0aDOIETKP5K80zk3f7ZATtfaMSdiwIK
X-Received: by 2002:a05:6a20:7346:b0:39f:24ad:ad11 with SMTP id adf61e73a8af0-39f2f046df4mr20634350637.9.1775640293500;
        Wed, 08 Apr 2026 02:24:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:7346:b0:39f:24ad:ad11 with SMTP id adf61e73a8af0-39f2f046df4mr20634329637.9.1775640293018;
        Wed, 08 Apr 2026 02:24:53 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a3f08sm18274413a12.31.2026.04.08.02.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:24:52 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 08 Apr 2026 14:54:38 +0530
Subject: [PATCH v10 2/2] watchdog: qcom: add support to get the bootstatus
 from IMEM
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-wdt_reset_reason-v10-2-caf66786329f@oss.qualcomm.com>
References: <20260408-wdt_reset_reason-v10-0-caf66786329f@oss.qualcomm.com>
In-Reply-To: <20260408-wdt_reset_reason-v10-0-caf66786329f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775640279; l=4422;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=CyI3VfpN7ZvgkmfHWVT3f4/oL+YMTP8zz6uM1V5D2I0=;
 b=dQg7F/41tHFheDpFaSfZTB3oEOJJt/EN7mICP0FotiZPPuCTe0ltklrG6bCQqTlQ/VDk/lNWg
 e3JDu6gdXkcBjCYOs/q4jEzgI6kSgNusosSqdN3pG7KkyixcwZePuvK
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-ORIG-GUID: 0f70--O4Sw1FoxL0g43zlEFFMmhfCnif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4NSBTYWx0ZWRfX6mVy7+08yu8A
 +P+uCMIcpyZtXps+QfKuGyWkew9TVenuuT/wWtJVq+09EvxvX/qpucU5MqhEbzEBKLnjwB5kwR3
 rsXLPVqzvoduPUki58oEow82ZJClY4DQQ2LlXMrHYEnJGaaoBnEnZ8fug9/b36c1SYmmRjbXez0
 HXP7CO7feytWWqGMf8XCbGM08n5zu4pAH4DWz9ulRdEu8lRdncXma7pQLm3SqkeEhK3NQQoeeFL
 hbieZshVVwHbtAnvK3i+JYv27zS8Jp690eLVMvxwMn7xBAdStX0g+X7XOGc0sJvNrypWp78g+EB
 K8sFNgQJxo2XNdv4qTytNhvOKdA+B58rGs8WRQlAhCjd7b31U7+OHsxZqS052wkRnW5rJjLJPbb
 jZp7ng3P+NJirOQgmFDp+R0zMHMj0BiG4m5WkvFnUbEN26bHDicMqyLdlTwBdNBFuMIj/I0s81V
 9jWGVgWruTNTgfOOpsQ==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d61ee6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=qKWHfwwlgvfnR6H4MV8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 0f70--O4Sw1FoxL0g43zlEFFMmhfCnif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080085

When the system boots up after a watchdog reset, the EXPIRED_STATUS bit
in the WDT_STS register is cleared. To identify if the system was
restarted due to WDT expiry, XBL update the information in the IMEM region.
Update the driver to read the restart reason from IMEM and populate the
bootstatus accordingly.

With the CONFIG_WATCHDOG_SYSFS enabled, user can extract the information
as below:

cat /sys/devices/platform/soc@0/f410000.watchdog/watchdog/watchdog0/bootstatus
32

For backward compatibility, keep the EXPIRED_STATUS bit check. Add a new
function qcom_wdt_get_bootstatus() to read the restart reason from
IMEM.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v10:
	- no changes
Changes in v9:
	- Log the error message and continue with probe instead of
	  returning from the probe
Changes in v8:
	- Picked up the R-b tag
	- Updated the comment as suggested by Konrad
Changes in v7:
	- no changes
Changes in v6:
	- Reworked to get the restart reason code from SRAM region

Changes in v5:
	- Use dev_err_probe instead of dev_err

Changes in v4:
	- Kept only WDIOF_CARDRESET and dropped other codes
	- Renamed qcom_wdt_get_reason_reason() to
	  qcom_wdt_get_bootstatus()
	- Moved the existing check inside qcom_wdt_get_bootstatus()
	- Dropped the device data and put all the details in the DT node

Changes in v3:
	- Split the introduction of device data into separate patch
	- s/bootloaders/XBL - for clarity of which bootloader is
	  involved
	- Mention the sysfs path on to extract this information
	- s/compatible/imem_compatible in the device data structure to
	  avoid the confusion / better naming

Changes in v2:
	- Use the syscon API to access the IMEM region
	- Handle the error cases returned by qcom_wdt_get_restart_reason
	- Define device specific data to retrieve the IMEM compatible,
	  offset and the value for non secure WDT, which allows to
	  extend the support for other SoCs
---
 drivers/watchdog/qcom-wdt.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index dfaac5995c84..49bd04841f0c 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
@@ -42,6 +43,7 @@ struct qcom_wdt_match_data {
 	const u32 *offset;
 	bool pretimeout;
 	u32 max_tick_count;
+	u32 wdt_reason_val;
 };
 
 struct qcom_wdt {
@@ -185,6 +187,7 @@ static const struct qcom_wdt_match_data match_data_ipq5424 = {
 	.offset = reg_offset_data_kpss,
 	.pretimeout = true,
 	.max_tick_count = 0xFFFFFU,
+	.wdt_reason_val = 5,
 };
 
 static const struct qcom_wdt_match_data match_data_kpss = {
@@ -193,6 +196,40 @@ static const struct qcom_wdt_match_data match_data_kpss = {
 	.max_tick_count = 0xFFFFFU,
 };
 
+static int qcom_wdt_get_bootstatus(struct device *dev, struct qcom_wdt *wdt,
+				   u32 val)
+{
+	struct device_node *imem;
+	struct resource res;
+	void __iomem *addr;
+	int ret;
+
+	imem = of_parse_phandle(dev->of_node, "sram", 0);
+	if (!imem) {
+		/* Read the EXPIRED_STATUS bit as a fallback */
+		if (readl(wdt_addr(wdt, WDT_STS)) & 1)
+			wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
+		return 0;
+	}
+
+	ret = of_address_to_resource(imem, 0, &res);
+	of_node_put(imem);
+	if (ret)
+		return ret;
+
+	addr = ioremap(res.start, resource_size(&res));
+	if (!addr)
+		return -ENOMEM;
+
+	if (readl(addr) == val)
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
+	iounmap(addr);
+
+	return 0;
+}
+
 static int qcom_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -273,8 +310,9 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.parent = dev;
 	wdt->layout = data->offset;
 
-	if (readl(wdt_addr(wdt, WDT_STS)) & 1)
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	ret = qcom_wdt_get_bootstatus(dev, wdt, data->wdt_reason_val);
+	if (ret)
+		dev_err(dev, "failed to get the bootstatus, %d\n", ret);
 
 	/*
 	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second

-- 
2.34.1

