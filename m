Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3F2777F3
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665126; cv=none; b=bAcGnHH6j8YHQB434xquD9kRNKN8wDv37AVIwKc8PmvB9WwYqt4QaKC5zKVtKBU7I3hLRZRKo5/x7hF+5EG5GSck0D064fSbsSA7CZBdGUB8bdwKEG5i5jizW3oDWPkedDb391Qvq2M3sznRcBBSlxy6k47CkbQu2k+QoOfUkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665126; c=relaxed/simple;
	bh=xQRbhjlzCJ5KRFEHUnvw+ZTyoJXAVoqR5yT89mXtIWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLGqTyJ7GlShkwiFj7cWmKjJkElxcoY3V5jIfaOKRcijjXfPyShT5LC6gEil4St/NFt88kZFfM4u+eB/EoA5PLpn6jgW9pSAmQRibuiSt4FG/qLektFNbP0C+mQZaG7qbGHyx4XaDmyyM9PqhCqNGaVaHajAr/zf8HGxZVdr4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=4dp4GmKj reason="key not found in DNS"; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="4dp4GmKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780665122; x=1780924322;
	bh=pwIBjxAgsa9c8+74zjoKOZBEUnMSSb1CI3oeJGdoDhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=4dp4GmKj8Sn7t2BpvuvXcbjwEAS8/phpu9FTKQlkEa6IlOhgi+GcNZTjvaXVgSgT+
	 25NUOppO/Z5eG2ObxdEhrddVPYJ+gWgW/3qWgbkcv6K/OGotW3G7fR2wDQ5q+6yAk/
	 WAECyYDROtD/zAiYnwefay5f7ayhnBUHyBxeItbbNWNqpvMQ9xinrkB7CyV7Yl87ow
	 qFd8OrTcddqPyMYff+AVTNdf81jBGS28ybHeCcXF6j1duFzxM/i63qShF4vbrORdDn
	 xVudsJAxQBjgYfKvb1EdvFi1k36Cko2ibpHvaMC9gV6nL1GRTZzzXWTsmS1XH8DdNB
	 6vaVBvsQQlfVA==
X-Pm-Submission-Id: 4gX1zw6ryBz1DFSn
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] watchdog: starfive: runtime PM cleanup
Date: Fri,  5 Jun 2026 09:11:49 -0400
Message-ID: <cover.1780664848.git.william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605122336.159546-1-william@theesfeld.net>
References: <20260605122336.159546-1-william@theesfeld.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v1 patch was a one-line conversion of pm_runtime_get_sync() to
pm_runtime_resume_and_get() in starfive_wdt_pm_start().  On review,
the StarFive maintainers pointed out one edge case the v1 fix had
missed, plus five pre-existing issues in the surrounding runtime PM
handling that all need to be addressed before the original fix is
useful in practice.

This v2 turns the single fix into a six-patch series.  Each patch
addresses one independent issue and can be reviewed in isolation;
they are ordered roughly from the simplest correctness fix to the
ones requiring a small amount of restructuring.

The series:

  1/6  Expand the original v1 fix so the runtime PM reference is also
       released when starfive_wdt_start() fails after a successful
       pm_runtime_resume_and_get().

  2/6  Treat a return value of 1 from pm_runtime_put_sync() as success
       in both starfive_wdt_pm_stop() and the probe path; the watchdog
       framework currently propagates the value verbatim and the probe
       takes the err_unregister_wdt path on a non-error return.

  3/6  Restructure starfive_wdt_probe() error handling into three
       labels (err_pm_disable / err_put_pm / err_unregister_wdt) so
       every failure path balances exactly the resources it has
       acquired.  Previously two early failure paths returned without
       calling pm_runtime_disable() and several later paths leaked the
       runtime PM reference.

  4/6  Gate the system suspend / resume callbacks with
       pm_runtime_status_suspended() so the WDOGLOAD / WDOGCONTROL
       accesses run only when the device is actually clocked.  When
       the device was already runtime-suspended the previous code
       triggered a synchronous external abort.

  5/6  Make starfive_wdt_shutdown() only drop the PM refcount when
       WDOG_ACTIVE is set, and stop just the hardware (no PM touch)
       when only WDOG_HW_RUNNING is set.  This avoids the refcount
       underflow that the previous unconditional pm_stop() produced.

  6/6  Release the early_enable PM refcount in starfive_wdt_remove()
       when WDOG_HW_RUNNING is still asserted at unregister time.  The
       watchdog framework's stop-on-unregister path only runs the
       stop op when WDOG_ACTIVE is set, so the early-enable +
       never-opened combination otherwise leaks the probe-time
       reference.

The whole series builds cleanly with CONFIG_STARFIVE_WATCHDOG=m on
x86_64 defconfig.  Runtime testing would require StarFive JH7100 /
JH7110 hardware and has not been performed.

William Theesfeld (6):
  watchdog: starfive: balance PM refcount when start operation fails
  watchdog: starfive: treat pm_runtime_put_sync() positive return as
    success
  watchdog: starfive: balance PM refcount and disable in probe error
    paths
  watchdog: starfive: guard system suspend/resume hardware access
  watchdog: starfive: avoid PM refcount underflow in shutdown
  watchdog: starfive: release early_enable PM refcount on remove

 drivers/watchdog/starfive-wdt.c | 92 ++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 19 deletions(-)

-- 
2.54.0

