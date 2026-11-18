Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993724;
	b=Z43GcEs0Ar2Q/qnD3LepjCnJXQzLRqRcVSHziOLyG375ZoqbySGXR2fzHLcPqTG9aWgJ
	 dBWLtK0Msvki8RuiriUHMceeKgNtC95ezVbSBjWBz65+zwuvFgWi81jEPKSWph4yZN6na
	 8b/1nacXltqwt+RRQLTEGB1aygYTtZxBtiYbqfa1Sr7oSFqGw+lqqTcNDPuyiYYaKI1lX
	 YW3IivO12ScrKDkGsLBrh+Xl/epPBxeSbrkNL5AhyPEXyjWXVRDq4k2KOzeqgQZDRLy/A
	 I704Qf4uZkN/inhgAVXER5yv3ovfoMjJXhK2gi+RLT2SnE3pLUeNeMqRa44LBxRGDYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993724;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
	b=LZBmS5bETbhzQ0le5jtEB6n/nn3QnypKNvmSYyf57Y/9br4MZn4If8qnRqWTeOaRhuj3
	 Si1GrE+mJN6UvHsX1l2rqccRpfNF6WZ3HskMH4V31pVsk6r7TXS3nRAOYrCEskBs6Axqc
	 Vu7qLuJtOf2mdbgsAx9Fs7tSEUj/hHSnOW+xM87qCDoreuC7k+E1jihjlO/j4SPUnG6p8
	 XKpZ9SCu98+LspSKY1DIj4A8f1w/aRwx7OQfy5TGa7AHHjFcOkipQd4cNFDwxsCra7FpF
	 C3cRzeE/MngPg3WF+DK5OMgIuWkhwTx53otf/oHqWKbHXgRYaSb5xKSpuqbMTEl8rBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bPnHchSI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ewFOEhyw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3D606A320
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC3D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bPnHchSI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ewFOEhyw
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8MJsE3371230
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QRiXeo9zMwX
	nHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=; b=bPnHchSIw7DFE82b6lZrJvQD+W7
	xpwVnP5+/1XSne6m9lc/quPgzd7oayERc7YApJNgv/NpuDEXQ6CFJek8YcRRqfuM
	/FBE5rcQFZ0pb5yDGlMypcdHtCjnjOmrCx0wGP0JOtoOV3pU5GXhtSSyJuscrcKk
	MmSkOXHC8UeqIkw/OfHaaj8ncD+9VKv4GP0Bo8T3XeolnI45QNjGdhNsy5yLJ8H2
	G4DXLrbeVVhdCKS8X/UWDz4TtEV3/u64Zr2LXoL2QzZf4P4MK0CxB1zEulY8Cg49
	51MxkuMVtpj7DLzOOZ1yQBnotWst5X3knTwE1OD4kea8i47N2E8rWdAx9eA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8t8k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:22:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38131260a5dso2383438eec.0
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 01:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794993723; x=1795598523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
        b=ewFOEhywbXgJps6+YMtRnIGrCTHpVPxTv8vOG4Yfinzxqq/bDSkwRP+tGe2szn8UuW
         2lfYgYZrnjtDNRugbqKhe6GNcNHp1iu8iUKvhvxjG4zqRWt2R5NVNgFAk/yJGlYivhPa
         oYNzoo69Cmu2QxJ8HR/mfvKA31lF5tynEZPookyZY98Fj8bT0MQlHO4IQWPPHxrkFUAY
         JudFk8R/eTYw/0jVwkDxTz3H2+vhCmUNDian7+LvxLjWpGrHB8rQKTf3LY6slQPF2EDk
         QC+Hr44gToWoqaEVtz2k5406D2la0QkMw4xPJYfTNLTwH2ivZutuoZe9S+2NklBuesoA
         RUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993723; x=1795598523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
        b=aetFxRn7p3BZbryeFHzvelMd0nefZwNShV8eUmU0PZZZ5p0trpnHqL6zf4VBe4V5u+
         lE/YyO1cgCXRa0V/sgRyTo55sGPTYorRHhZekE50/uNGj5zaeKBTJwVKYc9mpER2NGk9
         QBNYK8ic/HoBWjgE48yZmU8cIEyryeZ7yhrKI7QNgEfv9IuOf3GnHVZ3GzIKTVIZQLOp
         TJTdZEH9DR/UwjmW+v6vI5WuKl6YAQS0RsdNCYr45LElo8VKoYeaE87BJv7y+l8f2D7G
         vjN67+SUsdWXyzEa8409ig5MFhK853kZ4FAdj+OYHaXV+R978iUMboUdeUjqvQEM/i7+
         Eq5w==
