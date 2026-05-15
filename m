Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97749405C34
	for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880249; cv=none; b=TW12iibNce4pzHb5n6x4WSBSANEKJ2eB42Z/OjodXg2TxhfI4RD+vn1hpCJKmnjW2VbYVB+Qv24Ou33AZbu6wck7TQ6pE6B2tiUxMOBa/X1FeAMBUHP4KP/aLyN0HaKNDiC/OEfrDIPp10+Jrf81F+1cS4HIlw7zhoOTTAH06RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880249; c=relaxed/simple;
	bh=kVvu0H4g4Vl59/xaFd+65cdN/n+KHflh/9R3GaNZfg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CP1f0wp5X1KT2PIbJ7nv/rd1hp+8sSUHO8N4LeA1WdCFLW9FZBoaRXnQyAqtsU6WLJlP4f/OCfE4EEKFDC9kYjUXfESIPbZUiCv6brT2XJ5fkxB+SgbIls4cQAEaobwdQhWLwBEDYFiK1R+o7AMKjEwyBK0m/cI0KvDYydMKIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=dOpvfaMp; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="dOpvfaMp"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id E3CBC780798;
	Fri, 15 May 2026 23:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778880247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8K5NTWqg9/GDJ9Zwu4jbBsaiSzJDxpTkqUtrEM9IxgI=;
	b=dOpvfaMpqWc6/CQquO9LVrX5uFPC4gUxbededBJVA/KhhAz82bE0CZj8ziQ1nUYggxoaT2
	ArU5LLjHwEqYz3XaQOn3hgpBQfiRZHKOnWCi1aLEs4bYhrX3UdFkjCaoXKsXiS+BLo4D+l
	sJluUYrn3OHDROju5KvDD40mDUZYe06m5ns7aDa58+cdUVDJAooBitGm9UF/lVPz6Q+CU/
	jd7o2y9DwR0FzokRV6HMDPHX4OFdLjgTT8Dw8mgSMrt0DaA8JhxTbAkET7qf8s4eoeWOdG
	ebr2L+6RzgvxDL5WGb3Mfd07mPo1eVg+9y4S/ndptf9i0eF5aTDvXIegaNBAHg==
From: Sander Vanheule <sander@svanheule.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Rustam Adilov <adilov@disroot.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 0/2] watchdog: realtek-otto: various fixes
Date: Fri, 15 May 2026 23:23:49 +0200
Message-ID: <20260515212351.752054-1-sander@svanheule.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix some minor issues with the current code, as reported
in [1]. The individual patches can be applied in any order.

Should I add a Reported-by for the Sashiko review, or how should this be
handled?

[1] https://patch.msgid.link/20260509172748.54B33C2BCB2@smtp.kernel.org/

Sander Vanheule (2):
  watchdog: realtek-otto: prevent PHASE2 underflows
  watchdog: realtek-otto: enable clock before using I/O

 drivers/watchdog/realtek_otto_wdt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.54.0

