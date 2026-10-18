Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46053B3C0A
	for <linux-watchdog@vger.kernel.org>; Sun, 18 Oct 2026 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792312914; cv=pass; b=KYfv28xo1OXkOAs1qd+/UmGvJJTOIJdGXTZJP6wdEOQNdyI92XboUS35ZmLauuAJNxKEX4o9jj+EFCWA1faAyhYJb3toxe78kayuIy3SJj8Ljq2tzW3AHUrESZt5fi9GPvuxRF/LmSN6lB0kqgjg9OD93f9Tj11MBzDaZkw+8ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792312914; c=relaxed/simple;
	bh=5iRx2ZSxes9xpNH/ccBYerhwDJMxlHq/pyvCpsWU8SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN+hdqhABB5Yg+izqha09gdeYioPS5fL6MZ/sgDcRI258EwW1C3uR7uDQgSlvXkf8FRJLc23SC0VZeMBwemhxNDa/dkc+fyxAFCTZex1uteTmdUuLsfjxG0NtT3Re1fj5I030jfvJ5D17PBzlGVBLbGOsg1PGP3bxC9qinuRgz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS4UZku1; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS4UZku1"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso1305463a12.3
        for <linux-watchdog@vger.kernel.org>; Sun, 18 Oct 2026 01:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792312911; cv=none;
        d=google.com; s=arc-20260327;
        b=cr67RY7D6xlgtF7c8smtjebbA4lXXWNnIrtlRJgrXUNdiv7MH4sYSmtE6xWh/qgk3y
         WbeOdd0cwlBiDYfrGk4VCHdp01lGO2pr4fFzZvz6CNSqJq8r9CaVKKPW7XIxKZpiiS/c
         q8KMH5g3/zB+tyT8yXbjg0Iihbm5FcFXdL0X/00QMSNotak2ANN8eYls0dwm5/aiMbIK
         sDeJt15gMvCWKDRO40/v5zL9LOXeojLY9DxlO/IAKrf8w3PF+GeOhNQec5eLrJqeVqPH
         Rd9ytJS/8YLRD57bNXaEh3yyXKk0Gw1hKarwLz9useVh/v3LdkfrcnqNU8qsyuruvBsy
         2B/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5iRx2ZSxes9xpNH/ccBYerhwDJMxlHq/pyvCpsWU8SI=;
        fh=lJH5RsSKFaEs3m86SCx2eCds/c8oslXokozLR9FOM6U=;
        b=BR+qe21zCEF4LkUvVU/HNGXK6UQjuQWxHpoaHub4FwcUSh8bD/q6stCBdSaSsdI6Tg
         ngQS1K5XH1pyl5wi+b6g9Nq5LZO4HnwG0hNMR8gWErgoaOhJqswNwJRDnjfhVJjjRBaw
         QGXwVvmEem4HTAts5JzoFo2dh3rSLwLgJIxDH3JSBkc/WVNFKGTV1NZYYpCJIxioMUZ4
         hG4/zHtsux37dKytDDXJ7ppe/TzWahPXPlPeA9UAIszeAk30XlgNi+6nYT6ZTDL+vewA
         z+bhBYoaRSymjZUWtgo0o6CXQtNWEFgkJfVZOhcdjWY86oeVwYRMMKMqhXL9v1NQWhe4
         pcwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792312911; x=1792917711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5iRx2ZSxes9xpNH/ccBYerhwDJMxlHq/pyvCpsWU8SI=;
        b=VS4UZku1t06BlRiF1T9+BaNwWa/HYdm8UQq2ThmXtJ+uYUf//9yDO9c9g2NAzeNVQM
         JORBHzB0aOsMZUvzXL4d2fTOokKIQgC2MfQaQ2TqoJ9x7mrwDU+yOUc6bFAVrOyYlsKr
         ODPl4hNCBa95CUjsmn4JVZ8JA2qigfYMJFDPd0fGJkhXdnEopdYcQCP39BGlTtMgIGSn
         xWBwmc8qOQBjFgvpFUypj7yNOaA5XNhsqcGoWntrndSN5tHXC68pV//kg/PJk+K55axj
         cvr8RdQXshuuIbpWZd6ct/l/1KK5ppZ9j2VNpzaNyGcATpXkUxrF3hp7fA77SclezMjO
         C8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792312911; x=1792917711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5iRx2ZSxes9xpNH/ccBYerhwDJMxlHq/pyvCpsWU8SI=;
        b=s43N4D8RWY6JUWmNtWiYoJX9CF1GScGtZTs2zbvo0LqIAdGP1Ja/7qffWAvOfgPdiT
         IraZmv7JRTl2mDcCeBsnS3OBnQSIXOgLFAvSLm/+4/68ffI1XDTtEeKhYhZdy2x0cuOM
         cyePvgo4aVtpRipFGyyezR2+yRrVuo5CH80p7cm+dMcYDFs4QZxA4eJwU4jFtvemxc8T
         Z9Ms/ET1LWS7EOfNoowpHUR1tz44sF9UmYQX7hGNSkbgSYJkdtrH+u0IoNj1eqbnsDx+
         lGTc9lvhrVh+YZgxFwxPkFgCQgSr/jbeYV9uFs3GVMtvBWoWA2KnC4eIluYpwjqes4Yl
         CaPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvjMsHDtSn+nUr6/qo2bowby4NCLgfSNdk/ThdmB4hhoE6mTrdgFd4OcHDQ3sR0x6Xmzi0bI+3lEHSEz/kYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYItNYdbsOSuwY+usdkpIsFgoaEsYnHLT3VNtbr2pISryrQOwLC/
	84w1gTS1x5MVIR2WHjLPa4eeLkuIddlLMW9LXRS6ke+peL8KY15+FEExjo8KwZOZi1nvNNq9NGj
	7HrnuKmX+jGOlexzoEnwS86QKeFGhrEnav4uX
