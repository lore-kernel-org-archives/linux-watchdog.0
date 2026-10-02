Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514833E49D2
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959097; cv=none; b=JZFzlSHe677YbryortfXkj0nZaoboPmB03RSpPEtpBiCx2R+gBTHC7bh7KsHDTeBVkP3FaxTCUTplDL963nxgM6MPxDw6kxZrfx1rgWDK/oPeAP7zkMn5HrlOJLuAGPrRPb67Qi1nRudxVZo0bKHHCSp4EieFoDnHxjqvLp8cqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959097; c=relaxed/simple;
	bh=+zmHpDxGzsgXIbjLeO+2/jn14t5d6rmiuLroQYwwOUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RktoClyHyyw3hOkVe/XgeHsc69SwWoa/JB0j00wlZhgkvN2cAsfoHBRloHcmte0PtucaHLzL8bXkK23YjhShS2SFU50GOFMqLpMEfUdSMufT2VJGcoHj1rGKuT2okDoeDOAmqRNrn3BZ4ucEFdNoagkrY4OnFyxEAh+Gcsjg4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p2MstG8C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VtxT9Nu6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p2MstG8C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VtxT9Nu6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692FHKNI1246899
	for <linux-watchdog@vger.kernel.org>; Fri, 2 Oct 2026 16:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=e6P8A409W54
	xuekpmuoPC4b08ic6FRICkqYkILbMjjo=; b=p2MstG8CMvZ02YFurKyDitqM9nf
	U2vCwtuCzEBykfyi19gxp+QnUJlA+lzWLq5yzznJaj5foXNCKsPKoVJwA5Whai+P
	EPIxLvhm34VMeQ+jzIU2KLkyeX6kCLwJz0cQWMwfMRoqgykMznozDbdRKXgjYD8A
	FOVDQAxgxe8CjYkvDhH5iqdxKGWp0LCehxtjqUzL95CdjOpx9zRCJ2n3kAMFEWdT
	ft379YP35M76qZPsyT3lSOvIIphQrx7n0E+x53IMG1StnFSIdGSaIDNfILZsvtAu
	MLJlBRCNMLz5jwE2cy2FknluH1BtpHRPxHmb2b6wQPMHp6XdQXi5u2+tX5g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d8c08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 16:38:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so15075087eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790959095; x=1791563895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6P8A409W54xuekpmuoPC4b08ic6FRICkqYkILbMjjo=;
        b=VtxT9Nu6JQjU5VPDb27HL45tSsz2Cos5H7SjC0viOb7xPSZECuQJKzdQMzxu/0MLLo
         nJ+lGlV2+V8sR1Ca8IQdGTYJX/ixTWAX6mEirnIarERukHB1jBk0Fez0Jb4jGsksSD62
         1rXRlLdhK3+thwvHKk14nJCNYd+KjDpxbbtaiZwbHyhbohxjnXWq8aaOwFi2XuGAYzjA
         UrP50aKFZcCRAObrpKa09fx7vfwy4TaRs5Bv9pySmjtkbterMRpu7glKEyjJvMcKyGxR
         72V8ycfHZvyxGXBnRN4EAqV9tONehQVzPyGqDwLK6cz6BxR7KiEy57gMSDMd6LxjcjPn
         qaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959095; x=1791563895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6P8A409W54xuekpmuoPC4b08ic6FRICkqYkILbMjjo=;
        b=0l6S2vqstEZDttbbdekmM15+a2KWKyZkcMKIFcl5mxw29in5BNnTZhQ9HZvSpYquQ6
         /F8k1Vw/Efe+GwMsE8pWRbfQzrwWoQyeot9wqkRqJ5Z5HFYhnkLJvfi2tY9bkA9jZKq/
         IKNuwzuX9MFfUnfvNTmkYbodynjvf0F5KrlWz6M0DgtbxKAbxcaLqHiyAq6K1tn4j7P8
         SLsEu/bHc31hKjQnfgis5DqqKBxxqSqJihD0OkTDptPUYn2BPTvUfm5Sx4kERFzKy/6V
         axtG1GqUYxfXQI5x7Dh1c3Y8i2IW9uZPMVikfwqUe1hylWpN/OgGC5//mkVU4eunoe5E
         PPRA==
X-Forwarded-Encrypted: i=1; AKwUvBxMUWGu7nI4F7dICn0nutavyyrOr2KlDPjvxP9RJlsmG8ljQZWeptEt6Pstpk5Vh4m/t/Jw6drYBpOJ7u7bew==@vger.kernel.org
X-Gm-Message-State: AFuF++lpedbqWJ+/V4EWfXZnsHcCtdik0hKeOfEMd4rXVC3Mw4WGGtGO
	/Vb3BtcKZZuLBUGw7XWd51Ib2IKJ9LhqYnwISoYI0I4TetcmEciLiYegxpHR5dF81+HfUVzwd7p
	NgxP34f6npDBnaFOTGusbiFAJg7vCUJoNIzEhDGyKUkEcLw/6reqLvBAPYMP0Nd8XMwkExQ==
