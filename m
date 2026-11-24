Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526161;
	b=gaoa/ZpME22+7NRbPwg3LW0sv6cldPdjrBibVWljGva8YNWerBk2rDAV9vIo8MmE+R7m
	 TwFUIyAjheSzos85IZE4eYkr+YJdlbt0+wmqSX+64GHEAorjn4An3tV6P/CdHYAyDgiz0
	 GIxlYGL2lFT1ylohR/9HzP+PGsAD++rf2jsRLIII7TU9aXdBk17ASHWm2p1MujhLdnXf7
	 7BPtZnMUM2KPbmCXADw5GrfmmfOtIy1wFnXsaMDxU5sutc8DAgF/1aqrThRXPQuSr8IpF
	 Wtti5T3zCofmDG6Fr/Y+aL+9fPEDZdvX0mIJyWCt3NF3Yj3XMRaEZgzhZ30qoYUQ/gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526161;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
	b=b8QC7b3agRKp+Z+l6qpXqOXJ9rqLfXPYBlh1CS4rVoJLK0wQkGeTjt7qExcej864Koec
	 8A1b6OjbH4il2Hw6BRXacPiwApDDoaB728e1ZjAVnS51/7u0Q24u1QBbF2EkZ7mrasoZZ
	 hYkPjfMNUnIu07RwbLVnF/j3QxVDL/PWxRiv2g31jqMtH18nWd49TdcusRhY8mwxDn18L
	 IMTHCHzbeOCd9unkSE58bwZJ3GVGYBDMRNjjAU8CTIZcxosX8D2AlzOuN5aqg1psPfodc
	 HdXL4J/OS509sUv044n9k5CsPkfOLEsXsrEVDLMbXxkLhCnGLF19AbNhiNjzpFfFlnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RkUfu4I4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aAHDekUb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E6606A6B2
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E15E6606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RkUfu4I4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aAHDekUb
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AODAspS1408458
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QRiXeo9zMwX
	nHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=; b=RkUfu4I42DsQVz0A39abPrm8qSQ
	HvPzDG/XfgFBHW8ORhh22QDohUDYyar/ea7BsedscqAZHUbxNcj+d2hKD0IhXgsV
	t2wfvCrKNPalhhgh8ng4gC596NYnOlglUUmzzJ5i758YcMQh15sjPWOP2DkCXWVa
	EjncaMi2Zznb8N3k3Lui3b5JNESuipbMfSpP+Te3MIiXUHseGS7Pb/BlZG+7s1wO
	6lvo6ZCpg4kAVDkb3Hb0G2GuC7OVTe/TXWoVP7RCVi8er5Lmb3nyhSJFdg+G2UPf
	axLShUD56m6DUK72tVhimSq0zxGlXaaXbH4NM4XDwRkKFgcJIligFfZX8UQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b8000s5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:15:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386ad819860so2177338eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795526158; x=1796130958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
        b=aAHDekUbFoBTmPmwEWxRALxKLjHMg4WddSknN8v5vV8wEjGgL3rKNigybJ55nTRMqy
         RyCGc+Ln+XZpw8xuv6JPUuk5OuBaweXVZeP9sIst6I2NdXnkM9dbrY/VllQFGuRUo5Wd
         pJ0QJCg2t5LDPcUPjq0gxxUscdGY5lJWpQfwvn66h54CHTyKtxAR6Sb6a1jAgxEzmxkR
         dTWf6cTfBIdGd9/dkHPH6NmsFWET20sD9iQYcHRa5gChB7pcSwA7w3mrsiRudGF14vhj
         t+1c5cqKCxUK+CoZfEG+1STtFeZ4psOy1VhawJMUGfcwZ1CY1VboS3GNDvvrrCJf/VOE
         631A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526158; x=1796130958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRiXeo9zMwXnHtKKt3Sdkom7IzkBk+J68m3DqMeVlgU=;
        b=BdddcY56eP4znu2AdSNifVCcVXiY6+1608g0tZBOu+P6bS/cc5tiS8e+dghNBeWahi
         vd/gaKaa/MYCMNm6yzNK7ddQtK9PEVuN6tLAytFlk1J4DNz3gGDVpAAbZH/kQjroDAyT
         nnBdOCFJG/phJHmjtlR7AWyOSFbe78myR56KEVPWDtfODLsQamv7Llzxt6IlBFqzo0aW
         73qlqu4KZgFoDFcz4Y+47fQZS+pQwtpj/ok3rV4N72MhziTBViW0pxZaVh9oM0ClE885
         teT47oI3IWVaogdd9Pkv2rWTHd6YUYzzbUtHV/f/j5rrTgf8zDpBhfFUerit7zst5U8M
         xYiw==
