Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0253DA5A7
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496565; cv=none; b=FfxVtxqW5GoVQFy/UkzFZst48mTHxaqATBa0LbJXFH+RfLGJgvqR+WzxQeb6uyoenJdPB37U+rD5ZAp3PrLu6oNAlYKB0qlu5VkyDArbwp9OJ+ywanVHeF2xszE7IkBvLxLzZByl2TOaeDrYne03URAmQMozOBFBhKSOCfCHPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496565; c=relaxed/simple;
	bh=rm2g+7WCJu3gDwkB9EAuBBjUl6hpY5pkc4BGZGxOr5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mxFWOhXhp+FBO5i+Zer54fD5y6zhVhud8S0dYqRqnMogw3COQ+ySSzg6lUVa7wPrEV+bShe9MSmyB2pT75l5L2Z0StVr5FUfd7p/Ic7tGKIU8Ooa2/WyRXFhebRdPOGowVv+pO5EcxwpB1FDRSPdpQifrJ9FRRIitjwc9D7YiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDcuoxeq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O1aAcvcd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDcuoxeq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O1aAcvcd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B9I3o0017280
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 10:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tae5Yd+glqdsIfXCIHTUr6
	ZN2vtdU+CzMjAVlTQqV9Y=; b=KDcuoxequrHpJ8nmKUoBU8zbjCHGJzuF5/oOSz
	tnpD5inlo65fA0VuJ3ZChA7cA1NhwN/jIYjK9Otu3bTlYXXD2UrGwpUTWJ+jrP7m
	EcVGeu+XgxW+NQnykDOxoOGnCbYzjJwBYAKfh46HPY9ET3vvpmT5eAs9xhoniDvt
	no/wNjJd70oayVXvRmpZcSHvN0IqcOc30DzJ0Po+T7I+UQKulEk0io8daMxLchYw
	41S/ycZlRtW8dFvoJKiP0sC3GeIFqTPwmTCBOBjaQzyq3TTCeoT4vrJPYwTQLCiI
	t+nHzkkjijeVu5bOdB6Okmef7DlFl1KxBQcock5+fPhRplag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfsbt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 10:49:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bc7f9b2213so13561425ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778496562; x=1779101362; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tae5Yd+glqdsIfXCIHTUr6ZN2vtdU+CzMjAVlTQqV9Y=;
        b=O1aAcvcdoFQNvhR8bEYGnfYQQMQQjLa0RPtADbsR0GnQ/+E/YsybDUvl2x2b+r5/jF
         GUUY6sqHlg64QACT0Zsk5zk4y6qWHZzu/YrEoJtLp2N192y2kEU2l6ln6GxGmoQKOoUu
         nryhGE0LXr8xrPR8H+QBAIifNLWHlvBp/YPJCN8JPBdlxzKF89K7WJHwhdEdO525UNwf
         G5qCuAUGRQyLDdMFUGBpLi4j3luVkEF9mJaVlT5kC++4cziiEaggLb6s3DQ/+SOD1FF2
         +070IJk+qw1GSzJBMyZ4dW3A8vCS9PAMRvw/vyTCHlQXMWWdYnwN8vuOWNtzTUypkxlM
         k4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496562; x=1779101362;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tae5Yd+glqdsIfXCIHTUr6ZN2vtdU+CzMjAVlTQqV9Y=;
        b=O0djmVmwgJWRmLGRRJ9zxoAf0SwsS4UN0hjeJP2ZcIz29oUXxxHrBMuYg+7/wfb9pN
         WsNyJBOdi4wH5jNK2wCP3juoNiyqzHg2vGGl4vy1DKffA5CLBmPsPyiFv6Tjkrf+9eof
         S32kEHTYDuHmDGKmZY99Kt4Le2tvUgkNPsR+vGw9XB1crL/N96nEP9XxQZvmrVNM4BcH
         +5ysZmKBrPeMXtBnzfB6Zg8cjJkR55cS5XNVGRcZGppKIuOAxttpdTIjg8O9eqIeHHK2
         VHqgtxw3selzM5dtdAbVoyb5oqLcW/9VUxjsnDZDXE/fZKch0Z3poMN5dTdVeM6fu0AW
         xGHg==
X-Forwarded-Encrypted: i=1; AFNElJ9eQbk6yf3kmxM2F5o4Jjy4rtxllVu+KIfzIHjH2vNoG6Lj/p2liZd+nGEi/TZH1ANJdf89Mfl9n9/UfYGC9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZqDS0SPH6ho4rZct6zN94RDfKLIWlVbZwSSSVXrfvhIHwpKW
	ZTNmehvKZi46mOkVy2bzWveZYRXFKE5bcjA5YmT2GcIF+nvABpb9FVOioXLGBETk/QW0yDuctI5
	WfY8zFd/7+YJtYNG/0UyIyN2gPCEAZnrLLWxbKVXxleYn9jxPTVBuNW+bCDbxpLhGoemqsw==
