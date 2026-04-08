Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923939B97E
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Apr 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640293; cv=none; b=G32f/izR7TBS11dRcGalPyBJu0FZlsjvx+3QJ/KJQG0qfP88iXwh2XsIndYjveiYv3q1sCvMEXsB6Mx2FxcYNh56CqheGKTOl9uddr8aNZmmfxf5hVBiwtpEtowcj+q4o7IC0pxoXkO4NiPnw2nihlo7hHiE6ZkgRO6L2ZhzjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640293; c=relaxed/simple;
	bh=ysF7lMnW62Dw8GqPrgjEmc8c/jln9FFb0gpHqDZSArQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVEH0ShbVVaHVdJvk5+MtM6zNkQfAizES1GOXGFdLsI+4cQUaEvEUIQj1A2tZoJeVFV4tPjx7NkJ/98caB+emFVN2xWDyG4stHswPxHa7plGGGIxTa1+4jAEIZVivolXoKtkIZ6Vi/KJYL9PE1jx6fW0JwjZPim+t4yZwPBpvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BtjbBiCQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEu/r/is; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BtjbBiCQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEu/r/is"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63889ndU1796828
	for <linux-watchdog@vger.kernel.org>; Wed, 8 Apr 2026 09:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SOIlc/PtWR6rFkaZhdIsYBBjFwDm/X+YdDt7YDt1vJg=; b=BtjbBiCQLnliM9XW
	GVMMHfe02jgneaOhyQVHj8UkN1zqtL0VX9gPFsouFy2zNlqWbnOhyL2TjFSLcZ2A
	teqYSRJ6LeiuI81EAu11HU76hRxvD6h7K5tf5SFb7IdhHEnf56WFo6HAFInIvGJx
	TR55KYgzc+PjlquqOcOjptUeP4PRz2xl4mnCrf7wZRk3DgfoVR2MlbN9UuFXAGFY
	/JXdsjDyK/LILHwY0Mcf4uEroMUBEFinANqXcJ9xAA05hrLBLsuxr3iC1Re0jykP
	dntA0+7KBNwex4IKfua+YNSRo2EWWlMFcS3lMNM88PXB+hsFwSeFUKtBzFoHZeed
	Ax/fAA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51dbdk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 08 Apr 2026 09:24:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76c60c74f3so3075748a12.2
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Apr 2026 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775640289; x=1776245089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOIlc/PtWR6rFkaZhdIsYBBjFwDm/X+YdDt7YDt1vJg=;
        b=IEu/r/is+5FMGR5YtTdZI1lA7Bo/77UVrOdwh99X+takwkAMa1CHgS2aDawd1TmrLL
         djtAvWSA1zuPKASZXvSZMbaK5GRuXkUhWRWvLEtUvwG8U1zFvYYzi2q+zsYr1sw2lOCY
         pg1zD5ucjMCM3VCCPOjqmDCYZa9tIn2NWVc8PfbT8HO6QHg6AJDRiJEuGc6Y3p49F94h
         H2WjYzL56/FaveGI2I5DgtIW2b5kvp6tXUeE81eukXibFhkUvPiFdgmYrLq5LM//EfGT
         t60CeKLdbnmm+Jnxe0jqDG7pA/IHo2FqcBkAHS18bMvSNfKRRqQxFHZQVIMPgWdOD7G4
         d2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775640289; x=1776245089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SOIlc/PtWR6rFkaZhdIsYBBjFwDm/X+YdDt7YDt1vJg=;
        b=llIYinssrvqjr8QV1wJg0vy5ANip0pGFKxMDeHSFhzkddmj3iNa+xc7ZNoEajPu6iQ
         G2UcqhhaP60L6ehfjXIcgwTRzwFzZ+jm+gk2kLLEZj/rJE9EtDcAOWF1BWI2cVCqUQvX
         rmTXaeSjGki7YuFSHJIRjgkSDqnPIYxK0NBKK1NAAMCUYGXaDHL2pvgWVtfyPHl7Xm+S
         seLVeojzKcClzFH98jE3muFAkfrQUfPiUd5GfsRPfMuInarHV/K1bI5/ZcJrw7cjv6s6
         5Rl1y7nKmZvCKFiSbQiaNykcJsRdAAjLGGABATHqo7Kk+GmP5TPnwdF0DTKYBe59D30y
         ehCA==
X-Forwarded-Encrypted: i=1; AJvYcCVRM8IbGtWzoyyeSFicwFFb2Ae+6vOnEzDYPcZP3yarFBOEix+C3NrLYKKmvDHGnLYbu80GtMbQeGNSorUDBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzr0I9QOHW6lCpp3Lc3FhwH/daMeLl/lycdMhpbYSXTEn0HRv
	RDm2etxnhjqq5YOv6QbuYCFlGQZMjLb6WOSbY33Ny+IfFI/pMejIuljYL/zzJh7MseIPkmxKnG9
	fGMcMt3QcmOwmKimUcg/PdpmIDYkLqFQVOnoIqhim+/GnZTGoUxU8rgUByF0RERGgzpe2KQ==
