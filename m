Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417548;
	b=4eI8Y3fBV6HKt+C+Tb/vRw4m1Jtithi8JzoqOq4sY2rKMQjM4VzV4XYAhvKflsWBSGup
	 ZDGnDke3Ht9bcdO8l0B4RAiVFfU59hJ8v6zVjqTYN9iMcDKWQDcQxvhBFXDhmO784iKHN
	 8szjXAROpFm/WMLMLfEI8/pcYzDeXpxh4zttPGaIEYIFM51D3c0lWkLeTlCTxkh6zkigK
	 NBJ9xomsNQUHNf6IowzBVH2kUhPJ4MhcQuamAfS3VHIZVFx1bu+FVIfq7rIrYMkdX+Maw
	 Jg4ZPrD6ZTXZJkyxuOhjRNqmsfsI4qib+YDQ1L2BcWC2EmA2B0ILwCtAUSNbkZ2qbaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417548;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BkTJNshVqHa3mBbTpFv2gIiMyHVHhJZBrdr/LAVLnz4=;
	b=XsUqePLdUBiyWmRaY/QRnCHedYZzaLbAcUgwLsVlombZPIHMEHwg3a37wv9AXUTX8VQW
	 hzEB7JY9NnE6pj4UeJaE/iXpaqHlsUE/UXaJDYh7NaxR2ksgpenkJ4ovWpMTn4wxXsYXM
	 q2eJd+iWUkiSCkShJBP+WqmkS1Pocu7OuS/Kt6c2nKNuOBrW0QNLF2V+hFCv+5SS93f2H
	 vvfdX+Ak5CjLYDXy4Rvc7zGY5aR6XWYa+6M/P+YZPkGPLI/8jncOvCAVxHLuxh1MBLFlJ
	 OZzb/EaAr9/Yh9RprdNbtG6EAHNE7tYGtm93sb9JOe8BSdTmuYEexwH/B9FoJq2dK+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ob7UHo3y;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767D606A688;
	Mon, 23 Nov 2026 07:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3767D606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ob7UHo3y
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN510JE1961029;
	Mon, 23 Nov 2026 07:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BkTJNshVqHa3mBbTpFv2gIiMyHVHhJZBrdr/LAVLnz4=; b=ob7UHo3ydyrlnHw9
	gmtdgEfUkJmyw7XwqONtcRPZnW/S34lBiH5zlBUaLAPnEITF6jKbB8jJuTKghHBz
	fBRanLasKe1LBhyYj+7arurqvVap5DodAOtmfXR7nL3yPBVIlGMB09LTJbsJ2i9z
	EwfylKyXDApXZC7XPKT/Nz7wLVC+bhqP3ZH9FQCltX0Vs510rs7AsUOoBsWxklRq
	JeBiUynv+CtGwrqZ9FMqjdUzEttHuJ6j0HSUmqY7oBoJcyRTJNXoKWEN+TWwi3m5
	lkQ2SD+Gtii+7YgYTExf1NybrHX/KLPQJHHqfOaukHmuznTK8ftHSttekvBxlWST
	ZwqyvQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6npuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 07:05:08 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN755q34185176;
	Mon, 23 Nov 2026 07:05:05 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 6AN753Q54185090;
	Mon, 23 Nov 2026 07:05:05 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 12:34:55 +0530
Subject: [PATCH v5 3/5] watchdog: pretimeout: update PSC reason in panic
 pretimeout governor
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-pscrr-reboot-reason-v5-3-fbf3c7c92772@oss.qualcomm.com>
References: <20261123-pscrr-reboot-reason-v5-0-fbf3c7c92772@oss.qualcomm.com>
In-Reply-To: <20261123-pscrr-reboot-reason-v5-0-fbf3c7c92772@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: a0xe8MNwU-d8_uWEss5ZoXEDTzB7crM9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfX2lSvLyiTXPv5
 yBGAakKmOFqO0IPqRf5TTDgStPpE5cLgBQdnEW8Q9wjB8iuleG9VjTRuR9G1h8mTEYgkJ1tvEIy
 PEsFyt9zNLsN4V5WjptRER7y4LD42XY=
X-Proofpoint-ORIG-GUID: a0xe8MNwU-d8_uWEss5ZoXEDTzB7crM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNyBTYWx0ZWRfXzQPtjVx46CBD
 P85slnrLLkdNWJSoe+npEVxznp800GXFbsbwRfKzWiFIyl69NwyhpDzyafzZScJQO6uNQGHb525
 f6muEMWlVxCPrvVLN5p21YyWf2bqgPcPOCxOIs4UxQeajxMrEFZpMocvcMrFdg7hPcWfjejZm7F
 IZp1HX5Jxu0NjsfWDP1nCOM04nDwEbhiJPGLQLHXdi9sweeAsjmkQFQol7cq/ye4/N94D94Ni5L
 XuJQVAfoaVFctvLdGLh/fjot8Ncz1nWKb1/0rNn8jXuDY5ltmlWhY9FfG3RHDdQwulTQedqLjbL
 wrxBkqLUG/omZI+CqUBJ4G6IWZzN5I5TFoSKgVwD/71DuOeUKdXFm0g9vkMnltLrg8QOG4iZzdB
 eUIZD0EVhLqoscB2BxiDqZ2n9FYkVvyQNIyQlIR40qZ73lpUmykY4Orl0RnS43RzX1z9gz+C9z3
 ce9nSCiSsX4cc/1lTJA==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b03e5a4 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=_jlGtV7tAAAA:8 a=FYyizyoliohAzulCZuQA:9 a=QEXdDO2ut3YA:10
 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230027

Update the PSC reset reason by invoking
set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) from the panic governor's
pretimeout handler before calling panic(), so the reset cause is
committed to persistent storage before the system goes down.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/pretimeout_panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
index 8c3ac674dc45..819487b5e6fe 100644
--- a/drivers/watchdog/pretimeout_panic.c
+++ b/drivers/watchdog/pretimeout_panic.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #include "watchdog_pretimeout.h"
@@ -17,6 +18,7 @@
  */
 static void pretimeout_panic(struct watchdog_device *wdd)
 {
+	set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
 	panic("watchdog pretimeout event\n");
 }
 

-- 
2.34.1

