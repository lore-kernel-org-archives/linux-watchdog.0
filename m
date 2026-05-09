Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA161DC9B5;
	Sat,  9 May 2026 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778344316; cv=none; b=Fpk+UGsgEUkc81UjJrrU5XZTCip2qbInvc4SjQxVwRxy2h6hYP4MARISFgJug6H8000OKTLzz4spC5xYHLS8PRhOaR/fWNxWsppCrm9exlbZbaakceMjRXvqfEOU0os66t5aUhvILtz0CXlVajJNFkz67L4PRk0GX57loJCbskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778344316; c=relaxed/simple;
	bh=SeCJV7x6Kw87O4aRrgIJhUsZpHLgIsL3XYf+bKptXT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=quMZSYqxAbV0KriRs55fFFFY+wwo8NtcKeubCUwQjab4DuEBjSrLbqZNKL+R8rbwFZLgijstY0ncZ8thPTDZaZKlMaVBk28qIKzqdW0W6B7cqb7SHaXuKqBCquPDSqOd+R+7Dx+33PYCIY+xm7EWrbIdfeE0Kb24m/6Cq9E+gvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bNikaWiB; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bNikaWiB"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8492027251;
	Sat,  9 May 2026 18:31:47 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FM7nYVuAHbAp; Sat,  9 May 2026 18:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778344307; bh=SeCJV7x6Kw87O4aRrgIJhUsZpHLgIsL3XYf+bKptXT4=;
	h=From:To:Cc:Subject:Date;
	b=bNikaWiB5XTIngQOvV1+JLxkbS68MVlFgau1W9RSWu4+hWwp5CEXeMGBn80E2snX2
	 D2JpeWJh3Yq2JJeCqpi5klsd3vdwcd44OOfaw+UsPa8+q6e86+40yQMZfHdMJmYXMK
	 zOOb0K+xvHOoBDUCsJUXSD0dj7r2iPnqZTBuarQxTe67EiOoRwe6dix7ht3gTnPUnT
	 8+ENIw7qqLa6BXPDUeR2Mpz1XriSArHRJXNEnuRC9a126fIFhCxnywIHFhFsS0d8DY
	 8Y6OYp0/nmqez1RQz2hQmXzdeb+DOYP8/kHx73IQ0VmlHNMCJVL0qEcw9VqYOHMBiq
	 F3Kkk5agm4dzQ==
From: Rustam Adilov <adilov@disroot.org>
To: Sander Vanheule <sander@svanheule.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH 0/3] watchdog: realtek-otto: Make use of regmap API and add RTL9607C support
Date: Sat,  9 May 2026 21:30:58 +0500
Message-ID: <20260509163101.722793-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series changes the driver to use regmap API for all of the
register access stuff instead of the ioread32 and iowrite32 with __iomem.

It also adds support for watchdog timer on RTL9607C SoCs and since it is
indentical to the already supported SoCs no major changes are needed.

Rustam Adilov (3):
  watchdog: realtek-otto: Change to use regmap API
  dt-bindings: watchdog: realtek,otto-wdt: add compatible for RTL9607C
  watchdog: realtek-otto: add RTL9607C support

 .../bindings/watchdog/realtek,otto-wdt.yaml   |  1 +
 drivers/watchdog/Kconfig                      |  1 +
 drivers/watchdog/realtek_otto_wdt.c           | 74 ++++++++++---------
 3 files changed, 40 insertions(+), 36 deletions(-)

-- 
2.54.0

