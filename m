Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747407;
	b=r263T+ZpwO3KfAb8vkGBGSORM2UL/Ln5R6tVYP5ocK0/ZFOBXOFReLHaixfhKPjHTIfw
	 Of+X90w25KqEiHQfj3HsexYEONluYarnum+Xd/hjCilZHToD9F/P5Aa453V/yvHeubhtN
	 YxcghQRvBSJjFf+3TiM2r7wh2m61nuaO0T97BrFcRnNG8Ji9X2q/6VP8lRMAgpKE0wb6D
	 eMOMS+6b5RjkztUHAMCo1vFO0J+41Q5nJ1oDXs/r3cRTopRKy6554UR7YTQgnVgznT/d7
	 bqMK1jau5h+AJ07bB8h0wbB+BHYEXqbiBJAI3WTCeP7HUrY/dUdMnZ0Ub0WGzkPvk5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747407;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6xXNDxqhq3cVDlWPfpNm5hTwgInBUiJsJK4YxHxrK7Q=;
	b=Oo+o5rxPVoeTiMScrmt86vnAHqiVAjcg6Pf4BBfrB6msfZWzLYyyDUuHyxCCOOEIOPC9
	 oBgCmTB+pxdRehmCkYmJziyywADYXt3recEfDMl5aGMEwDFY0r1kjYgVWMno8s6Mxks66
	 rAZkqyh1TgQj/4WSZmWQFFtxRZ985ffXni7zjYekQg6TiFD5gL0jC3NBY/RfJFWl2dTe5
	 Hs0gPbnY47nZ3PGUmltQXIAVpKQfYyN8RM4ZCdJ2o6Biqwb7HK60THO1IgT1NRAqDhfWX
	 +i9HjIi6vqEGLbHLImHq3saMMkRW3mixq/j+NScmQvqRM8AyCokUg17raMq9UlceaJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Q/ZB700J";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD679606A31B;
	Fri, 23 Oct 2026 09:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD679606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q/ZB700J
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FBmA2092791;
	Fri, 23 Oct 2026 09:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6xXNDxqhq3cVDlWPfpNm5hTwgInBUiJsJK4YxHxrK7Q=; b=Q/ZB700JP5mK694z
	HKAews5QY8uGuJNkqFiYEPgpgzZV0UCKIsly7Sn5hafs2bbXvrsqDGcgrB4qJCwi
	UcnbuR8sEWo8Jl5LKHoInhUwrqlTEO29qsIC67ZciPZuI0PFpSVwc/xEBMFdvCiO
	BHYVoS5jVylPWrPznTMoqmlu4hC8Gi0a8+9r5vmTwxw3qhE8n6HOnyUXwbCNV3kk
	TBn12lAjJ3nCqHOKfULOqQz8p/2ciIIZx7uIFvMouRDcL27l6QQoFEo6Eeel448h
	Ha48eIv602yvDtCHVqlB3b5OU++gcnwI29yK6WxpUPpTnLTB+9eHoDyerMnnkNvz
	aGZz1w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyga5c7-11
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 09:22:57 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N9IF9V4054752;
	Fri, 23 Oct 2026 09:18:16 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69N9IEN44054700;
	Fri, 23 Oct 2026 09:18:16 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:47:55 +0530
Subject: [PATCH v4 3/3] arm64: dts: qcom: lemans: Add PSCRR NVMEM recorder
 node
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
Message-Id: <20261023-pscrr-provider-v4-3-e70fabb7e927@oss.qualcomm.com>
References: <20261023-pscrr-provider-v4-0-e70fabb7e927@oss.qualcomm.com>
In-Reply-To: <20261023-pscrr-provider-v4-0-e70fabb7e927@oss.qualcomm.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?utf-8?q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb2771 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=gg1OsQjKW_mRkEzLfZkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNyBTYWx0ZWRfX01truoI8NCrx
 CLVCu+KAO8BBb8aLdMTLfttiNnmjjlHnhX/wrMj/PmXus/C7HYJLnfiDc7etPzry8f9b5UAATzT
 LtGfLpJz9k7Yb+LfPXBz94fjycAPmI8=
X-Proofpoint-GUID: awbuoXlYO1dsUshWstS2xeVPF7xlnmlG
X-Proofpoint-ORIG-GUID: awbuoXlYO1dsUshWstS2xeVPF7xlnmlG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNyBTYWx0ZWRfXxGXDTZ5W5g+m
 Z6p2plf7SiKa+VqCf0RUwMIa9wVbfuCIFSnyLFb7AC6DLD+5daWcmXOho44M2GZnW5X28VTO518
 IOrEvOjx7ls7pBLNUOZbGncwazXvB+JEP5TdpCkkfJPV3f1VI/l8D0awALEVgqZTQKGIFmHedwm
 FdUXdKq5o5NGYy2uKtTvqziHBG0n2TJ9GnFJRGkQ5YsX2R+yUvej0wESQgsToOZXPMTacd4sm+A
 ZLkI2qTTo/KjNufIT+p/RRfkbureGQnCMPHnKNXQlg3I0Cb0QwqfDWN+C+6Hn87ff8ViBqpVsOr
 TBKiPzmySDe2n1X3RC6ayJ8/QAn/khks0iQS/M99utgd99HFBPEL7fMeQpMHPu1Fd9btcFqXTYr
 g6q743IMayGRcsxtRhpJEZCFBot1iqSSblipi38epAaWrv4ir5+79TVCWSC7EdWjk6VVoJ+NwwW
 nyZGcg4EDVZLeMMNDRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230037

The PSCRR NVMEM recorder needs a persistent storage cell to save the
power state change reason before shutdown or reset. Without a described
NVMEM cell, the recorder has no platform storage where it can preserve
that reason for the next boot.

Add a pscrr-nvmem layout under the PMIC SDAM and describe a one-byte
cell at offset 0x49. The recorder uses the lower four bits of this cell
to persist the power state change reason across resets.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
index 500f715931aa..180d180be3c6 100644
--- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
@@ -186,6 +186,17 @@ reboot_reason: reboot-reason@48 {
 				reg = <0x48 0x1>;
 				bits = <1 7>;
 			};
+
+			nvmem-layout {
+				compatible = "pscrr-nvmem";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				reboot_reason_persist: reboot-reason-persist@49 {
+					reg = <0x49 0x1>;
+					bits = <0 4>;
+				};
+			};
 		};
 	};
 

-- 
2.34.1

