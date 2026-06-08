Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BE385D7E
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952665; cv=none; b=TRRxOTeo6N09gBm1JcssKjJveGPMwaDRiRqgYudRLISgao+74ZFNaDo4pOD00UhVi1oYgsIDskHNFhdfm7mvuE5RBmKo+OryIDoSzqea4b3N8nH1lPcj7YyHGAklMHR/5LaLuhU9nIaT9nYOM+P0Qj90t4WGMkvxe1lvT1cBQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952665; c=relaxed/simple;
	bh=eQVQngmAj6T5Ofq5iPClVJszXRnjeijZdxVbnGzfx+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gR0v/YWZt+4RW63MFZl4WPxg1wD2dYragCsOCx34CuEIZPlJnpQHn7wadp9kRfUSfhlwKBoUT74uWJ3ERj+hHVgArEW8CaePC2hUAvMEp8m4F2QN36BU+YTLKNLTKif09Fk90ykPTzMsXrstLQ1uWOWQe0BMzg1LF+VmCnCx9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwRK4CeU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwRK4CeU"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dc2b658544so43507857b3.2
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952662; x=1781557462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNaBAmDTN0BUWsmF0Hwzk9UyiSH6I83sWyPJfmaJMDU=;
        b=NwRK4CeUgv6x9PNyXDO63t8AqQ51Vv7Pz5Mom7tHg4cIW3c69G75WAI/06gfhPgBav
         0wRb9mL14Q14HBcB4wpKvS7q8wFpXMD/hyhPjn+4ys5UDTXQo6lrTGXDfL03e8waxqvS
         0HrIfnS1Tzfi5FKRO5xTHFFFrrnGAoE6nihUAADtYIcD32vrc4ZB8/VpAUKApCWKKLZ2
         uTHpYJCFXEACyO639D8c9u1jWAchg0uThyFjTOJuTTjmcD+QLpzNpV+Z+8jDSCz9Qpnn
         /JTU/6AnXGgtpQPg0Hyk2XzmMO8SecuSXPSejSUmWqrjeFFueWH2gL1AhGj1XlfWFAbo
         9FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952662; x=1781557462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BNaBAmDTN0BUWsmF0Hwzk9UyiSH6I83sWyPJfmaJMDU=;
        b=J83NDrxp1LRuqdsYeY2F9Q77rcDBN+CpwLMh/FqkIl/3KcF7eQzSImSWjENzOzSjFL
         u3H17i8wR0NTStc1029pV+yZDFtGKW7/aL5TO7t+k1i71rJyk91pvgW09kA9Ogl4stDa
         7FVwO+q1L8H3MCKW0LUX/0R+KK9dmg2EHoC/nOvNwbLcAX2EFUclgesxRLYfptT4Htq0
         1uxSv4NFAMIlOhS4zbO59jeVwjbRzwmSuWCMcFCDJZD0ol7KYndSGqexRrnM3rHPFwzb
         ZmjAhwtDEiFAO+n3Rep11pRoE9qQSfS1sIiKt6oLB0bL7PcIxG/pUBAqoigmniWGkiYh
         2pzQ==
X-Gm-Message-State: AOJu0YxvV8mrF8wI5znykBXytADPDquuglfX3dSTn4MdJ/QWpkzz4hmq
	aXUldow27+kqsmfRh8A+w+rYHLiWGZTyb9VoCoXKey5bcgIN2c1UYu/BwWXyHhhx
X-Gm-Gg: Acq92OF22avA8dmP5WZQDdyyq+WRDIsXTOuCDAOf2mZMC+KI1v1+2oe5uFwlfzpbUEO
	mGRqCnStcyuh0XoAU/AwX36396eOuLXd94fMfnoQSJodT0GlHKGIutUBkxIx7x3TkeausGGjllI
	NrafWOXOjFKTvAWgOB5SmxbrrFlxEmWHf8D9swUbOoTvK98nXn+a242fAZcq3zCJdoI7zjtPXfu
	/ZhEtbo7O3oqOL6MahwKt+FiY1MOWOPUdocCnFc0rK11jXvDmV46QZLBNKbB1nIdKi1im5p/J1T
	a8aHd0Vlu4e7Xqww0HmixSjdhFRVqePHx/G3ZeFwVmUUIzwjuFCrM8kBmzRsuf8pNh2rKJ8JuSr
	hUwkxgH0SrmGguaPuRqK1a2VR7P+w5EcOxb08W8xqq5fdrWauYhwR8htlD7qI5zlfa5qFOuTyXy
	hTGnpfJCjLNUlYOhbA6juYjsd/yzn6J+eSTBzjzHjwsmHj4/3OBNGcmUf9fS+8dICOyEwx98ynC
	VH3O7AQhOUZTxuVE2u/f8/xxrf/JnUDp0VmiuPGIIZAPQ==
X-Received: by 2002:a05:690c:4512:b0:7e2:b35a:adba with SMTP id 00721157ae682-7ed0f630379mr167776767b3.21.1780952662058;
        Mon, 08 Jun 2026 14:04:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2399ab1fsm89468367b3.33.2026.06.08.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:04:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 1/2] watchdog: pika_wdt: fix timer lifecycle bugs
Date: Mon,  8 Jun 2026 14:04:01 -0700
Message-ID: <20260608210402.31545-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608210402.31545-1-rosenp@gmail.com>
References: <20260608210402.31545-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two timer lifecycle bugs in the PIKA watchdog driver:

1. pikawdt_release() clears the open bit before stopping the timer,
   allowing a concurrent pikawdt_open() to start a new timer that
   is then immediately deleted.  Move clear_bit after the timer
   stop.  Use timer_shutdown_sync() so the handler cannot re-arm
   after the call returns.  Add timer_setup() in pikawdt_open()
   to re-initialize the timer for the next open.

2. pikawdt_exit() unmaps FPGA IO memory without first stopping the
   ping timer.  If the timer handler fires after iounmap(), it
   executes pikawdt_ping() on freed memory.  Use timer_shutdown_sync()
   which permanently prevents re-arming.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/watchdog/pika_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index 87b8988d2520..d567103ec5e4 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -117,6 +117,7 @@ static int pikawdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(0, &pikawdt_private.open))
 		return -EBUSY;

+	timer_setup(&pikawdt_private.timer, pikawdt_ping, 0);
 	pikawdt_start();

 	return stream_open(inode, file);
@@ -129,7 +130,7 @@ static int pikawdt_release(struct inode *inode, struct file *file)
 {
 	/* stop internal ping */
 	if (!pikawdt_private.expect_close)
-		timer_delete(&pikawdt_private.timer);
+		timer_shutdown_sync(&pikawdt_private.timer);

 	clear_bit(0, &pikawdt_private.open);
 	pikawdt_private.expect_close = 0;
@@ -291,6 +292,7 @@ static void __exit pikawdt_exit(void)
 {
 	misc_deregister(&pikawdt_miscdev);

+	timer_shutdown_sync(&pikawdt_private.timer);
 	iounmap(pikawdt_private.fpga);
 }

--
2.54.0

