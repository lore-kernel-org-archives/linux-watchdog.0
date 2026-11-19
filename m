Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108049;
	b=LIzq3AljORzCQMM8ErIehNT1d0PM218lujXXW4Ln+UIXfI/RSH7NLWUQ6eWgl/6Ez+s8
	 tZ9k2b/seAn5tOJG4Gz40M9BKqZEHFehiZdE62DB8aTXFauwBAUyAhkN45CPM1z16Zi5I
	 qi7RqbkO/yBfTH/OvihQMWi7wvepHkblxf2uVYL821YQEBS8D8lKC4gkBHcwTmFS9rLd1
	 wwE250bFRCCVfBovY1TOei8o+c6pqH/PuWQ+d+LFKyioLDudpEP0q3q3/LTtItyPeN/US
	 S3EZtg7VMol4zU59nhzYxQhiIWt6aEUc8ynG6tnMZkE7vPLnldpyCtIKmTGLZg6q6+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nzPJLRB63+dKrib6RjHXiCvc2+NLxfe0JoT/8zdFAMA=;
	b=avpjoXrcZvFnwD6SLr68ujB7ALsfGaSKHOyUUGMLwWNNtuNZOGmqTaZXekdiEsWWgXOr
	 kxCHy0bJu13eU4C/5HeFqYNDCfh9FrCWJdrkbF6LFZ2xv+fs8Z3GbG2aszeQmdUFLlHUz
	 AKHampCOYylLYJ/8+FOQQDv5r9AjwyFLz8Q3bM1TO/vdjQjrlPSne/Czu3K/gmiHkyPbF
	 6qdZbBfGRawZl4wQDpFt5FpLWa7GXJ+ooczrFBDCurClO1IIFqvqbDHYBzuiOf1Nj637e
	 Utr9YNjSkfLgk3fl3WBNZn2bj+VMN75Zq+J+yDjPRTQ6naq8FGOLMC3Zp3zqH+ltltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5UCajbs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AC606A335
	for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5UCajbs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CA11F000C9;
	Thu, 19 Nov 2026 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108049;
	bh=nzPJLRB63+dKrib6RjHXiCvc2+NLxfe0JoT/8zdFAMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5UCajbsH2LB1biXpMS2hXycUu6I9KKsgvdQTgKjHPtHbP7Zfs1pp4nXuc0ssBtWA
	 iVJiz/lp48xP7k9A3dGjjksD8ye+3d3DZSjTB3OUOoOWw1GsSjhlAPepNkA9goJ9ki
	 BGHrCYE927CQr9KDWbfDLn3pzE0f/Vy9n1/44eaRnYnhh+CYFCBTQZxmccahw6BxeZ
	 HSrSTxF0FVZvZPfVAMkZEtUx9tsZsgMijKbtyeeCtl5AFEpOWbMFRndJ6wlEQ4ve8m
	 Ohicg5vYKZpCSJCiutCSGsOHEFZa3yyYlK6R6b8pq+kZ8kPKIvIxqoO0PdzrSGGPF/
	 51qkpfTPmEIWQ==
Message-ID: <sashiko-outbox-223620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] watchdog: core: Ignore userspace keepalives once
 the system goes down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261119-watchdog-reboot-keepalive-v1-1-c5902d959796@gmail.com>
References: <20261119-watchdog-reboot-keepalive-v1-1-c5902d959796@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:07:28 +0000
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
- [Medium] watchdog: core: partial execution of WDIOC_SETTIMEOUT during
  shutdown
--

commit aaa4c1cf2a5820b51fb679779e0af90fdf817cba
Author: Arun Iyengar <aiyengar1990@gmail.com>

watchdog: core: Ignore userspace keepalives once the system goes down

This commit makes watchdog_ping() return early without pinging the
watchdog once system_state is past SYSTEM_RUNNING.

> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
> index aad3f1f1b4ce8..0f149da49a694 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -201,6 +201,9 @@ static int watchdog_ping(struct watchdog_device *wdd)
>  	if (!watchdog_hw_running(wdd))
>  		return 0;
> =20
> +	if (system_state > SYSTEM_RUNNING)
> +		return 0;

[Severity: Medium]
Should watchdog_set_timeout() also check system_state > SYSTEM_RUNNING?

In watchdog_ioctl(), WDIOC_SETTIMEOUT runs watchdog_set_timeout() and
then calls watchdog_ping() to apply the new timeout:

drivers/watchdog/watchdog_dev.c:watchdog_ioctl() {
    ...
	case WDIOC_SETTIMEOUT:
		...
		err =3D watchdog_set_timeout(wdd, val);
		if (err < 0)
			break;
		/* If the watchdog is active then we send a keepalive ping
		 * to make sure that the watchdog keep's running (and if
		 * possible that it takes the new timeout) */
		err =3D watchdog_ping(wdd);
    ...
}

When system_state > SYSTEM_RUNNING, watchdog_set_timeout() still runs
while watchdog_ping() becomes a no-op.  For drivers whose ops->set_timeout
reloads the hardware timer directly (such as sunxi_wdt_set_timeout()) or
that use the keepalive worker updated by watchdog_update_worker(), a
daemon issuing WDIOC_SETTIMEOUT can still reset or extend the countdown
during shutdown.  For drivers that rely on the subsequent ping to program
wdd->timeout into hardware and restart pretimeout_timer, wdd->timeout,
wdd->pretimeout, and wd_data->timer are updated out of sync with the
running hardware timer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-watchdog-r=
eboot-keepalive-v1-1-c5902d959796@gmail.com?part=3D1
