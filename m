Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795336189;
	b=Xg+cVlAhdXrv6mHsk01uZ0L0jGqq0ddukB7QJXGKVHVneO4IktLYztGcU8CapCr0fJsP
	 8SJkA+kv1wZa3c1+j9zLleypOK/iXzaECPTuh6Vd8V/0Ky8YTemABpAFHOZuwga8tT4tL
	 J5Of13rs+8HKLAByHVdVy/RP4HWJi78NqEpFUbBdTVBrr4OxNxnZe676bLgwQweYz+Ug4
	 OQWzzLOQktM8h8f5ybxVcfKZzis5Sw3TuflRpLJCrt1eFZVi+CuiM8HJwNu+YxTVCPhVY
	 a6EnK/4XBlbHTKVpV7fYN4oorrinRcB6x9T768dRNUR9gRG8FrK5gD+4kSpPpUp4HLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795336189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zDSvzl1Gx/Aqp+Qnd4iIo4LN86WJizYkgXEiZnnjt7k=;
	b=p8NFp+/jviTsSipFD42hYrycZUTSmUrOi67EA8esBTtnvTaooLB+zQSiBIqbwa2s45hL
	 GoD676awtg8GwiCU+DDbw36P/f0PXYzjfAHX1vvL7kc5eNgrfvB4PEeFAPybjPViW7rTA
	 29mjYjrqZvMr4ktadJuONr1EXnJU5FZFmrOnmlPdfkyVxIIY8ASdnz43O4vRSNdpLitZv
	 MmtN4nvkhT7Wzvf/6OQ3E2Zg84iDupxDheBJk7eHXhDqivVvc2q29BgLxcrmusYD6EWUH
	 R5ZKz3bJjvMeJ9OvvHLlewOm6399+C2kQSgsC6X8eYw6CkLFtRg5i34x66Fcsf+xGAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUH6hyzI;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034E606A32A
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A034E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUH6hyzI
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b41e5a1719so862271a91.3
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 00:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795336188; x=1795940988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zDSvzl1Gx/Aqp+Qnd4iIo4LN86WJizYkgXEiZnnjt7k=;
        b=DUH6hyzIJG+cWQTiB4umG7yN3dF1aZAe7V4GunH1oCvonuB2i6gwyPlll6HEzYvRdw
         JixNKlguagGorSjowb1j9tKca/sNOemoH/KCyWN+b+VbA/JKexAdzJFW8JWIU3hljxQ+
         541NCI+2NZcvIdCLTkhb7b2HHsYzlbAKS+OalMhUWa2vZ8Sm11ED+0g00Cg6KSBvHmmD
         +GV+/J3nvkz3yjVCh6/Vm159qp5uABn0pfSAJbJlJrCdxXjN6Yi4YsjwRCQKaRm9KHEi
         RKShldYElNzG3o+8G6yWS/FM8kP2/VraL4WjZudGUZBxeCcvrj+XLSN2yUjxjwSoEt6d
         Mk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795336188; x=1795940988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDSvzl1Gx/Aqp+Qnd4iIo4LN86WJizYkgXEiZnnjt7k=;
        b=Cq88EfgTFc+fJxQyZgoCQd4YWtIH5JXfPnNqyLIFCyFpptbuR/I3r94VX9lRgMSsxh
         VqIUpQ2aFOqzzXx8Kh4nVzYksdIKOAziQdVPBaVWH1Q9Wm2XDvX5qoHiTXzwWuik5V0q
         kU+mPqpHjDWnMHrbnzS5HfYuwyr53AiH6yRhRmm82NIFkG5t/ZTvhtmmodmaw96e2D0o
         K6UlHgeI/CP9t89JdBtlkKCEsO6TACt2Ie1zZ69Jl5dZSioJY8APR7qYXb7jcNGPeAkC
         hPcHe249DhzV69AyCO/Kbw2myVVKO4haGmcDRZbXOg4qzcbVoII4JFyvTubCmbGxLZKq
         4ukg==
X-Forwarded-Encrypted: i=1; AL+hErFziTL9U3anDfIRD5w7RxftPgfJ8jxRzLH8/POKcmDSJzU8DFmagQsxqHy7o1Nu0gnqN/sfFaOjO1eFF3iJZQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zJCcZwPKqyy2a/g6HI8DvXyu7vmRN2UX7j3z4I3BYDIpzIUpX
	yBuSLNagam+8B78H6l/HMQnkkEsvUl2M8M1Qntm4KorBpny5dX/QTmBS
X-Gm-Gg: AZFdTZciMxdJf0q8f+YFaPJfkghViYHpoJd/31hN4kMZAaWtDpw19yjTyj8IVls9TXe
	qkeMo7iZRjuF1fSFk4cppqrP+RCNu2LmsGSVsnrk7SM24E25nDUyFH6D6LfFreSi2x6MS8McETT
	ES6JizSSsL1ENN85EHtQ0Y+vZkrc4RErOwYAX6rinYaaMn53e0wPgLZScSdv1xiwgO5kQclNa62
	kBhOIetbQ9ZpkPYpppeXZjMcbxTBon45i4giYzaIqp6/2AITekMIjKhvpXHo303xV7orF7q+YRE
	Wwnos32VLmEzZm8KlNXHG5rupO6jTaBW0lh0sy55vLLVj3MC+aC7MyQ5IvYpMWi6ut9Pd/46hXE
	yTyFJA3CRoDKY/lK+eNwIoczxoUyXbxkcJqnSH0udBxT2egAiWLyj5JvH9iTLXuv7iml7548YQ2
	yKKk74MCHlkM6DlREgPFngILL5MwSW23/aQRS1NvFtYrSVCVIKh4aFTk/pEytFSQwkEg8WBqxeo
	ihkLUOGN4FBhSih6USUk6lBzzeJ8ytjYqA3/JCC4Sv2ZLa1YHaBM4kXiWPPldJMsHqaHLY0+ncv
	qDy0tGGt22uMHT3UiCAobcF99yByfcGEHi79WGiM/nEabJ1lyyc=
X-Received: by 2002:a17:90b:5407:b0:3b3:c998:6d6e with SMTP id 98e67ed59e1d1-3b41c961528mr6953366a91.37.1795336187924;
        Sun, 22 Nov 2026 00:29:47 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([134.82.71.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm12957455a91.5.2026.11.22.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 00:29:47 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] watchdog: bcm2835: add newline to dev_info message
Date: Sun, 22 Nov 2026 02:29:43 -0600
Message-ID: <20261122082943.173681-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/watchdog/bcm2835_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 755954cbadee..df08236d2689 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -213,7 +213,7 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 					      SYS_OFF_PRIO_DEFAULT,
 					      bcm2835_power_off, wdt);
 
-	dev_info(dev, "Broadcom BCM2835 watchdog timer");
+	dev_info(dev, "Broadcom BCM2835 watchdog timer\n");
 	return 0;
 }
 
-- 
2.56.1

