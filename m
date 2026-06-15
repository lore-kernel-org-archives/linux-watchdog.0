Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928043FFFBD
	for <linux-watchdog@vger.kernel.org>; Mon, 15 Jun 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536104; cv=none; b=AWNHIUOHFBZtsPxSl1/eNLC21GLcemcNDMrm7JRxiV0KXMIbu47+nF3AT0adZVdJDL3wVXqXjmF9SeGiNFAZj87ogBbwztx+pW/0kg06Iac1EUwi8Uu8eUOAMdV2MYI40JbTjuHecnxJi5jQKXrClseP0hP++xMFzzxv1noNih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536104; c=relaxed/simple;
	bh=t89NUc/TGv4jiXGKrHOPcozjQfC+wotyZ/VbB4vskMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QhvX7ILXVa4/Q3mDAwByR3xRU55kaDYgsFp7Bu1BtSqJZ4K+Vkf8wqQcIA+/txd0v1hj/dbZkp0hYgakhbVCpQ2dcEEhnQls52uwoym+8EnKxm+N4NQuH7qiihKpWEnbbHCTTrhhT80UQ5CbregGGwT1WMAi1uz1rXtlZrnn/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhvpns0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhvpns0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511211F00A3A;
	Mon, 15 Jun 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781536103;
	bh=0S5EzcQMBZgygI3mCYe9VExiPC9JmpD7svIAmnlTOBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jhvpns0w2RrhLPJ1cAMyNa9V5iZ6lSCl9efgZkgTV7/WPsVDAJDOTd+f573AUWdDL
	 S0n2fKgTvQ6/2MX6PJ2aCG54bfdN50ILQ8XgVyUCEQ0FuCxzxtsDmMr9xQtx0cAyO0
	 fIPpDzamAVQH0usc4zTK/co9Q75QRLoM9yuwqNSD8kJzTx/oZa6OHXD7+lN4i25yjS
	 a+S3eqceF6MMao1Qb81HDZknOwTL0BmWX4y6McKetCx0cr2Qw6rQyeI+geFQmRF+Ea
	 I9eouEZYe7c8vk3rhbY7Wnphr90VtH+5CUlIMv7fMtQ/Cu44nt6HDrUHoQYjFUsbQW
	 sQNH9ZRMzX4dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: take all OF aliases into account when
 assigning id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rasmus Villemoes" <linux@rasmusvillemoes.dk>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>
References: <20260615145759.3142743-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 15:08:22 +0000
Message-Id: <20260615150823.511211F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Watchdog devices without a device tree alias will completely fail =
to register if any watchdog alias in the system has an ID >=3D MAX_DOGS - 1=
 (31).
--

commit 8dd153efc0fe9ba312373b449e8eef726a399693
Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>

watchdog: take all OF aliases into account when assigning id

This commit ensures that watchdog devices without a device tree alias are
allocated an ID greater than the highest numbered alias in the system. This
prevents devices without aliases from consuming IDs that are intended for
devices with aliases depending on probe order.

> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog=
_core.c
> index 8300520688d07..d1f3fa741a4f7 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
[ ... ]
> @@ -265,8 +265,15 @@ static int ___watchdog_register_device(struct watchd=
og_device *wdd)
>  					     GFP_KERNEL);
>  	}
> =20
> -	if (id < 0)
> -		id =3D ida_alloc_max(&watchdog_ida, MAX_DOGS - 1, GFP_KERNEL);
> +	if (id < 0) {
> +		ret =3D of_alias_get_highest_id("watchdog");
> +		if (ret >=3D 0)
> +			min_id =3D ret + 1;
> +		else
> +			min_id =3D 0;
> +
> +		id =3D ida_alloc_range(&watchdog_ida, min_id, MAX_DOGS - 1, GFP_KERNEL=
);

[Severity: High]
Does this code prevent unaliased watchdogs from registering if the system
defines a high watchdog alias?

If a system defines a watchdog alias with an ID of MAX_DOGS - 1 or greater,
min_id will evaluate to MAX_DOGS or greater. When passed to
ida_alloc_range() with a max limit of MAX_DOGS - 1, the requested minimum
will exceed the maximum limit, causing ida_alloc_range() to return -ENOSPC.
This would fail the device registration unconditionally for any unaliased
watchdog.

> +	}
> =20
>  	if (id < 0)
>  		return id;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615145759.3142=
743-1-linux@rasmusvillemoes.dk?part=3D1
