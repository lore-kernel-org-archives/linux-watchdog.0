Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308934751E
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208008; cv=none; b=WLqipiOUmvtX/cDNrY+Ywe0hqa3Di8rCs+9tqqrl4GgRvoVXJDoNYEu648BYjAGFBsNol+S1qr2GEqE46dHj2yQV9WEsLwRX3ed8PdtYE8RWWoJcB+u3NLW7STT2y8OyXGcSf76lXZHKSIo0PaMM5+RJD3EoGIIw9C116b8qjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208008; c=relaxed/simple;
	bh=cVVG4MkyscY1qtPoUsoyn8mWMRvlJbKMwxOJCEj7VLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olASfNm4wZ2lZLO2eephXQ+UeJgGHJBYceVidBF4fXtI0essz6+hQZdMlR79RCX1S0hHna0JJ/t4MhGFWYwIidlTXQVv8mOaGuDJ80VZeD/3iicAJrgRtA+PbSKDCSAEZFrE3WEIrASYqq9kcFV9YffZn2ZHDmq3EdtlbueXX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erMPqiE6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A/qQSC+6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erMPqiE6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/qQSC+6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B2qwWd2179297
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 05:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RGjJZDCOw/JM7x4VTsDtjQl0GpiD3yXd9P4Ux06z21k=; b=erMPqiE6z4nLBgSL
	YYh5dZelzYYFOdO7oJN2sicJ2NDagoQsRCMGhRVO0o1lkux18AMWeyD0fL4yQJ44
	BsxtfMTgeZa+NQAldjqcauT1dHZ/5F4MZyslGwfA73fs5exfSdufXq7UI3/+GuWL
	sGIcjBHTIZxVYG6UHgPp+HPXjhNQIQ/bNhi9aCtYbqliODHfOpmRBabprjjXEtgQ
	TDtIrMQS32W7HmGwIu23vMdyrf43yDHmxy64WBrAEj/XR1tntjAyCcZ8p+JCq5MR
	5joRlSH8mT9zOb4AuIf6LvJYgSwwNilMp9ii2cC6wmiUbGahugEpyP5fV8P4GLfo
	4D52OQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvst2j4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 05:46:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c738563e61eso4391812a12.2
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Mar 2026 22:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773208005; x=1773812805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGjJZDCOw/JM7x4VTsDtjQl0GpiD3yXd9P4Ux06z21k=;
        b=A/qQSC+6IxQeSuJCPWEiVG61B/CbY5Qr1CoUU7YgZdXhrCNtkCwiZPFrdj0bdiEVOc
         owosN599LcjXY+4126ilPnOl8Tyn48ce/If6qhhWUrAX74Mj6Vvqqwp6KBVVOwuyUFSF
         Id4kAU46kEW3mitJ5edGzuuVpACWCkMA9QicE1mLhP2ctMzRA2APszQ9sBfBCZVL+CXH
         7ztieUWCyhasv0lcf7/1S2O9BNzC3sUp8kZcjDGsD5wT+pvitsLe/K7Za16tXQ2sDXQS
         lDV/DrUy37seESE+JzwVUPot5GDp15XychWV8u06/08oX/xG88DGa/YP12L+6my8kfw8
         AdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773208005; x=1773812805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RGjJZDCOw/JM7x4VTsDtjQl0GpiD3yXd9P4Ux06z21k=;
        b=IDeMXthZNpmOhOG2/0U8gPCcZSQEuCBSmahxTHdeEiTvD2R+6JxJGtwnoCcVtzyiGh
         J5yAfcHi+Ut6YDGP9FbAcy4UiC/40Iazy9PX0h5UETwX9iGeIwUkAb+3Roj488DaLsI6
         14ZElSxHB5Z7Grb6yhC5iADUade7Oa4cTXWtorC/ro2GmyGEhzJBJKcIW2uyxlUKrCZL
         ugVwXXOY+aw+KnK9+Ry9vfrRcodf9ZyWC+jIDVWJCnMw3ktHJlqKTU1eXY/Mw3upP1QS
         Ypc/2hukPCye2hUWqFF4i9g4QvUKyEIaRzigMFbCtdwrVM8iJi47E9PLs1heDczjqOsO
         oHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+AQohjESFzyRxDTUkLZCEjbGfH31YsMZ9lGnHu5ULqVPuqu+ftylt/bcGFIy1utahEWyQkxvMFN1RJ25DyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeamp3Yg5z2bbJOltxzxtu17k1up6yqBF/wT+I5+ztvSheImE
	K4y4+owsLquJwts0Vfwr7hWG9OFmcAv9TIUvLGS4dXONMnJpX85vtds8ys1hvnDzDB8tOKFI/qd
	+iTai0VvcUe9T+zYeUpkOLPL9YRslKHlz4iGu3OoQE8L/DLVPaR3s98Gq77VJYjOk9EW0Og==