X-Gm-Gg: AYBFou1Ts2zXPgGKs3GZE9/YX7pF+9bHCfelonUWpc1yZb5nWPfhFeVaq0y/e9Ic4jm
	ujnu9hhbAEQInY3G9eSS7RJBgaIJLJI6luOh7iPY9yg5awnDD1m29Hgl+D27IWiwCLS5QKp1CqJ
	CoBMqNFzD9jtP+nupgBn2bA2q0XAVA0kyPQN6e1eS0HcBvWLYp+IIgI2pruLLWAiON+b0GFfWKy
	8jhYykiZBg91XSPDLWtMGBT4WvXxzLdRrnczoxR7NQbbplx5n+VomBGt92X3rax6HKTiomKZVbe
	Jwz/APWbinNfv6az+oqjvtYKtkykjqkBm/mMEDmH37crN8gG4ZJrendsbztK5lW0WnWMhwOVE+r
	+6d5lnFQxOkQds3wRJsoQk0HGy05yVdrsT0h5dHbKop7rl8qfzAMwq8GQaoyKm5YTS15/riwoVV
	Ljr7nGcGm1xyYq
X-Received: by 2002:a05:693c:20c1:10b0:351:595:750b with SMTP id 5a478bee46e88-35105957899mr2170004eec.36.1790959094494;
        Fri, 02 Oct 2026 09:38:14 -0700 (PDT)
X-Received: by 2002:a05:693c:20c1:10b0:351:595:750b with SMTP id 5a478bee46e88-35105957899mr2169976eec.36.1790959093938;
        Fri, 02 Oct 2026 09:38:13 -0700 (PDT)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd5620sm7756398eec.21.2026.10.02.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:38:13 -0700 (PDT)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net, anup@brainfault.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, prajwal.n.oss@gmail.com,
        Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH 1/2] include: sbi_ecall_interface: Add defines for the RISC-V SBI watchdog extension
Date: Fri,  2 Oct 2026 22:07:57 +0530
Message-ID: <20261002163758.2919372-2-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
References: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1ObJm-nBF5xT1fqijVdQdITR7IWaQgOG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX64yMJcciIaqi
 Z4eCeLvHFhswlbVGIB+6Qvy1A8BvaqpwOjLUZdQW9o431fmsBC+qhEQPiXAp5LHQIkj2d1Vw8BS
 G+Pk4hOwOk69b20lNNhWbto3Uy4VW8k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfXyoM2Ms3sQRSY
 rQcC/u49Z22kbdPRf86iWWbnJHsHaLMy6OK5RYdekSgDI/Ti9JtsrurMATuLhtY1uZGXxy8PUca
 G/GkbwXBxdCyZj5kHre2sQdG3T2GPta7DuOLi5Ly/g6Xjaqw1wXgh+FRCaIiZRPJCYnodr3GY/d
 kFYf1/4Rq78r5sTCBDmHnoa+9IxYZf0BULOciq4gnFgUyGFLi1rFFtXrUdJr+H8veQetRSA0AwN
 Z1tUqhm12hpIcZe5/CizpSjpDG/qympW7miLjbEhj+JpSkB5NfYyQI8BN+GkDnUtP/juOle6Dom
 O1mNx7l1umly22DScfbIsAhr8FTXCfbJqMLZqgqHVSpBpl5aXnTe/fZghQjERgTiRMQWNQ8AmlL
 vwSD9gsvZsFBOC7s26yldAVRR18RrywCpG/0L1RQNcdPyl7gLVU44vJL6iHLI6fXpSGnqNlOR4R
 cnfI48d79p2GSUlFQsg==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfddf7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=JCsno87Pq3fPI6XBcfAA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 1ObJm-nBF5xT1fqijVdQdITR7IWaQgOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020066

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
index 5725e0ca4dda..b67ee507c517 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -38,6 +38,7 @@ enum sbi_ext_id {
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_MPXY = 0x4D505859,
 	SBI_EXT_DBTR = 0x44425452,
+	SBI_EXT_WDT = 0x574454,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -534,6 +535,31 @@ union sbi_dbtr_shmem_entry {
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
+enum sbi_ext_attribute_id {
+	SBI_WDT_CAPABILITY		= 0x00000000,
+	SBI_WDT_STATE			= 0x00000001,
+	SBI_WDT_MIN_PERIOD		= 0x00000002,
+	SBI_WDT_PERIOD			= 0x00000003,
+	SBI_WDT_TIME_LEFT		= 0x00000004,
+	SBI_WDT_NOTIF_TIME		= 0x00000005,
+	SBI_WDT_NOTIF_MSI_ADDR_LOW	= 0x00000006,
+	SBI_WDT_NOTIF_MSI_ADDR_HIGH	= 0x00000007,
+	SBI_WDT_NOTIF_MSI_DATA		= 0x00000008,
+	SBI_WDT_ATTR_MAX		= 0x00000009,
+	SBI_WDT_ATTR_RESERVED_MAX	= 0xFFFFFFFF
+};
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0

