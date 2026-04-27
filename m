Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780425FA05
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Apr 2026 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777253572; cv=none; b=Xaju0LmWRW6uNMs2gkd3JT5/YvqNB2DS08L9GjaIrFflcOV5yJOIUlS6/AV+ZAxUvlbYgkJf2gN4VGvffjkJHpfCrvLXsjMcNmK2eo7omd2tvruEreZG6M9p4QPceBL/h+knM2r5XhGtHsATkq8Kpe/HR0hjeNm4xi/1uDhoqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777253572; c=relaxed/simple;
	bh=qdgOoJPrYwE3M6SbNj/xaSbJRAJU5RxLjx0JdrgyqQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4yL6k5lZcUzlqqd9ncMBIQ2HuaHX2XnVddaCLnE5qLV8z9SMA7wqEuaUnvVERMIEyQpKxuTntc4tUoitdNu/fX7/Xdxbkm+ByUhW0YUZUjFPqdZJpQUKcvd+WD8xacVz9EW2YM2q09IzuuIv89GkUfTtfLIQGxQFy9sDVU+RS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbY8eZuH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bxynlsb0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbY8eZuH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bxynlsb0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QGr9jV1716741
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Apr 2026 01:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sOYlVc1RxI7zDZA7t4Xs+obBnFZx+Qhmg0M
	MpXOIeLg=; b=AbY8eZuHsV8aWF5/lnxGTV24OoslIEorh0myXDvEATwEM1I8Cav
	E7anwz28dGFPAHHzKRMYUEkP1gJWmfSglzn7/QvhTvrn3a2vlHPSiBIwkTsyYzbw
	qTeZ8Lugpfq1ETaOGbLsOa0J0xoQvcIIUBo31lxQfjKP/7cBi0Mc0f/o9RHz8FBu
	H0ydXhwIjAOZHoExjMtibe/93qlFUWDUjBYoS8qsjvmm1TYTAZnVZF8gDA8q2AC+
	13/B8RqdczheI/Gn51GerNt3FStxEvgEVeFYrvC4qvF1ninA5n6Tin2i/gwIvv1e
	UE/YNXoGr01cIQboFWZWHKz//itwjdt8eIg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr3wqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 27 Apr 2026 01:32:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2cc75e79b97so26900322eec.1
        for <linux-watchdog@vger.kernel.org>; Sun, 26 Apr 2026 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777253569; x=1777858369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOYlVc1RxI7zDZA7t4Xs+obBnFZx+Qhmg0MMpXOIeLg=;
        b=Bxynlsb0UiSxrrL7NLbEz3qSoytqs6v3nDnZ4YRIfWh3CvezCQr2kZ2zWp0NUyiH18
         5Ao9bjt0SrSq5wT4NYqPMZyqAP0MeO4ERQShA5jpPbN1Hz2dKBQJ7qD/0sNXCILdEJjX
         bmCHZx4a+mMIj2LgMI2bxWObos5BIaj2p9Wnhvo/7WxGBHjbWQNqIDiyE00m4DucHoTi
         +4zsfxCOF9XrzWRGfpUhgsbllfJYYLdc9fp7w2xQF4dMyKh7xV447OmlCOfIn7RuRZ1U
         m88Jg5tY/5vWzupp+x9GGNQ68uGiB0KNBuAse3W3dE/HfUVWstg5t1VVfbNABmWdgKJC
         pB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777253569; x=1777858369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOYlVc1RxI7zDZA7t4Xs+obBnFZx+Qhmg0MMpXOIeLg=;
        b=q21IIzrCSJAKA6a9wNy8vzOYZZyKU8JOBDbJ3EB2XqV++sY8RMZNJSL8ZzIUGzNbSU
         qs2qbzmWlmpj3fg09lCs7AgzyTl76TB7PWEEzIslUQntH9CyE+DoZ9xy4UHt8lJOHOcB
         6KOMSsdhnE2iY0NqCfl/Ieofb7m0DfUHDJS8rP2XYepNA8bZNpKD9JYCF/GHx/QsrlTI
         ZE5rOAeuvAngXBSr/3Gxo2/qqCcQo3nfnS8C9ukcROWELK7ZuzUbcJASrrtMclR9AVpQ
         1B4FJ2rtTE9OfLn96GZW03+mxx+JZgFffSlKf4uovYhVuwK/4EvZ/WEG0/FumSxyVhwx
         PSMg==
