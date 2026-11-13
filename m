Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572391;
	b=mg+fxAVerrZz3z2Ai3/qVuW0wWZyzuJx5IEe1MX1zi/1rYH1gToOTIGylnlEjBofh0Cs
	 w6iot3DQ7dP22Zv9VWbwpS85dDPqYXFWa2ztC/LqfmW2DzMGhA7zq9BGce+MosgQOIRmv
	 Ekw6TvbDgEITaCEnEMUKk+tgliubPcg5U8MoT2G39fkqpHPKckj7vlRZshxy1CzBomtJz
	 zEWED7nsq182xEQ8XKr6SsTGQfiKH+yLbNug0jmzTzJTSo8GeXXnla2RTII4sjZoe7g7U
	 y2ZHCWL7H7Hagv6qj26ttoztJ36AjOU9hvprbA0H6SAvktnGXev1+sfHDkZCVGzLo4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=82wzG/D5SymZBCo1RImBwEu2ls9+RkCv88hNwE8Odws=;
	b=IPWNmiU+2T4CHY4CHwmczBUDuj2mHnUcAwuiT8yLao9Vqk7VqCVNn7Ej49GuOv/rMRaG
	 noYon5V9iElj9RUZfzCCdyAILfmpWmCh3Y/YKfnbKI7UQj4VPP4hxeHHe+ApsomN0XAPf
	 R6bjbwb7iXs3O+fA1JiA1DYdHRDm7uky9ccUePpfsgdKX9XK6W/HcHdVl322SQmdahdLu
	 PnMhC8NoBipp4jlCq1Y6wrUTXWz231R7s/mN5hrs+RlhZCJiB3QknFU0lubG4h27HGDbq
	 uwEeOaJlfdg6fpo57J5ZTEoprPlY7rXln56QEnMHtPZVQUpq/8VIUymvylz44/0DnDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MPzGx+Pv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h6muHFHd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED0606A337
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFED0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MPzGx+Pv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h6muHFHd
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJoSV516550
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=82wzG/D5SymZBCo1RImBwEu2ls9+RkCv88h
	NwE8Odws=; b=MPzGx+PvbxOsIKaSdQ9kHQV538VpKgdrabAoRMPkpVvsjRJv42K
	Z8qfLRTPV1xTXj7ncR7zUUgxpi2fit5h0CIdroV9T7PpPnGNd6G3szFgiLfUXFRl
	+R6gyh3Ue0ToAKCqlBbwH66tfnUrXOHJSw17Kc/2KVJnEJ9YiHEfP8Y9OLd/1IBR
	E0NEmkQG2PxiadG0QwlSBDzzDKDc/Mh5orAEVji6QUOzWh8Hb2mmRee7yZ/zkSbx
	eQW1qUD13c3cGXRmdODHp16E02KPep/7dirXbWa8+++6FzvA/G7ESwGTftFUpFGw
	4y18G9DeQNtYdvn6Qy+5OLbPssZEHG4POCg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdk3gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:19:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so414658c88.0
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 04:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794572367; x=1795177167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=82wzG/D5SymZBCo1RImBwEu2ls9+RkCv88hNwE8Odws=;
        b=h6muHFHdLoI+BUIV8xyceDv5+OGpmjIr9mk2NrH0xUrR8D+aXWK0pC1/MlzHEzj+tB
         2uVpMFhWZjhMdQMkjmzwXMEvlhglDZPMmvq3n4MOgLeM6CoDlZvIpxNNY23h3LDVmoYx
         DCVvYHuzFNY+n4OuHUEhWEDWZOqhFvKR0aZLcY17mVSV5RFyFSPj9nHZxXVHpq4eojv5
         oCll+RRy+OjRJy/Dafxxawlsvr3RHjbgH4pU+1a1NRGW0m34BsqMrQHatBSTJtZgKCJF
         hwbkMC3B9VjDp1QKUBgBVkHqv91ZvQYXRU2+9h6fbeHiAFFKiEegT0YxfT0RZxC+N17K
         3zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572367; x=1795177167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=82wzG/D5SymZBCo1RImBwEu2ls9+RkCv88hNwE8Odws=;
        b=ac5GbbOmR/nNnjZg0UU24050Z3MrK/D7GPtC23qAmxmC0yCjznCA7bJ7iMHzJVYDXZ
         X/826tOcoacLrZB+w0nodau30bo/0ETOjKAFHPecvydbvg6qKQTjkECxjTLVKTO4S1Hn
         A50A3CXXD9df24lSzekb1D/AKgmIrJ3d1lv/mIHdF2xCZPKukNRwwQzr2sWas8nrf3Aw
         tPBdB78o3POSOT32tZ2SnmLYWYO60Z4NOnwcK9A8atCysj3591scyo9uF1VkS56LtQGM
         FTqpLkIrQ26e0Pvf90iBedOGameF9TzRQuMHyqzI7eqjzNxD1PUoSf5tCosRJE96keax
         gJVg==
