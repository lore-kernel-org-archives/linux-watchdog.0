Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF8370D57
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460574; cv=none; b=cQc2vYTwcTl8JVTV5s2tE6dyKyiztORMgupv0Gi0JAcljmZ+yjsRst6QjYbOqdeswjhiv8Edt6pckNLe+UvKn3GpwCOYFuWRWUs7w1mlzfTDrp2gwxPGv8S01LoF+NXMAeFD23JfCNALWNM57kxBC1POFYEapDmgh6Az3Q/kj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460574; c=relaxed/simple;
	bh=49gT8yjMT+SZmrUkhGd4wU7h1/sDlO08YdILflxINSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j+iwbjXeJNZbxnOJiN/Kvp4yjOl8ySZjfEnUfvRp0bHmpnKc6RIiRgqIxhCmTmdaOgL3b08zonEG6DmIyhs96Qvn4TpM5/lIseHnrYFZes+9jXjxBBkpHgkaYzY93ty2ObTqFj5dZeT77wwn8yYGyuMTVxFpTw+dnNwEC5An3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8yKJWI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8yKJWI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8DB1F000E9;
	Thu,  3 Sep 2026 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460572;
	bh=UZCN/nTx2iLx0Y+cWKMLwbsVqziLlRXV7RlGALrSaRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8yKJWI6AUwe0STIMU2JgGpWoDMAYAJsGhvN15RaIAvywUuS8kR/ZrLUv72MgfcTl
	 MA51sZDXbbrIB6Un/ddjVxe44aGBmFGsMQePqI1dEqnzRYNYZvUWrJzxDOX5aiBTGa
	 vTgsGInG+Wmu5kQE6aQJrk1SmQyuhUlrIgHkdIBleYroTL2a1903fe8Rf9rFjddnqC
	 xN6F130c9Sv6/aZcQdne+hUTnVYKxbMDDjwBxznaaNnQln+hEUlBIL5lEQuF9Wb5cZ
	 mPjeRlrWGi9j1U9PbttmeT6CCRkypFWHm1kALdF8l+wGXqnbsWaYw7kBYbDIfnTAgf
	 /Zxr15VYQQzyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: fix hrtimer start when pretimeout is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Arcari" <darcari@redhat.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260903182029.936030-1-darcari@redhat.com>
References: <20260903182029.936030-1-darcari@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 18:36:11 +0000
Message-Id: <20260903183611.DD8DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A race condition during watchdog device unregistration (`watch=
dog_cdev_unregister`) allows the pretimeout timer to be concurrently re-arm=
ed after it is stopped, leading to a Use-After-Free or NULL pointer derefer=
ence.
- [High] Missing lock acquisition during teardown causes data races with ba=
ckground operations, potentially leading to hardware corruption.
--

commit 04d7e6cb40777d8a3872c4dac3b1dddfdfe115f8
Author: David Arcari <darcari@redhat.com>

watchdog: fix hrtimer start when pretimeout is zero

Per the watchdog API, a pretimeout value of 0 disables the feature.
However, watchdog_hrtimer_pretimeout_start() fails to verify if the
pretimeout is non-zero before arming the timer.

This omission inadvertently starts the software pretimeout timer,
which could result in the pretimeout handler executing incorrectly
when the watchdog timeout is reached.

Fix this by adding a check for wdd->pretimeout before calling
hrtimer_start(), ensuring the disabled state is respected.

Fixes: 7b7d2fdc8c3e ("watchdog: Add hrtimer-based pretimeout feature")
Signed-off-by: David Arcari <darcari@redhat.com>

> diff --git a/drivers/watchdog/watchdog_hrtimer_pretimeout.c b/drivers/wat=
chdog/watchdog_hrtimer_pretimeout.c
> index fbc7eecd8b203..49a05ea60c979 100644
> --- a/drivers/watchdog/watchdog_hrtimer_pretimeout.c
> +++ b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
> @@ -30,6 +30,7 @@ void watchdog_hrtimer_pretimeout_init(struct watchdog_d=
evice *wdd)
>  void watchdog_hrtimer_pretimeout_start(struct watchdog_device *wdd)
>  {
>  	if (!(wdd->info->options & WDIOF_PRETIMEOUT) &&
> +	    wdd->pretimeout &&
>  	    !watchdog_pretimeout_invalid(wdd, wdd->pretimeout))
>  		hrtimer_start(&wdd->wd_data->pretimeout_timer,
>  			      ktime_set(wdd->timeout - wdd->pretimeout, 0),

[Severity: Critical]
This is a pre-existing issue, but since this function is used to arm the
hrtimer, can a concurrent device unregistration race with a ping to cause a
null pointer dereference?

Looking at drivers/watchdog/watchdog_dev.c:watchdog_cdev_unregister(), the
timer is canceled before acquiring wd_data->lock:

    watchdog_hrtimer_pretimeout_stop(wdd);

    mutex_lock(&wd_data->lock);
    wd_data->wdd =3D NULL;
    wdd->wd_data =3D NULL;
    mutex_unlock(&wd_data->lock);

If a background ping worker or a concurrent userspace write operation
acquires the lock before unregistration sets wd_data->wdd to NULL, couldn't
it observe a valid wdd and call __watchdog_ping()?

This would result in watchdog_hrtimer_pretimeout_start() being called to
re-arm the timer asynchronously. Since the unregister path never checks or
cancels the timer again, when the timer fires, its callback will execute
watchdog_notify_pretimeout(wd_data->wdd) with a null or freed wdd pointer.
Does this lead to a crash?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential locking problem
just above the timer stop in drivers/watchdog/watchdog_dev.c
in the watchdog_cdev_unregister() function:

    if (watchdog_active(wdd) &&
        test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
        watchdog_stop(wdd);
    }

Does calling watchdog_stop() without holding wd_data->lock risk data races
and hardware corruption? If background ping workers or ioctl paths
concurrently issue pings and modify state flags while this runs unprotected,
could it lead to inconsistent hardware states?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903182029.9360=
30-1-darcari@redhat.com?part=3D1
