Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80D3009D6;
	Tue, 19 May 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215066; cv=none; b=sW2NVi6og2QD5u7klZ1+TW/obOSWQxRiNa6/1gxl7Gkt4CGyDKS1JPaTb5EPnYZ2ExzJU7XEps+iTycYBJpy0J9cbzpZzqDTs8lvNFCPmNXnSv80VmpIMZVS9b6479pJj8ZQ38Uni18C0/kNEukyqkHn10YdfxZRnI49zRBjVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215066; c=relaxed/simple;
	bh=c/O+6xmDdzXC5tKkDhyfsSmom/E5OyM2XwhkahPR0MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GebR2wtbH9DxaFFS1/bWj2hUanONj0yViy8rebPE+aAIKkcUqOwUM/jdqXqxPG2KmC8RbNgChhjEzkAWjQKYXuff+ozbsQDjcm7qxDIsiYqz1EbyVTh1meqO4LPEX3WGogXR2CsGl9GvyQe4KJ9+QwV5G6ywhqFBHrI7KgjlFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JmoC6SKi; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JmoC6SKi"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 312EC2720D;
	Tue, 19 May 2026 20:24:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7rN0qgcdktE; Tue, 19 May 2026 20:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1779215061; bh=c/O+6xmDdzXC5tKkDhyfsSmom/E5OyM2XwhkahPR0MU=;
	h=From:To:Cc:Subject:Date;
	b=JmoC6SKixicXE8JjGjKKapkXjecdMoqSXIQwapyOVKXe4aSFFqMCCV+t/t3454eJW
	 h4TUUBGTZ6RDmcLmgWTEnmEA/F5JwQa25yrVZj0Qayyul5HEogsIRLiiEmALuSEk+R
	 TohNYeDBsK0v3yxl7VIS3FZNuuUE3gG7vREzY0kjppkoBopY4dMRt3AMFmIKzmL98x
	 oTzfvCdjfZ5xdBM7RNwhYXEV4HmIXzEesKDI4dWy7W+WbRGilOc+XzNsW7CJlqz/9g
	 hyOLKsBe4bJH/TmKnC7FL+sfezkosen0MNPCZcU4zVjiR1W6G/QrycO/fo0+69f1E8
	 iGRf1Sn5Ix2Nw==
From: Rustam Adilov <adilov@disroot.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sander Vanheule <sander@svanheule.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
Date: Tue, 19 May 2026 23:23:28 +0500
Message-ID: <20260519182329.24472-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series changes the driver to use regmap API for all of the
register access stuff instead of the ioread32 and iowrite32 with __iomem.

---
Changelog in v2:
- removed patches 2 and 3 that add rtl9607c device.
- included driver changes made by Sander in [1].
- added disable_locking to regmap_config and set it to true.
- Link to v1: https://lore.kernel.org/all/20260509163101.722793-1-adilov@disroot.org/

[1] - https://lore.kernel.org/all/20260515212351.752054-1-sander@svanheule.net/

Rustam Adilov (1):
  watchdog: realtek-otto: Change to use regmap API

 drivers/watchdog/Kconfig            |  1 +
 drivers/watchdog/realtek_otto_wdt.c | 74 +++++++++++++++--------------
 2 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.54.0

