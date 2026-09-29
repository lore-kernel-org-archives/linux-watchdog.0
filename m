Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AD52CCE4
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689610; cv=none; b=mJih4gGcsqZP6emB20ci79soS+ZBmYxrZ1BMRk0zYYrBX3kHrE+eqd2FrNtDpBohNsms6/az32bBh69WY/VUJ/tS4kxNb86mlWDjeK9qlPkM0flk3ZIsMyONV9Ei2qy68H4+gOcfciJ7mwQyMZvFypz7uo4ks+yD3B532f4B1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689610; c=relaxed/simple;
	bh=Za+HJYK1E43xDzddYmqVfuv17VQb25vK3pN9AzFy5xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThVc+B98T4XbMQ8+sw9fPsnoumwnvyqEHsQgZLSDBq5+HXiORm5HJw1PS6cx1iSGAa8ug5Hx+Z7s0DLFvtkZ2/tj6g7DAg2dBzN/Nunl3jq0BnzmYRrZ8fBwmpQTg52f7g8CMT3PFdd1QyswRJzcNPwbv5aYShvGZ2ktvJXjjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlxgCQg0; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlxgCQg0"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso790659a91.2
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689608; x=1791294408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Bj68ooP5wtxyCAiyK2LzTDyYvhmr7H1ma3tEIFx6GY=;
        b=nlxgCQg0Cs0LOYIgHdrJ2DMlCo8TER35eSbQSlCkitLWZnYxbkc1A/jk7ICGq9wQh9
         unS2mtLw7hVJwaGc8kEblJs4KZx2gq0qi1MQtFQsb5IDtandgSBksvDItWC6Hf1adCYo
         VCXXgWJKPZk8OSgtCOTBrfKl0G1NZCfZVUG2V/zzs6Md9hLrzEb4kLUNFFiqJt3IRe1h
         Hg4U9LetEaGbNtS32mepKX4yBZ97IWL+KRBeiscL5fzVRNM8IunobVNpM9cWvahiI+aL
         n3+zOKVBnfTQlbjqm6pS1TdTceWGnc9skjPYQqzrNhd5xYQutwVnuZSWeEKsJi3kaAxF
         YM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689608; x=1791294408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Bj68ooP5wtxyCAiyK2LzTDyYvhmr7H1ma3tEIFx6GY=;
        b=QaLBDuVe6F/FpoJSdzVtA6FSJLILUvCdPlCu1vk4jsHB/ZZebzJ1en7rCsH5C/IC/P
         oxiJ7anLwBkAYIhPriLNAXFJ7KqNYYwX36bH9ABBdpur1UuVzeaRgAsF+4rtkD892JVv
         4TLb4jHi/JK9YhxWMJda5+4eXoEHDAO772rzwRIt5a2+q79ZWC1lfFnnhHk71lxCt5wl
         yDZfT4vEqH+X84M1cQCxh/0T3lm/g8bwMv5Dv5kHz8pWzkAMtc0t+0/6qgoMAbY6GGuL
         HDC0rSoske+YQRb/V0Q5wWVk7d73IpiowM/5b+C9PWE259oM8lnlmi1wQYcUwr6uBP4y
         Ez8w==
X-Gm-Message-State: AFq9FYKaBnfCtab4vOyPindTihkoVD7Xp5DNyk6v02D6iyQ63V/ya3vH
	N0W3G2Al3Sm65AqGfAsKcwMJFnd0mPQyhbfi8/PNFJIkqRggeUa/4nrcspC5Vpju
X-Gm-Gg: AYBFou1td+8iDKeIqWfnkHUnEWYvhD0gIc8JuNa0wVRQQCMR+6VjIXHBIZC0F31ZchM
	TVJo6mm4q9F+jNTHhDflWtWCcYkomZyOVFNml9eUFkY1p6EGdkziswIxF2lHxit7ubqxjpeFbb1
	gz2m7D+UCg9x+Clyhzu6j8tqvPL7xb+uJrGuajQ4U0NQU0J1Qm05jrQIcLgN34vfMsaAGmhlzzi
	7A2RIoND6j1IzpAaypfSl/UxoTlnuTbkMyD7nRs17tl5Zubi5VaMppyJ1Csh61oZJQjUtyQ4sLV
	mD31eJxkRE4c8qIu2UU6hvnlDIYwV1xOnxr/JbtAVjVpCLMojOgkoKjJfD2EDMAnDXeFgB0YkNA
	8J4DNo34VgusM21Xlg/MkeBABxn162TdC77b4d0a3PG7dlwKrXGEw/FOtJ4yyT9HT03e4hyul30
	ZdPIX9iirDtBjfWyqB4g5hcujznJgbYxpnJ/T8hGO4ucwayV2AdOInKmGcxO/6rRTK7YCq4utM5
	h71x6eU9yZU3roovUzR/0o=
X-Received: by 2002:a17:90b:4b12:b0:3a0:8050:2ed1 with SMTP id 98e67ed59e1d1-3a0bb6596e8mr11498284a91.63.1790689607720;
        Tue, 29 Sep 2026 06:46:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497d9b117sm6092957a91.3.2026.09.29.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:46:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 7/8] watchdog: core: Fix unbalanced module_put() in watchdog_open()
Date: Tue, 29 Sep 2026 06:46:34 -0700
Message-ID: <20260929134635.2567137-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260929134635.2567137-1-linux@roeck-us.net>
References: <20260929134635.2567137-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the hardware watchdog is running (hw_running is true), try_module_get()
is skipped. However, if watchdog_start() then fails, the code jumps to
out_mod and unconditionally calls module_put().

This can cause a premature driver module unload while hardware timers or
interrupts are active by dropping a reference that was never acquired.

Only call module_put() if the hardware watchdog is not running to fix the
problem.

Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
Assisted-by: LLM
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 31567ffbfc23..24488c20539a 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -937,7 +937,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 
 out_mod:
-	module_put(wd_data->wdd->ops->owner);
+	if (!hw_running)
+		module_put(wd_data->wdd->ops->owner);
 out_clear:
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 	mutex_unlock(&wd_data->lock);
-- 
2.45.2

