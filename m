Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906580;
	b=I2wxoDYb47x91Ns3hRCDzOsyQqe4sEBGF+/Ye5/UTtD/Ji+lrWylO/Igt+r4+t9bc/gW
	 DNJbW+4csW0i1GXE6iDil5NLIlICRZjikgLTBoWktYYs35fYzGjlpwYPQ8FXaU+kOTW1B
	 3x0ZPvUohYuTvr8UdLpM8J4GSTljQ7okYAvbU0ipDVsMUYy1IIVY3EIXkcgULwrzYyUL7
	 4BD7Zma67ou8u/Tj7zbYFiwcEDElUC7TRBzfv3hKCPN8U8VPVdS9W/BC8HsZV7auT3/t5
	 CHp/HARKiq0wgrjNNTj+7eXbLAQ9MCV56Msqi3mOmvw5V+ZpyoJXOQyUBgIFvCeSaCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906580;
	h=DMARC-Filter:DKIM-Signature:Date:Mime-Version:X-Lms-Return-Path:To:
	 From:X-Change-Id:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-Original-From:Received:Cc:Subject:X-Mailer:X-B4-Tracking;
	bh=9kU6pzFrF0JRjF9S1nvwA7nlQ5cqugMZ9xHh5jZBAxQ=;
	b=YQVBXk/cIiK+blVFePAqUbJQ60EExvpoXRpxYnUBocl9TFwYHK7sHXIdrjieR64hj1XH
	 WUUwLo2tljc67vuub4Q/mPENlMfiNHECAKOJCd/pgBlRP6wLTw3gjeQCrH1/mqbfHvxfE
	 1eLjouYHYPwIkwinFezM13Sy0fQJCVZUmtxTcCN+DGzywy6VzA9xpmqRtGPq48iqGY9HG
	 /AmuoUqRKv723b4+Xwn0mWDJ4gPiHR/yI3hE4sf2xctxBQ3ZaQFgyPtdcNtrpb+E4Cp1x
	 GJur4NmHzj562gw1PINlsFwCt0QsIvgD0DAZ58RXQlY3SfuZ7rX7D/UmdW6gHQw7B6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=EP8ylC9k;
	arc=none smtp.remote-ip=209.127.231.57
Received: from va-2-57.ptr.blmpb.com (va-2-57.ptr.blmpb.com [209.127.231.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D96606A329
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 09:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D96606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=EP8ylC9k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794906574;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=9kU6pzFrF0JRjF9S1nvwA7nlQ5cqugMZ9xHh5jZBAxQ=;
 b=EP8ylC9krx9iTbOzLJ157ycozWUfqxXe52eu+gxUPfkwAlUM6dEBQQbiWAOT8Rf93GEXe5
 DKaJni8w8avNd1pvaUuvrsnDuVL5ecZDkTK+Xf9UEDYHX/FZMN8TUVG8o316k823rwgCX6
 ++DgH8CpVbUDBOcV9SiE5PEWzLAFggunlWWrBp3q2o2hCyJeJFchb/YeKjDQz6Sr8oEdU2
 7DRFBdda8CzItKeCttLHlFicquUjgLQAmafGwJz/KqnZ2gwp0ELotoHT4wBpFpo2l+cPjr
 ceFdz80iCoPyKGiQ1ZoaK7tXLXu3DxsCixgkvJsdHlQ4CYHJsQM52cznlZkRDA==
Date: Tue, 17 Nov 2026 17:06:42 +0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26afc19cc+1aa41a+vger.kernel.org+rongrong@oss.cipunited.com>
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
X-Change-Id: 664fad58-mips-ls7a-wdt-1e614643b33d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 17:09:31 +0800
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>, 
	"Conor Dooley" <conor@kernel.org>
Subject: [PATCH v3 0/7] MIPS: Loongson64: Add Loongson-7A watchdog support
X-Mailer: b4 0.17-dev-ce4c1
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Nyw6CMBQE0F8hXVtCWyjoyv8wLvq4yDXyCBdQQ /h3KW4McTnJzJmZEfQIxE7RzHqYkLBt1qAOEXOVaW7A0a+ZaZ2WxmcFr7Ej/qDc8KcfuAAtUp0 qq5Rn66brocTX5l2u30yjvYMbAhIaFdLQ9u/tcBKhx2QitRAi2dmT4Ak/6sLaIhNSgj63RLHDb mxwAB+7tmbhY5K/itorclWgMNZrK8s8d/+UZVk+xMpljQoBAAA=

The Loongson-7A has a watchdog compatible with the one on Loongson
2K0300. It uses an internal 50MHz clock source of the PCH, which is also
shared among other miscellaneous peripherals in the PCH.

Add a 50MHz fixed-clock node with label "pch_misc_clk" to represent the
miscellaneous clock, and migrate existing miscellaneous peripherals
(namely, ls7a_uart*) to use it rather than clock-frequency.

With that, add "loongson,ls7a-wdt" compatible to dt-bindings and the
corresponding watchdog node to ls7a-pch.dtsi. Afterward, enable
LOONGSON1_WDT in defconfig to make it work by default.

Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.

Since the series modifies ls7a-pch.dtsi here and there, it also fixes
the weird semi-dec-semi-hex style in ranges and reg properties and add
the missing #address-cells = <0> properties to interrupt-controller
nodes.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
Changes in v3:
- Do not add #address-cells to the lpc node (thanks Sashiko)
- Strip applied material (rebase on top of watchdog-next)
- Link to v2: https://patch.msgid.link/20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com

Changes in v2:
- Add a fixed-clock node to represent the clock source for miscellaneous
  peripherals instead of introducing a new clock-frequency node (thanks
  Guenter Roeck, Conor Dooley)
- With the above change, "loongson,ls7a-wdt" is now compatible with
  "loongson,ls2k0300-wdt" (ditto)
- Replace pre-existing clock-frequency nodes by utilizing the new
  fixed-clock node (thanks Conor Dooley)
  - Suppress warnings in lefi_fixup_fdt_serial() when the UART has a
    clocks node
- Fix weird semi-dec-semi-hex style addresses and ranges (ditto)
  - Also fix pre-existing ones, as their context (clock-frequency) is
    touched by the series due to the previous change
- Rephrase commit messages (ditto)
- Add missing #address-cells to interrupt controllers, as its absence
  causes a flood of warning when verifying my changes
- Link to v1: https://patch.msgid.link/20261110-mips-ls7a-wdt-v1-0-968bb85122e6@oss.cipunited.com

---
Rong Zhang (7):
      MIPS: Loongson64: env: Don't warn if UART has clocks node when fixing up FDT
      MIPS: Loongson64: dts: ls7a-pch: Add missing #address-cells to pic node
      MIPS: Loongson64: dts: ls7a-pch: Use hex in ranges and reg properties
      MIPS: Loongson64: dts: ls7a-pch: Add miscellaneous clock node
      MIPS: Loongson64: dts: ls7a-pch: Bind UART nodes to miscellaneous clock
      MIPS: Loongson64: dts: ls7a-pch: Add watchdog node
      MIPS: loongson3_defconfig: Enable LOONGSON1_WDT by default

 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 49 +++++++++++++++++-----------
 arch/mips/configs/loongson3_defconfig     | 54 ++++++-------------------------
 arch/mips/loongson64/env.c                |  6 ++++
 3 files changed, 46 insertions(+), 63 deletions(-)
---
base-commit: 865c2d0f1dd3f0937865dd11819eeb59298a814c
change-id: 664fad58-mips-ls7a-wdt-1e614643b33d

Thanks,
Rong