X-Forwarded-Encrypted: i=1; AFNElJ/8vou7vIdPTxfZU55Ucz8Yxeqr35bSNGFxOGIQLluSlwBvrfksdJSkRv5NXJiDoc3EVL0dsGBetqnzOyzDHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvpqb68EKk+MAgEsnf/we6UPBA8R0y4kCeGzKkP/oh8QAiwLe8
	SXRjGvTF32ny/z6b3+KymzgNxRTCUpQC+RcOoBTma86S5rysTPS9QJ2RBXeF5gyd5M/5XNwyvFZ
	/Nh2tSUgOQSwwvEphvB3u8FnzJRFjGLWox8Gqhsq5/lW98sj40SYQDAP08iogjRNQ3uFCVA==
X-Gm-Gg: AeBDiev5PxQ7PGGX5nFv5eog0aM2bB5hFTC1Vrj0ZDC+v+OD9Raappw75yl/zzajBZj
	61hZqp57tP1zUD7veQAEtK/WOEgyDIDV5TcrBngYEU+eS0AC227aUpVkaSJNtmQsN4n9nbZpnbZ
	5oI1dNP7GoLdH4bFZRCyeSyLKncGmRL970acbCpUOrIG9EQ3awI8+gk/mPL0KkOJYmUp3Rxn0So
	5hHixg4Ok25Kwl0Zy/Uf8aJlTIH4p0kmL7HRQFuY25zf8wAMFmfdHB0tHMWoh2HTxK/sqvbghdj
	uSsZbZQc7jNT4xz6pqx0+ZvSwGseNU2HW53cGn/2i2sOswBTLaY39sAOHG+sf1C13yA7WNnM5Ht
	VE+IoRd3DgAzec/eU6sa0iAVFXUvJaV0RQOEtLM7ic2DkYRNH9tTgFk/wB7Sq8i+ilo136Kd9d2
	qY/TtCQMZ6zwO3x1fR
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr21456629eec.4.1777253568721;
        Sun, 26 Apr 2026 18:32:48 -0700 (PDT)
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr21456609eec.4.1777253568236;
        Sun, 26 Apr 2026 18:32:48 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e79c2954f6sm47558002eec.30.2026.04.26.18.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 18:32:47 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: watchdog: qcom-wdt: Add compatible for Nord watchdog
Date: Mon, 27 Apr 2026 09:32:36 +0800
Message-ID: <20260427013236.231841-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69eebcc1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vLXAFcHGVjC68m0yDQIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: fNDrmew86g_J9FOq3fd9RTO_6w5JodaW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAxNCBTYWx0ZWRfX7nsQfyk6HC0a
 nj230Y4TZo8njYMEf3ECxgaUWMdGhZh+AuQMkfnw1D+ZRlBbLcwPKw24K/9X4fS0GdyHYGu2AsT
 Umr0zXArL+WDgnNeI19xjDyG+gWU2Rr8NQ5JBm/KaT+LoyE1LZYFbHGKUz3pfJXDHEIcbOSANcF
 kH2+0o2MT66a5Blixc/XLv3XbbqSLpBDOp6X9xr8MbrTiRPaJ6MPkjSzG0QKDbNmOeMNvizuLdY
 PHevoMAJ7JLRdK9oqyZp578Qoe6RM/dMu6gSlCil/vweX4E7wu36eS8tW/1wrKDehk13diSjslK
 xybDEI0h2sSkInEvnRgO4UOAeuVeI2x3lqGqQv3fDM4iaLkK6iF2jfwGkAvPWWI7xEScTB0Ql9/
 HyDm9w69jzOOHDl9JeqpRRjDe3qoa+/VjfEXP2ahMEkt9uEDdipve4p24iKP4pMY0BqYsaw+y40
 j0yoprTJRSQWswTb5+Q==
X-Proofpoint-ORIG-GUID: fNDrmew86g_J9FOq3fd9RTO_6w5JodaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270014

From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>

Document Krait Processor Sub-system (KPSS) Watchdog timer on Nord SoC
which is compatible with 'qcom,kpss-wdt'.

Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Changes in v2:
 = Improve commit log to make the compatibility explicit
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

