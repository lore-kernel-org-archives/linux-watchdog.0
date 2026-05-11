Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBF346FA6
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535862; cv=none; b=mKfSq6hQiLCCzOJgYbApwef7d3ok5f0rg1J5rGFjKG0HGXw8Uj6FxPXzcEzFpJpsIHc1ucecbmBn55VUrYfhM02xF8HfKCxgH9HMRxaKfWW2ocz28jnjBhAtfpZgeGestJBlkFnGsD8sNuI5r59IoTdSjIrSfBaSvHxHmpJHV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535862; c=relaxed/simple;
	bh=KP9JH3wuHbmJcBsUPBAb+8FPbVLhe0Nq5lcMUPDrRUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bUv/V/LYtQNGF975+uiUGDSSiVqNPlVzDWM3Aur4Y384jNTQTz9RsagM1e/gMFf4VKq5RWv6N35FCKtpPXjx+skg/0CO5rNiJ3lc/i4YxCpmYLPfUvCo62Op+v4FzqYUCsZeeUDL/NzEsOYSuLl3BRHPBhPhPkX57/Bdvt1nB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG3jiBU0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG3jiBU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDEFC2BCB0;
	Mon, 11 May 2026 21:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778535862;
	bh=KP9JH3wuHbmJcBsUPBAb+8FPbVLhe0Nq5lcMUPDrRUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vG3jiBU0YdBnR4cDYw1NB+bIlRsQ/6Jt06YItL8W4Vp5+83XdtDb23oCtD8b5umZs
	 yIahYsSmNbFuyoDG/9EW9l8E52b65KHBwGCQ+h5OAwI/RnrNy2ooOFZ/+kAi3RWCX7
	 t1aGivtjxlD59BezakF3pfJDJaN8WxzCaV8P8VGC36NAitzRXMU8JD29HsB5wXjRRs
	 FGYolDP4PrCRZ+a6OarGBZdKGlcLCl+KEZzqM8WgcL+mn8xVOC34OCno+LSyXESxqC
	 rWMT+v+ZvVGPw8nZI003+lv52FYNcDlzx7yQxYhpnFV56ka7hBHXhChRqrZjtAWWzI
	 dzaqNVDW+xn1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: sb_wdog: add missing SPDX license identifier
Reply-To: sashiko@lists.linux.dev
To: "Mayur Kumar" <kmayur809@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260510191847.50499-1-kmayur809@gmail.com>
References: <20260510191847.50499-1-kmayur809@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 21:44:21 +0000
Message-Id: <20260511214422.1FDEFC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The applied SPDX-License-Identifier (GPL-2.0-only) contradicts t=
he explicit license boilerplate already present in the file.
--

commit 64e66089a6e522c77284fd01a8849e12869d23c7
Author: Mayur Kumar <kmayur809@gmail.com>

watchdog: sb_wdog: add missing SPDX license identifier

This patch resolves a checkpatch warning by adding an SPDX license
identifier to the driver source file. It defaults the license to
GPL-2.0-only.

> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
> index eaa68b54cf567..03db71a43d6fe 100644
> --- a/drivers/watchdog/sb_wdog.c
> +++ b/drivers/watchdog/sb_wdog.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Watchdog driver for SiByte SB1 SoCs
>   *

Does the GPL-2.0-only SPDX identifier contradict the explicit license
boilerplate already present in this file?

Looking at the existing header comment block:

drivers/watchdog/sb_wdog.c:
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	version 1 or 2 as published by the Free Software Foundation.

Applying GPL-2.0-only restricts the file to GPLv2 only, which strips the
explicitly granted GPLv1 permission and creates a licensing ambiguity for
downstream users.

Should the SPDX identifier be updated to match the existing boilerplate tex=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510191847.5049=
9-1-kmayur809@gmail.com?part=3D1