X-Forwarded-Encrypted: i=1; AL+hErEsx09JT8jE9Ex0FoSKh8ms4w1Zn9nrbPnKltzXO/LarV3L01pYDXuFn6nbpFM+IiQuY/pwVT6OHqAu6zZQ6A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QE4odvJwM/4QUE6Swkvau9ky9FJfj/eYDgKLl9Me0HEHarEa1
	U3Aac6wLt2A9eBQ9Rmq1jHtrV7T4Ys02Ih9zSeHy3AbV/4fNNrF9En7vicQMD6geCQrLFO5NMqA
	jmU6nMlcJ714fbKY/+CHedLrQVlPVPKvkQMAHZSguSUVnJ2es7g7lS1hjp22e5YqAXwmpgQ==
X-Gm-Gg: AZFdTZcbzXLfqcVaZ+9bcHGC4onv+Xk2FRCynPOr7x3j0vGaJE7oMlfEKZOiUCp52h2
	6g8Jwtxj7GcpfFq5sllWOMesQyQJ18qJ8SiT81BXyBXrJTygqMYzHwCu7wnSiqH/qJktnAUoBiG
	PKe8MKYC0HPWbaw9nPkH6mNmdmvrtj0YCS0/oH602r99K8dK5nINEc3x9L9UfDsyKjH0deNsU+G
	JUIxBPGgEjOWdmsFKWSkyZGz7itNdCVAGv6ohK3llaYlum0zG0gJpzA8DQ8L0QUaV9R06km5CPB
	JOT3KWACI2SX1D6MGhGqglA+Nqu0CB8v+0bhNCwI+k0JSsyRX6FeV33NxfGkbT7iAUIptrIawyq
	SDTJko4CRjbcGW80LcfKuPls1KcB02CUq0RvlSZ2oUNDWivCIb9WCOM/SXSkPEfoth2ot/GUncF
	bMMFB34z8+qJXlGW3gHOYzkpRSzQF1M5WH2UifRiwQ+a9viC6BWTj+ata4Ju+RIQ==
X-Received: by 2002:a05:7300:fe4b:b0:36a:1d6f:917c with SMTP id 5a478bee46e88-3828036f24fmr2247990eec.22.1794993722572;
        Wed, 18 Nov 2026 01:22:02 -0800 (PST)
X-Received: by 2002:a05:7300:fe4b:b0:36a:1d6f:917c with SMTP id 5a478bee46e88-3828036f24fmr2247958eec.22.1794993722125;
        Wed, 18 Nov 2026 01:22:02 -0800 (PST)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm9194334eec.5.2026.11.18.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:22:01 -0800 (PST)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net,
        radim.krcmar@oss.qualcomm.com, anup@brainfault.org,
        anup.patel@oss.qualcomm.com
Cc: linux-riscv@lists.infradead.org, linux-watchdog@vger.kernel.org,
        prajwal.n.oss@gmail.com, Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH v3 1/2] RISC-V: Add defines for the RISC-V SBI watchdog extension
Date: Wed, 18 Nov 2026 14:51:46 +0530
Message-ID: <20261118092147.2017658-2-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Eu1HPicA c=1 sm=1 tr=0 ts=6afd6e3b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=JCsno87Pq3fPI6XBcfAA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: ULMYL7RcYm_afERRPuRVZ81wFZQYX3Cq
X-Proofpoint-ORIG-GUID: ULMYL7RcYm_afERRPuRVZ81wFZQYX3Cq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfXy9BC4bZhZOTA
 I1j9iYzYnPRlG1I/51dulKR4du/t3hCuWUeOK216T/YnqoCTavDRnvk3I/v0XfY7PS9G3YsBSNF
 B8uDsI/jRlfO3+ss9GKz/YQ+gGfkUzdexgQQuP5Eedp27TbIHf0ugW5brVvCQ+8f364kZI8JOx0
 tKiGXctnQZAbcZ83YnmGyfDiCR12Q2FheF4ZbmOtw+ArcCUSUSlqoqDM6s351nMcirHPmADarpy
 AEvFMj6Sgz++DyHWfYlYEkLRa9B4Ugna79qzrvzNXJf38f4dw/Ta9/0xvgocIOS18LDIx6m8el4
 NMaNNkiVP0FWrYGXQZ01aEQcI2B0skXlNsZv7/kQbKpxA6tOiR/VkfaSsYY4Hh6i/PX3LWXtWIL
 j7ai0ruMq1coAA/zMEKOIpv2wvtUlbNKjXsF5IH4usl4l9ro557BD3c7WaKF5KN4Bu2mvFoysjp
 IfCFBaIzDNk6Oax4aAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfXyWHBeJOe7REh
 2FJ4VHVKMOMt9UP3Bjw3Z65WXmHq9FoL3abuzyEanJtUGoIW+1Qi9CYb6rzUSUK9liQYEqVFOud
 EOCCktYYsoZkUZbg/v8NoQdBuFr8mt8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180037

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

