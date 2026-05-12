Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857933446B9
	for <linux-watchdog@vger.kernel.org>; Tue, 12 May 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584147; cv=none; b=HPVOgAPq1zhP0VWNH2qHs76z3zG0ztypc18jZdura/d93QFQTss/eZBi17sWO1V6U/Azz63vGY8xoHvCXfDwM6OOF0mcRFFiVAjpvDdlO/P0u+BdsIF59tEQuDZrHudksX/L5KYyKiRiU0rwwKNmNjib0mmygms9CMEWjd3Ww1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584147; c=relaxed/simple;
	bh=XaWeZYfJb9wM/PeQM/RzrWduqvb6jL1QGTBeE03a/wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJcd23d1Rk3f2fzLEYzk327LVc8NIHYIdsy4Cp4D+sIJnuke1tUkH4SjAsNAaZshw+CpCCH99FS+udTGKu/t7ZYYyFin1cJVB8DoxmPQoN5fZsbzAaRSs+VcTDNdAuubqbMqXCxMzoAdiuewIkFQQzImhOBTa/e+rixd8of7Mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=EOdq2qrj; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="EOdq2qrj"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id BA7EF77E05C;
	Tue, 12 May 2026 13:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778584138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r+tTAsw6+5DoQDilDubfg/PaYw+55SsVFLGm4QSZPp8=;
	b=EOdq2qrjDqITF/+Jn8jPbu+M4OaTfFzksXWD58tSExj447ZLItCkAiyRWI8V9qSsvW9SPS
	MB5iD4U7fEHE+1lqqDWblh16+JUHTSHdEMjEihFn/B1mfkME5AWvzHfGYd8WOZGL1IlEtZ
	n/ooFvfT8Ti64Aqdq0ahHP1dL66bO9W6cZpn04M+5CBhYTl9bxx2BRm4buloNUSRF3McUP
	yhwYihsXzvDiAEdN3lxAgX1JG5Kh/rO2Ul3jAThDGENf06hUrsnHyoYnpHD3EAkpxjGORa
	HunBB9ZL7S/Dqz8MbKiYLPqwSefXGq6f2JDl0/WJWlc+gcCErQ0BPKI2rqO6tQ==
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
Subject: [PATCH 0/2] watchdog: realtek-otto: add fallback compatible
Date: Tue, 12 May 2026 13:08:46 +0200
Message-ID: <20260512110848.106620-1-sander@svanheule.net>
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

 .../bindings/watchdog/realtek,otto-wdt.yaml   | 19 ++++++++++++++-----
 drivers/watchdog/realtek_otto_wdt.c           |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.54.0

