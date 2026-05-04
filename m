Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9131F986
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882615; cv=none; b=jjGb9ebQmIc4VLEvwndLAuQ2Jvwh/JMJl4FfsF318L1cppAQ97keBSBeXOsq7HqSh0U1CANYLOgVMGpmdsIKM6l1N3NaKDVUDroC55/NTtBjmTLTqKb/FfVp4zPnyVAABjzZl1WCtxbm6RLcUeWohje+Zs+WWvGy//Xy4ZpDVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882615; c=relaxed/simple;
	bh=ssvc98NVfA7fDPfYwtO2liPTnGF+kbxWY6x/lSmWa7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K20X7+iNn04eFppKYsEEDE7y0RUM+JphJZSAr1SA8qG1Janf4lUarPSlyiXowO4XQTTo7h3J/JrkUoAYuj6g1OzAkfvdJfu5cqAzhphnHBRaDVDHHZfjN+BKpoB7q6+Z+x3IbRrAHh/torsQdTEHOb5chSMma5X/I+noKetNaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QmMplkKE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BqNDceeA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QmMplkKE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BqNDceeA"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446D6uX483416
	for <linux-watchdog@vger.kernel.org>; Mon, 4 May 2026 08:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=A/UsH+hKXoFiCKwvQNzcoN2pkWyXuUQc2Ws
	08NJ1FOg=; b=QmMplkKE/KvWeOv0Cv4N8V38+aRATqORx+jJn7EJkZmi/43/vkD
	ih6BUe4xIIIJw8GmH6a6ObLfx66O3PP3AhVmLQadvorucuJYJBEKzjc6rfKN4J/o
	Yl5TjDGtbn4PkNcjNBm9/VcQIeTXr1DpxbiJW12bo/X2GOOtTRPZwOi9NQBA6grJ
	OVdMGxQqRMZrQOI29P4fXmsb6daYBti1PtOWFxfW1L4SikjcAB/sAS9/ackwm8YN
	M0xr1T/DOSkLwoHEjJ21oCH0azX0DnD7D1mDP89OXtxvKHDgoNJhCgZe3tz6b/vT
	u45UWIhNuLE34RLQoQQlXX9s5UxF6L0m2VQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw87sd1rs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 08:16:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2cc75e79b97so6491047eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777882613; x=1778487413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/UsH+hKXoFiCKwvQNzcoN2pkWyXuUQc2Ws08NJ1FOg=;
        b=BqNDceeALkAR98pdP9dnsP3RvpbmrU0r5WlMQlojcVHNcgsWdS0HiatK8S1oQNbZog
         5Y8VwTgWJJe+WT/BCryZ7Eg4IOPDkZVgTfMGUgRSmATXP8+mGOfukaZxF2Rqui8IO9Ec
         MDNm5JPIX9/kZhCkQfWF6vapsa7/ddxkX9ON2ciZzWSXrK+qLlP7i7LbLe7RvDpzSU60
         t/tz+Wva6V/R74LcoI40cRFLzPf1FZcrkXlRl7tiFLdztxumCebw0SJwSca54XYNqPc0
         lSdu2lYWg1KYQBcWVKtWkOe91gejO8kXooy/IdJdWG7ZROZIHSxkNTLRVknV8vpnaSw+
         9qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882613; x=1778487413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/UsH+hKXoFiCKwvQNzcoN2pkWyXuUQc2Ws08NJ1FOg=;
        b=O6+ixqkMIJZCBdpuP/5OuNxSApmZb/QXNoVnqLb2Z2zHehI19lqRexrDhi9wii8Qze
         pLUHmHfosjikaokiYRotuxbHvLP7w61IIQ+jMCccg2b0RxREFKJAgjovXTjyX/4geHrf
         FZqoTPYeV81hHYP81Y0M9bDpm87AP4cDv4ph92dPX5q+X8c+oenH2O7HvEf8f3AlzqZC
         Eqq/Zx/gKvrRUxMJgNybkjDlEuDVLmH4QQjyhGPBbSzgN+TQTVtftEFl1Dh1eBy7q9WN
         se+x3A1a3WIwL6FdVOw79Ks0YvnTimldagkEn2lTiRanvry7tltGWDxs/wMuX//8v17Y
         P3IA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZAVmoOX/UOzQqz9NTJ60YZHt1n/zjDPiddo+PZtbpT/HsN86hNj4y79FxSf9xtqlm9KST3g30EnjNSRu9+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGF7go9HHMickN89B02hWqo5FUc7s/KfMYoztTbxT3FrJYZvOk
	LRRRXm10SUTcQJplVNatCLWj3MGiE6lb82MRSdchuOS+jjvMc2s03sZCsbgE/EKehoPPFx07yNs
	t5p8wy/sWTCzYNSTYE/OO8XPa9zXMvusz8z6G8fA4jLnRt14dkwNxBLEopAogrGkQMndnFA==
