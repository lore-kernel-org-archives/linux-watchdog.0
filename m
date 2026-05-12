Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192D3C3449
	for <linux-watchdog@vger.kernel.org>; Tue, 12 May 2026 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618946; cv=none; b=eZ4Cu6EGcY9l2guPCxhQT4ReMPIhfzkKT7HIfnlPc2g4BmsT8/Hw5FabssL47QDJzXXM3vBL5htuAokEasRKtUdkDlsA/O5XJd3QDiIrKeNpHJthi6jLzdJmGzoPYjXqCNt3GPPmbtQ9d5pAx9xKipLmswa6JuUW2tuZYwjGvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618946; c=relaxed/simple;
	bh=3LMjTRWuOnWvbfPLhKPzRA7CSWwGzz+QVRDH2NYutUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+RJ3fgBW6e8VXQctgeSACsK3RztW1IXz0fpLUk6auUR4ZE2TclGVnqOBn8fIFgK+X1Zf1K4J07v5lPnT2Ese2jhOzLaUKl/MynayzZCcIqo8N0NgyyhfujbfXh6Slbu264OLZJ5EvKDeJBujor3BCAhHgsFvRBAHq2rkA7YssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=2h0GQixN; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="2h0GQixN"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id F28E977E463;
	Tue, 12 May 2026 22:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778618942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7/NTSVZOhes4gOqm3j4WrCMMEBVXuwI5o+q+SaVyVPk=;
	b=2h0GQixNHv/xirLEpYEmDnMcAECsubdQpXY78LhBQwOPVTIme2SOpqnXIS6osnpYKCEvnc
	mM4vo7nUZegVe59EzZ9O14xHSacmjsUJ9RxfZwniREbPDgZ9vA78KRXti5zdAD/Uvvg334
	craJ0QcsONj1PMrTNQgqA6Tkb2N9no6rKmZ9Dm5AyYypZcWGA3F01bcJ1j+UhyBYfOoTdQ
	Tld1b3tB8De3CBcGCtB3VP2sxx9jCG8l5lXYjD4EBIpzlSNDqu1UraO1qMtFRxCLKmmY0O
	MY+5BCoNvTeBfXLuanEo8TNxaptWG6Ev9rs4ePOayRT0YjoEcT7LAC1CAEnd3w==
From: Sander Vanheule <sander@svanheule.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rustam Adilov <adilov@disroot.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 0/2]  watchdog: realtek-otto: add fallback compatible
Date: Tue, 12 May 2026 22:48:52 +0200
Message-ID: <20260512204854.8931-1-sander@svanheule.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like for the GPIO hardware of the Realtek Otto platform, add a fallback
compatible for the watchdog hardware.

For backward compatibility, the binding will still allow current
single-compatible devicetrees to work, but new devicetrees, including
new compatibles, should use a two-component compatible.

This series serves to address comments regarding the device compatibles
for the patches adding RTL9607C watchdog support [1].

[1] https://lore.kernel.org/lkml/20260509163101.722793-1-adilov@disroot.org/

Sander Vanheule (2):
  dt-bindings: watchdog: realtek,otto-wdt: Add fallback compatible
  watchdog: realtek-otto: add fallback compatible

 .../bindings/watchdog/realtek,otto-wdt.yaml   | 22 ++++++++++++++-----
 drivers/watchdog/realtek_otto_wdt.c           |  2 ++
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.54.0

