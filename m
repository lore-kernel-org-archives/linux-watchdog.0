Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932A368D5E;
	Wed, 19 Aug 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160108; cv=none; b=aqRDUPGlo22az4uFFBl0fw9BrGeYGc9wrOhog4M6ogV2K9znXDOnjHrQfDq4edUgumUl4U3TkIkqa7ZrhRTfy5hlTU6Ud8levKRFK2ia1XQ360fmKxtmsWst7ZGIQD4Jk2snIId6NKZGDbEPEkStwGgZ/VFePp3AgAE7XJK9mk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160108; c=relaxed/simple;
	bh=HQR1jd9XVDt9kP59NBL51DuihrYV2Qt4CCZsAKiqYxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALd1EFRm7NMdlg+dwwb+WbIDabQBdOxOoMYIXgCqma8fVzBXvySj76xW3hMTBT3bQ0XxvMdPKHp/jJud8mLrPj1ezQuEiueOnodT1W1eYHjYPXKbpOVi5KJ75Mc8AW7/JX2qNz+hdCOnhdQ5Qa2ke3dppfXpQSjiz/hqQmZGosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KENZB9UB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KENZB9UB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbLME067602;
	Wed, 19 Aug 2026 17:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rb6dE5y6kbaCv/EunSzpHBECJxErNwXCc8DBOXliMHw=; b=KENZB9UBysLloCWi
	QiSZOF7EHKFJDh7BY+0G+VArKmk73KNg5CwOnoBdoPkAxKKOGZhU/cnXR+Ap/Iak
	bi6YJb9jyVemn4rhK9mrdUuse547PnBPficZUqWVodBgTC1OacIPK3AAGGmv7tRM
	idGnRhvCL8OUyvGTyfJSKKi3Mj8CnVwoljtiRHzGsOcebFQk+uEXPIkugfIcZ3aG
	9jOAu/fvjh0wI50akLRyJt0tBULYwvYowngZ7tBqQL6EG4LF4o8a4jocYkx1bwpz
	65PrH+B1rn00kp/zTVLExujnCF1c+adegyPWa1YjQg3Exf27IiUGiyr8u5yxCL0c
	dSYr0g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e5d0xvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 17:21:11 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JHL6cL027988;
	Wed, 19 Aug 2026 17:21:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4g2h6kddba-1;
	Wed, 19 Aug 2026 17:21:08 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67JHL5eA027937;
	Wed, 19 Aug 2026 17:21:08 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 67JHL5jE027916;
	Wed, 19 Aug 2026 17:21:08 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 22:50:46 +0530
Subject: [PATCH v2 4/4] arm64: dts: qcom: lemans: Add PSCRR NVMEM recorder
 node
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-pscrr-provider-v2-4-9072383e0f4d@oss.qualcomm.com>
References: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
In-Reply-To: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfX2FzD1BZDLCPS
 mEdtSF7rUT812VUbz/UEFOG1MAeCgjAQfq/3OjTX1sfXK/FdClRaHkfEyO2Fgjr+EhJATPnLhF8
 RJ1sBUwBJUMAVCZnAXuLkf9Kp31ceJu2WAgb2YGOPoe1SXvSK8vwxrWx6ob4IZ0AuP46xQ0NEQc
 atvBtb+96EMtfXo2J+rR0UskO5Tf/jp+bVyDgGX8q9tfpX0r/zet6CZ+qi+IziSGeEDErQpcz5e
 PBrpceGUDi3ASP0fa3aRCm5+nFTxBxUVu31kxmfxNft1euDsOuXBPUMsmkcgaJbVXX0+mTUYqpU
 5QQ7KzQgSPfGWnFS901eCA2+c79IUlo5a35BLAQhQgzhSvQoifK+tGRKaP1/foBBDtyss/KuxWd
 o7vhW9yWnDr1unNxyurPXYeZI9CdamdLV58g6j/NqOezewVAhIfU33MQpcKxajd3H7oq2CA2Xu1
 SDcKbMy6HFHnX9BJ/kQ==
X-Authority-Analysis: v=2.4 cv=cuOrVV4i c=1 sm=1 tr=0 ts=6a85e608 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=MOLsqODhR6HaTkgyW3wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DL34dKFa6OPFRv_qfuSZonI8p5ICq6X5
X-Proofpoint-GUID: DL34dKFa6OPFRv_qfuSZonI8p5ICq6X5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzNCBTYWx0ZWRfXzWBgWSLihqAm
 N1C0hyKYxUak2VL6ewP2gSS/lwp0kYxJifQkKoM+LrxZTcz78bb5IQBkcZ1ImsasGZD0WGAkeer
 hw0NQQ1sZOZnSdJM24xnSQBa8JaFJy8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190134

Add a one-byte NVMEM cell node  in the SDAM to persist the power
state change reason across resets, and wire it to a pscrr-nvmem
recorder consumer node so the reason is recorded before
shutdown/reboot and read back on the next boot.

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
index 500f715931aa..96db3f57969f 100644
--- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
@@ -97,6 +97,12 @@ reboot-mode {
 		mode-recovery = <0x01>;
 		mode-bootloader = <0x02>;
 	};
+
+	reboot-reason {
+		compatible = "pscrr-nvmem";
+		nvmem-cells = <&reboot_reason_persist>;
+		nvmem-cell-names = "pscr";
+	};
 };
 
 &spmi_bus {
@@ -186,6 +192,16 @@ reboot_reason: reboot-reason@48 {
 				reg = <0x48 0x1>;
 				bits = <1 7>;
 			};
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				reboot_reason_persist: reboot-reason-persist@49 {
+					reg = <0x49 0x1>;
+				};
+			};
 		};
 	};
 

-- 
2.34.1