X-Forwarded-Encrypted: i=1; AL+hErFfpo718YOOKCIEDin0S/KWhMTI5h8CIHYfGIL2blVEH2gUe8ETPN2D5HIJco50xJdkVnHaFpwtpLoEopnMtg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8DoRDEpYVXRya7pJUcdWwUtN/hPv3cgcDEc6LS0RSwOXyDCKfS
	s8V3Vxmtq4F0skzCGtHxG2mtsdke6mOobsmvwxACY5Im3bs7cf8NA7ZckFf17MWQ43o5S+S2sQ1
	FbiTK5dff2RRrSetsipPJEli8rqEUReAAQIohH57EdGu+CudYzznAH80x1lDhV6Vh1F2Nsw==
X-Gm-Gg: AYBFou2Lk9LalANHDmzuqD7QtEgVEh73fAwTnDVsBuXYaqczwcAEPdA706Sirby4ayQ
	LPIeXecEbNleGFOvwM/xXWfVbfRAf6/aybyOtaoEwMFUQJ6dA6LCUro3zGIarmOVYR+TE5xye/S
	HffyVb/IZjS+QidSyAn/T/7DIpWS66wsJfYeifaauYK8t7sfH+IZNbasWl1o/eWtS8psG1NJaHc
	aiA5/HOijwIQHxLIySy01/h0W6XMVUghCQCXIW6AT8yx8+o8YIvCLq5PPLJIixNApYP98zQjTDK
	eQhUBv0cgFpwSGfkbSck+0dYAavDs8/ts1jnnj4KwSyoZmdo/5IPNTvHqxksdrshL6ZI6Zwt4uB
	JnCJWhYlq8ypDQFEdD9buLh1POLZ9bQx7+v/y+aqGV4sU7hjrQsRe/ZjkMFoofAqDleMTzWPYvJ
	23++btVfi8giLGFHSZ+Ou+5l4dvqO6lUE+K/ZN4HrW2dNJ4jhSh7BjFsEw+T40
X-Received: by 2002:a05:7022:290:b0:185:4ad4:3d15 with SMTP id a92af1059eb24-1b503068235mr2010283c88.1.1794572366998;
        Fri, 13 Nov 2026 04:19:26 -0800 (PST)
X-Received: by 2002:a05:7022:290:b0:185:4ad4:3d15 with SMTP id a92af1059eb24-1b503068235mr2010241c88.1.1794572366102;
        Fri, 13 Nov 2026 04:19:26 -0800 (PST)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm6423629c88.7.2026.11.13.04.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:19:25 -0800 (PST)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net,
        radim.krcmar@oss.qualcomm.com, anup@brainfault.org
Cc: linux-riscv@lists.infradead.org, linux-watchdog@vger.kernel.org,
        prajwal.n.oss@gmail.com, Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH v2 0/2] Add RISC-V SBI watchdog driver
