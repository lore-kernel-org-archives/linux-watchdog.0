Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993719;
	b=H7WTFBhfRIqSqeBFdE+xCbRv8eWjk1hAICgEr8+UAqV+cbwnal3vUlv/c3xT/a6rGCHG
	 dxWfbKELE1OtiRARO/mervUFwd3a6FR2mGBPpOKEpvvuQuIKoE/5WJ0nKNBTnrKxTKzUy
	 kFboxHWvm8rrm+hrzGS+O3R5e8DJwyepeRKHEdwqcAGaPaaVN9b72jRT6NXPbMdBJjDg4
	 uCHG43FUG8WfGWRwunM+OVzKGu5ITUiVhAM7D3abttJwQUZGyLT9KDD1l43qsUQgOnftm
	 NMK5xdtFngdgFPfLFeN+4BGORao7UGDAzlqJxT8OM/dBTPl3gXbh890FsmBfcngJAyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993719;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=S2YwWZohB1T2+RVJYVuwbz8OZ2OfSbztv8WJJdDcvb0=;
	b=JVTeZRM0oIQrQQ29i3VywyZXPAdcR4nXE56okMZQTLUL94eTlsnrtUl4h4l2wMKv5EAX
	 dfnNePlxwTDznvj3UWIjDbBSUtQo9kUK/XZEv9vCnH3T1AxF6wuY6JHfUCSikMtsZEX8c
	 7TNzYeyLGocVtbd/e5KCCGreN+Lf22HWf72DMpTThOZE+HRjdaZll0ZpHnLGogV302nf3
	 LSJU1iJCtB85OgiZaZ6IXVvOlGxtBovJPrDs58rrifkeDjvPoibMvEw844dqxE13HtdRO
	 ocaFpcf/xOh5jB7DcSuzGDNCkf9bpEnClUk2mkZqLJgDjJmGNtgBFLlbficfX7rouAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WGprEa96;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fwzDLCt7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37680606A325
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37680606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WGprEa96;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fwzDLCt7
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8ZAia4060171
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=S2YwWZohB1T2+RVJYVuwbz8OZ2OfSbztv8W
	JJdDcvb0=; b=WGprEa96jBLNb1rscLfBKBj7tCgSU+7aZ/I7RV/IKwR8zhSEF97
	r6qLG6S/9FLhFH5vRPkMZKEOPp79dGe2ItzbHQgM7l8pjbllJOBA4ZsPaI+/Irlr
	DE5RCR8zz69H6Fl0Aj6nRD55OwKRATD+sgGvzfHo+l3iQYvg/sxTzpcFSZy5YtoB
	mr9w2nfIu9RaRurZF46H6b0Oo9kN+R1bn08bfnba1lUDZyfc+Pjwz9AViS29aqQE
	EYsNpm+3Y+ImszL575q5XcaBL83pcy7WH0FSd1OU8Kc1G0Vj/KzlS02Eo5zgKBRW
	O7cWyaNJV8KN+xICo/KFOYZMkOQ5WNz+CYw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvcjaap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:21:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-38131260a5dso2383272eec.0
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 01:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794993717; x=1795598517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2YwWZohB1T2+RVJYVuwbz8OZ2OfSbztv8WJJdDcvb0=;
        b=fwzDLCt73qb2FML2MJZl1InCqAIjHL5GIzTqwBj0N/jyYc5aVkXEXbhfpRHImt4PSO
         VKaeR1aJAI43OeE7/P3nCMuG8jihTByZXrHfi9uV/v79mBdgunT7PzlEXRr220V+6dac
         tGHggoquvRohtV5M8OiJE0tBDeU/TWgm67v4NdkmDBN/KiRMPKHHCq4spea7emCdBEZb
         UmK35BpCeL98dqd88ytcX4t49CJKPPHEtLkovif08dwjNt37sjEj1YLcEyrh6Je909tz
         ed6WT/PhUE058ncX6OKLBQK7hEKH4uas3hFwwUvLiOos5IRjB+DRuO3+WMlAsDcHFRwB
         rB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794993717; x=1795598517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2YwWZohB1T2+RVJYVuwbz8OZ2OfSbztv8WJJdDcvb0=;
        b=iY79/FK7IJbWhzRjs4Rskn51Ed1BM9t+ndoEHqYmAiSk7wJUWKLcet4sUORETh8WZM
         58dx1vbFhD80MdMb735WZCGyr23nDAt1oFROwmaEapL0ozbJu599FgCDR+d6PPDoFwof
         gZIh3l6lE2Ue1CCz8z0i6TTjSjHVRdWg4HI5wEG3paGx36dd8H5n3lB660WLlqVeaQxh
         l1RlRZEb+gfkP4sw2c5FWxBi/w0J4YszgRtpa4RJBTT0IpXBLfBfahqtJ8duYF7F1j6y
         p1GSdZveiRO+SMmPEbNNLfa7wxkdSv7zzLTjuDLUGdpcE9CmwpRoVomtomWBZXnvhquY
         Sw8A==
X-Forwarded-Encrypted: i=1; AL+hErGpmJ7E5HUr8prwQ6Zdu9PHK+b+7r7F9yMbacdkuRkvE/F0MtuO2MBzuY1M2I0bsVQvDoUbNYtj162QToOrQA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wEsLUNEH+SkWIjIwwHf9Zwhd2l1gYFumEMdIt9D7YshEYvfhb
	tKm65OVJNVb6rxb5HJM5GPYnm5sky5Q5zZGA/Pt4cnAev+AJy0K7s+FXbwpEr6TnFkuWQghjJSy
	TZsmStpChbxMbKj1pHb97y3P3wSSvMyZ1prUA6fzatt2EaALByGSwuAWqc0R0lIIljezpBQ==
