Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6352C21F1
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934425; cv=none; b=afRUaMJf3TFtswbC3qKt0HhYHwRc4tR3dL1EDCXTkAEFGa1pIfT0Ebv3dpybGFcraRerZhYBponj/f895cu9MBARUn6v+E326MwY94k8lgZdYqz1fOIwBKkrNuiY3/L0B+K9Q93VODj53ots3SP/+ABHg3pm5LACpXEkIlhc6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934425; c=relaxed/simple;
	bh=eToSU84wH+RqoCHkEl2LGoVJjttIjbbnVKbZLDytt6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJbCV9WQBUuFmkdeg9JGxBTj7NOX4aXNMpo7EXppvTzLOiUt9/jHc6GxiiZbB9L+CbKJ0LTUmvVVHmKQfHfGAdzj+GpzwZH53n94ZtDTMhpV5GJK5f7wtak4hLWNTr8CWzvND4cUXGRKZDbXT1h5lmxIKvau5pKmWFpWHaNisys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsPMpy+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsPMpy+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9DF1F00A3E;
	Fri, 28 Aug 2026 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934423;
	bh=Pqjre3QyTA7X552EA8GCWXErBlK0FaBWo/SZHmj2yIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsPMpy+3glYFtdYSl7/xQ/mzhCPRJMPyG+oH8im1mdtJG+c9qQM7peK8PYB1SDXLp
	 aBnbe/FRpyy30v8K1AbRsGsejc0fuE3pNSaCrvpT0DFSeHpzUOvm0B8TQSZnnm5Ued
	 yZAkM1cptqs6/q9JFgKfLlceJYG6hrVwLbFEAKhIMYQ21wXN+CDqJMpcD4v7qyhnJS
	 sfVm3yWO0OLNbxjfyNvUPJNvrvKK/a+2gORWvtJc0lXyJvMb0FG9XGi+hdACHgpzQv
	 iBHFNjiyG48CHYiZxNH/W6XAjBq4XKCYBy7IEzcX2r/0D9XxyczmgpsJLgZlPeG2M0
	 1naaC3HKIAEqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] watchdog: msc313e: Propagate error code in
 resume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260828161348.13212-9-tzungbi@kernel.org>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-9-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:27:03 +0000
Message-Id: <20260828162703.9F9DF1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver manually clears core-managed watchdog flags (WDOG_HW_RU=
NNING and WDOG_ACTIVE) upon resume failure, which violates subsystem bounda=
ries and causes userspace watchdog pings to silently succeed while the hard=
ware watchdog is actually stopped.
--

commit 671369d67bb1efa18f6207e680185bff41e40d0e
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: msc313e: Propagate error code in resume()

If msc313e_wdt_start() fails during system resume, the error is
currently ignored. Consequently, the watchdog isn't running without the
user's knowledge. This commit propagates the error code, prints a
message, and explicitly clears both the WDOG_HW_RUNNING and WDOG_ACTIVE
flags if start fails.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index eea26c6c95d84..eff90ddeb3634 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -192,11 +192,19 @@ static int __maybe_unused msc313e_wdt_suspend(struc=
t device *dev)
>  static int __maybe_unused msc313e_wdt_resume(struct device *dev)
>  {
>  	struct msc313e_wdt_priv *priv =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> =20
> -	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev))
> -		msc313e_wdt_start(&priv->wdev);
> +	if (watchdog_active(&priv->wdev) || watchdog_hw_running(&priv->wdev)) {
> +		ret =3D msc313e_wdt_start(&priv->wdev);
> +		if (ret) {
> +			dev_err(dev, "Failed to restart watchdog (err=3D%d)\n", ret);
> =20
> -	return 0;
> +			clear_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> +			clear_bit(WDOG_ACTIVE, &priv->wdev.status);

[Severity: High]
Does manually clearing these core-managed flags cause userspace watchdog
pings to silently succeed while the hardware watchdog is actually stopped?

If msc313e_wdt_start() fails during system resume in msc313e_wdt_resume(),
the driver manually clears the WDOG_HW_RUNNING and WDOG_ACTIVE flags.

Later, when the userspace daemon writes to /dev/watchdog, the core
watchdog_ping() function could immediately return 0 (success) because
watchdog_hw_running() evaluates to false. This bypasses the driver's .ping
callback and returns success to userspace, hiding the dead state from
monitoring software.

> +		}
> +	}
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828161348.1321=
2-1-tzungbi@kernel.org?part=3D8