X-Gm-Gg: ATEYQzxt5AcGHECufvboxJj6sKa+yuLCly8SQ6hXxqe6bInXNsMWND2aCq5yF+MzhHa
	zj9DvumKBOdrP7l5S5Jj81L4gWqtwUg63u6a9nbOUrfdKC3iy0lPcnjJRQAXX6mgsC7gFFqfkJL
	1cD+GtEAtcjIMHkgHdsw9+rw5mYWuE6SByOmO4fsq5G7jW1XW/8uJW9CzL3190w9td7RbUUuAXd
	oFP0yFn8GPH6I1pzcV+k66cINw8jYY8WejnX1a16zMgVptcpLzapSY73Bi8kuSQnk5waWQCRc5j
	CN7tgq8He5J258e1xZ17Vz1TL8IP9IHXKgyen6EyMy8yA2GzdiZdJy8PqEbobhjVG9KJ8mkJr3G
	TNCGMmzpjrTQgRE+3h6jnC2kPQhEjIkQIn0FhM8DehutzTBf15hyPdos=
X-Received: by 2002:a05:6a00:f04:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-829f6e68c8bmr1376788b3a.9.1773208004750;
        Tue, 10 Mar 2026 22:46:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:f04:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-829f6e68c8bmr1376770b3a.9.1773208004254;
        Tue, 10 Mar 2026 22:46:44 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebf43sm1114108b3a.39.2026.03.10.22.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:46:43 -0700 (PDT)
From: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 11:16:30 +0530
Subject: [PATCH RESEND v8 1/2] firmware: qcom: scm: Register gunyah
 watchdog device
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-gunyah_watchdog-v8-1-4c1c0689de22@oss.qualcomm.com>
References: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
In-Reply-To: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15-dev-dd521
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773207995; l=3227;
 i=pavan.kondeti@oss.qualcomm.com; s=20260311; h=from:subject:message-id;
 bh=Ixc7jFfJtf3sYdNbi1DoA+ted+UPWdZsOBlvyEIVFtk=;
 b=kaXDlCTlXIpFBqcbs0fuEmRqJ3g7Ex/Y1wLPSAa8uN54wY7kFMvphZCwNmf7qDdPkUBkzq76F
 yVhrewOPHYYC5us3GUJDdJ6gN6r24Uii+rqF83sKb7nyUvFg50bvPPq
X-Developer-Key: i=pavan.kondeti@oss.qualcomm.com; a=ed25519;
 pk=Pdl9NnQpMlqbYaAGGkgBGpURTnZFe2de5LRZSGHkbHY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0NiBTYWx0ZWRfX3CxixxJFH0VM
 D/hUun/aQfIVEvuEUi7Ja4aMnMyl1g/OzIEps4agP/1g3Av//S3BRGOW18sPokdiEN0qRvrffYW
 57YHI0vTh4eBBM56ZM3MvZc07Wrod+gltpIynoW10G9pR45CX9t6z+Zf2phS0EhTj81xL6Y3OUl
 YWSZXhE5WKEb9kpIZR8rHdmdnASb8rBYBISTVl18ALa+bx4mNsgasAVfcO9SXgkA1aYBlptCu8p
 SoAFuhs2Y89i+LP3CUJZLd4QQDSVuvwkd1ShdVzuLuRpIWzGpZIc3k3x+ChTGXI6DVsmAelSC09
 LqPCuuVwjGY+5YEEqFiJ+U0xt/sIuyJOQkmqVkbx1BdbtHGxYe/OW63izlM8GT3ONng14QDHyRp
 3uPHJK1836geofAssMuYb2D2ewzYE3217VOj4rT4w56N2dybD/4tOCdL4c9iSO77m9aLkMMFuYq
 k0858OjFmaQJBtQeIbg==