X-Gm-Gg: AeBDietNK8ricS+uRCI9hoK+RrV3Nswh0AvROi7AztyHddHzUHDUDqAOn6jvSXqaKrR
	2P6bp0S/UoGkNJQ2MCBohx+MArvmxS5bEzm39I7mj2GKaT38wL0vD98qcCp09lZbLaUlnX4Kw7f
	M9uzOhRTm49P1DViHn66KFSPdBhvlB+nqElb4SC8jOBmMLwsxovwV8Q3/RBZ5DFabN7qjVxYwf2
	NvpapJfJgQZ7opmOHa8CfzvybJ4CHsr0Fna8Wh6l/LtDMDG/BPPPZd7ofylzkeG0jBGZJ3H0vEj
	wZRpwTRHdg0PWcyaIsA4ulZCoqiIN/zFwtqbmx1YklGD29KCZ/hWvLnVdPsi+dDyNz0x/RaUEUA
	Sw2wggIsNvYu0H1aKuXiD7b6beTwyGxVz16qIVbZE7iHj1L6d2BlbUIvFqKJWQCWC4nwgQTLQqK
	9gLc6kiFqLXMUTbCu9
X-Received: by 2002:a05:7300:6d21:b0:2da:1874:f39c with SMTP id 5a478bee46e88-2efb85af63dmr3929815eec.12.1777882612918;
        Mon, 04 May 2026 01:16:52 -0700 (PDT)
X-Received: by 2002:a05:7300:6d21:b0:2da:1874:f39c with SMTP id 5a478bee46e88-2efb85af63dmr3929791eec.12.1777882612420;
        Mon, 04 May 2026 01:16:52 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f15cad1729sm5438517eec.6.2026.05.04.01.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:16:52 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v3] dt-bindings: watchdog: qcom-wdt: Add compatible for Nord watchdog
Date: Mon,  4 May 2026 16:16:43 +0800
Message-ID: <20260504081643.826038-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qK7EF-n1M2glWC9iEosMjEoh75GKXIhC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4OSBTYWx0ZWRfXyZg77BsXs9TE
 XEy1GpPpTDOvCF6x/vvXnlvz2FPkKJb9KOm3fQzc8AOLzoyBLbl7H1qzlXhEMoe2CWeE1cbrNgB
 JD7dwbvPtiGK3q+H4l41Ihwl3Z8ltvrCMiypVopbAFg1aQC90Wg/qZy1itUMWv7uGrrSC2p3uXm
 qI4OAOyXveCcH3/Z8Ffyfo7DRQAhQioBK7N3Ymb4/hb1yw1KjrvtC4oOwJHCW4Jd+ZX+7VvMWJh
 bfrja2IMpPUkPtXrdSifDKlvAFBrTGzhPOthq32d7w+79hP0VFrUJFd5/GR4LRBSbLb/7IlHsmy
 raSC+F19IEhTQrVEeyTKe2o7tQVixLggylV+P2WvIHU2okm5SRgAfguYmOjVCvzwDjm9l1KMTbc
 rJn12FtQ7b8KDknf7xTtQyhFSUAT0A==
X-Authority-Analysis: v=2.4 cv=O4IJeh9W c=1 sm=1 tr=0 ts=69f855f5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vLXAFcHGVjC68m0yDQIA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: qK7EF-n1M2glWC9iEosMjEoh75GKXIhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040089

From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>

Document Krait Processor Sub-system (KPSS) Watchdog timer on Nord SoC.

Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Changes in v3:
 - Improve commit log to drop "compatible with" part
 - Link to v2: https://lore.kernel.org/all/20260427013236.231841-1-shengchao.guo@oss.qualcomm.com/

Changes in v2:
 - Improve commit log to make the compatibility explicit
 - Link to v1: https://lore.kernel.org/all/20260420114950.1253792-1-shengchao.guo@oss.qualcomm.com/

 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 9f861045b71e..f2e6091902b1 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -27,6 +27,7 @@ properties:
               - qcom,apss-wdt-msm8226
               - qcom,apss-wdt-msm8974
               - qcom,apss-wdt-msm8994
+              - qcom,apss-wdt-nord
               - qcom,apss-wdt-qcm2290
               - qcom,apss-wdt-qcs404
               - qcom,apss-wdt-qcs615
-- 
2.43.0

