Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776364;
	b=AUaZe4cLIl5wlP6WhtO1uiD8kK6nNgl5HMaKrkYN7sIA6Ixe59tQkteLpvjQXIrx5jSh
	 sUXtq11ioozQYiAWrs+jPhylILjIu/ksghcY5/bZMN/iPJoD0ILiikf4vNvRr5AklAjDM
	 u7+xCgIl8mWQLe4CRqEQ77+GL8kHiGVczKk+eBNtadTgBtKtj7O4nSSbXSRc6Im4ii3L4
	 6vUWaMWHxyVZR8jNSPHDj9xxaH/QtJ0MplEZlrYx1XJDEcIPHg0mDsx0QF0YBYjgCJ8gX
	 /2XEpzOKVy2ylCwOZ5X/iY/i472R5ApaIaEvxlrq4MPypjWvlW3DaeMvMLij6ZpQD7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776364;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1ck4DQBMkQ3m+KelL8iTlvB13CQBPiFxNw+niqTgpdc=;
	b=apHlcovOgagm6Ckg4VPiemHCQMeKiI1QRDC5bDaMIV24/I7iKZOgAOuOR9W+DvyxRe6q
	 RpMVPJKp1w6gY+86MScewFK6aUdEA1vRS+lvyImO9pd8jc/JIlLD14xw+NR0kCCoUH4zZ
	 aBbfSmq3295mtrk8AWhKWgpVoee5iuBV7YA0C8CwWYuzb0CxSWPYyyXmCU3qYwOdtB/fZ
	 8ASatlkbRiQJ0/CknjY+UMNUYAX3Ib4+uLWBgjeCcAOViqFzLd0h6rB7+r/3GNy3EZ1ax
	 YgpMKcVZakGjB0mt+mEjmk41nPquzW+GiKdAofawF+SMnLhugcWNv9aRd4s+0DGtOKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f3eE61/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214F606A326
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3eE61/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B8E1F000C1;
	Wed,  4 Nov 2026 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776364;
	bh=1ck4DQBMkQ3m+KelL8iTlvB13CQBPiFxNw+niqTgpdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f3eE61/wQyB9PYB1beU0+f0ZFoGAMuI/o6X27VbQUIvD0qrVC+Y61AD5I5KUeW2Vb
	 lcPQ/KKfp3SWFnT8/d9UtdUKFAW2aqcKV3W1v8S8fyvfwiI8m/QDbAFEsfcml70ceV
	 CsiHm70+Sf/a67is3iom0pVPUczQGTP0L4KFpJlpE3lQ4UrNCBmZ4MBjkdwzb5jkUP
	 h4csv0r6oa+wqv4ohyl0uXT9+xw3eIm3O6muKbKXktrV7UASCaqYxBKnScU8732Bur
	 exIi4qJyuplodOMC0Hjqv6sXjqJLs2pFCutAkBBLuZxxTRN+ZENW9tP0WZWmJS0eRN
	 9HdI+/zViCJvQ==
Date: Wed, 4 Nov 2026 08:12:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: omap_wdt: stop starting the watchdog twice in
 early_enable
Message-ID: <20261104-melodic-emotional-pony-ff5ddd@quoll>
References: <20261104021535.1468760-1-vulab@iscas.ac.cn>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104021535.1468760-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:15:35 +0000, Wentao Liang wrote:
> With the early_enable module parameter the watchdog is started before
> watchdog_register_device() and the WDOG_HW_RUNNING bit is set, so the
> watchdog core keeps pinging it.  The start that predates that code was
> not removed, so omap_wdt_start() runs a second time right after the
> registration.
> 
> Every omap_wdt_start() takes a runtime PM reference with
> pm_runtime_get_sync(), and only the reference of the probe itself is
> dropped at the end of omap_wdt_probe().  The second start therefore
> leaves one extra reference behind: the device never runtime suspends
> after probe, even when no user has the watchdog open, because the
> usage count can never fall back to zero.
> 
> Drop the duplicate start.  The watchdog is already running at that
> point and the remaining references are the ones that keep it clocked
> while it is armed.
> 
> Fixes: cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/watchdog/omap_wdt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




