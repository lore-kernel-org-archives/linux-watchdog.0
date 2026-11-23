Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466823;
	b=GiFQYy0KJsxfhpCuiFydj0wnZ9LbJ2BYYyZanc0SbJKeQAtlvRjsvRJZgZZC8P4lPf1F
	 lFzsmlR2rndPmff6NSYcCq8a93/Ca0c9RnyyAq47sPe3rqJkimcPAyArTergfrNWIOCSs
	 mO1fUtinMHeG3bIYblFD4y4jetrdi2kip2S19OGvkQVNDt/00hIIi8+Oh+9QZzNRv+a6W
	 me0wZqmt+n4fq17k8Fyt7VHjHQsrcdCNBYa1bcuUaLxGlakqRf1dtVOjBYyBhULmeIXN0
	 4oJpH/fJuRGohW6S61Gugddr4ySDJN6mB1YKv15YNY0mZxpvMWoawhhDKoM232kcf6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=q/ieQ1somtCPNNRmWO29BblscBs9YmYyywCgLFSgw7c=;
	b=GrxswG5FRhRpJZz4k2lAeTJ/TfEXFjVeGu6Exp3hSU2l2P6/nvijGPYJkn17aJnPNSVd
	 2uB/K2mLk371WFQFCSpzJqOJw5a6ijLLs1E9OiGdLyuT0N0Z9Y+Dz4xaAq5e5BS7/y1Hd
	 kAh/0lOkHbNOrBS4clen8zzs9U5PpUgt9/1GaXiH8WaBdRojtiwcYgANAxnL4eAb1vm77
	 lWk2J+N7s3lJyoYjzh5+SP2nF5mdO3JZPNz7hZYelGPaOWSg2bDTKcPFEOyrLr9C9hjQ3
	 g5fGXXEzrcXbBrlxkUA5X9MX0YQRMYZJxBI4GnIbv/65QoM0YYbbNxmBrjnneml8/bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m1/NGxri";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42935606A31E
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 20:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42935606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m1/NGxri
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so29935605e9.3
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 12:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795466821; x=1796071621; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q/ieQ1somtCPNNRmWO29BblscBs9YmYyywCgLFSgw7c=;
        b=m1/NGxriI3u1HEVL7ejtsoa3to+D6e1vuTomhiQS/TAyZHdHRaY0GUNAnQvSC+92Z0
         TTOPEbj5K2K+a8sHhhDpE0Mbo3PYU3U/9pe3OhGdA1wqISOlOxOz5i5P3y+he/7t2TkO
         yeousO+/yv3dErVXdBzhMSU3Zi3+N0XSYfhrJoOMRxbP5N16kCWhaL3+GU0/5E423+k6
         wXCs3M+OcHtvnZLRUdYxhQTJ4EZhVrWXO6tLtm/9XM2iK5gBTS2oxy5rZbPt4JN7y1+e
         wIY8gL9rUJ3mWmBEuMaSjolbGYfnEr2rbZAIXa8sc3WfWqN8Bh5oSVfS0Aj8uav/BhEg
         ItwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466821; x=1796071621;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q/ieQ1somtCPNNRmWO29BblscBs9YmYyywCgLFSgw7c=;
        b=K3vaBgP18s5AzGnL3yorpG7bs/r5je9W/F7nU5okmiwY7opStqG1+EqWi+FKd0AZEe
         HbTlbezsqIzRRn3DqJ+21ZZpWUNWQKEIPsHcaONh29d5Qm7fjCff8fG//s3PD83mdsaZ
         PS8bGN0DYqHHCbn5fhvnCsBet1LbiYdWA9fd6ArrWcJfQtH2gPqXQzZogehx9R72MfSO
         dlug4mRKnxl0tLkIUlMGVORj0SwM1FEd6CfhLSCtb6Y9MrMFAFlwRgr+2uqjVFBkR4Qb
         YJjwMW22rqViepkZJSbgSAJ+10Fqqk/0GOTu5JGBLZJOArs1BQ+31qAFsLTqJ5NQeJVC
         Ogxw==
X-Gm-Message-State: APuU4Z8HDid613RGze5XDXlHPFjtheGQgBxt/3r9tjGCIkEAsTnBHSBZ
	2cQcjPx1GTLRrJ7I1RqwMRtYgiiti+IdMtDIiWebcjB80pbck9MqUNzw
