Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9673E49D2
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959092; cv=none; b=C9NW/7nV6tNyDHskcMRHknlNtvHNoOD9WiL1m9CFkhtMvtwPUvbH874CDD7nAJ/ShUgl0Q1PjGOVDBDHX8Ogb9BINgHi5cYoyeEL0oTtOABOa9DFrDs7GmfAoBA2YDxFIAojITGZD/BeLLG4KBhL4+GK2a0stHZBjojvQBGv0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959092; c=relaxed/simple;
	bh=MlAsrFDxIio94Vdqusa9O1JK3xxR9DUssXgflYDQyYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCYqNp8EOJg1U/HCLgbKQRUK9gRUYrh46rzsfPBFCTeWkYhyWwryfrn5zVbHKvXIHQbyQiZFrrxqyHzSJ213ogq9KoPKdcc6mUP9osQijZf6HPmS71+HtRpnjcS64e8McfLvTksaodmE6OuETSl91OkR8lHUZQwD3RqJlmLwKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TXs7Llvg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4wOEMZ4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXs7Llvg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4wOEMZ4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692FGpDQ1246241
	for <linux-watchdog@vger.kernel.org>; Fri, 2 Oct 2026 16:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HsZcy7a9Otoosd4ozeXc9gj+pTu1VbaEtDu
	qjGWoYGo=; b=TXs7LlvgmvzWhXVx4prUXYbLtMmu6SEFeo8H8Lo48xzmMSs5kMg
	4DJN0uFP6x39mZ9lNDbjJ+kFiqyYfHi5w7risJ8Zc9u3/Wd9zX9MfyCLuUYUgq3J
	VnCdU3uD2051mQWn/30vesW0o29cBMwWR8MuvScWc3eYIr2w5bFBEeahYSMUaYJ3
	9PO2YvkVXORmATNro0Ia6tygRHhn+IwkqcFjz5IYOiKKOjlka8mRH2iwWn82s1fl
	6ywEJCybXF7OUiFrcPv585CLOfEJr7SU8GYA6G/Luipz/Hb6fHRKQ0ve2IpJ2V6F
	ZLdUW7GuFB+rN92ACTtlQq4VyLflqU4/OZA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d8bys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 16:38:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso2813595eec.1
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790959089; x=1791563889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsZcy7a9Otoosd4ozeXc9gj+pTu1VbaEtDuqjGWoYGo=;
        b=G4wOEMZ4l9vyBUEk8XeoHSs1i2AeUZhUmfNQiJs815ZEOvxGQh5J5gbSqyGD/bgyqI
         AxO9KjiYgcqFCX/4kQHFXh1ucmU2xXARRqfOgFhv9TiVGLlEaIP2sFL72dtXkLBIYEQF
         M3fqZbADMXMWqfumUd44gWeZShzl3TkuxsW2vmFH7xlL1848VzrFV/F75YNrXm40cq2/
         EDu0FcbWrSn6UGpO7Njgz8qxpJRshWFm/P+sOFK7Z6ROiVdMffcSUD6h7vgJl/L3yZzT
         UCZh+i5o5IMX0iuuBXjK1MpgGJEtLYOgON3A5FHSN7f7kVr6f4Ayzo4YRA5CHJ58USKW
         DlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959089; x=1791563889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsZcy7a9Otoosd4ozeXc9gj+pTu1VbaEtDuqjGWoYGo=;
        b=toeTRd7zt3WeuIIdCXoLy3Tw//oIa6eGBQei+hlkSNvBJLUopINhPAhcm9oZgUNv3H
         MxRbAItXIRnXPht2+BFqHY1mShGj/0JSCD4f8/JyDPAIQWDV8xLxwwVbb6DontaPR4My
         8ndK3FM6dPIASnIzX3ZRiSJZm8zRHDaiZjVj9FuCr9kFk3P9Oe1il1FPN7huhlKbcu0Z
         kROglBfCHesm1pPQ2O4W+p8WDyjAvJ/LYERG9AX0tNrgrWml/O9rjg6fxAQkGje5pov2
         6631ZKsBeI8BCayBlE5HtP4wGoQGWlkQ2iDEZ1FSa945nue53P/HTImbAEspi5BS8TJ4
         RKug==
X-Forwarded-Encrypted: i=1; AKwUvByBkEDsYZIPNb5Fg9M68qFYrr2pn5KMls8bWLoK9u/84DJ3lJnqYrQixZx0wcXEaTBleFUcNlpAKBu9CQELkA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJp1lJ0zK97prCcznvlqt1ei8dGUqnxqTDUMjIeSwLLMbVB3UMr
	9H092c+aGlhr+q5Mu+UAL67vy4nqTP43Ozas9aCYz0+6AdKSYN8HandwCz8yywavaFfxV58RR08
	XHKv4f/jcOWPrYNl2i10fdTsflVSx2KwQWcXjWzklDm2YnR7xujgP+a+O9A+8UplIXdO+ag==
X-Gm-Gg: AYBFou0TNcOS/kDHra9PeQ7l7NmLV+IB7KzKhwtWZzWX6Fvi8FhrfAUgh+l0WH18C+W
	VwGqf0XzIK03G+2Jstr/49rSrZEJLW7Pes1C9uiE+GdAyREXB5jQ4BZtSpMJjYrOk4O9G8BsBrA
	CMhWvMZ7G7xXImx3ExQlEB8fEvjfqKrWtjee5FQ4j00RaQNfB061d38rzDatpDdO+KZzfCoPLIv
	+ucvWBCjaTnwJ0ouMekc/V4YShU3XWCtxp2T5E6s9WgbZdKjXyVQJRnJy/F0ZvT5e7MfBxKTtJC
	AakozmlZClGVdA8I3NTX9kyh58vwj7PXps4MaC4F5pmcJVl5+4zyxKC9PY2RYRgUMxa+Ov8Hp2d
	TRL4X9vZ8Mlj3f/P6cY+c+FLyN6sp1KKZByacyBZZZzTwfMYnWFdjfWn0pTpzbSMkVM/eqNDNgR
	hkhjTv/l6yTEZ3
