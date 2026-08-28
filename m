Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B237DEA9;
	Fri, 28 Aug 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933644; cv=none; b=kockEgtRL1uocSDpa61csNG/nt2Qp5VQAdF6/NUXmpgcIK0V1P+r4lcnYkffkvrZqKwLiYcSa/vEBpbeyntj05J8E4sMjURKBhze5aGzfrfGpLvSnNLtwf6zw6Vfwv7bCBD96hvJRJTaVRcDoA8JidduNKuIGdfYji8m8mAQJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933644; c=relaxed/simple;
	bh=VYBsEpF/jbhuMDomV5YSAYWPyJbxFD7HUxyl+pkBYOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rN0AsWEc/5wrLLA6WmfZhvDIUvSptBTdxAb3ME0YtWcDx6l3AuT4PPzc0dWYWqm2ORQDb/H2bzLcRO61+2Tj5LQizAC8WKi5g7DOO68UMgtiVY777rH7EmMu3Y2i0uYO8maTJnk3m/aSDyFjsfTpb0wnAcUngJnA3QQvCDIoidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyTLesNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyTLesNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA921F000E9;
	Fri, 28 Aug 2026 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787933643;
	bh=w3ZYLoTVwcaPhoiVuhVp1wPlXMdYO1Q30pN+IlI48as=;
	h=From:To:Cc:Subject:Date;
	b=JyTLesNmyEbCwDx3il/b3n+u0GYa0mzqK8Tn9sfhInQcsbfDR8JhfhxD0KFGEHXBv
	 kpqdDKEkIX3YKkaIycEppA42vooSwdbjddqAGr9Eff6POljHLzkEzB4SjKjDVJ34B1
	 zSZIq3K8QcpxTWTGQHODHOFzEtpzXglG2rJSyq9gwqyBg2y0Q4eRnwFkNTNdCrqVtu
	 ghYPsDGjy+E/FfXdI5wjBWRhqRF6CJPYYXszefNaTolnUwgUQa/C3RtVs3hk35CGUu
	 clkir76t/q4ShHDD6pEepQF+IFs+a1gHn3gR/cEvOCwRWbexjR/3Q+QohpcnpDAIFs
	 3doIqfztAztAw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2 0/9] watchdog: msc313e: Fix issues Sashiko reported
Date: Sat, 29 Aug 2026 00:13:39 +0800
Message-ID: <20260828161348.13212-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series mainly fixes issues reported by Sashiko in [1][2][3].

Patch 1 fixes a report in [1]:
- "[High] Missing platform_set_drvdata() or dev_set_drvdata() in the
  probe function leads to a guaranteed NULL pointer dereference during
  suspend/resume operations."

Patch 2 fixes reports in both [2][3]:
- "[High] Potential division by zero during `max_timeout` calculation."
- "[High] Potential division by zero if clk_get_rate() returns 0."

Patch 3 fixes reports in both [2][3]:
- "Clock reference count leak and unintended hardware activation in
  `msc313e_wdt_settimeout`."
- "[High] Repeatedly setting the watchdog timeout leaks clock prepare
  and enable references, potentially leading to refcount overflow."

Patch 4 fixes a report in [1]:
- "[High] The driver accesses hardware registers without ensuring the
  required clock is enabled, which can lead to a synchronous bus fault."
It also fixes a further report in [3]:
- "[Medium] Clock reference count is leaked on the probe error path if
  watchdog registration fails."

Patch 5 fixes reports in both [2][3]:
- "[High] Hardware watchdog is not properly stopped during system
  suspend if it was started by the bootloader but not opened by
  userspace."
- "[High] System will unexpectedly reset during suspend if the hardware
  watchdog is running but was never opened by userspace."

Patch 6 fixes an undefined behavior while I was reviewing the code.

Patch 7 fixes a report from a local AI tool.  If WDT was running at
boot, the timeout value could be inconsistent with what the driver has.
Sync the value.

Patch 8 fixes a report in [2]:
- "[High] The resume callback ignores the return value of
  msc313e_wdt_start()."

Patch 9 fixes a report in [2]:
- "[Low] Struct initialization uses commas instead of semicolons."

[1] https://lore.kernel.org/all/20260826062035.7645D1F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260827045746.C79091F000E9@smtp.kernel.org/
[3] https://lore.kernel.org/all/20260827050107.9AD441F000E9@smtp.kernel.org/
---
Patch 1 seems to be applied[4].  But the tree isn't available yet.  The
series still bases on current watchdog-next branch.

[4] https://lore.kernel.org/all/666397f1-ac63-4644-9de1-9f675d2a7f3a@roeck-us.net
---
v2:
- Add some more fixes to the series.

v1: https://lore.kernel.org/r/20260827044700.554333-1-tzungbi@kernel.org

Tzung-Bi Shih (9):
  watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
  watchdog: msc313e: Avoid division by zero
  watchdog: msc313e: Fix clock leak and spurious timer in settimeout()
  watchdog: msc313e: Enable clock before accessing hardware registers
  watchdog: msc313e: Fix spurious reset on suspend
  watchdog: msc313e: Fix undefined behavior
  watchdog: msc313e: Sync timeout value if WDT was running at boot
  watchdog: msc313e: Propagate error code in resume()
  watchdog: msc313e: Replace commas with semicolons in probe()

 drivers/watchdog/msc313e_wdt.c | 90 +++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 18 deletions(-)

-- 
2.53.0

