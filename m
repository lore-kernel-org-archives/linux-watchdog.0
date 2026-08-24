Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483536194A
	for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605660; cv=none; b=M7s+BK5xAiUt6OzXlRxu9rOy/tzmWrZ+3ZhHFy1EOg3FruPkkHQD2j6gZygYrYe9T7XMkf6RAEeNZAP86bJS27iHC9jDjELXadt8asGyL6H8q4VJLqhEqOqFl+xBttVCQVqGcWutTL/JfZiM+9ZShe2L+yDapRO7rdXd8TBUTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605660; c=relaxed/simple;
	bh=G4QCHkvPYFQxPIR7b5Jxv0jzKstFl5gCHL+MwewpkYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FWU+5npWFv3e18DUSs9JuRniL/pbwmXl7LCGWXTTjCzJaVmvuy+yS9jRBMJc/ciQlyyoqxw63DgwtuSPpgyIe8ruJEiTkZVpRiSUNT9NNulVeswMysCrCP1mVWlznoaD4DoY4J0kHebM8kWqiy2xDojCAj8RsnhLddBrJ3C+3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hibAlTRk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hibAlTRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742541F000E9;
	Mon, 24 Aug 2026 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787605658;
	bh=ht/dRBObdy3h64eBf2oPCwxRvRHBqiWJj3/roXZGwQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hibAlTRkvRZRG6ded7jUv7m95iJ+2l75Qc9OaddOA0v8j6t8Iu9Pl4XcRnyT3QDdV
	 /puS9gKLF4kIe2qzr0WiEgG6Osttv1mzonK0csrTaYWTBCDrqPjAjNjCzEGrh69bsz
	 bjsKLlQ/Gl8unbuFWZJR63H98MVWoHcmlcW9VtIjzNCcYFyqX1EXUujJBiMrKQL6Bb
	 1xVATHNP92QziIg9GDSMlj0tSUINnUHENE8DnmhIi/oUqZFViX67LIDxy9/uS/NXl/
	 WW5Wrjv2LgKF3u1aE35bAU4N6bx658EHmlyy+Gb1YqvEBSfvW5xin0nEKJI7Au0nRK
	 DbZK69KVahmzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Differentiate scenarios when watchdog is closed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charles Haithcock" <chaithco@redhat.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260824205051.4117285-2-chaithco@redhat.com>
References: <20260824205051.4117285-2-chaithco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 21:07:38 +0000
Message-Id: <20260824210738.742541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch inadvertently omits the keepalive ping when a watchdog d=
evice is closed without the magic close character, altering expected timeou=
t behavior.

Pre-existing issues:
- [High] If the hardware stop operation fails, the `WDOG_HW_RUNNING` bit is=
 incorrectly left cleared, leading to a premature module reference release =
and a subsequent Use-After-Free kernel panic.
- [High] Unbalanced module_put() in the error path of watchdog_open() if th=
e hardware is already running, which can lead to a Use-After-Free.
- [High] watchdog_open() calls watchdog_start() without holding wd_data->lo=
ck, creating a data race with the background ping worker.
--

--- Patch [1]: [PATCH] Differentiate scenarios when watchdog is closed ---
commit a2b7eb1d1568deccc7f35e939965c301a7ed7c1c
Author: Charles Haithcock <chaithco@redhat.com>

Differentiate scenarios when watchdog is closed

This commit updates the watchdog closing logic to print a specific message
when the watchdog is closed unexpectedly while still running. It separates
this scenario from the failure to stop when nowayout is set or when the
device fails to stop in the hardware driver.

> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
> index 9a5e544b886bf..72f687aee067a 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -955,14 +955,17 @@ static int watchdog_release(struct inode *inode, st=
ruct file *file)
>  	if (!watchdog_active(wdd))
>  		err =3D 0;
>  	else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, &wd_data->status) ||
> -		 !(wdd->info->options & WDIOF_MAGICCLOSE))
> +		 !(wdd->info->options & WDIOF_MAGICCLOSE)) {
>  		err =3D watchdog_stop(wdd);
> =20
> -	/* If the watchdog was not stopped, send a keepalive ping */
> -	if (err < 0) {
> -		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
> -		watchdog_ping(wdd);
> +		/* If the watchdog was not stopped, send a keepalive ping */
> +		if (err < 0) {
> +			pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
> +			watchdog_ping(wdd);
> +		}
>  	}
> +	else
> +		pr_info("watchdog%d: closing while running!\n", wdd->id);

[Severity: High]
By nesting the keepalive ping logic inside the else-if block, does this skip
sending the keepalive ping when the watchdog is closed unexpectedly (without
the magic character)?

This seems to remove the watchdog's ability to reset its hardware timer on =
an
unexpected close, which could cause the system to reboot based on the last
explicit ping time rather than providing a full timeout window for recovery.

> =20
>  	watchdog_update_worker(wdd);
> =20

[Severity: High]
This is a pre-existing issue, but if the hardware stop operation fails, is
the WDOG_HW_RUNNING bit incorrectly left cleared?

Looking at watchdog_stop():

drivers/watchdog/watchdog_dev.c:watchdog_stop() {
	if (wdd->ops->stop) {
		clear_bit(WDOG_HW_RUNNING, &wdd->status);
		err =3D wdd->ops->stop(wdd);
		trace_watchdog_stop(wdd, err);
	} else {
...
}

If wdd->ops->stop() fails, err is returned but WDOG_HW_RUNNING is never
restored.

Later in watchdog_release():

drivers/watchdog/watchdog_dev.c:watchdog_release() {
...
	running =3D wdd && watchdog_hw_running(wdd);
	mutex_unlock(&wd_data->lock);

	if (!running) {
		module_put(wd_data->cdev.owner);
		put_device(&wd_data->dev);
	}
...
}

Would this cause the module reference to be dropped erroneously, allowing t=
he
module to be unloaded while the hardware is still running, and potentially
leading to a use-after-free when the background worker fires?

[Severity: High]
This is a pre-existing issue, but is there an unbalanced module_put() in the
error path of watchdog_open() if the hardware is already running?

drivers/watchdog/watchdog_dev.c:watchdog_open() {
	hw_running =3D watchdog_hw_running(wdd);
	if (!hw_running && !try_module_get(wdd->ops->owner)) {
		err =3D -EBUSY;
		goto out_clear;
	}

	err =3D watchdog_start(wdd);
	if (err < 0)
		goto out_mod;
...
out_mod:
	module_put(wd_data->wdd->ops->owner);
}

If hw_running is true, try_module_get() is skipped. If watchdog_start() then
fails, execution jumps to out_mod and calls module_put(). Could this drop a
module reference that was never acquired, leading to a premature unload and=
 a
use-after-free?

[Severity: High]
This is a pre-existing issue, but does watchdog_open() call watchdog_start()
without holding wd_data->lock?

drivers/watchdog/watchdog_dev.c:watchdog_open() {
...
	err =3D watchdog_start(wdd);
	if (err < 0)
		goto out_mod;
...
}

If the watchdog hardware is running before being opened, the background ping
worker may execute concurrently. Does this lack of synchronization allow da=
ta
races with the worker that can corrupt internal states?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824205051.4117=
285-2-chaithco@redhat.com?part=3D1