X-Gm-Gg: AZFdTZdjTBSf2xOXZun8OpGnjkAqVCaTmWksilITVoFw28+HjllEHOKpOQR+NiFbi0A
	OYL3EIkX8Z3ukCuhRLqrK9e8JkN3qkczDycNNsLYoGEe2pVIRSnxdKGtt+C2sVMM3N4Oz8odOub
	cOEBmIMuhCg0Bwo+hYUv5OVTJ5MKARzHCj1yzGc80BQGr3Gz4hKj/9w+za9cgOBX/IL17r9fjX1
	O1GuYK/ytOTEEqP8pPo4wmDr+DrtFgTdhjmIQrm07T35MXqGrDT5scfEuYEuK/oA+SDRduqZJ7C
	/glKY9MbnHfr6OOxoHKBkWEl0KUGsTZxq6J/SHOr4SfBgIZxVdplgjZR4EHy7OmFa2dIOETqZDk
	xFfh18jeBWf4zfxWvx6y7RCNOtAMn+3RUuYnrLnrtIVehO76QxrMFBZAvPfbMASH6MoVu6naRBH
	ZPTUW/wKlUx5LcSPB8FXQysqT07Ze6qkwVegNSoXFwzZvAGjLy5mavHQTzH4HTew==
X-Received: by 2002:a05:7301:dd95:b0:36c:3b8a:8089 with SMTP id 5a478bee46e88-38281427c58mr1852554eec.36.1794993716607;
        Wed, 18 Nov 2026 01:21:56 -0800 (PST)
X-Received: by 2002:a05:7301:dd95:b0:36c:3b8a:8089 with SMTP id 5a478bee46e88-38281427c58mr1852533eec.36.1794993716050;
        Wed, 18 Nov 2026 01:21:56 -0800 (PST)
Received: from hu-prajn-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm9194334eec.5.2026.11.18.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:21:55 -0800 (PST)
From: Prajwal N <prajwal.n@oss.qualcomm.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        wim@linux-watchdog.org, linux@roeck-us.net,
        radim.krcmar@oss.qualcomm.com, anup@brainfault.org,
        anup.patel@oss.qualcomm.com
Cc: linux-riscv@lists.infradead.org, linux-watchdog@vger.kernel.org,
        prajwal.n.oss@gmail.com, Prajwal N <prajwal.n@oss.qualcomm.com>
Subject: [RFC PATCH v3 0/2] Add RISC-V SBI watchdog driver
Date: Wed, 18 Nov 2026 14:51:45 +0530
Message-ID: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afd6e35 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=0SxRSwYGAAAA:8 a=bDjJS1w-zusUvRiTzisA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=evtWB9OUeeBtXImRToD_:22
X-Proofpoint-GUID: qsKtm9WNCUrNayMmALUVixeEfgn_hvtf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfX+Qaqtb4ly8he
 m1pV6cX8FbjFkIoELbFzUTQkqQr7Z61vX9T81dpa03Uxz1TVVHyi4SCF1uwJvVuZcD0KLnYmaBM
 QgmCBLmq1+SLJAi7x2C0EKeQd39tQAQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNyBTYWx0ZWRfX8u9kdORRUC9g
 Ixo/40WvAS5NI23PgDgFbjUbpF9eKX9gcaQFZa4mq7a2a3OwPj7mXI7nowx8Ad0Tg0wTns/gOZq
 ZFN+8MXtTqfJKCtbPOe10+josgM2BkRb4/kUlhoPzJJxxcfqmrzd+5RQQeDnuc+KulprA1RHtuO
 hncNWApkEa5iIDguDyLkRzm7brc+ioCxcMQhVksI9HKfPBu24Q6X/0kvHD+qynsYxCmHZcmTl38
 yO24tAlwiUsJ86aZsWcK3Y69P1XqoFYAAPCUjIfQV7+l3CpIFYk1bgpREbaZVXJ6vpIJjkTVQT3
 A00sWNAy39WHK6ZEP3LjuRGM3IrZueZpEpykSHi3OzMVleQBZOaUMRwyweTH/WTeaRhHTWqi9vG
 XrSzCY/lMB0RQzI13tFrfcBPCeCaph9aYXB1P+CNOqdiMF71Q4QNTDas3y5DxLK3LqqyDFn3Jgo
 Wxtiir0UBb7yROHA9bg==
X-Proofpoint-ORIG-GUID: qsKtm9WNCUrNayMmALUVixeEfgn_hvtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180037

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

Changes in v3:

- Address Sashiko review comments
- Select WATCHDOG_CORE in the RISCV_SBI_WATCHDOG config section
- Appropriately return from error conditions when using dev_err_probe()

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
  RISC-V: Add defines for the RISC-V SBI watchdog extension
  drivers/watchdog: Add RISC-V SBI watchdog driver

 arch/riscv/include/asm/sbi.h     |  26 ++
 drivers/watchdog/Kconfig         |  10 +
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/riscv_sbi_wdt.c | 436 +++++++++++++++++++++++++++++++
 4 files changed, 473 insertions(+)
 create mode 100644 drivers/watchdog/riscv_sbi_wdt.c

-- 
2.43.0

