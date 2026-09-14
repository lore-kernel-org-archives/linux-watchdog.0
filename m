Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7593750CC;
	Mon, 14 Sep 2026 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360764; cv=none; b=uIO/Za/oy8TvGtOAMLBeBovO7daTiyGjjJUW1gNzFR7WfgIMg1kgN/w1ytxUJQ5BHwOul6qtRBPAcnlZ75oHteNrf8Dc/sU8ERp62B5+Cvu9/llxuP8vX7ScGZ1T/FFzFqsztb4lhLRuHgsIEvbvNxtxtm0Qot9ZiRxn/amEvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360764; c=relaxed/simple;
	bh=CcfGecDBtOLIQE2iImJJOfkKpM/+XnQ0SnOWaiW8HII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAKg393XK97lm8J0hwIXhuLjILeSC76z5XTdJ9XAx8BNRe+IDhi77zFt0B6O9ioNkkpPxz890bXCrG7OvWEoAcHck9b29fGbsNPBXs/FNmVRoa0jwFuNtgiy7LGbKYL8gGTqZbwzUGrQzgjsZSYWFP3zYuXvsp5vz/kjnCBNfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgodD7HT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgodD7HT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eTxW3348570;
	Mon, 14 Sep 2026 04:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L5BjR9yuX0w9A8iBbpgDFPH2EoKDQ8C+CtRTeqM63T8=; b=mgodD7HTMaqiFSGe
	NlgWWrCq0Jts1bXkaSLAicwMIDP5XCLJegmyD3gJEk4U43U1fQ5pK/fMJtrEFNZ2
	u5+5HSt8Fpi2IZBIScOdpQ7MMXeAhwzjQ8YbUyONZQmmftpgUFNDZ8GrCeSbQX80
	wLJQfycn6n1vRDjb1kOTMzkxfZY3P6OTuxv3BuZ2B0kk/q936MfQQwI97P5hZAgS
	dtUW7Iez2fdfYq5y/QVdGDCBM2QGyTiSWj8wq2tmEAP1MveuOeJlE6QgOWJbW1Rj
	2ck2+Kn0xQko33VtEazOOam/Ob/W5M8F2llzYyaSpifQa7shP6omZRs/L+p34Qsb
	F1wHew==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dd0qy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 04:38:52 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E4cnvn811237;
	Mon, 14 Sep 2026 04:38:50 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 68E4cm1m811221;
	Mon, 14 Sep 2026 04:38:50 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:08:47 +0530
Subject: [PATCH v3 3/3] arm64: dts: qcom: lemans: Add PSCRR NVMEM recorder
 node
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-pscrr-provider-v3-3-c45cb16542e8@oss.qualcomm.com>
References: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
In-Reply-To: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
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
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfXxamR2s54QrSk
 lrhUMVt6i5swlXs8Eugp2YV4BfAcwRcUiecNGE7l/2ranUNFUw4Ck+qfDJtdOzUQ0IQ1PAfebyY
 sHQY5hJBDOh/UZ889A83TlUsyNvwdqE7jnicN0RpxO52sMp7OpMLbjpAEycH40N0zDBrnueDLHL
 nBCbCVIjT515aASv4eG2NPOWEY0Wodjss0ihz2hd45ebUOcTAOkUHgEY6hDbQhmJ1wbvugPul9C
 gojYdRm/KvoZbEWTjLtqrU0BQiuiT7DBP6p3RkAlCwBJ54fTm4o6HFYO+72HqjmtJf7uX+s8uGA
 AF3bImR5QYPzApIIBMlemqYxs99tVbjOwvZAhk+UC4BmzHIEnaHKPN5XNnK6cvNnF3Lm8Lf9Z9Y
 hFoW3d0KxKg/SutJZKP7SZDfsrp3ca/iOk7orKYZZ1CJfYlEbdkd4xIB/M0FJ1Sd57Ks91S1F0h
 bb0uSP+lTHHhLMPTviw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA2MSBTYWx0ZWRfXwDXB4lZJcA8y
 PdCYNEEWkn0QCI9cRlLSiOeQjSIFgYPqXaZYLu1pQSYgt8ODJ9qjWsVO5c17n8SXK3JPovswc9H
 9E39I4byS58O16d3GtO/b6NwttTpMd8=
X-Proofpoint-GUID: Q9XvnXEMV2OO3vUJYlZxGVu3m5fb4CKC
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa77a5c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=gg1OsQjKW_mRkEzLfZkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q9XvnXEMV2OO3vUJYlZxGVu3m5fb4CKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140061

The PSCRR NVMEM recorder needs a persistent storage cell to save the
power state change reason before shutdown or reset. Without a described
NVMEM cell, the recorder has no platform storage where it can preserve
that reason for the next boot.

Add a pscrr-nvmem layout under the PMIC SDAM and describe a one-byte
cell at offset 0x49. The recorder uses the lower four bits of this cell
to persist the power state change reason across resets.
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

