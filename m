Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776374;
	b=e08MY76H2Y/drzvGXzOtmV+nBqAMH3v1L3nYumJTeuy1UuMReZz+/C7ofSIQNxkrMa1P
	 wUrfEWbhd3AZiJ04VkK7iGCfKCwfql7uyK6XDqYUhMDKTl7wCszfUtJeGpYs/hiII9bnh
	 xjrIWNn3POlLr+UvdPheZSpHY435hVzGlbfQmT396hjK/QXk5Ku4KMks3mmDgi1wAZffK
	 CbUWE9MZH9cxmDsVoMRYYgA/3lLf7w9AA2i4LaqU5DiHUfzhWUBUhFq9qpfRlcqO0kOpO
	 wtuKRUwXSkWWY2afkL9Ntc1yO4I6fC4CbBgNh91mD/Ve1UqnDwGLFz+GKnbX5ib3vWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776374;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X+v8P+XVH4KjqP0QjXnq1EmaYTJiMaYgsAmxt9gqq4A=;
	b=zePXzfDERcgg46x6ELi81AtJOQFEwQ2g8Jq0lumky7EH/jJbryux//mIfxzd7JO++drp
	 Vn1QI2B7pNfZc7PTHCX1ElONoWTjWpBt2pi0AJtcfy5pP/2kz0lSwFL+7zWM6QjIQeyGr
	 CJ6kzUq/dy+S49RVrCOuDRwobH5ODSe3+lOJr/Q1BFE5ip0y2yzuQ+ZsqrxLwrFMUbDlw
	 q2/v53TfJSYbQhQm87pssvQkhYoP3yomzdt0TuEWVphq415F6CcNvlewiHyqmu9CM9Pp6
	 tW+9Rgb7/DOm0QNgL0rInSo4b2iLyjRmy/Sr5vMandd4WJtNsEfEfZt2F6e0U1GH9vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfNrxgWX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCBA606A326
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfNrxgWX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7264C1F000C1;
	Wed,  4 Nov 2026 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776374;
	bh=X+v8P+XVH4KjqP0QjXnq1EmaYTJiMaYgsAmxt9gqq4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FfNrxgWXPlC99QJQHSWupkf/y6+unggTdZ4u74p4g7Q6PSz3SzoERDfxDHPKhoqB9
	 HHnRuDIovZoETLYDZuC1k8w5bC2eND+4e5h23t1CnjX4ZFhlKJCqWMos3YCgPWatDH
	 OYrb4MPobHFSa3S/64C1FyTcfw6E3i0mMd0Y7ie0B0hkho+y+ckSAVs27aSCkRL8b8
	 oZ9mlSGGZq0cp+y5NWH8W4ayjpiW9aiR16/pl/L4RXjQIh1mg88y7x/96hbo9ZRY4Y
	 vq9f8q0b6jS539YCBmOFCp7n+0a0gpoubifxS2LqfzXmTAofpPSpRfP374dHkpl8BJ
	 lxax2Sr0mBWag==
Date: Wed, 4 Nov 2026 08:12:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Ziv Xu <ziv.xu@starfivetech.com>, 
	Xingyu Wu <xingyu.wu@starfivetech.com>
Subject: Re: [PATCH] watchdog: starfive-wdt: drop the runtime PM reference
 when start fails
Message-ID: <20261104-aggressive-poised-lorikeet-a5cc5c@quoll>
References: <20261104021527.1468703-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261104021527.1468703-1-vulab@iscas.ac.cn>


On Wed, 04 Nov 2026 02:15:27 +0000, Wentao Liang wrote:
> starfive_wdt_pm_start() takes a runtime PM reference before programming
> the watchdog.  When starfive_wdt_start() then fails, for example because
> the interrupt status never clears, the error is returned with the
> reference still held.
> 
> The watchdog core only calls the stop callback for a watchdog that was
> started successfully, so starfive_wdt_pm_stop() never runs for this
> case and the usage counter stays elevated for the rest of the system
> uptime.
> 
> Drop the reference before returning the error.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/watchdog/starfive-wdt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
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




