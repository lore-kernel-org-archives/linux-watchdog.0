Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCC3C76BD;
	Fri, 10 Jul 2026 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669436; cv=none; b=n6tsX9s4y/+T4nU1OOANGJZ4zPMEHoqY0ekOkzKin34CVqU6W2YGotrbftCm4f0S3mR24ixlbJnxXEinxybEWIIckQccAibgoy2/ASlENp6C67Y6TxHBBG+P6sFtFCx1PCqfSOZK8JPweHUD+OZjygTI9eJQBfzP41l4OT4znqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669436; c=relaxed/simple;
	bh=oJJHDpDJXOknwqcCnUtoQkhIS8iZFCSeiHev8fH3FaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQNliBpypQMVniDPNW8HLxkIbRu4inVbOmU530/BlBMIA+y2BEJgksh0bcZImE8EtekZSLCkBFcgiFErsNMNfcxg57qKKuX6KqNDZ7CdAThhhA/1MbX0bAPcQ3SZOIg2+HV3IoNpB7qYb78LRu6D2N3V94eBs7nXDU3z/AQtcIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iAfsDk6y; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iAfsDk6y"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 179868535E;
	Fri, 10 Jul 2026 09:43:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wUgg5GFRggkz; Fri, 10 Jul 2026 09:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1783669431; bh=oJJHDpDJXOknwqcCnUtoQkhIS8iZFCSeiHev8fH3FaI=;
	h=From:To:Cc:Subject:Date;
	b=iAfsDk6yTGQGIWfu1tylS4wUHKEILfIb6PeAilu6xpusK54d+VLrsfWKE6xMoKgx+
	 qj+fybfVHFqodAeNtYMEKkDXs8M3SVyITydkKIi9rYDezTgMFHZM0zu0NmqI1whYNh
	 ozheMxFE/nKJmTUi75/2zndJet+aYX99Y5jBUiGZhNYSI+VPFe5HZNwAKpQOk26V7s
	 hJs/FVA2d0HGbn9yCiIdesnPWqY2UkLOpFV25swaKIKe+5w0MqfVF6LMOn7VCYIJjt
	 24+3ZYu8vfY7jOcwgzUeG3UCwt2IyjfQRZi7XZxXDVbudo7CUST35ruLIQ/XBvJX6A
	 zCqJGnEHDzIcA==
From: Rustam Adilov <adilov@disroot.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sander Vanheule <sander@svanheule.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v3 0/1] watchdog: realtek-otto: Make use of regmap API
Date: Fri, 10 Jul 2026 12:43:15 +0500
Message-ID: <20260710074316.46643-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series changes the driver to use regmap API for all of the
register access stuff instead of the ioread32 and iowrite32 with __iomem.
That makes the watchdog operable when SWAP_IO_SPACE config is enabled just
by adding big-endian property to the device tree node.

Also, there was a comment by sashiko which got addressed by Sander in [2]
with possibility of it being false positive so i left it at that.

---
Changelog in v3:
- reworded the commit message to make the main reasoning clear.
- rebased the branch.
- Link v2: https://lore.kernel.org/linux-watchdog/20260519182329.24472-1-adilov@disroot.org/

Changelog in v2:
- removed patches 2 and 3 that add rtl9607c device.
- included driver changes made by Sander in [1].
- added disable_locking to regmap_config and set it to true.
- Link to v1: https://lore.kernel.org/all/20260509163101.722793-1-adilov@disroot.org/

[1] https://lore.kernel.org/all/20260515212351.752054-1-sander@svanheule.net/
[2] https://lore.kernel.org/linux-watchdog/d0b159eefa6bc5abf0d1531acde568396f480500.camel@svanheule.net/

Rustam Adilov (1):
  watchdog: realtek-otto: Change to use regmap API

 drivers/watchdog/Kconfig            |  1 +
 drivers/watchdog/realtek_otto_wdt.c | 74 +++++++++++++++--------------
 2 files changed, 39 insertions(+), 36 deletions(-)

-- 
2.55.0