X-Gm-Gg: AeBDietZe3sgU8riw8f3OgDggoTCjp2F6hwmAiQrNzmUDR3PIzk2gd9u2ClzAlPYAEy
	nFu5z0d2xqYdAmkkNIEKllBJl1n1TM+CbsRqv5cBzjaPn0An5wEZ6YiUVLTgTFkg0ptJSYAHYR4
	7Fwp7ls8IS8VYe7cofwQS83x4OAdOYu74lyaoTJXoGmuuVtGAU8tPPxsqn13nMdjF2Yyi1sY4t5
	EhlaBbIzaqMy6Q4F3p6b0+q2ozcVa5Ugd+ffiwu3mlCs4x59d5YquET5YDa2C9ux1BoTQJafHXg
	b5G9sgiiSLyti59kzWNfFKi6hFRa3BwYXJ3Q27ZqhcYk03UM9btgtVrNHkBbl0NY4dccquguAAC
	1yUtd5t0ISvRL8ZYruHdJr+OuGpyyIibgk28wW4QNWfjCQWsHlXlsgQ2LShlvc+Z6deaqOK0rRg
	DtfB1BqB/KKWPrzXIalyoxJTmU0vtoiK42o4H/e9OqE3YIzJJz9oXgmI1N
X-Received: by 2002:a05:6a20:7346:b0:398:aaac:a079 with SMTP id adf61e73a8af0-39f2f215352mr20749063637.45.1775640288857;
        Wed, 08 Apr 2026 02:24:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:7346:b0:398:aaac:a079 with SMTP id adf61e73a8af0-39f2f215352mr20749042637.45.1775640288393;
        Wed, 08 Apr 2026 02:24:48 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a3f08sm18274413a12.31.2026.04.08.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 02:24:48 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 08 Apr 2026 14:54:37 +0530
Subject: [PATCH v10 1/2] dt-bindings: watchdog: qcom-wdt: Document sram
 property
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-wdt_reset_reason-v10-1-caf66786329f@oss.qualcomm.com>
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
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775640279; l=1576;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=ysF7lMnW62Dw8GqPrgjEmc8c/jln9FFb0gpHqDZSArQ=;
 b=bBzR0mJkOQv8UsfpR8e2VEDPLF/CyO69j4fLRNMOihyoxdjx2WE3VTh2pEA/ACC9uUikNZ9oh
 tzPFp1lh7IdDdLADvjzls6r/CyD+Z2j6Dj4cIUkuWHL5SkUtzLTjaK0
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-ORIG-GUID: JMVGTg_phw_hQjXEPwsAiVQoBA6O9ZDE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4NSBTYWx0ZWRfX8gCV8Y5Ir16A
 sWkuvimWUxJPAU9UJxdlIC61PpLuKM01EDOL0SjIJtxucIZ6IbV5IwG9jIy3cAs24mhbISVXvkh
 5QRorQdtp9DGqVYDSZJXMoF5qsxwvwv7AiE+5mJPii/RPvyBOyzeTKmizub1Ti4qSVovKvZLvUd
 RfDFyBL1kcRkWb/MqAi8/3ka+uL28Xq2sHu/VkmiHHGdV36zyBnhQnKlHuDYUipRs/07H66NLGi
 tqzU7hQ4OZ4jjQXsVEodhpdqNj/u71BsX1qv/NnFRlh0UcphpddVqp8cnD9aeVahxDdPwfHqfp/
 GuanII+v+Iz8B4BrkftqMl2DG4jAH2USpI3gOTYqoARJ39pEPSAPP+VBkdojs76Weg19+J5Cj2j
 0sSg3MBKxT/jQwDX94dM+rHcm3WIzH4kwMj19Zfu50cS7auoLuDg2x641r4fcH3OsdD30EFlulG
 3AhJfxuiqSLZnaDDkFA==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d61ee1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RpRSbNz5O0cLrIcFx98A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: JMVGTg_phw_hQjXEPwsAiVQoBA6O9ZDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080085

Document the "sram" property for the watchdog device on Qualcomm
IPQ platforms. Use this property to extract the restart reason from
IMEM, which is updated by XBL. Populate the watchdog's bootstatus sysFS
entry with this information, when the system reboots due to a watchdog
timeout.

Describe this property for the IPQ5424 watchdog device and extend support
to other targets subsequently.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v10:
	- no changes
Changes in v9:
	- no changes
Changes in v8:
	- no changes
Changes in v7:
	- Picked up the R-b tag
Changes in v6:
	- Update the 'sram' property to point to the SRAM region
Changes in v5:
	- Rename the property 'qcom,imem' to 'sram'
Changes in v4:
	- New patch
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 9f861045b71e..3ead00da3cd6 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -84,6 +84,12 @@ properties:
     minItems: 1
     maxItems: 5
 
+  sram:
+    maxItems: 1
+    description:
+      A reference to an region residing in IMEM(on-chip SRAM), which contains
+      the system restart reason value populated by the bootloader.
+
 required:
   - compatible
   - reg

-- 
2.34.1

