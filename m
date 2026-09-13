Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9935AC31
	for <linux-watchdog@vger.kernel.org>; Sun, 13 Sep 2026 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282821; cv=none; b=PkW8NTIA0l3sh4oVpP1htNDys8eBCIvQ6x23V53oN2SO3omWrlaIxGG5lpVQH3M+aVi3Fc+ypPuIZ5COB6KJC5DC7B4+0TsCz9LrjIAfEIdX81runz2yhPivSHy6fJj50XaKq08lNhdqvJ/Qbz4fTLULv4WSqSqmmGEO5/sdElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282821; c=relaxed/simple;
	bh=eyLipANu+txoTcmd9Are0/dV2ItVgjp7NKdCZn9IDpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GaZ6/NHH6OJCniNafdv63IFgrUbeqgWs7U9Am1f0DcjTptJKJVS69O+++UVrO0zz9mRJEsaYzN3BDGI5J2jPuFYQG36ivzrpTCo2j1RxxzMQfUDZsbunBuMPyPDTYuhDnw9DkzpdDTlDnlX/aWSIUOAPouZLaJTX7WKLakHxrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeQ3wljO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeQ3wljO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D61F000FF;
	Sun, 13 Sep 2026 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789282810;
	bh=A0cDs7Ni+oXgc3JYbtzF03H9Op/y2ZBCXI2VrHcXgP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeQ3wljOlUV5F6dzI58ogB4sSatv2NuqGOBJAXnlPx74kzvT93LHVmm8CzLV+M9uY
	 XcTtp9HrWhhoBKv99jAQUmPuNXM7al6T4dBslVxOD1/yJNyvqh1FC9RFKL6ys0sXyE
	 nA1PvQWMAYi5MbhExpNp70w5kRQi30+UYNkOfMRNvCg57IM4cm0YQmDG6K4GkTqmYz
	 yxYKZyFfB+dSWZTTRmP3rCGmMoAYgIhfbE58vS3H4MBxzDwVoREwmWIO0qNKM+SIfg
	 tBbbVwSsfXfalcAa0hSdOgv5mNzGcPH4J9L5iMW6AKsyTZ2T8vDQKcrtF9goSxbZHj
	 jsAcLyDFcfLKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: msc313e: Fix premature reset during timeout
 update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260913065126.8350-1-tzungbi@kernel.org>
References: <20260913065126.8350-1-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 07:00:09 +0000
Message-Id: <20260913070009.D63D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete race condition fix leading to premature system reset du=
ring watchdog timeout update.
--

commit 7f35d2e3193543673ce5c7858773cd48582d5c52
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: msc313e: Fix premature reset during timeout update

Updating the 32-bit hardware timeout requires writing to two 16-bit
registers sequentially. Clear the watchdog counter before updating the
registers to prevent the timer from timing out prematurely.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 4a5cce2a16b18..a743087e922d5 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -46,6 +46,9 @@ static void msc313e_wdt_set_hw_timeout(struct msc313e_w=
dt_priv *priv,
>  {
>  	u32 t =3D timeout * clk_get_rate(priv->clk);
> =20
> +	/* Clear before to prevent premature reset during non-atomic updates. */
> +	writew(1, priv->base + REG_WDT_CLR);
> +
>  	writew(t & 0xffff, priv->base + REG_WDT_MAX_PRD_L);
>  	writew((t >> 16) & 0xffff, priv->base + REG_WDT_MAX_PRD_H);

[Severity: High]
This is a pre-existing issue, but does this non-atomic update still leave a
race condition window?

If a preemption or interrupt occurs between these two writes in
msc313e_wdt_set_hw_timeout(), the active threshold becomes a hybrid of the
old high bits and the new low bits.

Since the counter was just cleared to 0 immediately prior to this, if the
old high bits are 0 and the new low bits are small, the intermediate
threshold will be very low.

Could the counter reach this small intermediate threshold during the
preemption window and still trigger a premature hardware reset?

>  	writew(1, priv->base + REG_WDT_CLR);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913065126.8350=
-1-tzungbi@kernel.org?part=3D1
