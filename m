Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02504475346
	for <linux-watchdog@vger.kernel.org>; Sun,  4 Oct 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149899; cv=none; b=Sh11GdxPzuwq35U5/4VqOY+M1OIwP3YGq0d/x/8s8D4uqLUfdl6GJxqTiVPLUoPaJ6JWVWDiu39vSoXdWXJmE7WoA51uUj0KgBBYZK1HSD8AM7w5Sd1nPrvSTU+ZisxyqfQWMcqZ9MPc5fC2q4IpIj9kkaqqyjF0iBdeTS6u2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149899; c=relaxed/simple;
	bh=EIDKNMktdL0LGz2pcFHCC0gOYw/pv87lPZRCv+H+IMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/bFemgmWpkTVjhLWk9u/c6g0aAF/0tmCq3Y4JHXxba/cM9U+zOOtoxazGSFir0CK5x/sKqEeREB2YAliO8Ld+N8PyBdJrcmdJcw4tC7LstNibZs1wAhC159Xx1nAHgpFY091+sVVjVuoZND7501k050t4ge16MQIO268P6MFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKw8pJ/D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKw8pJ/D"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so11046365e9.0
        for <linux-watchdog@vger.kernel.org>; Sun, 04 Oct 2026 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149894; x=1791754694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DG6Ijqzx5tZCBpjwT37tlUEZBO9Ju0fncZQV6F7YmY0=;
        b=VKw8pJ/DPhyxn2viHcWLxCwopNjffhs8RZV1/hULlU7iifHuNjQBoZhTPtjK0N4weW
         iD6FKRPOVaP3tUYwqP3ncjIWd3DEAAOKU4O12vux421ViBMSu1e7L23ijHRWDYiFMYz3
         QlqKmsbrOCxz7qrJ+0VEjIi1l1gS0WoF5PwDaOnfaqpcMwhiQ3iuD793H02auSVAG+jO
         BcVGTBM23uYz1lQ09yBeeiuw1gWeH6S+LeYjfQiDi5Rq7tWpbIH9/nhNOjOT8q4Ipnxz
         crGXvVYdh0vTHwKd8qsUMR13/uMgLx/A/g9n+hspwYT/tSaX2VY++uaS4zED7H8gchFD
         jHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149894; x=1791754694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DG6Ijqzx5tZCBpjwT37tlUEZBO9Ju0fncZQV6F7YmY0=;
        b=nPTvMCI0301suZQp5lZERwLlGvU2lPnlnE6YFzlfPjeZkdrGrH+FrrnlhJzFHDgZhx
         TUe70/YgOWq5YF8Dv3daZHAHorkwWFI02QCDa6z7UZbMft1o7RcClAgOJXHzkBWuQowG
         A8vVJfIDkAavk50DUJV95ufex0S8wox1OWmATnmqegkBa4ocnxYajjVTke567SyPRS1W
         tyMO+EtIeoEV8hMDOaiBySBNlASVC1xnAtrC71kIeC/frE+ZpR5YmfyIIQtFetGLcYjF
         78zjLuvRQDQmz1qpX+cuX0EOTzYZd1jszsw89O5zEUjaobl7oQNDHzWy4yPTHEAbd7wt
         eDzQ==
X-Gm-Message-State: AFuF++l5OM8tsmteqHg8H5f1PdjYQiG5JQ5tKStIr6PeBfiiZe52yn48
	nwxmvm96SyOVZrDs5eQ5It2v24Wg7ZQhEodsNZVvndhBy5VJMkEjyJkq
X-Gm-Gg: AYBFou0yZIyKo0fPpDn5o8Kq4hTHmbT+44qlPhlRAl9Gt7wiPLyLu035cSzDhfKGcw0
	vILgPejG/l77NfvplrX1phJGXI7+gIHbllLv0ejsKUbYdF5I7PD+cQeQkazhQjEzxBTZsRf4DWh
	5FOOGMuFQ8FjwMOQ8j1rUk9kLdBUij56u784qaLpRioyYx9rTTSGhL4isGt1UsaozSAqJI+/P3u
	W8fV/ozVwvgS2+ckeBo8jPUyDd9OsNZzHR7NGI5qA1gFhkAK/Xzs9OQbur6T9TUD7KJh+271VEc
	K7qys9nAgtg5LAf4Sd9lW1V2hfSDs1tO+ByhRrbGSrNy9SkMsuzEhAmd7L0CHWw0kfp5ugNnvsl
	03R3/2zsBG5sSloBcd/gRCJm0WTJ2pG8ohfzJcGIXpJJ13/SY43MW5RbQ1R3BJE3vEP5SNQ8nXo
	1hcoaLTCd75uZnblJwqNQNSRGgfRL9THz4FG99M50V6YYKO6u2baFrPoXxk2L4UMBbfsW0GMwco
	5AqFBePSwoe9NGLEJikUzj4V2ZpsBo8JcdO9WJmCQZwOABcge//p48bL57ioBG9LEbyDjeh+I9P
	o95xUYQ=
X-Received: by 2002:a05:600c:3b14:b0:4a0:1c10:12b9 with SMTP id 5b1f17b1804b1-4a1680fda81mr92920855e9.32.1791149894375;
        Sun, 04 Oct 2026 14:38:14 -0700 (PDT)
Received: from voyt-laptop-dell.fritz.box ([2001:9e8:bd42:1800:7f8f:d400:b97d:31ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8c4asm22189320f8f.37.2026.10.04.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:38:13 -0700 (PDT)
From: Dmitry Voytik <voytikd@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Voytik <voytikd@gmail.com>
Subject: [PATCH] watchdog: allow WATCHDOG_PRETIMEOUT_GOV_SEL=y
Date: Sun,  4 Oct 2026 23:37:55 +0200
Message-ID: <20261004213755.554191-1-voytikd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue when WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =y,
and always is =m.

The issues can be reproduced with the following steps:
	make mrproper
	make defconfig
	./scripts/config \
	  -e WATCHDOG_CORE \
	  -e WATCHDOG_PRETIMEOUT_GOV \
	  -e WATCHDOG_PRETIMEOUT_GOV_SEL \
	  --refresh
	make olddefconfig
	make mod2yesconfig

	grep '=m$' .config
returns only CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL as module:
	CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m

"make menuconfig" doesn't let it to be switched from =m to =y either.

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c0ef..712ebfa1c99c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -92,7 +92,7 @@ config WATCHDOG_PRETIMEOUT_GOV
 config WATCHDOG_PRETIMEOUT_GOV_SEL
 	tristate
 	depends on WATCHDOG_PRETIMEOUT_GOV
-	default m
+	default WATCHDOG_CORE
 	select WATCHDOG_PRETIMEOUT_GOV_PANIC if \
 		WATCHDOG_PRETIMEOUT_GOV_NOOP=n && WATCHDOG_PRETIMEOUT_GOV_DUMP=n
 
-- 
2.55.0

