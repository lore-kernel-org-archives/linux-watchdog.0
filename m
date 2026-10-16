Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56F36DA1A
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188983; cv=none; b=lUhm/5IT3n3YEieNXnv5m8tXVbOm6ShDJbTsk4tBjdt2qRJ/xEHwsOsrXWR8Ux1yI3ErqZfCmJxTFLK2p2mPItxdxA4jV8OCozARla8o3lX56j4UjzWuEDqBcVChhZoKL5MV/+P3svbX8/YZmnqkfuZMEQ03diPzstYKrfOqQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188983; c=relaxed/simple;
	bh=XJsty+XVq3BgRuwoN2PV39ABqsBfB0LokyWIO3aDiLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+A7l41s0+UMq+tV6jktz1WzrLrKRqY6X43d2thAy129uZdk/gqvMAzNjkqgFxceMzTLJvZmf8LIEilDyRytggN+wVJaYEk21VoWsBXQQmgmsSHFfyLJ41PmXmODvkjLS06G+M68eZwiUvEdlzOsEibCH15DgC8ROybS3C0WOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbG634vI; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbG634vI"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1517bda04a0so329760c88.0
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792188981; x=1792793781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bsRKo08wZU2d222RmzKutSRcq0g6gJCTiEkblWEA6+U=;
        b=ZbG634vIPC+kuAzhAbUYFxgmlxlQ6ybF9uI/bvrzn+X3X5YMCdOfRk5Cz2fKwr36Ov
         25odjBoN4/m4wZFwKHPGG7fWShsJ8OcaQoI25HsBXBasmhgy3KoGIqFmUf0V+Xzlsbcz
         5kgz80MkzRjF73+xLKPQL2O9OmINQziqn2XNykKrDK0OYRwkSFE52541+zHDoDeLRdT+
         mTpIO8phRt6dez3RgwoqqEaJh5xnj+r9YEfynDg1UEOK1B5rfF0qdBVjYDKYPHBD5MIE
         QJYZYVElbkaR3K/pxC7h5fpl01+9Rt9agD8H06zyVG5Eo3IK9vyar0kORxRt/nvti8nv
         WB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792188981; x=1792793781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bsRKo08wZU2d222RmzKutSRcq0g6gJCTiEkblWEA6+U=;
        b=tYACEMmSVAeFxfPpWO0zG/9wbJ/7AOXZ92V7VmMJVTzwLk6GRZ38QqDcf9UCBFqXX1
         DiGtU6xPqtkiVvGLQH2wamr/TokHH3CAjDhcD8ETYZqWxvaB2jer+zs5AbJUKyROA7oC
         1loCKo9Vkje0RzrQPnwZEIDySfSeuHlwScx3T50qy+j8TAEwnPb+yyvnNqbZaucb7jaf
         yefdjSZ/92qMCYBOeVUVVTCO4oaUAIgMCVgpkDL4m/0PApAezmuvdb9nGgzFvlZKU9pj
         pS/AAA0hZ9eCpTWnpjRDIDM1v060Cupgt4XQ03oC7Xi85HUYG87z6VX2jUAS0uKYvKgE
         Xt9w==
X-Forwarded-Encrypted: i=1; AKwUvBwyRUzyZbpDn0AHoWKvm54cY3MWJ8575n13C/n1mq/55kL1SwXPEJ1Z0Dy5EIXr5ZFf23+wii3kJRgT/lIiDg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIScEzwdpV/N8PZzZliGC3esn68YupzFyV45LzC9o5Klw0hXO8l
	MEKT8ILHtNFciW6nhWh7YoV75gX/cV4W+ZnivPQwgkdEZOIcoo1zgQHT
X-Gm-Gg: AYBFou1zUm34z0rBAgZ16U5aMPrjUZer7e2McJtiwdbAJJL1iAHljM1jwCoU4Op1qj4
	ChRopotPxg5w5KdUqbXbTZ7hOU3Id+UY4Wk+DYx8v+kZyQ1sOGuoL+CslcxD4ttwuFV8umB7dsx
	9lZh6CZm9+irVNB7mbDqKOD8XAV+A609cMc1PwI6VKJCVWOqVZidzf1kpd9FgOIzMShZjvFBc61
	Z9PaC9RKynN1CeF1jpwuCX8Gh0qKRlGhTVDPfdUwIWCqYFc2jSwsnLhwBL0BHRXhrSb+QqqaZcP
	wD9yRqgTiTZvOQexmFa9lflYMgHIvt73wESBJ7xodU9ogNBtOn1MNYVJ2Vp8uuz20XTT0pIF/oV
	GSZUnyo+LBf8tnKexUxaxglVJn//P5AZ9y5tH7IycT97DoVQlKwDKGQ68BmJ6fWt9pgrE88DyH1
	yDjc3OUUXg9HwcVANOn8j0so48zGSjEw5MMZ3i84zH8IsnnPPRzhslROzcrYyvzxDTtXkPxw==
X-Received: by 2002:a05:701b:208a:b0:168:fe32:35a with SMTP id a92af1059eb24-18512296a20mr1365274c88.20.1792188980748;
        Fri, 16 Oct 2026 15:16:20 -0700 (PDT)
Received: from eldorado ([2600:8802:b00:1f84:d294:66ff:fe95:a98e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm10480863c88.6.2026.10.16.15.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:16:20 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	manuel.lauss@gmail.com
Subject: [PATCH 0/5] MTX-1 watchdog driver removal
Date: Fri, 16 Oct 2026 15:16:12 -0700
Message-ID: <20261016221617.2223004-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes the bespoke mtx-1_wdt driver and migrates it
to the generic gpio_wdt driver which it should have done ever since
gpio_wdt existed.

Assuming the patches are satisfactory, I suppose it would be easier to
merge those via the watchdog tree than the MIPS tree?

Florian Fainelli (5):
  watchdog: gpio: Allow devices described by software nodes
  dt-bindings: watchdog: gpio: Describe minimum heartbeat intervals
  watchdog: gpio: Support watchdogs with a minimum heartbeat interval
  MIPS: Alchemy: Use the GPIO watchdog driver on MTX-1
  watchdog: Remove the MTX-1 watchdog driver

 .../bindings/watchdog/linux,wdt-gpio.yaml     |  11 +-
 arch/mips/alchemy/board-mtx1.c                |   8 +-
 arch/mips/configs/mtx1_defconfig              |   2 +-
 drivers/watchdog/Kconfig                      |   9 +-
 drivers/watchdog/Makefile                     |   1 -
 drivers/watchdog/gpio_wdt.c                   |  15 +-
 drivers/watchdog/mtx-1_wdt.c                  | 245 ------------------
 7 files changed, 31 insertions(+), 260 deletions(-)
 delete mode 100644 drivers/watchdog/mtx-1_wdt.c

-- 
2.53.0