Date: Fri, 13 Nov 2026 17:48:55 +0530
Message-ID: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX9FGR0Uen2RFt
 sOh912Bdeyv3//+JyAGfJR5OHzyxfBWCadVbslnEcc/4Hzws9fLpshhBfS9JzOMmxsyDUukLtJN
 1p5hgFktqRFoAsOVbT3E6FmDbbNcX+Q=
X-Proofpoint-ORIG-GUID: _cWI6YI_0TIGjIoRpSFXYkhIBuDHqspy
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af70065 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=0SxRSwYGAAAA:8 a=fWIFD776mP1l5RU5hFMA:9
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=evtWB9OUeeBtXImRToD_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA0OCBTYWx0ZWRfX5gdGzsM5AYOn
 IHR/zSyQWXcYj1GRn1RBu4Sobhw2ID6T9MaMWDh+2tILfWVb+XcRmkcH9VQZsMS8xog4oLIgFgz
 c+q+sd20hElnlT3OHi7DEWl28JTxjHkLurJ6o8fx2FZQs/VE6aF/ZjkQIJnBO4Aue4LEyHDJ8F8
 XaGOB4reRT8BIte7uxLX51CrrT37WZpMsU9YEsHhPpK61213BYvEdsvBNqEdAg8zIZGv/7Y00Yl
 wV6oAWd6QTJJBDCMVWt6jIyog63dYaDbzvSmFBJflHH8nBf++13b7kEcQTMvTx+3JeVGGSPTfKT
 ZCx55Ac9w5TbSxWUhbHCMwSYomuBoHHWQZ2pXnY78BUtCTG72NUBuV4gqHVJygcuhzpvG8UVlZ1
 /lUw2TEZpwwk29vad0dD9XjV5rYTaMhkr+rmO8y1Eo4+8I8sVQSdmz9G5pGn/3IdRQQ3KYGnWrq
 jr/VCdfa0wS/4t6l+0Q==
X-Proofpoint-GUID: _cWI6YI_0TIGjIoRpSFXYkhIBuDHqspy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130048

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

Changes in v2:

- Address Sashiko review comments
- Fix silent overflow in sec_to_usec() by setting max_timeout to U32_MAX / USEC_PER_SEC
  in probe, preventing timeouts greater than 4294 seconds from wrapping around silently.
- Add pretimeout validation in sbiwdt_set_timeout() to return -EINVAL if the new timeout
  is less than or equal to the current pretimeout.
- Advertise WDIOF_PRETIMEOUT dynamically at runtime by assigning sbiwdt_pretimeout_info
  to wdd.info only after MSI detection succeeds, rather than statically in watchdog_info,
  since CONFIG_RISCV_IMSIC=y does not guarantee MSI availability at runtime.
- Fix MSI interrupt leak on probe failure by registering platform_device_msi_free_irqs_all()
  via devm_add_action_or_reset() immediately after platform_device_msi_init_and_alloc_irqs()
  succeeds. This ensures all subsequent probe failure paths are automatically covered without
  explicit goto labels.
- Add module_exit() routine.
- Replace dev_err() with dev_err_probe() in probe() error paths for cleaner error reporting.
- Link to v1:
  https://lore.kernel.org/linux-riscv/20261002163758.2919372-1-prajwal.n@oss.qualcomm.com/
- Sashiko review of v1
  https://sashiko.dev/#/patchset/20261002163758.2919372-1-prajwal.n%40oss.qualcomm.com

Changes in v1:
- Initial RFC submission

Prajwal N (2):
  include: sbi_ecall_interface: Add defines for the RISC-V SBI watchdog
    extension
  drivers/watchdog: Add RISC-V SBI watchdog driver

 arch/riscv/include/asm/sbi.h     |  26 ++
 drivers/watchdog/Kconfig         |   9 +
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/riscv_sbi_wdt.c | 435 +++++++++++++++++++++++++++++++
 4 files changed, 471 insertions(+)
 create mode 100644 drivers/watchdog/riscv_sbi_wdt.c

-- 
2.43.0

