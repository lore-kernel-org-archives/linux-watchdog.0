Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343015;
	b=O8eG0TYENNJglAsIiFZiOI94BSmC2WItKGTKN+sRsw+Ns74hcI6GMmu/R9plJzEVhvWn
	 JDtKMnTpjKVp7YesdcV1JhA+gpzgC0DWF+zJbWW7wrbyXutir/PLa2xJcN1Pr3ykCuYqz
	 M5QAPWUWrJjLo+4Y5hAQUw0ToRyUpU3leaCrllvwtMAxgS3HZyz1VYog3TPI2KCf8O2vc
	 A8sMTk9F3h+Bzio2i2GAKxEZEycuw0x+NneY4XZt5WEVxuvHaay5r0169I8BBmeg6GLDM
	 qOFP1+EOJqCLfZxz2c7xToqGJneVRJItp4TlPMjPCxwTCqn0Da3y17M7DXMpmsfGkgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cSubAhLf2nToqdpyL5hNhVaoMwlhz2nCl7Gn87Xueqo=;
	b=okbQRXP4z864muzXdw914D+LpmQAsA6KO4IpSQ6TdOJWp7EaJXggH7Xf/7XzXwVfi0Tt
	 HruxIspFqbkJoxr8QaNb4/sAAoPyicd7G9IcuRDOD4uHMELr6lE99AqnFQmLFlQu8mir/
	 3MLbi7dN5hrs8N6HiHbIvK4tvQnqR1wHce8Qsg/dYj3gwMBrZRHN/xcDYSt54h/zZs+Qa
	 rcZU7PvRXob4hO86RMRojsKS1AkH8KIgR01HmvLfY+hftJ540S7n6zvqGv/R2Alf6U261
	 oJKBhUrGaY7klp532M5EMMyFU8nKvHNDA75q0cdfLBWzt8CECAJHqhrm3nRm/HyGVJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UriH+rnc;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23721606A32C
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 10:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23721606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UriH+rnc
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f05bc71e01so7259295ad.0
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 02:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795343014; x=1795947814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSubAhLf2nToqdpyL5hNhVaoMwlhz2nCl7Gn87Xueqo=;
        b=UriH+rncW5dbSem2k/IMc9Kh+RX8VYHC4eywgNMHqwQRSEq6rZUOBfKq5ywV07S8wv
         yImnubBBBgIiR3KHa6l558qnoyw9fUfwGg/QX0rLcHz1icT7w806qTQcJuo0zAmQ4sZd
         EyWL8eTiFIGcmqExv2CklrPO3Q+CpX5vOC68jofIDNjIBD4SH6soHvTdTbHbwmiNkSmP
         aQtxX0RG/62iqUVCG0jbq/m219Dg+A2fKenLBKHrBt7GAZ5F5frWQz2T/6Ecb3UcUkvf
         /rnURGXNRiyy/ZdxKrPSmmfzlVQixOO3jGHj/iOc0lQr2p4dxae/7HPVnpzMWSCXdOYx
         WQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343014; x=1795947814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cSubAhLf2nToqdpyL5hNhVaoMwlhz2nCl7Gn87Xueqo=;
        b=vfvGwz/zMU+A/lOhNLFbp60LeLSAgFXUiFHyW1C7jcLAR3XkKjg2Q+rHxuSgLCy/aK
         4FIcZ7EWNEXd0gqxw4vz67K8pSt693UjHBahaHihovAEMuOcURhfWjyxlxz2At1kx4rn
         iSDs4l5XMjJeihROtazHoQu0t2oiFHkE9nMm+EoGWBswsKRfPG7HBIoXCk7GBoft31rz
         imIRDRvMyDTBYsy9uDYIybs9eNdHzu5ni+qXAeAHfXGIQ4AfNxRK3rI7F2umkdLdlXOr
         1AzOCVK5dFeLPirEYIo45KiMp0zg8ggeLkurfBC4cnG6BivrjfRSzmaqeLgCrRLbo+G/
         VA2g==
X-Forwarded-Encrypted: i=1; AL+hErHoLI+tfmg/oBo/y36q4p2IoZgdlvjfvp/I9M+qrPL+vkrw5EVwmAQW1J37eAQS0QDAFlKnfVh0sXBsU0dxYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+qtLCcsLjGKNVOFV3+WsFG2ZqKJ2ynu3FL0QhN5q5ZJ6lPO1EB
	UyhdyOywdPM3Bzp1mP01Hje1hxTMyEkeRPQrEdrzON6/AD8rYmvfJFd3
X-Gm-Gg: AZFdTZf7ZHKw8dSW/BavnV33z38FuVzbDZD32r8ilQJ8jF6XGo01U/Lw+ighHPgPZGV
	DUj3wftPO70t7fABppOlG+IMK5Snar5UVii68/QMgrWg2Jx4JgsaiF/xdH+OgeUVA1+9c+UJS75
	27sENJx78rdlVFtRG9auS6mNc6YXIZxmcj6XygZpHLvFh17E05z7c9NScroFULOo2kiGQNFqGOt
	lKPiOx1GdJdpMUdMxZPZ4ebn5krJ2/K5LedWDmCI7SFS+YVjNotmORi36h2OV8fjF0v5A5Bhbox
	e/NNP887fKun69Gx8NV76sc+LtPAxiXMwZfP2rL4yOvvl6euPJLYy0GT2zGByvy0mCZVhTtA+0S
	zJBafYc3VqWVf3U6TxotjzN7hsA5kcfA8IR6AM4E+8G52mGJIsuey7KTa9dCOHKqC0Y/gL5RxPm
	CNFNcplU/NHVgaDkEYb99k/37y8BV7zYI9Uia6xj4ThQXyhxU9qMtYmiZ+l0bxxWwbeLQvYFuFv
	8GHG/d3Gjq5ARUotpuAZ/wPknUF2tMBrJ1d7SGq8Bbo/KbPBum5c7c4E/OkN/sbEG0zaZ0kbM+f
	iXFLWa1gtpbT8V3Z1TefC501tRyPum9/c4nwSJnykvhDV+8ThsE=
X-Received: by 2002:a17:90b:4a48:b0:3b3:b5b4:e4a9 with SMTP id 98e67ed59e1d1-3b41c7ac07amr7895999a91.3.1795343014416;
        Sun, 22 Nov 2026 02:23:34 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([134.82.71.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm12098095a91.0.2026.11.22.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:23:34 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: linux@roeck-us.net
Cc: artem122novak@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	wim@linux-watchdog.org
Subject: [PATCH v2] watchdog: bcm2835: add newline to dev_info message
Date: Sun, 22 Nov 2026 04:23:28 -0600
Message-ID: <20261122102328.207524-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122082943.173681-1-artem122novak@gmail.com>
References: <20261122082943.173681-1-artem122novak@gmail.com>
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

Add a newline to the watchdog timer initialization message so that
the message is properly terminated in the kernel log.

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

