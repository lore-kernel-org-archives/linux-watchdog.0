Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572374;
	b=fxqYhfGfpE4w0L9GlsmfVlYSv7A5rXqx5PX0dzj6tIvl7DWz68gixAP8PqdZi+5KcIwi
	 mvR2khTfzrtVglDAHtweRzEwQYA9Xu++bGn9y+KDNWG87yWz+P4Dvsgy3yvmF0ZazcuWk
	 2Ylh8PXAkMLy7EkSHgSyo7jLJWSNVlAUUPuGx2QxI4yF2rZ08I71QyfshQ+OHeYuNVtg+
	 9RqP9vfb3X8L9fr/UCZYAN6MF2Q3CCLVeGUP2eoqqT4HbXMkfgcX4T1MkbBNKIuCFgjOW
	 n4NFPExUJB4OyiqMUbpThe0ZZFyXRVWwMbMfnnoCUe5JvhzKoEzjOYDjS43SB46JI9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572374;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
	b=etRaeZiRFEcpoDLmAQfEndcbA04jTSfW94gjmfc7rELtiHMEPfnzLJB0tf3NL3fUgwUQ
	 l7T1usOp6E8rqcvEDRCCrM7rL1Ki4B8jCHaJMW5hj/aiQY4SX+yYYtZBn42QNpZi3M2aq
	 NO367zHq3b325GvHuKC+W22imlc/MtSo9ymHBbA6Xnx5uNxDJ0n5LygAstYsesox/KDyL
	 H/zeMeM2rkQViCIdS6GApqg5X4HMU0XQCPRVMJ0LfkO56TzMoVQDX/7/JOcOtA25TOEGP
	 7tjnd5cPkIQ+sQY/rUA4kc7PM7vmoXxJLFMBdtmgvie/d8Mbh9SnUsMw4Ck1fgjDPLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FrhoC+OM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A73d8pz1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217ED606A332
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 217ED606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FrhoC+OM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A73d8pz1
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJQsV1525303
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QRiXeo9zMwX
	nHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=; b=FrhoC+OMLohCAfHhW9LHtnY0nhn
	tsSnndN5ygSt0Ud/df2WDrFtHnl/Q4LJHMiwEeNMBbrQ3+neP7PM0STflzcYG1/t
	dNQ8gDrvcSkjMqT0ibPFnF4sVPKtuUv73kVcO6JHHxdHMGYShDbReoPoplyNIQAt
	jyPo/OLqzpBFiDiblRab6aICcFpie7EJn5rc0EQP9mvv1RewMrO8KKAK/wQasIw0
	5WVdodYt7wbnjoFBTeFwmnvHmW4i6Q8GusSs90jRLxqCenC3hZ4RFoA09+RNnPeH
	wbqwuCKiSq2n4jRqS3uipI4W6HUToR++cP5bJ/jmkKZmXlnZl23mimawKVg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g20e1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36de26cb4b3so1123815eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 04:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794572373; x=1795177173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
        b=A73d8pz1e/zIYugOWsMKDFm8K6CWMq2nPhngXmzYXjPSshLgLbv6nKWPYQEwuWvalN
         t/g6HMgH9tzOY+cMNTxw8twUtPdhFYPB4xgw8hmPHhcRnqmajKGzsmQodi1YnqfnkrjC
         HlIPsqsc2AIEM8EKOPx14XlUZgTl/7AUdcvXJZlDBvbGfB6xA+rlgXiu+E1ybVlkmhfJ
         0MwQdQpnJTSL5zKI3LHkAQvW3LeoCLiA5en+O7vXzwSaFOpwq79R+KPYOhblkfLFJf3B
         RuTimquERCk5Xmqt2bvgnnXK+o3K39IEsJ9vrpYd2lGeVHTQNlQOj7HmycU+yiLrZEU8
         6lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572373; x=1795177173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
        b=ZrIafnnHHqflnbUWklkMpoG3bQjSuZPcaZiq0dPJPEWnXXlc7G7lihWNk7uUdVEUsU
         +QbwHYu29SUdA3LiQl2dMAC1rYxi2D24mHLaZjXTQ6oZLGoGQwGWOn/9ViOKaIvug1JO
         INq6dXAiwuoC7svN8HpWDQKSfVc2qBYYOhLpM52eTD3jCONWo9BqJM/mn1kpjFm/OGZI
         IdeCmAuET5yD8MKXov6fxdClTdqgsrjWhJLIEYC7ilmXJDtyCcXATlRW7VE/W07mcrLP
         dTmsItB4aT0fBqDgyr7OSMsV0p+hr9R82HpIeXNWWpWwDMALm5T6gKwC1kHO1bDH9rN6
         Lnmg==
