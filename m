Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BE4F797F
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773353; cv=none; b=nRQ46Dv8Ef+WQp/Q8dHzL6LMICIzOzC/xeedhhcYnBqY2yPm8NBSYDhmGJP0VnBKQ2SCwvlCXNHfYO+UsCzDrvb8pGmG7Zd9Ggtca83HSIsqyn1idR1B/ty9vvj0jpTztmGQZcKzKKo2LL3+L2u2ElcymgCi2brPE7IYrdeUq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773353; c=relaxed/simple;
	bh=ltqw38oqTiV8y+kaD3UGw5jHFMwJC/FR2UVSSBuZbcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uMUqrzxlHGSog3S1nQK/Bhce680BtbyDj6ncgL65zKY8/W4IjeYm+vOLy3HyV0ihiC4Ogumparsp8v2SNqaX98Heb25uquliB4M+AbN54jkjLU3ydexbhNX4ZwrPwQntSxTJQIppqnGkEhvw2uXUVOOq9nr4qg68FiRUPCZFU/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7gX3Tif; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f4zGg2c8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7gX3Tif";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4zGg2c8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB8JXC2898178
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 13:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QP9XFcOlvHmKC+vLTSIEGZ4UPszljszOy3XO95ROkP8=; b=C7gX3TifyRhlLQzh
	WhDjWNEUw8K3PPfefOvxvtQKZGMX36mOp5j/8iONVfVmx2DlPjRn10iiD2bRUGFj
	6mOTseFpw8z6sSHNKWThXj7vDT5cd9IBUnOdYFpA8q2e0W0Ff8QeKQaqOkl8vNjn
	HG8yh5gaxp8vCinp3NDYXFGnZe1+VhMWRW0RCQJuHyecgiPIQ+EYqU3V+/4SKPjv
	9bJZuFwqnVqvth6ry85YNCmVN4UvuRUX6cTT5tTJ4s1FbPJYqzL9kjxHcE7+1MCL
	KrIGKhotl6SA3Qeqh8GMU1IY9pdvuFYy2alNlRn+H14TIGxyRtjfGwRlL5V/y5o3
	LLQYrw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn2bkp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 13:02:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so5606036a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790773346; x=1791378146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QP9XFcOlvHmKC+vLTSIEGZ4UPszljszOy3XO95ROkP8=;
        b=f4zGg2c8j63dZV2DwiWQM84tUC6aObkMHZ6tLdlOg30uCqu/3mTgANpDcNo0LPIl5o
         o/6a+SLwNN3ctiYLyXgpOJWj/5NeRzRNGbf/rhrtPzT5iahg8e702WOA2VNBZ0qrlhOq
         PsMTfFuyGgA24tkqDeZLiPe1I4FtauZ//3rYLxsXtmAvWw3Dnyn5tZXhP1AIdH4ibllA
         RSaBkUPJTfKvTgiBVjw1+7ET0RpGb1AsNoMYJSG9DConP4FF6ml1zd3gBZT4BnbRzjmT
         KVIPkOzCVAaaIBUsPWbLAM56A+BKi1Q93c67EKWwT+4ldoVfzCk7eJV3u7tBdGsbS2Xq
         aJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773346; x=1791378146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QP9XFcOlvHmKC+vLTSIEGZ4UPszljszOy3XO95ROkP8=;
        b=IaiRCNeWtOXBqfE2tsqgo3AIy38yJedZ/Xie+yy52loVfwMElCKfZfW/XBsxF/M75R
         xJca4/P5Tlqez2MA4wBp2lBFeTg3oDpnTRlThoqzqIoUUQbKcO3fCvCKtBH2kxfNyFH9
         q8i6275O1/KqTGl2iEpYtCEkqZJE7XSe1MwfwJeIZ02ziubRDNtjasOGcrAqgvcbnEnx
         QsiTaALbJ6PRYJOc+WdRH7UIjdVzWxSMoY8hRMp+xBra4maJ18td4haokFGyep3h0HeY
         RpeN24wBStGGDTv0SLPCkFTz6nxxzSQqlD4+2SGV0e5py1F5WOlUuP+yTsOMLYsZYyX8
         TEnw==
X-Forwarded-Encrypted: i=1; AKwUvBy1++nqUoKBfGFstT7ZFJd1elcDT0gs2QIQKWNk65zm70CHJXTyrqYH1kmFXWs4JdUGekWNaXGUXqy1Ebnmzw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIP7pQZNuMh24MhwiFa/gax+IRq2xWPoHqiqii9HvB7lP+F8k0B
	mwNyIiML1sK73YDIqcBFJjJHL6/oLx/fDRIQ5cMdVgSh60HmcdNmUyRRP8MlEBGKxKt2WJQluy+
	X9cb2QyeR4HaiE6iW9GB7nwtdvwXGgbQKProc83GeVRlDzaBqZB5xhNHCmbS+73TjfDI3kw==
