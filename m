Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254F17B505
	for <linux-watchdog@vger.kernel.org>; Wed,  3 Jun 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448071; cv=none; b=IUt0vfqXJBRJ+3fbgkf8jPgEts5ZF90jQmFLQ6xkGNq729IFO7GZRXUFSvaKpzsr3+MgLW60l898tDjpYc83eiSmi6KHbEoKvh7M1xqypd8EPKLRcnSILQ9xxJjCkieOkHEpOJZLihmC9rd7qUfA6O8D3DuJ5j3IWKhx1swzZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448071; c=relaxed/simple;
	bh=bqVnGA20mnq29IyUcKUln8rA3lQX0dx92JrF1cEnaOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d49vl0zysAzwqxTmE+usu7lyMtsCnqpHaKBHSQWrlZpl05YBE+F8JRhgfnCHurrq+aKGU8AR4XkHVxxMpTwAFgD6K3OxZN22NiV/MkEi7Tj8ob8THkvVHRGyA1qiiExHDTT4XgOzMNyBDYobnA2DT5marxYBFokbmKdP/oqIdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU+SVSjL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU+SVSjL"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccf7b7d188so40562836d6.1
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Jun 2026 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448068; x=1781052868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wuWxtoLkojb3/QNJMxn6zgx0PCcWwdg04dV9N02CDM4=;
        b=EU+SVSjLISt5aUz5/r5ToZzRCUiLaR7spsOkly7qMTrJ7Osb4IXI0FyOirHau2qMKu
         iytyAAGSEN7w3/4NEGE6uP20OwrkiCLO3ar8op36UWLRg5GKP258bX4Mz+ziUpxHz76E
         p9NlXzzfjmouWQibqXv9atZ0QfXP8+6JQGGJsLW7IhIRXZ/apZwhNP6uoztpKflW+g/w
         ss1bTNFY6fbpSYY0sODLyOTob4EjMgpXEWYJUf4P7hxuHpl4M8tSrNcmgIyhJkD4K1PL
         u02EpdTZClgCeEiENguk7UwYqDeWTB36F09tgCiRKSSq6OpjnypF+vYjT+9eQhNApUXs
         kCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448068; x=1781052868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuWxtoLkojb3/QNJMxn6zgx0PCcWwdg04dV9N02CDM4=;
        b=kTcNoTKKvP6wkfYiL8vrPV2CU2ld0KONeR52s7pUv7HFlVfRAxMkz/CrEPfBFeTIUP
         oLUAnZd6Kj2Y2Ks5aXnEU+uXSmuwcCsJdztZTDh72nmd5megUAqTUDoGqTrX6v9OuaeA
         anqA3PIiWph7SdBWCTaUp8Fonjn68/fw7nCe6Dmo3FHpyYly9nEaLi73Q5gOxCBeYWJQ
         PDtzpG+mioqsto8CRxhnMbuDs6BfJaq7s8VQacHh+xzyUHZQoLYG8R4yJSdyFlFGNtDY
         1jJ0rXWeQYvpLdWI4i4OIDqONbsXo2P0y2nV57KocTDeGl4LCpfP10QiMH/NaXJLrJYH
         AXLA==
X-Gm-Message-State: AOJu0Yyd9ojgtXVWBI+jCvYVb8Q+rpfdUihxq1Vg268lAq+Htz2aGed0
	7k0Lnk7rRB/wojQrMJUZM3uciuSQ2z1pQ1NPx1XaxblreB/4xMH+jer3v6WF7wJq
X-Gm-Gg: Acq92OEpEEAnKeltCzpzv/Y1915+kmIbhDrPhKql/ferfJbNSeNbVUWsHiyI4LEaQY5
	Dk+YPkWP0VRvr++gWAOREbtFk28RCb1D34Cm3Mt3eNl0eKIMI0/94h8038ocvLeCSYA78YAp/p+
	J7j7PDjuv1p168PJaYqilZGk3OwMSFH93Wy7IxeWCK+N8wMHTt867bCBlDLG5cK+FqT/67mlCP8
	yRJNU9NegKK39K9rGXhHcpwYsjvFITtwAxviAketOY1Y3/RC0Xz8fvkN68bOlPoZNAbWaGFXzBV
	XTO2ORHFA67sgZ1o4dRXlC0Y6RePNAgOQNkPwIXLy2ryrsN9L9TjFW+bpX/YPhHT+NG4S9BACGe
	3kSBkBoW82R8JjbAwQnAglN6Ba1aMBg4my69uEQPZlO/JowdJLrcZwzDC4Q4vG2bwzVg1mD2mb7
	NjieJs6gnp/ZtqeIyyulXi/N1JLylLGXA9ot+bmNUsFgm73teXHdbuufakf0S0OZKAEcObDzPi8
	JLN5TOq0dvo1pnF9fXzlnrTwxwZJa3b4Bco1IA1v7cyyg==
X-Received: by 2002:a05:622a:313:b0:516:df62:bde3 with SMTP id d75a77b69052e-51778793493mr21392041cf.54.1780448068201;
        Tue, 02 Jun 2026 17:54:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775e25c5dsm11828721cf.30.2026.06.02.17.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:54:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog: sama5d4_wdt: use platform_get_irq()
Date: Tue,  2 Jun 2026 17:54:09 -0700
Message-ID: <20260603005409.226774-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
bother with it as platform_get_irq doesn't need it.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 704b786cc2ec..d62031b02348 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -280,8 +280,8 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	if (wdt->need_irq) {
-		irq = irq_of_parse_and_map(dev->of_node, 0);
-		if (!irq) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
 			dev_warn(dev, "failed to get IRQ from DT\n");
 			wdt->need_irq = false;
 		}
-- 
2.54.0

