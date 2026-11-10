Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314924;
	b=T061lbL8wdBbdnVp8Hp1EjAA2fyDvU3QS0EJgLxe/snx9AkGCK8KpcG4Z+dJaRd47xpM
	 Dshp4brZjNt8yXMIsruhH+3VOyNJaoCqtU1C3PgbwO4tgweDRvCZqkrrseF6lP/O9CiSK
	 whbadCju/dbx19PSgwEHykN+MKJ8G0ByY5qQ05Bm9M5bxyNa4nZupJtvcWRTs0nWFHysR
	 z6q7WmScljRaEFLviwEeHI5uAHz60xVe5NrATX3/XDqmxHdeopXkub/iaNvcZhAj/99/R
	 HbmEnAao80V9ql/7loFoSCjDQOMJi7qcbreCLbsyPGEuZ3kaP4kHoHJuPzDXmaGcpqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314924;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+tn3X3la1wIxt5YyuWdqd3PT0dXWZxhxuhM/J0NVsRc=;
	b=qFNxq+EZ8IcUH1282HbE+qU0yiXke4Is2W33sVnecTsatXhIV2vGbZdawtgEim0VzpPY
	 mj1vrJ4F9aZzEVTX1oj6tHSePx+q3ECAetkN3/ec6Hcm9ySlbFA/NtQ0TQcFleylMkIDa
	 GyY6+VRHvVXSOy6oaarvdZSYSg+gSvHwKNWCvOjdM5QBHXz2CyO3z+qhh4P081FSoHVFS
	 tXzz7HDozNzAN7ylGWduWzdVPdvi55VHp460YAbR8bZG3D9zAbVMZKD2OnyBC2X9AQcYs
	 DDAqibHhn8wt/jvjU1NwuG6UIK7VyVctw4Bh2dGYpmakzU/BPWvFif2YBQLVj2KmeVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsNlBtxf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2A606A31C
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Nov 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsNlBtxf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489C21F008AB;
	Tue, 10 Nov 2026 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314923;
	bh=+tn3X3la1wIxt5YyuWdqd3PT0dXWZxhxuhM/J0NVsRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gsNlBtxf0bvgj6mtK3g3ip/r1J1VJH9CSjAR+KSIpEoQTdq2f1X7EiTwn3fJ8xAor
	 OjOfaelnAQ+HKGwaadkzFLpWMqpl2fI1rVzNLag5PvJsbyrGYBymuqtJd/lVMeQvI7
	 dQmcHMREVXGl70ZK0ZZ5cDaOD6fcrBEZLD+6Ynt8gSznHfBpBVSdMIAdB7YLOcu5KT
	 kpImBRdBVxz1KVJvyMxy5bAIzdeQuyUQckYJnXcIArYQUi6gfMQrau0VsiHcjHk3eA
	 J+JM06roru52l2rrRWjAaXj4FuYXoicS02pwvjh+MiFqZKagR8d0/x4UMDyL1Zn+hN
	 Aw4INQxTWWjsA==
Message-ID: <sashiko-outbox-207046@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] clocksource/drivers/timer-tegra: Keep Tegra20's
 watchdog timers free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artur Kowalski" <arturkow2000@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261110-t20-for-upstream-v1-1-5923449951fe@gmail.com>
References: <20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com>
 <20261110-t20-for-upstream-v1-1-5923449951fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:48:42 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] clocksource/drivers/timer-tegra: missing Fixes trailer for
  f6d50ec5f85c
--

commit 65df25a211b643454125037a766cc25969d41802
Author: Artur Kowalski <arturkow2000@gmail.com>

> clocksource/drivers/timer-tegra: Keep Tegra20's watchdog timers free
>
> Tegra20 has no watchdog block. Instead, the clock and reset controller
> resets the system when the interrupt of TIMER1 or TIMER2 fires while
> the previous one is still pending. A bootloader can start this watchdog
> and leave it running for the kernel.
>
> Since commit f6d50ec5f85c ("clocksource/drivers/tegra: Support per-CPU
> timers on all Tegra's"), the driver uses TIMER1-2 as the per-CPU clock
> event devices on Tegra20, where it used TIMER3 before. When CPU0's
> clock event device takes over TIMER1, the clock and reset controller
> still resets the system if a timer interrupt fires while the previous
> one hasn't been handled yet, which resets about half of the boots
> early. If the system survives that, the watchdog stays enabled but
> never fires, as CPU0 keeps clearing the timer's interrupts.
>
> Use TIMER3-4 for the per-CPU clock event devices on Tegra20, leaving
> TIMER1-2 to the watchdog. Tegra30 needs TIMER1-4 for its four CPUs and
> its watchdog uses TIMER5, so keep its mapping.
>
> A watchdog left running by the bootloader is then no longer disarmed,
> so it resets the system unless it is pinged. That needs the tegra_wdt
> driver, which gains Tegra20 support in the following patches, built in
> or loaded before the watchdog's timeout expires.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>

[Severity: Low]
This fixes a boot regression introduced by the commit cited in the
changelog.  Should this include:

  Fixes: f6d50ec5f85c ("clocksource/drivers/tegra: Support per-CPU timers o=
n all Tegra's")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-t20-for-up=
stream-v1-0-5923449951fe@gmail.com?part=3D1