X-Received: by 2002:a05:7301:23af:b0:348:201a:6c88 with SMTP id 5a478bee46e88-34db6605d44mr6538951eec.13.1790959089081;
        Fri, 02 Oct 2026 09:38:09 -0700 (PDT)
X-Received: by 2002:a05:7301:23af:b0:348:201a:6c88 with SMTP id 5a478bee46e88-34db6605d44mr6538916eec.13.1790959088429;
        Fri, 02 Oct 2026 09:38:08 -0700 (PDT)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd5620sm7756398eec.21.2026.10.02.09.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:38:08 -0700 (PDT)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net, anup@brainfault.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, prajwal.n.oss@gmail.com,
        Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH 0/2] Add RISC-V SBI watchdog driver
Date: Fri,  2 Oct 2026 22:07:56 +0530
Message-ID: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zTlrSD-F0Dh5rC6pSxo2k03M12GoEWOd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX+ZKUg6F3heWS
 FZhsMU0dJYa8eyDhBU2CHRE4jTXGbVaKO7mQYs0CMsQ32/ozWeDxN5iFpc4vtmmY0q+gKXe57Du
 +ttQ7UnlKDy+zvLyX1QffuwShXK25zo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX+ZQw8zTSj6Rl
 Vft4EBH9ZZKXweH5vfnrQPpxpsJAbtxeOrMZ4dMbgp7UtlMak2v6uGawK1bezpsxBMY9WoRCyTJ
 vmakTAK8UoPV08M6MZ7lwe6mhkDzde8KnOrXfTBLqBcdSbMgWDdkBB/Mwk/PYtW17AxDmZEA/Co
 WOQGoqNGrX+WRipHzxNnqgfi7cP5jb5trFerTNXn79bkav0U28G3Hy9HhhH+OXQqInfcfTjssd2
 Op+oBmG6Iayw6E5d9MfurLqZG+qAWboP/tU8Wi+0HZwpk+aHlR4wqTU4FaBuJGBR2/MkaqRpR4x
 l9AzsanhFyJMiXWTwHMGPb6/QRNFa9B67aSoyloWYSZbq2wkhJ09Iw7O28sxIKFwofKZWAz44um
 Eej2mK+07aRJWrxLHYT9GXuOSFrNN2A8YaiYpsG1U4gS7p2KQRn+HE5lOVpY5KPasQhnXSWRtjf
 MjBdZldmhP1EMVTIUEA==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfddf1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZbvlEdOQB2PwL-2qBAUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: zTlrSD-F0Dh5rC6pSxo2k03M12GoEWOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020066

This series adds a driver for RISC-V SBI watchdog extension.

The SBI watchdog extension exposes watchdog including start,
stop, pat, read and write attributes to the S-mode software.
The kernel driver uses the standard SBI calls to interact and
configure the attributes. The driver integrates with the
kernel watchdog framework (/dev/watchdog) to ease user-space
implementations.

The driver currently subscribes to the Message Signaled
Interrupts (MSI) for watchdog pretimeout events.

The series consists of following changes:

- Patch 1 adds the definition for SBI watchdog extension ID,
  function IDs, and various attributes that are supported by
  the extension

- Patch 2 implements the kernel driver that utilizes standard
  SBI calls to interact and configure the attributes.

This is based on the OpenSBI watchdog extension implementation
patch series available at:
Link: https://lore.kernel.org/opensbi/20261002083040.2533097-1-prajwal.n@oss.qualcomm.com

Steps to test the SBI watchdog extension
1) Compile the kernel along with watchdog kselftest for RISC-V.
2) Compile OpenSBI patch series mentioned earlier to generate fw_dynamic.bin
3) Launch QEMU virt machine with IMSIC support enabled.
   Note: The following command requires a rootfs.cpio packed in Image. It can
   be modified to use rootfs.ext2
   $ qemu-system-riscv64 -M virt,aia=aplic-imsic -m 2G -smp 4 -nographic \
     -bios fw_dynamic.bin -kernel Image -append "root=/dev/vda rw console=ttyS0"
4) On kernel boot-up, the /dev/watchdog entry should be available and the
   kselftest binary (watchdog-test) can be used to test the functionality.
   Following are some sample test cases,
   
   - Dumps all the supported options.
     ./watchdog-test -h

   - Starts the watchdog, configures the timeout to 8s, ping interval to 2s,
     and disables the pretimeout.
     ./watchdog-test -t 8 -p 2 -n 0
     
   - Starts the watchdog, configures the timeout to 8s, ping interval to 9s,
     and disables the pretimeout.
     ./watchdog-test -t 8 -p 9 -n 0

   - Starts the watchdog, configures the timeout to 8s, ping interval to 2s,
     and configures the pretimeout to 6s before the timeout.
     ./watchdog-test -t 8 -p 3 -n 6

Changes in v1:
- Initial RFC submission

Prajwal N (2):
  include: sbi_ecall_interface: Add defines for the RISC-V SBI watchdog
    extension
  drivers/watchdog: Add RISC-V SBI watchdog driver

 arch/riscv/include/asm/sbi.h     |  26 ++
 drivers/watchdog/Kconfig         |   9 +
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/riscv_sbi_wdt.c | 406 +++++++++++++++++++++++++++++++
 4 files changed, 442 insertions(+)
 create mode 100644 drivers/watchdog/riscv_sbi_wdt.c

-- 
2.43.0