X-Proofpoint-ORIG-GUID: 3r090tX6sRdSnSebVMRTLrsP---_tpZU
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b101c5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=g8_2rFH-n0ZcawzQyqcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3r090tX6sRdSnSebVMRTLrsP---_tpZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110046

From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>

To restrict Gunyah watchdog initialization to Qualcomm platforms running
under the Gunyah Hypervisor, register the watchdog device in the QCOM
SCM driver.

When Gunyah is not present or Gunyah emulates MMIO-based watchdog, we
expect Qualcomm watchdog or ARM SBSA watchdog device to be present in
the devicetree. First, we make sure we're running under the Gunyah
Hypervisor. Then we move to check if any of the above mentioned
watchdog device nodes are present, if not then we proceed to register
the SMC-based Gunyah watchdog device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
Signed-off-by: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 8fbc96693a55..1611e1ab3a31 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2467,6 +2467,56 @@ int qcom_scm_qtee_callback_response(phys_addr_t buf, size_t buf_size,
 }
 EXPORT_SYMBOL(qcom_scm_qtee_callback_response);
 
+static void qcom_scm_gunyah_wdt_free(void *data)
+{
+	struct platform_device *gunyah_wdt_dev = data;
+
+	platform_device_unregister(gunyah_wdt_dev);
+}
+
+static void qcom_scm_gunyah_wdt_init(struct qcom_scm *scm)
+{
+	struct platform_device *gunyah_wdt_dev;
+	struct device_node *np;
+	bool of_wdt_available;
+	int i;
+	static const uuid_t gunyah_uuid = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb,
+						    0x92, 0x65, 0xce, 0x36,
+						    0x67, 0x3d, 0x5f, 0x14);
+	static const char * const of_wdt_compatible[] = {
+		"qcom,kpss-wdt",
+		"arm,sbsa-gwdt",
+	};
+
+	/* Bail out if we are not running under Gunyah */
+	if (!IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) ||
+	    !arm_smccc_hypervisor_has_uuid(&gunyah_uuid))
+		return;
+
+	/*
+	 * Gunyah emulates either of Qualcomm watchdog or ARM SBSA watchdog on
+	 * newer platforms. Bail out if we find them in the devicetree.
+	 */
+	for (i = 0; i < ARRAY_SIZE(of_wdt_compatible); i++) {
+		np = of_find_compatible_node(NULL, NULL, of_wdt_compatible[i]);
+		of_wdt_available = of_device_is_available(np);
+		of_node_put(np);
+		if (of_wdt_available)
+			return;
+	}
+
+	gunyah_wdt_dev = platform_device_register_simple("gunyah-wdt", -1,
+							 NULL, 0);
+	if (IS_ERR(gunyah_wdt_dev)) {
+		dev_err(scm->dev, "Failed to register Gunyah watchdog device: %ld\n",
+			PTR_ERR(gunyah_wdt_dev));
+		return;
+	}
+
+	devm_add_action_or_reset(scm->dev, qcom_scm_gunyah_wdt_free,
+				 gunyah_wdt_dev);
+}
+
 static void qcom_scm_qtee_free(void *data)
 {
 	struct platform_device *qtee_dev = data;
@@ -2811,6 +2861,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	/* Initialize the QTEE object interface. */
 	qcom_scm_qtee_init(scm);
 
+	/* Initialize the Gunyah watchdog platform device. */
+	qcom_scm_gunyah_wdt_init(scm);
+
 	return 0;
 }
 

-- 
2.34.1

