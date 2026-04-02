Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770F26C3A2;
	Thu,  2 Apr 2026 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114232; cv=none; b=H6/71pOAjdUfvoeaxvHRnq7hVErBaydtqkNdQrvRs6jj1n88X4v+uF7BNgdlxD7O4cqUwxdjwynkTSSI4l46ry5X8smMrCJ/vd+Bv9bbX1iWFepMDpcit8mLy088YiyY6iges+4dL5JxLJHuM1ruHa5RYSw1yccgsGYW2QlNTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114232; c=relaxed/simple;
	bh=HAHuOlPVYQ3Dn+Vock/kb2wLrLF/ZZbNwudMUOXL8/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFkOzSBc8A0c6JFKFThS22BpWGodq4FWdLhlLnD9JrjSXa7KQRSvBao82U5hhfQ9opR7PAqOVetN/VNn+qR1H5USoskw4PTHlPVmRhC4IMB5PxhJyyC/kiddQGWJ5tSZTuHeAP5hxwkVlErNtkVLviON3yw28GFB+bl9NIqiYes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j4ClygOG; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j4ClygOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775114201;
	bh=U1QsJFKb0NZ3vc93Lgwq1WYOANd0CrzQcpIHz/HXHxI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=j4ClygOGGdnBadMhiyyqRk+t3azgH3FjKq+KTc2oPpn9tXkYMulkzs9Ch5MWHleio
	 0ZB6NyK4epZ314+qtwPnu5mZ2FaFJsN+3jwoPt3t+sFvUJ0lEijvSidVV/Wzesjd9y
	 7VYOmkp5dG+qL+P3skkpz8bHdbWPtzUnUzgSAtXc=
X-QQ-mid: zesmtpip3t1775114183t51af5bcc
X-QQ-Originating-IP: 9QVCHVuLN95zNATHSCKC0cUmsBL4dWu/6UEeNIK61rw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 15:16:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6913409089707253484
EX-QQ-RecipientCnt: 6
From: Yingjie Gao <gaoyingjie@uniontech.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	yuechao.zhao@advantech.com.cn,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yingjie Gao <gaoyingjie@uniontech.com>
Subject: [PATCH 0/1] watchdog: sp5100_tco: Use EFCH MMIO for newer Hygon FCH
Date: Thu,  2 Apr 2026 15:16:16 +0800
Message-Id: <20260402071617.634563-1-gaoyingjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MpN8VHsXqjQP168YxeqMp1ONUgJiikjCtqYEYuvQC0fuMpB6pUUAFios
	qKQx4BayJEB9au7L3ZJnKNcddVu63JL1h2o/oNNxxC15e4IjSHhLCDZl8eyjfSHJfjmI7hN
	TtGkw36BApz/2Vjhe8DxW1dUKaBu0hfJVGiH4tRJAcB/W4IBskG8rxmkj3a3DyyCcdMxyNs
	I0QkuAP2LS81opejSRqj9rtz1zDcQi7e5wS3eu5oqcKEDQV/HK4/dLmbraGuPxPuCwP0Szj
	j6gd8AXizSIY3BnbKvigFRxe5ANL+ppFgijD40h2wcsexIti8c5S9tXHqUqsinu6BeuVDNS
	8JQ/vDyzxkHXT6i4ZnGpImK3nSUFA2sx30ocSGujAn+ZIZcYBHIx/h+xGlrBsIbBrgWUURt
	W4t2o8PjhR4dXaqsrVaJukLOsZT7JhtVtiPJBk+H9DE7dCEQePAgjRO4v5A3T6IRYCPWeWf
	ec0OhkFCYO0w9xb/l0Gr4Y6GJqSAMEUSJqRb8tZlgUXFjNQeXtL8AYPwTuhTG5cshwUiBud
	2A11yyc/eCok/g7HOd0qNUZs0ew1eseOiInnT/5WFhYXs5iDP39fs37yj5CkfBbwNKDi81+
	NMxw5yKENgX3UJSqJVLRDUOE1B8V9duA20/BI5NcB23e63FkibPLWyS+7hNM3ASNaAOrbvk
	xS3//SCPUVrW83UpI3ZbQ47+assqHw1B8EV1vccIBRLwz8IyJexnoRWU7+WUBU1DoY0K6g0
	7P3XU9yiIvIBE+gfL4YxmKQhqe8GNfAYFzq98d5anR0bbeYTgBIJvs7v/f05bmW5A5bG/4R
	WC4vEVPLLVUJ9j+m25tCAGYv4tV2b/zItlKm+7elSn2koZjC+b0MPEMQ041f2eghF2P36mC
	+5ni0gxr2gA3DJ1Pb57fsYI9CA40rE/pzf9P/VDtfNTbsOaZtGMjgPDboAqDDlOqyNkUwvB
	pRAqlfemWaEK/22H5G03rPJiNnkULx3uaZAp7Hb5F8ut73zSosd6CXleeAgWMSb90ghPcLq
	enrJyj2qUUH8JCro5tgPRHd1quX6yBRNWmW86/ZeS3YNnpStMRYkP8yQfIoJyA3MnmHF2k2
	bqGafutBzOT65cLslnWMWCejtrX2a2aF54US/9qdL7slzNzaxLkHuo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

This series contains a single patch that fixes sp5100_tco device
selection on newer Hygon FCH/SCH platforms.

Background

On some recent Hygon platforms (PCI vendor 0x1d94, device 0x790b), the
sp5100_tco driver may select the legacy "efch" initialization path
instead of using the EFCH MMIO access method (efch_mmio). When firmware
leaves the EFCH_PM_DECODEEN WDT_TMREN bit cleared the legacy path falls
back to an alternate window and the driver fails with the runtime
message "Watchdog hardware is disabled".

Root cause

commit 009637de1f65 ("watchdog: sp5100_tco: support Hygon FCH/SCH (Server
Controller Hub)") added Hygon vendor matching for the efch layout, but
newer Hygon SMBus devices require the efch_mmio path (the same behavior
used for recent AMD SMBus controllers). The efch_mmio path performs the
EFCH MMIO probe that enables EFCH_PM_DECODEEN_WDT_TMREN before
probing the watchdog MMIO block; without it the primary WDT MMIO
window is not enabled and the watchdog appears disabled.

This patch

Selects efch_mmio for Hygon devices in the same place the driver does
for AMD when the SMBus PCI revision supports the MMIO method. The
change is intentionally minimal: it extends the existing efch_mmio
selection condition to include PCI_VENDOR_ID_HYGON alongside
PCI_VENDOR_ID_AMD.

Test and verification

- Before this change the problematic host printed in dmesg:
    "Using 0xfed80b00 ... Watchdog hardware is disabled"
  After loading the patched module dmesg shows:
    "Using 0xfeb00000 for watchdog MMIO address"
    "sp5100-tco ... initialized. heartbeat=60 sec (nowayout=0)"
  and /sys/class/watchdog/watchdog0 appears as expected.

Fixes: 009637de1f65 ("watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)")

Yingjie Gao (1):
  watchdog: sp5100_tco: Use EFCH MMIO for newer Hygon FCH

 drivers/watchdog/sp5100_tco.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.20.1
