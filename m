Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372028B7C8;
	Tue, 15 Sep 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445142; cv=none; b=UL1RTgeHG6WFrFAwJD4fbE6BR/TGgw27gtve4u0c2rjpf6baeJfo54OE9N9UIWM7b6lvvLjPwTDIOipSNzCMxi2g2a6sWCsqbuCgtnDHDrs4qDkiCPsYMQy8yqxdn0KUUTqQpZBhx3gQQBIOXsksIkB/fUTPkftJFFBWKDhKsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445142; c=relaxed/simple;
	bh=Fitd9xic3VY7OxGA/U1n7+dTEemtLBhOmyJzBiuhKgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DPJE5VbBwGUfQFtLO8e58+RsrooFGu5k5Hrn1ia6RcX+6gNw/e39U7DMgvgO5c94TaOK8GyoqcHTM2n5SdI2KWtPMRFYvIfLhBQlTvTVD1pzcV8cyEvLxz916pzhd4jjeoDTAWlRvBKtTSjGylR2ZQWzDyMBWFtEkM9a/kPuubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZjemYoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZjemYoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937371F000FF;
	Tue, 15 Sep 2026 04:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789445141;
	bh=Fitd9xic3VY7OxGA/U1n7+dTEemtLBhOmyJzBiuhKgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZjemYoVTE5ymLVvmURpHe8SYld1uoddgP5GBpRUcDLcPjJpqI6cq2kRD0G6VQeOY
	 8j2keyRcUxIe8bxNmH0YK5b1e/igmRctGHJ7U5kx2I7ADLsN0fjwCMmTTEBkwrGwPs
	 WYKfIv4YYqx+1ooxpzkhBivaByXer/rgLA7hDgT2kTUujs/ye+XXlGmnDC21M/qkXq
	 8CBB7gtI0+XqD2TD8nhZd7yFdQsbsGoMgd7AeInPZMfohI8eaB/uC3/wF6+SJfRsUR
	 vPDVAuj1kEvQhfByU4LQ81Q+NTsnQHdgQb6BZDQvHcV4BIurnkvQFnsKsRNekVvJeK
	 7xP2iGeBlmyGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] rtc: pcf85363: add watchdog support with
 configurable step size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260915034452.4086683-5-lakshay.piplani@nxp.com>
References: <20260915034452.4086683-1-lakshay.piplani@nxp.com>
 <20260915034452.4086683-5-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 04:05:39 +0000
Message-Id: <20260915040540.937371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

> Add watchdog support to PCF85263/PCF85363 using the watchdog subsystem.
> The 5-bit count selects the timeout with a clock step: timeouts up to
> 30 seconds use the 1 Hz step, longer ones the 0.25 Hz step (max 120 s),
> reported back through the watchdog device. One count of margin is added
> because the first period after a reload lasts between WDR and WDR-1
> counts, so the timeout is never shorter than requested. Select
> WATCHDOG_CORE if WATCHDOG so the device can register.
>=20
> The chip has no reset output; expiry is only signalled via the WDF flag
> routed to INTA, so this is an alarm-only watchdog (WDIOF_ALARMONLY). WDIE
> is toggled on start/stop with rollback-safe register ordering, expiry is
> rate-limited from the IRQ handler, and the watchdog is only registered
> when an interrupt line is present. WDF is cleared through the
> write-0-to-clear helper.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915034452.4086=
683-1-lakshay.piplani@nxp.com?part=3D5

