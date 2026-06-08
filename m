Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7037104C
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952662; cv=none; b=gd5yCquCXvRIreUkthXN7jxH7iwzelR3FO4xIyUHcxyjwmawX1jsoOi/rk320XsYaqrmGJU79QXN9WKxevTHqR8g9zur0R6t90PAI7Jv9mzMGFVjdQzIRFbo4UCdQROJALsARXQtv3YcPe0+6WPQg3T9+mC2U5Fzs9l7eqEFLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952662; c=relaxed/simple;
	bh=hz4fPxcMxlkXvWVKbLE3lhHuChG3yhAzqnaJ0Q8Ik2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbRNLKtutOq102HXeG2Y9ZXQunND40D/tT5NgCcOKd8OQ5YRmBOd7vUSyXBgGn0CDFhDbbbSH4lT+Ovy444uOYAzLEt8ydxAoGH8svlPpAga5SpimHw+BqdNCghaJhTOwvwSNRbGPMqH5QsR5KflznBvJDJCvcrEWuy4yDI+M8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqYVV4uZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqYVV4uZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7efd2dc350cso13148697b3.1
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952661; x=1781557461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYrF02Q4H0GPi4etfZwQS6STBkC8T7voQuGLfT+/oNQ=;
        b=lqYVV4uZzKwHzJF3e3qTcdElKcACLSNPGdZ6F20JWpaEv99JdcyVW00Og8anBJ+rbz
         cl7O0Zanu+b4TAWgjy50VJZ8FEvIuW5FxT3+VRouYBaYpFTL7cRqtXtlr3GIhdtdRW8A
         MNbwp+DcL6M13Z7U22H41SfnKH2Rl7QJMhI/Y/ODTs+D9kn/rBVnDq6wewW6mUKlT/OF
         sWn9WV1irrZaCmD6BeqH5Y4DtOB4zs0gcTvsHDH5geOylSejnFl0A6HF18DoYSkTHBAd
         RzrVuxmiHgLoXTcyQAFPF5E5+JE5RnnNk2UCovrqteqcSeQ7ZBuz4nuuqDfK2g673jST
         qimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952661; x=1781557461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYrF02Q4H0GPi4etfZwQS6STBkC8T7voQuGLfT+/oNQ=;
        b=g7vg0N5/kxZ09WuFWLeXXKFiFmJK21KvHj3A6QnHO4gcfbYgPi3Me2XtwhUgHfW5YW
         KbW27SjqmaTGFTdJIFlK7nbSV7p7u/IaxxsEnFVlqxVok4VQCohd6EyIlNO7JhdOpX3/
         k/6FOHGXY5yI/WTGtsoqfBOk68foLIiT4zpeExsb7wUmfCWoYrm+wUwkJdkMF4Oi+ZLS
         oE2UIW/u+K5w3wNtm7nF5S4vWWyOGySyuohP1XygDErvb+Iq7EPewDx9eVr1Y+vg7INk
         EQC/065WKNYrgihjFeGOpJ+hzdTpJKhO80bmHTmQGWzoHOlYEPQ6B+S6q848ShzbsOzM
         Pp2g==
X-Gm-Message-State: AOJu0YxVcp/DyQ3dV0hALUCVrp//9DL5G1cYXkW8GsrMgR4qHfKJLXvc
	HHJhEX2TPY0dlgAzPVhlhZtL5NEMj/1psSPeW5fc1CG9MhB0JNQorzVYDhSkSGy6
X-Gm-Gg: Acq92OHl5EDkdIA1y0GlCLXqdiSstdgawh8c+dM9IvTKQEOkNX17u7n13pkj9YZnZO7
	7YHEIeand4xXXv//9jgyW+7Pu7GHbhntA5Zb1o0jvZHEEILGqc8crdGtbqNj97x3lDin4caxKfI
	TPzqdT86FJ24nIjMrLIy4LOAjvNbAdb7mGWXGyoYgFDeT5n4K6o8QlbF+hExhODV2qZO6cdKB/K
	SCZRGK1oKtS3YZteoq1Ilt/29abhtJ7nxIkeNd449slvFBANW1GcBtluinMr5XyBm3OhfvaoiaO
	QaDVf/b3uD2tn2yFSVWDDsW71kSbHH5RW2h+QrDUI9EHMC6vBRCMJbEBXR6dzZ+ErIssHaXKYvi
	eOghMXGWX2dQDZE3hzH8G6YI/9n1OXH+Asl8gZpPYuSB0mSve4ynJeRX7En3mqMqcUzo1FPT5S8
	AgfyYaIUOwo/ndYBDTP8x6AG1/x6WZazBbGACtjGXjX9/32Utvo9m9fJoGeRerPJUZSRKBYrEyc
	aNto+c2m6Z/MoRw9d63IKPHXNF3ij8OEfaQCoQoRf+ewQ==
X-Received: by 2002:a05:690c:c52b:b0:7db:b027:6155 with SMTP id 00721157ae682-7ed0d3c96e5mr170494037b3.37.1780952660707;
        Mon, 08 Jun 2026 14:04:20 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2399ab1fsm89468367b3.33.2026.06.08.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:04:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 0/2] watchdog: pika_wdt: portability and timer lifecycle fixes
Date: Mon,  8 Jun 2026 14:04:00 -0700
Message-ID: <20260608210402.31545-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two timer lifecycle bugs in the PIKA watchdog driver:

 - pikawdt_release() could race with a concurrent open() due to
   clearing the open bit before stopping the timer.
 - pikawdt_exit() unmapped FPGA memory without stopping the ping
   timer first, potentially executing the handler on freed memory.

Then replace powerpc-specific I/O accessors with generic ones to
allow COMPILE_TEST builds on other architectures.

v3: fix sashiko reported issues
v2: fix preexisting issues

Rosen Penev (2):
  watchdog: pika_wdt: fix timer lifecycle bugs
  watchdog: pika_wdt: enable COMPILE_TEST builds

 drivers/watchdog/Kconfig    |  3 ++-
 drivers/watchdog/pika_wdt.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

--
2.54.0
