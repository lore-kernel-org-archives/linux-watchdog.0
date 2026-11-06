Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984736;
	b=36xyZ4HO96e3XdAucxe+gcq5LeAgsWb4zB7Jx7ecKr4/En9w9ZFxP01RaIqYkvW/n9JU
	 1tnaFYqstnLW4qkNVTlgKGIo5q38VHV0yIhtNmTLxGu4bbzKq42s85MEx/v541dzEtHiv
	 ry6yCRsvHIn52ed6woGxCqrfvdTuq0tjkyFCqx8mACapPArJPN0O1uOjEGDuKwUcMo5p4
	 GuqGVZzBQeCRpOKArlPtcUe9t6c4EfsA3N/+EY7B6TJroYFl5DZ9Wk4r0PTvTnl/kkzOg
	 BjagG/Hglx9kAa+YOl70Fak2evaOxN/EpwTIgm9fhaY9DSYaCfTAkMyJJEno6DCmR+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984736;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9ixBFuEHmkHOoQ6uutrazXK9Kghyu2179JvKWtPj4fQ=;
	b=DVH4QqUrl7bTsmSu7DgqXHo8xz3R4IBkKCpcUP1IEcpEIxSWD257S1yy2VkYptGGFuqW
	 cZSX0g9ouHNZhmXHNQ1dDct/Kloc+OKwqm7CNA4tRMWQprpZL46NFJDYM6kdl8QraOBB6
	 zOTxbiQRh8i5WH33Wv0fCfPxk0rd2lwQCArgExIlcXC3gUqP1ok1oADGQoiHyGe87jltt
	 EEpDLbB1iyzokPkAev94TeJ6w7XU3N3Q54edbvzX7qFMh6va9agbphYHLqmCehv4NK3eS
	 /OdPncTI822/Rr8QCGO39cKT00KkGzt3JmCIlxUjXv0jPgHHX4pWq/0XOz/7UwEhXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iskjez2R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D67606A329;
	Fri,  6 Nov 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iskjez2R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275F81F008A7;
	Fri,  6 Nov 2026 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984735;
	bh=9ixBFuEHmkHOoQ6uutrazXK9Kghyu2179JvKWtPj4fQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iskjez2RIUfuGPmcNAlg+1LcCsRwacGrZQn961/SVoYB1qf3yTpUT6qAkxKSLHLoo
	 t8XkonZo0ROtXFmm5xNxYIbVg1ZL+TxS0+06qHxJrpaexNUjp4aMaM6sv5PQBSQZ5p
	 G/b8UkmKSPwFz9GY9FkNToh9+48ZnjovrnY5WX/A7oX1sKJD3Q3hbgwLG4aSvraBNO
	 Iek1uxH3S3wrbiflMDUY7L79gYPKhP0Dxwa5Unfb/yxQPRZm5WdRKe0o/cCWmfq7KE
	 BJdB2setxxHITmLzxyib6QUGirJ+2IGP9vySUT5SB2BuHb4iHx/dpIxOhJnGVmtFgN
	 ZFNGYXRm9l67Q==
Message-ID: <sashiko-outbox-201895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] watchdog: stm32_iwdg: detect whether the
 watchdog is running
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-3-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-3-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:05:34 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] watchdog: stm32_iwdg: unconfigured timeout in
  stm32_iwdg_probe()
- [Medium] watchdog: stm32_iwdg: WDOG_HW_RUNNING gated on Kconfig in
  stm32_iwdg_probe()
--

commit 7c2acc17f93336becc29a7a139de848c3db25624
Author: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>

watchdog: stm32_iwdg: detect whether the watchdog is running

This commit adds stm32_iwdg_is_running() to detect whether the watchdog
was already started by an earlier boot stage and sets WDOG_HW_RUNNING in
stm32_iwdg_probe() only when it is running.

[Severity: High]
In drivers/watchdog/stm32_iwdg.c at line 394 in stm32_iwdg_probe(), does
removing the call to stm32_iwdg_start(wdd) leave the hardware prescaler
(IWDG_PR), reload value (IWDG_RLR), and early-wakeup interrupt
(IWDG_EWCR) registers out of sync with wdd->timeout and wdd->pretimeout?

When stm32_iwdg_is_running(wdt) returns true, stm32_iwdg_probe() now sets
WDOG_HW_RUNNING without programming wdd->timeout into the hardware or
reading the bootloader's configured timeout back into wdd->timeout.
Because stm32_iwdg_ops provides stm32_iwdg_ping() (line 162), which only
writes KR_KEY_RELOAD to IWDG_KR, the watchdog core's keepalive worker
schedules pings at half of wdd->timeout while reloading the bootloader's
counter value. If the bootloader configured a hardware timeout shorter
than wdd->timeout / 2, the watchdog expires and resets the system before
the next keepalive ping. Even after userspace opens /dev/watchdog,
watchdog_start() in drivers/watchdog/watchdog_dev.c (line 261) sees both
WDOG_HW_RUNNING and wdd->ops->ping set and calls __watchdog_ping(wdd)
instead of wdd->ops->start(wdd), leaving IWDG_PR, IWDG_RLR, and IWDG_EWCR
unconfigured.

[Severity: Medium]
In drivers/watchdog/stm32_iwdg.c at line 394 in stm32_iwdg_probe(),
should setting WDOG_HW_RUNNING be unconditional when
stm32_iwdg_is_running(wdt) is true, rather than gated on
IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)?

In drivers/watchdog/watchdog_dev.c at line 1099 in
watchdog_cdev_register(), the watchdog core checks watchdog_hw_running()
to pin the module and device references and to evaluate the runtime
watchdog.handle_boot_enabled parameter. Gating the check on
IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED) in the driver prevents
the core from knowing the hardware is active when
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dn, breaking the
watchdog.handle_boot_enabled=3D1 kernel command-line override and skipping
the module/device reference pinning.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D2
