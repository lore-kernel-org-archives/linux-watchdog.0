Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7611336897
	for <linux-watchdog@vger.kernel.org>; Sat, 19 Sep 2026 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789846401; cv=none; b=B1h3RV1azDj+qe5V1k2ANAElbg/rUMSDauqBRj/b70GBIbEV0sY3OVF3X/+CBEd1OIcTKB9IxC83U3J8LfiuVctzgzXDrzjk5PHW/y2/XTlU3t148EvERpUo/HREhtIFa7Ll7jdAOxPJf7ZDWEXRP+hHZk/DgP0QO6a6YVNk7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789846401; c=relaxed/simple;
	bh=Wfm7MRdCz3PCooPqLwwI+1PZ2qUS3OpbHZDPUP6NcMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X2YoxJnv0J8prBqTG3ggkW3lvhy33lNvz7b69C7m6Y/3ixDAYBF6QI+nw0WXIOw6yeB/2eLdtiBVGkCZ4eObsnjzi/Qhi7p28JOYJ5O8Hc5ODB+BQJ9Hwle13uGu4oy+s6VEg1n3/cv9s4YDXxIV4/GPxUIxn0ZsCN9dcZUIUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8Yr0Exf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8Yr0Exf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB191F000FF;
	Sat, 19 Sep 2026 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789846400;
	bh=uHUiOrUQd7ZyTuTIS7x32T2BmEhUAE/dCCv8BTk9Yn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W8Yr0ExfhqPLSOKV2YfqFlI4UzIfvnnzfgNgVroO+Q9wjX23R6z5vuyaOS6cu/Cxa
	 KGwseGRNLL/rCScF9FmO+ACZOr8cDoIBo+tsP45ccQY3TssNrMrcX+unumlug4C0Ug
	 4JQ0b25SJ3lyhDZbIQRD3qHtWtkBep/umhIFUBGf9W98DvTMG6szTc3fpbHl+MPkPH
	 Yd6Kh4KiGwkTAfpoESuf/+JasJ/oPTxqp0//xPwmFYU2a/W2Rm51pAtpZt++IX3sRT
	 7Kl+QBaOhZdcwOlgY0ZmNODLKBJBJffSWzvKSs/Vk+6BgX767fBPeux9S6caYdRBre
	 mW9zXD8/IVW8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: cpwd: serialize device access against
 cpwd_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Bilal" <meatuni001@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260919192301.272194-1-meatuni001@gmail.com>
References: <20260919192301.272194-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 19:33:19 +0000
Message-Id: <20260919193320.0BB191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: cpwd: AB-BA deadlock between misc_mtx and cpwd_mutex
--

commit b2d69e49e806eb6cb2c3610179ff17ccacb7cf1b
Author: Muhammad Bilal <meatuni001@gmail.com>

watchdog: cpwd: serialize device access against cpwd_remove()

This commit adds synchronization using cpwd_mutex across device operations=
=20
and teardown. It guards cpwd_remove, cpwd_open, cpwd_ioctl, and cpwd_write=
=20
to prevent race conditions that could lead to use-after-free or NULL pointe=
r=20
dereferences.

> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index 13a4d47e68cd8..48f5e92b8cbd0 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c

[ ... ]

> @@ -618,6 +631,8 @@ static void cpwd_remove(struct platform_device *op)
>  	struct cpwd *p =3D platform_get_drvdata(op);
>  	int i;
> =20
> +	guard(mutex)(&cpwd_mutex);
> +
>  	for (i =3D 0; i < WD_NUMDEVS; i++) {
>  		misc_deregister(&p->devs[i].misc);

[Severity: High]
Could this introduction of guard(mutex)(&cpwd_mutex) here create an AB-BA
deadlock with the misc subsystem's misc_mtx?

When a user opens the device, the misc subsystem acquires misc_mtx before
calling the driver's open function:

drivers/char/misc.c:misc_open() {
    mutex_lock(&misc_mtx);
    ...
    if (file->f_op->open)
        err =3D file->f_op->open(inode, file);
}

Then, in cpwd_open(), the driver acquires cpwd_mutex:

drivers/watchdog/cpwd.c:cpwd_open() {
    guard(mutex)(&cpwd_mutex);
    ...
}

This establishes the lock order: misc_mtx -> cpwd_mutex.

However, during device removal, this new code acquires cpwd_mutex first,
and then calls misc_deregister(), which attempts to acquire misc_mtx:

drivers/char/misc.c:misc_deregister() {
    mutex_lock(&misc_mtx);
    ...
}

This creates a reverse lock dependency (cpwd_mutex -> misc_mtx), which
could deadlock if a module removal or device unbind occurs concurrently
with a user-space open on the watchdog device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919192301.2721=
94-1-meatuni001@gmail.com?part=3D1
