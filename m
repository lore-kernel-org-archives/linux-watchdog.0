Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB91364047
	for <linux-watchdog@vger.kernel.org>; Fri, 22 May 2026 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493137; cv=none; b=pDQdjm8hlWzFGToSqJckJV2h383qqoOyDcTgDHB21Hr6yfUdg6Y20CwkAfmBT5LLfYQ67jXI2MSFWs5rwUo9iHfox5yaUKnGCtIlswsTX/U5cvPd1+LYFB10SSf9bcy42kua8pEBujTAwrvXq7BXkrWi1IBXCx6AeVsB0LyB1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493137; c=relaxed/simple;
	bh=3Eh8rr96AjUMuw30JiAnBRB17dMMNGmTMqF1yKYk39A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pky01ij24fvCnxATW9toXU7+2TV8MbCqGYlUkFRa2a2tIBT8uJ9tr+Eng4txOn1ArbUV3Xbin6szItSiQL8khg4loDVc8u97j0cUkmS+3qsygvpYOMEwvoFIq+vhVHtbRqX+KIh+KfN/or0kkeL/pB+rkET2Tgln5zUi/ACV1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSg4gsr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSg4gsr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1FE1F000E9;
	Fri, 22 May 2026 23:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493135;
	bh=3Eh8rr96AjUMuw30JiAnBRB17dMMNGmTMqF1yKYk39A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSg4gsr0i+ZFsYo+dH6BJ2YjROZreUSDcwOlbCqu5ajnCtV4YbG4sgrgm8FbUyy5L
	 TiFEu2aQvNGR6DIuPtgW0LTJr/RUPvyrD2yGWtRoCwTgumdluB1+c+1qOLQ9SzllrG
	 cZ6RbNafkUnCi1ASxV+hmpXxtCWyv0Z7Hx+6u++JnXyWZ3GlzhESze5nEtbL5M5Hu0
	 4l1NbstRTGKY1BL50JzaPq10Y07sCdu05NSZ+780KndRWVix8Xmn0lUzN5scLkYBE+
	 IzS5LOu6WLUVg2eQ48Ii5yT9HA+L4NYr80Oyt+FSlTOMzJ/hg/WLzj+Mr8qqJvXEsD
	 ZtTmJWslLgITw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] watchdog: ath79_wdt: select OF and COMPILE_TEST
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260522232553.44748-2-rosenp@gmail.com>
References: <20260522232553.44748-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:38:55 +0000
Message-Id: <20260522233855.CB1FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to 'Select OF in Kconfig', but the pat=
ch actually uses `depends on OF`.
--

commit dd7e4233a00f2440d964fb07f7978a246e1b7c28
Author: Rosen Penev <rosenp@gmail.com>

watchdog: ath79_wdt: select OF and COMPILE_TEST

This commit explicitly requires OF for the ath79_wdt driver and allows
it to be built with COMPILE_TEST on all architectures. It also removes
the CONFIG_OF conditional checks around the match table in the driver.

> watchdog: ath79_wdt: select OF and COMPILE_TEST
>=20
> This has always been an OF driver. Select OF in Kconfig.

[Severity: Medium]
The commit message states that it selects OF in Kconfig, but the patch
actually implements this using "depends on OF".

Does the commit subject and body need updating to accurately reflect the
implementation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522232553.4474=
8-1-rosenp@gmail.com?part=3D1