X-Gm-Gg: AYBFou0oPV1J6j9H2V30l/WET1BCu3fz5i8SWgxcAZnJxqgL76K19bLq6uRLhNntaMn
	gTfgyXm56T1E3+ou6J2oy2eEB7B2n5l/wwNYWYeL76AYZW2XH+kbK66hOAi9cPQBPfLxJvx2L/t
	3zxbzSnQ2Rdee1NpW4tb2wXGF7j2UypB6TcrUm6sEWI62v4PJezgp0cNzOTWBIPG2htsOSnU9Tv
	D2RqIhYJDHMuhALY46u7vQQ/iaiKNz6bY21PgYtaEN1zpeffxPHQ0LTm/qrPe64/6W/Jf4M6I4t
	V6hXp3VXjDHXfT+O/MrR96YmyTt1ulAlN9goiqMPgBR28xu4MgZ9zfwx
X-Received: by 2002:a17:907:a2cd:b0:c40:dfec:50b6 with SMTP id
 a640c23a62f3a-c41a0cd5321mr274282166b.49.1792312910747; Sun, 18 Oct 2026
 01:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320135624.223863-1-a.shimko.dev@gmail.com>
 <25916fdf-22e2-4884-a78f-a7926a99b63e@roeck-us.net> <20261018-dw-wdt-shimko-v2-ask@iav.lv>
In-Reply-To: <20261018-dw-wdt-shimko-v2-ask@iav.lv>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Sun, 18 Oct 2026 11:41:40 +0300
X-Gm-Features: AclHuK9P2iF2gWSz851uTbxbHnWf2v6nboUYIiTnbXgBU-u-2PjNlk6Dv4sXWhE
Message-ID: <CAOPX747Nbzs0aQBoxXx2_K9qY2_6RyMqtcpWcop3KrZqcm0u7g@mail.gmail.com>
Subject: Re: [PATCH 0/5] watchdog: dw_wdt: reset clean up and pm
To: Igor Velkov <iav@iav.lv>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, p.zabel@pengutronix.de, 
	mika.westerberg@linux.intel.com, andi.shyti@kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

Thanks for reaching out, and sorry for the very late reply - i missed
the earlier review feedback =3D(

On Sun, Oct 18, 2026 at 2:23=E2=80=AFAM Igor Velkov <iav@iav.lv> wrote:
> Do you plan a v2? If not, I can pick the series up, keeping your
> authorship, and address the review findings. Armbian carries it for
> RK3399 boards (Helios64, ROCK Pi 4A): together with resets on the
> rk3399 watchdog node, the watchdog no longer resets the board in s2idle.

i'd like to continue with the series myself and address the review findings=
.
But it will be great to collaborate on testing, especially since you
have RK3399
boards (Helios64, ROCK Pi 4A) where this actually matters. i'll also test v=
2 on
my side before sending it out.

Thank you.

Regards,
Artem
