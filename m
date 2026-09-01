Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B6335555
	for <linux-watchdog@vger.kernel.org>; Tue,  1 Sep 2026 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299537; cv=none; b=E4f+1sX9ogXl/faUd7/CtMes8Y4/nyqIEZTlZjTk2eNfsjB9SPm+u3yDLDXXeLgB0TsSxQqvq21zkZzEJ6LP+dtacKlltDbSowah8huzUBMEuuinot1icUnidq09Xma1943O0bcQ/u7Ehas/InbOnEmCdwRkO8b6m6rmOwMZkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299537; c=relaxed/simple;
	bh=c7GDTd4TUajJu0Qsp/H5JWKhiY+3D/iXenfG8x3wpLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rTTCeSuW4Arctfw1ZbR9aV+AIhpxDFXZk1MgIM7cG2jMP20s1biBqzwp8VpYgtwhQfgkhayOlS5IdssRRAfMQkU2F+exYh4hyWo/vr6jqnbVF366tCzuS2VzZobqC8KwjZEVylOdfoChykmW/kSw2/UVVbuWXGLpAKrAAHY5Zq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mul6qn3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mul6qn3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4E81F000E9;
	Tue,  1 Sep 2026 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788299535;
	bh=7Ge3iDM824Eg9C+8nsWEuEbgJv6PfPNqMjgiNmQA7U8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mul6qn3spgs+km9hRcxwVARQjy4CHa1ubUgP75/uQrACcvHrd5/ZYEjtG9bzNAgRX
	 RtjLG8+bOOSUtNz+rFOxwwwhd/I0f/HaX3HJxPJchkzog/05Y3ktyZ8lhH2sLdCcQk
	 KZh8vlty199vl7y0d1N2u+qpohKkkwk689OzVRwf9XtH7FZGkX3el49vOh1+jcnxxk
	 KsBzdl27xgvng/Lq3QRxXsuZbh5mPzVV16upJMySzDVmpzqyMn4m344SyXnQ62ohoJ
	 Cc22/S7vMD7WPBqqrJ/zyM0T9l55pnkfVnQo3vxcvMf8CN+tJdsjK8ABigpCI6CTbP
	 wUtFQRlJEjTaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: Differentiate scenarios when watchdog is
 closed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charles Haithcock" <chaithco@redhat.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260901214251.760184-1-chaithco@redhat.com>
References: <20260901214251.760184-1-chaithco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 21:52:15 +0000
Message-Id: <20260901215215.7D4E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `wdd->ops->stop()` fails, `WDOG_HW_RUNNING` is never restored, =
bypassing module unload protections and breaking fallback keepalive pings, =
leading to a Use-After-Free.
--

commit aaf821e8a7620610688b1a164fc083439874422c
Author: Charles Haithcock <chaithco@redhat.com>

watchdog: Differentiate scenarios when watchdog is closed

This patch adds an error message when the watchdog device fails to stop in
the device-specific code paths. This helps differentiate between scenarios
where the watchdog was intentionally left running (such as when nowayout is
set) versus when it simply failed to close.

> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
> index 9a5e544b886bf..6e3e437b7851f 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -305,6 +305,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
>  	if (wdd->ops->stop) {
>  		clear_bit(WDOG_HW_RUNNING, &wdd->status);
>  		err =3D wdd->ops->stop(wdd);
> +		if (err < 0) {

[Severity: High]
This is a pre-existing issue, but if wdd->ops->stop() returns an error, is
WDOG_HW_RUNNING left incorrectly cleared?

It appears clear_bit(WDOG_HW_RUNNING, &wdd->status) is called before
wdd->ops->stop(). If the stop callback fails (e.g., an I2C failure in
drivers like ziirave), WDOG_HW_RUNNING remains cleared while WDOG_ACTIVE
remains set.

Could this bypass module unload protections and lead to a Use-After-Free?

If userspace closes the device and watchdog_stop() fails,
watchdog_release() will execute:

drivers/watchdog/watchdog_dev.c:watchdog_release() {
        ...
        if (err < 0) {
                pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
                watchdog_ping(wdd);
        }
        ...
}

Because WDOG_HW_RUNNING is cleared, watchdog_hw_running() evaluates to
false and the keepalive watchdog_ping() becomes a no-op.

Later in watchdog_release(), it evaluates:

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

Since running is false, it drops module references. This permits the
module to be unloaded and watchdog_core_data to be freed, but the
background worker watchdog_update_worker() remains active because
WDOG_ACTIVE is still set. Will this cause a kernel panic when the hrtimer
expires and accesses the freed struct or unloaded module?

> +			pr_err("watchdog%d: Failed to stop watchdog: %pe\n", wdd->id,
> +				ERR_PTR(err));
> +		}
>  		trace_watchdog_stop(wdd, err);
>  	} else {
>  		set_bit(WDOG_HW_RUNNING, &wdd->status);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901214251.7601=
84-1-chaithco@redhat.com?part=3D1