X-Forwarded-Encrypted: i=1; AL+hErHQy8jX/SYhAGfp49NeXcaxMoF4GY+IqfTPqFuHzV+eiezdysCpC6usYyxrg7/awXtPA4w3B7ccY7WsBcONWQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z980uOSSdALq6AdGsz+IacR5ZvwDmYS45rNCwwQhpNtzYaTaPR8
	+LYoonlrBeUevQNbg6/L/7dlSCsUYLrfYNdbQhh/X93E5aM4eiVeNBuJe6u+tr2SWXn/WLLzN2h
	W8kszvyiMs2OesgOEbX6RwVXo9kgvJfq+9Q+OyJaIRzx0xVHNVdeOUNpUXc05zDylyeEWTw==
X-Gm-Gg: AZFdTZe1wZTbObmPCEN7wx2vZRuEaVDv6RPu96pJNwBvFEw5QydIQz5h+I0UC9MqyVs
	v2MWkIldItUHPfT9kffaNZ826z8SY1epqipODHmnfC5yga2a3HZUnEQPgtF275Kd2YXHCrvSaZe
	MWD6/kvrQCqdcoGWAn9X/2u27GB7NjzJn+puRGdO4bShbh4BphOzcV4fIQUIg9mpwpwZRvvNbMS
	qtZdWBUC5mOwbSzx0JOddd5hsLZm+ZzAe/hHvOgi1m1ngPLoD/cBKUCUqNWN+wBl8eNIfn+HW96
	4wjpaxAS/efXJ0T0bWa/2hQw+v3jyk84QPFjFMbJFbcinnghzVGXGZ6FFShM/qu0gfsbluba3/i
	F16ujZAwN6zj+fsm3Hw9oQJkVjyoHY5EZ0M5ZMhSKimmV+qc10Ww9Osh4dEADl/8yrGF+rvCAG9
	BWhjboeRZfF/kPAL+5SyIWXIpNNitEr+bMVb0l9YSqOx/O57oGNirhdQKRwn7t0Q==
X-Received: by 2002:a05:7300:d090:b0:386:8bd2:da2c with SMTP id 5a478bee46e88-3868bd2db9amr12860646eec.2.1795526157578;
        Tue, 24 Nov 2026 05:15:57 -0800 (PST)
X-Received: by 2002:a05:7300:d090:b0:386:8bd2:da2c with SMTP id 5a478bee46e88-3868bd2db9amr12860609eec.2.1795526156998;
        Tue, 24 Nov 2026 05:15:56 -0800 (PST)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm56371320eec.4.2026.11.24.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:15:56 -0800 (PST)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net,
        radim.krcmar@oss.qualcomm.com, anup@brainfault.org,
        anup.patel@oss.qualcomm.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, prajwal.n.oss@gmail.com,
        Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH v4 1/2] RISC-V: Add defines for the RISC-V SBI watchdog extension
Date: Tue, 24 Nov 2026 18:45:41 +0530
Message-ID: <20261124131542.613271-2-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124131542.613271-1-prajwal.n@oss.qualcomm.com>
References: <20261124131542.613271-1-prajwal.n@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MSBTYWx0ZWRfX0XnjTxvrCnP4
 aEINu0ydL8ffKj99PjfjF9h4sNEVeb/7Lc4Nzgyjr+jR4g1azKKYqr0n0RWZtmEy0J3WrgKfrNm
 t6juF3gNd0EgwS5zb+VuvSAveaYYWu989X1ryyzYwlOhUv3rLc+IdnEXwIcIdeWkKvdKygOtcwB
 Qrnla3JBdlhnVQbKDgE3kDNAtXIgnu27LX4wA7RSpvW8ZW1ktd+CBLsOrpTquGhdOfzq6kGbUHl
 OJZp3mZ3YyzKcdf/T5Qt7Q7VSW33SzEQS6l19uS4opsrx1OTTW7x9d4pJPGq5iAs1tX2mxBH5ID
 X0Qgk44xBJKQuEkJnq031zrPyc5cJ0oHkmvenoY7rdz/OWrGQZ2L7h98Op2t3NCA2mns5H3fK0J
 p0FmJRWmQeTfUvye/DUFzdGJA0gKuKE9Za1wKGII4e++9DfjVeczwo2ZFRC+9XjGehscQArTuG2
 9zTuF+VKlU5GD34m5vw==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b058e0e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=JCsno87Pq3fPI6XBcfAA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: l3uwjyMMQCBNbJa1w78wOKMqPaiKF3Le
X-Proofpoint-GUID: l3uwjyMMQCBNbJa1w78wOKMqPaiKF3Le
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MSBTYWx0ZWRfX88KAkKbGuLS8
 qG7BhP+/zPHj7+Ugz+fz6ofuwd7ZhPHWHytaqiuDNIQBkq5VZTwdi8zc1KrYp84rhP3RP2AN87u
 CqeU+zFM59LOQV/fB2tAESYuda3QkwY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240051

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