X-Gm-Gg: AZFdTZeWpPSKiAojfXaksBuGKAJdsX5Wy6vWJyUXr0eKf7Gkx/Q4KcV6twpnjw1liCa
	C8cYawd4d6TzF5+QlzUGISYTUA12jDd5HvxrmmjQ/5KPIgECwNklmDVc/fAXEIVM3utJaFeVSVk
	PGC6Ri2gTEo2wzn6w7CawIex+cA82qEo6R/3Y2fKwH2+kXXdL1E4iDgYdZn4BjbmSGCSLlHWMap
	OsKOOa0klC7neQEtUzewCiD10xxSBgW/DClqhuxoe7BhVJYW4oO5xezIKPcDqsWnH1dRE0aYc1R
	GVZiGgY2dkGWmMW35hLMuteOjUZ07ghjtUk9c8nrEXZ8k1x7tp4tOBcRuvvxQ1sk1vN7LGNz8L9
	O8GTOMpX7ypnlp3Ubd1aeYmuNbQ+X4qVe8e9BCKKxiegNmONBTu44BqLb+IHSDFHA6binQ7io1v
	xg61xwyuyA8rlQloWMBT95hjSQlk8vcTR7R7hmz/ErO8aNFYVfGWHnBywj/rHT7JDNhExUoIFED
	9FHLnLAePYRXmzTa3DQ3ME0tMask1IS+ibVePtzBm6sc7+WyjIuQJutKJFTVQj7NXJLrv/tjkQZ
	lqnjT2XSGkbEQ06+YpSbFgeUKR2pC/uYUaHFf0k61k8fdzrQdrqqVPUthwn7bA==
X-Received: by 2002:a05:600c:6298:b0:4bb:6375:aa41 with SMTP id 5b1f17b1804b1-4bb88934652mr240358145e9.27.1795466821552;
        Mon, 23 Nov 2026 12:47:01 -0800 (PST)
Received: from [192.168.0.15] ([2a02:a312:c59b:a180:251a:f25f:80fa:af1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm425076175e9.12.2026.11.23.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:47:01 -0800 (PST)
From: Artur Kowalski <arturkow2000@gmail.com>
Date: Mon, 23 Nov 2026 21:46:49 +0100
Subject: [PATCH] watchdog: core: Fix module refcount imbalance when open
 fails
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-core-wdt-fix-v1-1-a315269dce4b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ6CQAwF0Ks0f00TpiSKcxXjAjpF6wLMDCgJ4
 e5EXb7N21AsuxVE2pDt7cWnEZFCRdBHN96NPSESpJZTCNKwTtn4k2YefOX20jZyTlprJ6gIr2y
 Dr7/uevu7LP3TdP4e2PcDS+qFgnAAAAA=
X-Change-ID: 20261123-core-wdt-fix-898327dc0ca2
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Wim Van Sebroeck <wim@iguana.be>, Artur Kowalski <arturkow2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210;
 i=arturkow2000@gmail.com; s=default; h=from:subject:message-id;
 bh=ERqf4DZatBQEmIQzSk8fpEPJ7HixucgVur5PzZ2WhlE=;
 b=owGbwMvMwCVmYeTc/TaVxZzxtFoSQzbLModPRTdPzqnK3xT/pTHqWjXjQ/m1dk4rjAOOs33pt
 fvZsNujo5SFQYyLQVZMkcXsodAXnnle7ze83NoJM4eVCWQIAxenAEzk6l1GhkVh7ltKjwkumry4
 pkvmYv7NyJruRsPbur/XGBjnzrnN1Mjwz259S6m92rEvi4QUP97I6f4Y1jmZ70X51dNyHdUnOT/
 P4wEA
X-Developer-Key: i=arturkow2000@gmail.com; a=openpgp;
 fpr=F60710C8D69E03A01A2801CD87A47D20C2709637

watchdog_open() doesn't take a module reference for a watchdog that is
running in hardware, as watchdog_cdev_register() already holds one for
it. If watchdog_start() then fails, which for such a watchdog means the
driver's ping failed, the error path drops a module reference anyway.

This drops the reference held for the running watchdog, so the module
can be unloaded while the watchdog is running and the core still uses
it. Stopping the watchdog through the core later drops the reference a
second time, underflowing the module refcount.

Only drop the module reference on the error path if it was taken.

This was found with the help of Sashiko and Claude. It can be triggered
by any modular driver whose ping can fail on a watchdog that was running
when it was registered. No in-tree driver was checked for that. The fix
was build tested only, and no reproducer was run.

Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---
This was found while developing a Tegra20 watchdog driver. A watchdog
reset hangs Tegra20's boot ROM once the VDE power partition is off, so
the driver stops the watchdog behind the core's back when that happens.
Failing pings afterwards would trigger this bug when opening a watchdog
left running by the bootloader, so the driver keeps them succeeding
until user space has started the watchdog.
---
 drivers/watchdog/watchdog_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e8c1fcb53c56..9ad715d4d46d 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -913,7 +913,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 
 out_mod:
-	module_put(wd_data->wdd->ops->owner);
+	if (!hw_running)
+		module_put(wd_data->wdd->ops->owner);
 out_clear:
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 	return err;

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261123-core-wdt-fix-898327dc0ca2

Best regards,
--  
Artur Kowalski <arturkow2000@gmail.com>

