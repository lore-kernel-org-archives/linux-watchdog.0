Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66251313E29
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953046; cv=none; b=dbJSOQt0M9V3LAtC+4MzYDNwfMnC61MbYFd7VRHn4KIYZXQQxHWTlXr1x/MeglxMfBSKKEbRWnv78SQIrQ8EH4s5+k+fEOY1Qco89Iw9oZIWa8bPfMcWRZuMZc6bbIJ6filOBwrourAMtEq3rQQjTqXZqj+sMUJGdM6fPUbXCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953046; c=relaxed/simple;
	bh=xAa4HnmQgfnozoYWy8lfZ7uBYnsjDWnttfkXKp1xtiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dUofmvOuh1igX0VLFO3jGWR4VEnaS04FvmXqpNBTNywf8EDTKyWyZyV3Chj8r4ItaPciO8ua3dypfxNqnhVuRKRqfir5WXVrU5RZHcVsv3Z08fjBqJwrbhaE6/iwGwxYPm2kvZi0AKmq9k7l4Opuoq5lFqkyrDOcuL7Vt3nHCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO/5k4po; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO/5k4po"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A0E1F00893;
	Mon,  8 Jun 2026 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953045;
	bh=y16sJXQMu86Jyj2ZHdo6Fq+w8A4F4aL+bO2vwsOwJwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YO/5k4porAsnfjnVkUIwSAaP3c0ygdZ6V7WqxSTe6g3uqvs70Y8quF6GuEuglwV9+
	 8l2bi5mswhmiWWnHDJypoPPHYQ/zmYXoNZid+ZsN4tbt3IkPYr4+YnUUsCRWRLdmLf
	 Y6TPTKEvhTuAc2nxPrxLFq8sAXzTXn8CwNqO3KaeRyelTJ8pgfUO/xar4IoyA3YV17
	 F3bZkR7t1l8Ak02m4taWwHqITuVFRhX5BnMM74z2dy7TLhWONiVjG8FJI/odokSeal
	 i7tAPWlwxvwng+/3KinI2fbzQUqiTitf6+Aqj5iReSVh/09RoisxbQFSAHai9DjFIf
	 YO3M5Xsd3BkYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 1/2] watchdog: pika_wdt: fix timer lifecycle bugs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260608210402.31545-2-rosenp@gmail.com>
References: <20260608210402.31545-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 21:10:44 +0000
Message-Id: <20260608211044.E6A0E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling timer_setup() unconditionally in pikawdt_open() corrup=
ts the active timer wheel if the device was previously closed gracefully (m=
agic close).
--

commit cf2334cde532efba699588386b4f5a28da397535
Author: Rosen Penev <rosenp@gmail.com>

watchdog: pika_wdt: fix timer lifecycle bugs

This commit updates the PIKA watchdog driver to use timer_shutdown_sync()
during device release and module exit. It also adds a timer_setup() call
to pikawdt_open() to re-initialize the timer for subsequent opens.

> diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
> index 87b8988d25206..d567103ec5e48 100644
> --- a/drivers/watchdog/pika_wdt.c
> +++ b/drivers/watchdog/pika_wdt.c
> @@ -117,6 +117,7 @@ static int pikawdt_open(struct inode *inode, struct f=
ile *file)
>  	if (test_and_set_bit(0, &pikawdt_private.open))
>  		return -EBUSY;
> =20
> +	timer_setup(&pikawdt_private.timer, pikawdt_ping, 0);

[Severity: Critical]
Does this code corrupt the active timer wheel if the device was previously
closed gracefully?

The watchdog driver supports a "magic close" feature where writing 'V' befo=
re
closing sets expect_close. During pikawdt_release(), if expect_close is set,
the internal ping timer is intentionally left running:

static int pikawdt_release(struct inode *inode, struct file *file)
{
	/* stop internal ping */
	if (!pikawdt_private.expect_close)
		timer_shutdown_sync(&pikawdt_private.timer);

	clear_bit(0, &pikawdt_private.open);
	...
}

Because the open bit is cleared, a subsequent open is allowed. When
re-opened, this new timer_setup() is invoked unconditionally on the
actively queued timer.

Calling timer_setup() on a pending timer overwrites its internal linked
list pointers, which can lead to a panic when the timer softirq processes
the wheel.

>  	pikawdt_start();
> =20
>  	return stream_open(inode, file);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608210402.3154=
5-2-rosenp@gmail.com?part=3D1