X-Forwarded-Encrypted: i=1; AL+hErFrFSjCIJUB6thdYRcVEtG2ig94U4YrZ0nJYIVPmknxHqlXEGHw7YwbmD5mbTwZtO3pRjZ/au+heiNyNwvizw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NyMbR0r+RAjio613YNoEJYFcElF2+ySj9q3YF+WygeRpmn7yz
	HCLOI6Vco2Cah76rFO2hsye30raqyUngwAseoZsVsYXO7cvsE/PDQq9SkQGVTlcU55BVs/ee+PB
	5IdOAc3iGC8V/b8ameb6Z0h7qgzRFIHuHAn+pfquGErK5RHlkNfgX0Bxep0TDA17zaKnoJg==
X-Gm-Gg: AYBFou2vKF+2Bj11NwS8Wc7VOegngRN9lle26PAlINLBwkCbYs9B+l3zAMUW5RHq+lc
	OKW4HUACggk3Q4v+WgIZNXFpqLcyZac189Qh37GTCQ/1VU2DQXz9Y1eMUuRrXQ76JjkDvIMZhjC
	7GeH2pfTaS/yi7ZzC4YUuYlsiY5zDoHh/7NefqvO5qZ7jYwoTzLZjL5Q54hJMwNCwguhOvoMCMY
	0yhF2u/AAPG/nBv3VsOCOY9WVOMQX34mr8JD+p2HNRBW5ev5UBJlNOUmmu8aA5SYSW1Her5SPd9
	Mxs27Q5BLEcm0gDHfhcCswNwbZiD47jt2HeccIlNnr4dU+nqcCISmbj0kMNDR40jdADg1RTHkmk
	yRwsBNN76U78Q2uo3Avnrs35lfR+cs1mzn4MJLBxCg/7BbNBRX/z4bUcIauTYnDSH1+JRFA+ATg
	RjeevpwZ/H0Q0yEnZm9OrkydrxZ2wc78nZCYetT9DlxTjKyoOKmlTMjyniDlXF
X-Received: by 2002:a05:701b:4210:10b0:199:e38c:29a0 with SMTP id a92af1059eb24-1b50312e577mr2414319c88.31.1794572372731;
        Fri, 13 Nov 2026 04:19:32 -0800 (PST)
X-Received: by 2002:a05:701b:4210:10b0:199:e38c:29a0 with SMTP id a92af1059eb24-1b50312e577mr2414297c88.31.1794572372124;
        Fri, 13 Nov 2026 04:19:32 -0800 (PST)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm6423629c88.7.2026.11.13.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:19:31 -0800 (PST)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net,
        radim.krcmar@oss.qualcomm.com, anup@brainfault.org
Cc: linux-riscv@lists.infradead.org, linux-watchdog@vger.kernel.org,
        prajwal.n.oss@gmail.com, Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH v2 1/2] include: sbi_ecall_interface: Add defines for the RISC-V SBI watchdog extension
