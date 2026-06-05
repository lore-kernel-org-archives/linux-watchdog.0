Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7272EF653
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679996; cv=none; b=FShBeU3bWt0KRXaFGQtTgUyNtaLd1MFAxuBVqnb770o88/Ah11Tpjb9lKHjo1Lqr7te5fN/6ZR94MvYle5jU0kZtgtnpdiFHXW8le4YLDFaCe9gDLIhik6um79VMSmkEcKrs5eEdTbcACGlpSjaq3ltJWHaXbCNDCZljmNnDyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679996; c=relaxed/simple;
	bh=KdQCUWJYtg6o4lTjJU8cnuy3c8/H8ubjmrk894fH0/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1mMyijO2UebltRiXe03U4NCkaLYcQW2AudcN+etIB7YYyYxiedWlEDJpk5h8AlAw5ceO1mHbP+cljOdYGIQMxIeccvsjvCvIuClZHbqYQwcJQDOmDQvxLwTpDVvFnYknDWZPM0scNOKt6eaC1oN4y0K6/OvD1Wx5DEn7cwZvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net; spf=fail smtp.mailfrom=theesfeld.net; dkim=fail (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b=t8JVYBUP reason="key not found in DNS"; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=theesfeld.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=theesfeld.net header.i=@theesfeld.net header.b="t8JVYBUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theesfeld.net;
	s=protonmail2; t=1780679988; x=1780939188;
	bh=Z4QMiwpCEKY8D/kW8LnBSgZny163aGRqvBFSNaJnCAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=t8JVYBUPKWStcTRIbL7mEzaKxadJBwS9gfgzROvrTzGpvfxTvHatRcR1elXLiBiyc
	 mYl212Rd2+RRMXyP3Hi4CodNR9k3RF79au40aYOYR0LqCmVO3RiXwHbRuHfPN4418h
	 gk16G5LcnDZ/n6z0LwbQy37a1ywTApXqy8vldYIlzANGNjsjM2mmT0aSiLjMGXxFTP
	 YgUgVxOGPA9f0Ilt1Nw4x9BLJISj4io+OqTFXZkhYWMUaFaueTMlIh+gfJoiPk4eTg
	 3p/dpmzRf297Nv3zFSeCmvy5FAd7Yuyv5rJFnQ/EDrBvucLQZncEsWTm6O+WaPpcHQ
	 4DsHADaWF73Gw==
X-Pm-Submission-Id: 4gX7Tr6mCRz1DDXY
From: William Theesfeld <william@theesfeld.net>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Ziv Xu <ziv.xu@starfivetech.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] watchdog: starfive: runtime PM cleanup
Date: Fri,  5 Jun 2026 13:19:36 -0400
Message-ID: <cover.1780666366.git.william@theesfeld.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780664848.git.william@theesfeld.net>
References: <cover.1780664848.git.william@theesfeld.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses runtime PM correctness issues in the StarFive
watchdog driver.  v3 fixes three issues that were raised against v2:

Changes in v3:
- 2/6 (pm_runtime_put_sync positive return): the v2 commit message
  and code comment described the semantics of a "1" return as "the
  device is still in use", which is wrong — that case is signalled
  by -EAGAIN.  A positive return indicates a non-error condition such
  as the device already being in the requested state.  Reword both
  the commit message and the in-function comment to describe this
  correctly.  No code change beyond that.

- 3/6 (probe error path restructure): the v2 patch left a path that
  put the runtime PM usage counter twice.  When the success-path
  pm_runtime_put_sync() (line ~513) returns an error, the function
  jumps to err_unregister_wdt.  In v2 that label fell through to
  err_put_pm, which called pm_runtime_put_sync() a second time on a
  counter that had already been decremented by the first put.
  Insert an explicit "goto err_pm_disable;" after the unregister so
  the post-register error path skips the second put.

- 4/6 (system suspend/resume guard): the v2 patch added a
  pm_runtime_status_suspended() check on the resume path but kept
  the final restart predicate as watchdog_active().  For watchdogs
  started via early_enable, the framework state is WDOG_HW_RUNNING
  without WDOG_ACTIVE, so the existing predicate left the hardware
  permanently stopped after a system suspend/resume cycle (the
  matching suspend path had already stopped it).  Extend the
  predicate to also accept watchdog_hw_running().

Patches 1, 5, and 6 are unchanged from v2.

Several pre-existing issues in adjacent code paths were flagged
during v2 review (hardware access during driver unbind, possible
races between device_shutdown() and the watchdog reboot notifier,
SETTIMEOUT/GETTIMELEFT ioctls touching gated registers).  They are
not addressed in this series; each is a separate logical change
that deserves its own patch and its own justification.  Happy to
follow up on any the maintainers want addressed first.

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

 drivers/watchdog/starfive-wdt.c | 109 ++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 20 deletions(-)

-- 
2.54.0