X-Gm-Gg: AYBFou2FZ3cgwrZxD2nnkpFVKZCWT5CUtvZK1P9tBwCr2F8YTIkL56Uxk5mC2plpshs
	OYrovFzQxewOLMRxi88KZXfnIgwvXVIRgOnTAB2auoSDCpX5tdwT4vA6ZiExhWFxYcKQastU9n9
	zQ3K2c/FhxmTP4IN9/8uuTnzISAtpKcnjPzrwljpZNwUdGVBJjlqZYcdBE+ACqYarJaSxVZeT2H
	0og3owKIq741YSCmEJwwWd8cXU8hm2cW+23nMxIBrfEPVRcGIgb/+wFTEMmgkbEwJtgPiAJ7Pls
	AMmD1juESvbiZksYQUhKiJNGkQM9Nv87gtH4Sj7Ra9O9kUwJYN/O5PBKSQuw82cUbpGW5pDRI1F
	04pc736eVr225aTQ=
X-Received: by 2002:a17:90b:5828:b0:3a2:b04e:8084 with SMTP id 98e67ed59e1d1-3a4d191cc5amr716811a91.42.1790773345713;
        Wed, 30 Sep 2026 06:02:25 -0700 (PDT)
X-Received: by 2002:a17:90b:5828:b0:3a2:b04e:8084 with SMTP id 98e67ed59e1d1-3a4d191cc5amr716781a91.42.1790773344924;
        Wed, 30 Sep 2026 06:02:24 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cdf25c6csm3426058a91.5.2026.09.30.06.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:02:24 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:32:06 +0530
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8750: Add watchdog node
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-sm8750-watchdog-v2-2-b16fcda275d2@oss.qualcomm.com>
References: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
In-Reply-To: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790773328; l=943;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ltqw38oqTiV8y+kaD3UGw5jHFMwJC/FR2UVSSBuZbcM=;
 b=1ZFDBE/6DsQAfucDyg7dKzUVz5yszrLQ0D/OFGM4ZCxmjJt7O05roOsXlTrrzogMSJGRDP5+b
 cvoNw5cPy9LA5nJRdghB9QCyJYg22Fd5gn4utOt+4lYWSWJ3+IaWd7I
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abd0862 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=flqOiRKoU30ykSV8YR0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: DnwDqA1sgQ6a9pnFWvi2UC3gVtHmIWc4
X-Proofpoint-GUID: DnwDqA1sgQ6a9pnFWvi2UC3gVtHmIWc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfXybOOjQtiQsC7
 +quBikEQ3eW7EtOjFMzxdcXAXSap81T3M04UUxjp++aDCtPgrkVuCPM/1pxIDQL1znmt67Ippnq
 aP9QyEUnqmJ7tf277hJcUm4q+RCz4FKl1MkKKdeoUe8XCJhPqBUiaIk19+vYEfcxWGLnTDQJup9
 expgW2i6qRLFbqJwaCd2+VhCV8BuqfNQUgDm8T6an1HkECPSLM3cBSRXLV0VDxwHDasWC1LQpRr
 SSCZV4xmpl1R21BgZ+pT9pp0mVNCiaIg1JY1My79Jpc/edZCNi+fzICDNSqbQx8m+xMjM4Z3Q6F
 wtZ+0Ps7R60tCslcByFQcUgaTLT6ntiWNJ7Xax4lITtLbepkdyvNC3EljN8Dh/lboKMILIjU85H
 rO8li02yIYsuqa8boDNrZGswvtvxl6cC++eXLC8vGKwJxzT1kF1hwjqdrSSR3g/Fur/+BEyCQxS
 dFPNWId9sfOLujcZLLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfXyl8UANtwTiOP
 arnNN7UcWvkY7maowp5WHm25mCAmt8hNqIilRiBWl/75iBeGBGv+sy8Bu/gKoyOFAe6R2xzFZTf
 wEa1EzRlr16oYsn2orqsPJ72q/Ev9X4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300051

Add a node for the watchdog on the SM8750 SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 8ed5fa4d24fc..40ea164fcc85 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -5999,6 +5999,13 @@ opp-403000000 {
 			};
 		};
 
+		watchdog@16410000 {
+			compatible = "qcom,apss-wdt-sm8750", "qcom,kpss-wdt";
+			reg = <0x0 0x16410000 0x0 0x1000>;
+			clocks = <&sleep_clk>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		cpucp_mbox: mailbox@16430000 {
 			compatible = "qcom,sm8750-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
 			reg = <0x0 0x16430000 0x0 0x8000>, <0x0 0x17830000 0x0 0x8000>;

-- 
2.34.1