Date: Fri, 13 Nov 2026 17:48:56 +0530
Message-ID: <20261113121857.1640918-2-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
References: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfXxQ5Wm901+5Xw
 9y7lizF3mOuarbaJBu6xTPL2sOUCdu0z5Y++sUgVGmMf5gG8+j7743v5r7+kZFzlbnRrJxGvrvo
 /na8hcBlrctAQrAd55StAV+xmjVezLhEEJ6dQ4Vhwm3o/d+pXrbP1GyKqkxNOzT+PbkJyWqy31R
 VbsDs7Yj8Nn8GUFLgMd3wGf6r/RacAWzQi2RZZ0LVqzDeEQQduxY6tpTTySNFUqvMYSiemtKQJz
 N+7j4snI5sb5UrBV9pmvJeGhCoBjFjWKkX7hlkmDyqigbVtasFVA0MEHea318yjzXbmCXgZwmFM
 YqIqwUiPyG+lNkZspRGsh2yRI+hJSp34aqHKWxFxqCn5wcG4XPk26VkxhOqpJVfH23/fPy08q+M
 ggTEz204IDV7LP4qqu0tatW3BLXbEpZ8DFqtfKwVO2gPvw1fiBqOjuelszxFQfd/j+Tw0ZFGmmk
 u3jx26C1Ccj/iOthxpg==
X-Proofpoint-ORIG-GUID: jHv4qgcP-1N891R9pOPYwVND-NOxyO5l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX5xXAwd3WnTcc
 PvAjNzuK5IVbsJc0FnbjdzSIqbYyC2n28LlcBpLX+zK/dzYHZCeP3BdopIYQtMOU8FvRnqIE/HC
 Lbb1N8wUlnA/fbRYPj3qz7JOj9dY48M=
X-Proofpoint-GUID: jHv4qgcP-1N891R9pOPYwVND-NOxyO5l
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af70055 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=JCsno87Pq3fPI6XBcfAA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130048

Add the SBI watchdog extension ID and function IDs for supported
operations, including start, stop, pat, and attribute read and write.

Define the attribute IDs exposed by the SBI watchdog extension, including
watchdog capabilities such as MSI support and configurable watchdog
parameters.

Signed-off-by: Prajwal N <prajwal.n@oss.qualcomm.com>
---
 arch/riscv/include/asm/sbi.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index fd6266a7b339..f2b0b0c9f6b1 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -40,6 +40,7 @@ enum sbi_ext_id {
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_MPXY = 0x4D505859,
 	SBI_EXT_DBTR = 0x44425452,
+	SBI_EXT_WDT = 0x574454,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -536,6 +537,31 @@ union sbi_dbtr_shmem_entry {
 	struct sbi_dbtr_id_msg id;
 };
 
+/* SBI watchdog function IDs */
+enum sbi_ext_wdt_fid {
+	SBI_EXT_WATCHDOG_READ_ATTRIBUTE = 0,
+	SBI_EXT_WATCHDOG_WRITE_ATTRIBUTE,
+	SBI_EXT_WATCHDOG_WRITE_NOTIF_MSI_MESSAGE,
+	SBI_EXT_WATCHDOG_START,
+	SBI_EXT_WATCHDOG_STOP,
+	SBI_EXT_WATCHDOG_PAT,
+};
+
+/* SBI watchdog attributes */
+enum sbi_ext_wdt_attribute_id {
+	SBI_WATCHDOG_CAPABILITY			= 0x00000000,
+	SBI_WATCHDOG_STATE			= 0x00000001,
+	SBI_WATCHDOG_MIN_PERIOD			= 0x00000002,
+	SBI_WATCHDOG_PERIOD			= 0x00000003,
+	SBI_WATCHDOG_TIME_LEFT			= 0x00000004,
+	SBI_WATCHDOG_NOTIF_TIME			= 0x00000005,
+	SBI_WATCHDOG_NOTIF_MSI_ADDR_LOW		= 0x00000006,
+	SBI_WATCHDOG_NOTIF_MSI_ADDR_HIGH	= 0x00000007,
+	SBI_WATCHDOG_NOTIF_MSI_DATA		= 0x00000008,
+	SBI_WATCHDOG_ATTR_MAX			= 0x00000009,
+	SBI_WATCHDOG_ATTR_RESERVED_MAX		= 0xFFFFFFFF
+};
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0

