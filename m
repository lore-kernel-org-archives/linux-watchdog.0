Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72235C1BD
	for <linux-watchdog@vger.kernel.org>; Mon,  1 Jun 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342356; cv=none; b=Eo56B7Ey/E7SAtKJfeOSmy7b6m52ToPQyePc2jGY2HaHQYM4wYVAzSS7OdP91hwd6zX1aFSwkN93HPIiSCQod69jPD9WEirtsF0SutnmvC6WSZTkBy/XdZaWW5yzIa3SVRJtCebQT8a7g7lzs4E4zYWACBfJ6UloV//p0BuV9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342356; c=relaxed/simple;
	bh=YSoiQolpgzE3kbpA5FO7+B/GGJZQ+AUpD420iCnCOh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hnGApLH9yOJXM7jG+fg/YbfujVBVg4TzhCd9/U7XgNEKRRkGnBQGx9FnJhkyjgzfPXFPBqNdUFZyUlgcsVkI41Jix0JeLhJvBttXYY/VQDZESUgZr6ifQSYI4+ZmTMjTH/TPIPWj7XwbSLW0ooDrvAaCaI6a+BsMfA127peenu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyigKeys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyigKeys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01F81F00893;
	Mon,  1 Jun 2026 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780342354;
	bh=DlQWQBqJ0kFjOOFCcFPHE8dQN8rw4erXmc9dMYJA03M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyigKeysfa/dtW1EGFncdeamzm70itXr+OWiJoa4iKEj22uAKxqvCl0/oYkybtAfM
	 RW81+FVoTdwnSEixAA2QW5dPmnm04UnufV0/x4cqdZ6WWaRoD4sTdnERPe1TkY2ZpF
	 ISlCcPvsFnv/HqIcFb7Rd3nA4SUrMU/dE36ShZxJNhDAuJYUZOvtusF6/7E6HsF941
	 NHy2f0pptX5rY4E5C28lRHCO/8pKYP9WRhaM1r/2H4VvrAiNSWrpZKmi0Z8v3ciS/h
	 rV15a70z5ZeaYzmEquOPnLaJwke3LhcbcsGf0yARwvjTGpkFHffMozR4iFiugd8OzY
	 o110Lfy+qSv0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] watchdog: unregister PM notifier on watchdog
 unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260601192005.1970805-1-dbgh9129@gmail.com>
References: <20260601192005.1970805-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 19:32:34 +0000
Message-Id: <20260601193234.A01F81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ignored errors during deferred watchdog registration and unhandled=
 failure paths lead to Use-After-Free and NULL pointer dereferences upon un=
registration.
- [High] Lockless access to `wd_data->wdd` in `watchdog_open()` leads to a =
Use-After-Free and violates the `watchdog_start()` locking contract.
--

commit 7739691e12f24218c1001ecfc408a279156feca5
Author: Yuho Choi <dbgh9129@gmail.com>

watchdog: unregister PM notifier on watchdog unregister

This commit ensures the PM notifier is unregistered before tearing down the
watchdog device. Previously, if WDOG_NO_PING_ON_SUSPEND was set, the embedd=
ed
notifier block would be left on the PM notifier chain after unregistration,
potentially leading to calls with a stale watchdog_device pointer.

> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog=
_core.c
> index 8300520688d07..6c087b4ef5dd5 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -391,6 +391,9 @@ static void __watchdog_unregister_device(struct watch=
dog_device *wdd)
>  	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
>  		unregister_reboot_notifier(&wdd->reboot_nb);
> =20
> +	if (test_bit(WDOG_NO_PING_ON_SUSPEND, &wdd->status))
> +		unregister_pm_notifier(&wdd->pm_nb);
> +
>  	watchdog_dev_unregister(wdd);

[Severity: High]
This is a pre-existing issue, but I noticed that ignored errors during
deferred watchdog registration and unhandled failure paths can lead to a
Use-After-Free and NULL pointer dereferences upon unregistration.

When a watchdog driver registers early, watchdog_register_device() adds it =
to
wtd_deferred_reg_list and returns 0. Later, watchdog_deferred_registration()
processes the list:

drivers/watchdog/watchdog_core.c:watchdog_deferred_registration() {
    ...
		list_del(&wdd->deferred);
		__watchdog_register_device(wdd);
	}
	mutex_unlock(&wtd_deferred_reg_mutex);
}

The return value of __watchdog_register_device() is ignored here, concealing
fatal failures from drivers. If watchdog_cdev_register() fails, the error
paths free wd_data via put_device() but fail to clear wdd->wd_data:

drivers/watchdog/watchdog_dev.c:watchdog_cdev_register() {
    ...
	if (err) {
		pr_err("watchdog%d unable to add device %d:%d\n",
			wdd->id,  MAJOR(watchdog_devt), wdd->id);
		...
		put_device(&wd_data->dev);
		return err;
	}
    ...
}

When the driver is later unbound, it calls watchdog_unregister_device(), wh=
ich
invokes watchdog_cdev_unregister(). This function unconditionally dereferen=
ces
wdd->wd_data:

drivers/watchdog/watchdog_dev.c:watchdog_cdev_unregister() {
    ...
	struct watchdog_core_data *wd_data =3D wdd->wd_data;

	cdev_device_del(&wd_data->cdev, &wd_data->dev);
    ...
}

Could this lead to a NULL pointer dereference or a Use-After-Free if deferr=
ed
registration fails, since wdd->wd_data was not cleared?

[Severity: High]
This is a pre-existing issue, but lockless access to wd_data->wdd in
watchdog_open() appears to lead to a Use-After-Free and violates the
watchdog_start() locking contract.

watchdog_open() fetches wdd =3D wd_data->wdd locklessly, failing to acquire
wd_data->lock to synchronize with concurrent teardown operations:

drivers/watchdog/watchdog_dev.c:watchdog_open() {
    ...
	wdd =3D wd_data->wdd;

	/*
	 * If the /dev/watchdog device is open, we don't want the module
	 * to be unloaded.
	 */
	hw_running =3D watchdog_hw_running(wdd);
	if (!hw_running && !try_module_get(wdd->ops->owner)) {
		err =3D -EBUSY;
		goto out_clear;
	}

	err =3D watchdog_start(wdd);
    ...
}

If a device unbind or hot-unplug occurs concurrently,
watchdog_cdev_unregister() acquires wd_data->lock, sets wd_data->wdd =3D NU=
LL,
and unlocks:

drivers/watchdog/watchdog_dev.c:watchdog_cdev_unregister() {
    ...
	mutex_lock(&wd_data->lock);
	wd_data->wdd =3D NULL;
	wdd->wd_data =3D NULL;
	mutex_unlock(&wd_data->lock);
    ...
}

Does this allow watchdog_open() to dereference a freed wdd pointer if the
hardware driver finishes its remove() callback and frees wdd? Additionally,
is the locking contract for watchdog_start() violated since wd_data->lock
is not held?

>  	ida_free(&watchdog_ida, wdd->id);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601192005.1970=
805-1-dbgh9129@gmail.com?part=3D1
