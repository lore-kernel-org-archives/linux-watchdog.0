Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B036A376
	for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081557; cv=none; b=K5gDA309w6MAMh1jR6kCCvK2JVOlRQDKLcc1kCpldhpPsj78zsvjhpokjU61sFs4KWOgE7ihepheRQzpYEawtGt1u1TnaoM/GHTOFCOL2W+geQxjVyyHMT++m+zUl5eR3yjGfI8hMV+hErWHgelQ0f/m2SnUt7minaeDfa4hH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081557; c=relaxed/simple;
	bh=xJfJAteg4axihJ933Ft5/qt/NUmEeAVu/W3zUFO/zR8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzEMRX2N7N+sKe/KYP+7ZcoO5q4PQpgJmA/aW/aQCVVXxcv3Mfo3uS1S5HhWiNhIlkXeRpNGxJhMur9mH3CjL3aYBoUf/VeWk9JhoAVbfc250IHzmNgalWndMxYqMp05lUApQhkO+d+AYzkYaVhv3Nj3jZASWzTVnUoO2lTDbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=i5sISaL0; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="i5sISaL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1787081546; x=1787340746;
	bh=gHf37RNTlIwCVXI/bxIQxrItLpYx40Ze+VZ4Rny/ItA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i5sISaL0JAVEPmOPUEdLkx9kpW1BfnLw5BURnTKsR6ihZVlN8e+23hqEDePTj8Pnk
	 8OCCJyXQkcn5aN6y+L6B7b1Mu+nupdqWEMChnhoDbeVU7gJ8l/6dtCvE5KQZvwL0pa
	 AFT28LGFJL2QmsFyF3G5YkXF/PSplW9XE5Kur4WTKrJjcPZEPX1bN5MmeY3ksIgg1o
	 mwFfO1eLvqkA40Gpp3z6qu3OGSSH+l9PAutPJ7Fn3KcEKyQ050Wz0ASonF51vBcOII
	 l2KzmpHsrgZN7ZIGFYrHIk6hO6QEeFaV8v1sQ/jvh+0Th2KdiuAN86ZtymcvQ9Y3Ho
	 rUobmiPd5hAXg==
Date: Tue, 18 Aug 2026 19:32:20 +0000
To: Guenter Roeck <linux@roeck-us.net>
From: Aiden Isik <aidenisik@protonmail.com>
Cc: sashiko-reviews@lists.linux.dev, Aiden Isik <aidenisik@member.fsf.org>, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
Message-ID: <MvMjoAjL-_p1bx0Hkz3LV5jIs_HCsdxe7agP0T68PVra0YpfiQpAP7DEkimB7y5HUZ6hbCYM1W713QZKI2E8AEwxIwPXHsX297CSck7_r64=@protonmail.com>
In-Reply-To: <e634117e-57be-4c74-973d-3b13cbcaa640@roeck-us.net>
References: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org> <20260818-for-next-lucky7-watchdog-v2-2-6743f479a47f@member.fsf.org> <20260818155332.9E0DD1F000E9@smtp.kernel.org> <8919c7f3-2dcb-4666-91e0-a91edc378c28@roeck-us.net> <M_lNzXuQ5wi3MVyFU1JstH_dxQWKDdPGje5yyVFO9lvJsz1H4USWNtew1040JtG4p17UrpWTWoohByvy_x7Nc5dvBh0LuONKNmPZPNMImdg=@protonmail.com> <e634117e-57be-4c74-973d-3b13cbcaa640@roeck-us.net>
Feedback-ID: 46524699:user:proton
X-Pm-Message-ID: c095483f18f53041e481961d09f656e5727353d6
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

> On 8/18/26 10:56, Aiden Isik wrote:
> > Hi Guenter,
> >
> >> Aiden,
> >>
> >> On 8/18/26 08:53, sashiko-bot@kernel.org wrote:
> >>> Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> >>> - [High] The `drv_data_exynos5515` variant includes `QUIRK_HAS_PMU_AU=
TO_DISABLE` but fails to define `.disable_reg`, resulting in PMU register c=
orruption at offset 0x0.
> >>> - [High] The `drv_data_exynos5515` variant uses an INT_EN register fo=
r masking but fails to set `.mask_reset_inv =3D true`, inverting the watchd=
og masking logic.
> >>> --
> >>>
> >> Please either address or explain why those are non-issues.
> >>
> >
> > For the 'disable_reg' issue Sashiko flagged, downstream says this:
> >
> >> /* PMU registers are changed.
> >>   * MASK_RESET register was replaced by CLUSTERx_NONCPU_INT_TYPE regis=
ter.
> >>   * DISABLE register was removed and its value was always fixed by 0.
> >>   */
> >
> > Which is why I omitted disable_reg. It no longer exists.
> >
>
> What is "downstream" ? I do not see this comment in the patch, not
> in linux-next as of next-20260817.

Samsung's Linux kernel fork for Exynos5515. I host a mirror of it at
https://github.com/Aiden-Isik/linux-android-lucky7.

>
> Guenter
>
>

Kind regards,
- Aiden Isik