X-Gm-Gg: Acq92OHKEq9BIVKj9xwUIknc0OXkA//UVdmBWkBrVfpdE+qex8Y/dPyGqQDvJIv+jDn
	zbBa/9b3f+qNDGXE+dohaHyR8QyPUR7Eyeprr6yMhwp9D4lHB+QQ6mAGC5NSarqGO6QoTTM23j3
	BQZlMFJ7pFcWkitSBnZUXwc7lY1qCtWRP+YCmlmMfomPdwE71QYcKXXnDXap/WQ+1epDQ2trLV6
	EDE96WZhMVtU2L8kLxXf+8/00YhahsEDCBpTSCs/uvGqsINGnPZPlBoRCbYTxhOfel7Jl35CiH+
	D5sHVPhvzMHmXFgOEPM5jZrXlGFQHRyvKqQ9xmfR12L0KTKX8DypHYOSDQ0dFQV6pZoE47XMd9P
	athKn/ffOP3SCglUGicSJE788r2w8iyb/Gl8v0rSwN8W7q0q+iSoJexFTlwi8FVi9B9Cxtc1ZdL
	ayRnzW8CqUelKHuf8Xv+UFUEAMDTqmDqlDo1dXXOYP8OCoLpGmWfIVaVzN
X-Received: by 2002:a17:902:e547:b0:2b2:b117:1d5d with SMTP id d9443c01a7336-2baf0e4fedcmr143601605ad.33.1778496562039;
        Mon, 11 May 2026 03:49:22 -0700 (PDT)
X-Received: by 2002:a17:902:e547:b0:2b2:b117:1d5d with SMTP id d9443c01a7336-2baf0e4fedcmr143601215ad.33.1778496561438;
        Mon, 11 May 2026 03:49:21 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d26973sm103610245ad.12.2026.05.11.03.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:49:20 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 11 May 2026 16:19:13 +0530
Subject: [PATCH] dt-bindings: watchdog: qcom-wdt: Document IPQ5210 watchdog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACi0AWoC/yXMTQrDIBBA4avIrCuoYFJ7lVJCjKOdLqxV+wOSu
 8eky2/xXoOCmbDAhTXI+KFCz9ghTwyW+xwDcnLdoIQahJaSU3ppJcX0dXWyFB3FwI0fR2e0mdX
 ZQi9TRk+/43q9/V3e9oFL3Vewrhs9/t6EdwAAAA==
X-Change-ID: 20260511-ipq5210_wdt_binding-9f77d959a28b
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778496557; l=1071;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=rm2g+7WCJu3gDwkB9EAuBBjUl6hpY5pkc4BGZGxOr5I=;
 b=2C6wnhOrgRtGkh87K3ZV/0I4+Pda/KlnWA/nndO8Zy9Yu074ZXZstfitfc+xdQFM96Ykrqbpo
 tnC6j3sQJjYBcrtdsva+eZhXJpER++Rrv4Po/NS0CGOMtRssmhJZL6g
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01b433 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JxiR2JcaM4WusKbI-qIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: xgXBDD1aNwZaWcR6D7cWrIK6UhGmAS5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDExOSBTYWx0ZWRfX3WukqtSpi1kB
 hIisNnxcTCeofqdTZajdFZeon59jrpKRRTgA+lK5UbCwlZE8H5YQeY20nZ2yj1tcghSUGBOzDwa
 D4ZFCojx+X6sD/Q/eZQUsEEwXlQjeoXJEynn2xBPJZACiie6wS32mzTIfSP++1TpQp3zTUTfz3E
 drr6lS6AlB7U1/PyOo3bZRHMU93/HTNjjwCm4t5YRNjAsqA772Vc1SxxPzL5OEcKxHcXlMD7ZRy
 dlT41zpxvclb+ni87b47f2NWrPcUcsNnTt3ZZ2tKZHdn2SIbOj4fVUwHtd3rOQqmKL54ZC0kRGA
 bxhqmHfR1ZESyEFt4Wmlc175dqi0pWLJYKzqoXlHuibIV9EC/S7o0qrD7xvEFZRg44Pg/QGyQN/
 c9WlvCG851V0+VFg6zcvLMidt2TwW5xmFLsHZ2gUxz69T2ycHOLO0uv7lYvXMUO+NSBf7GExJuR
 AqumDcIPxJNSEgiZBOA==
X-Proofpoint-ORIG-GUID: xgXBDD1aNwZaWcR6D7cWrIK6UhGmAS5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110119

Document the watchdog device found on the Qualcomm IPQ5210 SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 9f861045b71e..21f6f7db7f96 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,apss-wdt-glymur
               - qcom,kpss-wdt-ipq4019
               - qcom,apss-wdt-ipq5018
+              - qcom,apss-wdt-ipq5210
               - qcom,apss-wdt-ipq5332
               - qcom,apss-wdt-ipq5424
               - qcom,apss-wdt-ipq9574

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260511-ipq5210_wdt_binding-9f77d959a28b

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

