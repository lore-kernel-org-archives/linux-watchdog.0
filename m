Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF146E019
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389379; cv=none; b=sniwEwuZmTPSe/z8xiVpyWdGQfo7JA8oGr7S25NtK9UQgXFgbVWJ+kTB4nIWDKPCb5LjEXW9wrfL1NMf/TDK7xUgPl6hnbHeM80n/fnZArB7yIqT1qSwi8FZeu9Fye9eMZa+i+mRwIBqr1ts5CPBFrE07kDVMibJ8PuaE0XlCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389379; c=relaxed/simple;
	bh=aLewbFs8FlsksoxGpUNdIM/fU4VhPzZwmbdBRBeVyRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AL8aLri21EXbxSU8qB104ffzEdNWbL0DBi0WgnzY815XZ29Lf4R1jNxcWhdg1t4qxlQ+w66VIwERu9OBzZgHW1CP0/e9WBiRW/7yYyV8u+HlFhsQu+2PmiQy/UlMtCN/tkQZwqA0E5kbmWK6MIa1lD4e1l1A8+WpqKrrk4eaZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZpiDfYa; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZpiDfYa"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6d6660191so631019b6e.2
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789389376; x=1789994176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YavU6eZ3BhhanoEPKol5pZZFs/bg8KvofxNp5pSA/U4=;
        b=sZpiDfYa7lYQuSGZr0q9aErXy5zvwyWYkKlBRzgfMGd03tbqo4G5r5iErnEFTVWEf0
         8d/UQ2Sygls59rz+LCpsoXSNDqH4V+G3wU8YM6nmTUm5b5rZWQgL+CR0adP3fcL4rf+C
         9ycJ+PnkUo82oNkgIgy2NMyT5cDjiNxpko14CU9/7vaIfYszkUN6srOVtq2bh4Y5Tps/
         I1wusHxJC2FiI8b1H8vZe7M9WI6+blOk//FfsZd9Fx+ydHewUzuuX01EsQzjtIdfAtxl
         EghFTMHJFQ9gzSyEzymwPKFol6s/NK2haDV3iQkMdSft6o+XHjoiP2h1ugCG1P0S5CBG
         PREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389376; x=1789994176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YavU6eZ3BhhanoEPKol5pZZFs/bg8KvofxNp5pSA/U4=;
        b=YT9hFauB0ZHfBKwF42dlUQNZuxg+EaFUb8ub4zHCX5dPA0qtMUaHdDDjBLGCYDzMTP
         C+9chlGUhsb8qSoN9lu25jpy9KVNnzh0GjOr/gyczmLvZ1Kj5KsXkXUhoTujUIJ5WucE
         kNw+Cs/F1QqYz+HsKmXuTt8cBjsDJQf5VLMJ0pvDXapShfhcqRLlXrEPeoLqsG8yspAa
         Wtkgu7hYv8VbL+Hx6QoBJAKck5nWfsSvIF0u7y+vajCuxAJ3IAhQ7BTyLfMHon+6+cr5
         HfsagShnW+/pZfMhWc5tJz4TzonUw0o8Pim/iA6Eeyesl3c3ClJvJbMGNwe3P0fVVScb
         DcSQ==
X-Forwarded-Encrypted: i=1; AKwUvByQvK72MrakYIetuKIIYZ1b65cZN27ESsXIpLQCIobFehtmMUI93d8Ka2v9FjbbJy6ZwIjteIjwHYthDyvcIA==@vger.kernel.org
X-Gm-Message-State: AFuF++mjipFfRBH8T+qmQKrK6G6y0kpa46/apx24TNEMyG4T4t2XmXae
	DYFt/RhPDZipBqROpmifpXMtDKeXMyT15R8+9bchbUVDeu2icXMI3DrU
X-Gm-Gg: AYBFou14thKzx+PAN2vgDS22RTpoj6E+vsQXU4GW67+oQsQ38Ge0nf9IRWn6m8c4DOW
	bp20Bg/KqC1VKY5CvsJczVZXwfOSpXE/+gEzjjG9GjPmMidI1wvAZ9kTjzbmwVRAfiWZ36nv3F6
	civyAP1irQgCJQyg7/BJYChbxW0x3CiYu4QP9EJFXaO6RwipU5IbMHbHqhWWlPDuZTcoUhFCo5c
	VQSBipk1gSvgmpxbNsVgqwKDpoPWENv+6ObUjIh2TO46naT4kVwiPZZkE8DOLxuSoWFgwKYNXp9
	O2E6PQN54CxlSR97cr12ZwF7cHWGXecm8S9ZrAPcpLqCaFz0JROTLY84sMyJt8aqG92awxGzK5z
	MpUs17O4/evICusMSZcjgWVHoGKP3yOkndhnlfmnBNQOe4gRYNHh0pq1Xeohxwl81+rmTbsFRFc
	lPltBvT0QkmImhoyZNtUrRUsb2CLrgQWQb0mBfuIESzMFpN4omKOVlJ7OgHwzzWLU03BVDpG8aZ
	C1s0uLQI/DKfAZu
X-Received: by 2002:a05:6808:6d97:b0:4b3:1a95:4160 with SMTP id 5614622812f47-4c7b3ed4b22mr1318687b6e.18.1789389376449;
        Mon, 14 Sep 2026 05:36:16 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3315b19afsm10256886b6e.10.2026.09.14.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:36:16 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: shwdt: register device only after full driver init
Date: Mon, 14 Sep 2026 19:36:09 +0700
Message-Id: <20260914123609.2186477-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sh_wdt_probe() calls watchdog_register_device() -- exposing
/dev/watchdogN -- before timer_setup() and pm_runtime_enable() run. A
start command landing in that window calls mod_timer() on an
uninitialized timer (NULL ->function) and resumes via
pm_runtime_get_sync() before PM is enabled.

Move timer_setup() and pm_runtime_enable() before the register call,
matching the order already used by rzg2l_wdt.c/rzv2h_wdt.c. Add
pm_runtime_disable() on the now-possible post-enable register-failure
path.

Fixes: 8f5585ec3d17 ("watchdog: shwdt: driver model conversion.")
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/watchdog/shwdt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 719f100aae60..c22b8e760476 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -263,19 +263,20 @@ static int sh_wdt_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "configured with heartbeat=%d sec (nowayout=%d)\n",
 		 sh_wdt_dev.timeout, nowayout);
 
+	timer_setup(&wdt->timer, sh_wdt_ping, 0);
+	wdt->timer.expires	= next_ping_period(clock_division_ratio);
+
+	pm_runtime_enable(&pdev->dev);
+
 	rc = watchdog_register_device(&sh_wdt_dev);
 	if (unlikely(rc)) {
 		dev_err(&pdev->dev, "Can't register watchdog (err=%d)\n", rc);
+		pm_runtime_disable(&pdev->dev);
 		return rc;
 	}
 
-	timer_setup(&wdt->timer, sh_wdt_ping, 0);
-	wdt->timer.expires	= next_ping_period(clock_division_ratio);
-
 	dev_info(&pdev->dev, "initialized.\n");
 
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.25.1

