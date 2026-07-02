Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E54A13BE;
	Thu,  2 Jul 2026 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007311; cv=none; b=Q2OZ/296y88il3oQLcRTBijPYPwX6P9uz1YCgWoav6MM56bC+5k7Zdq4g08+o8YMfv1eBj+w2QyGHdOrJAxx6qXAqdGXBhuqFD7fZz/hyf+QULy1cy+ciMRCDuFHzrwYqD1t5x7oE209vbOBdRTOWmG8tUlcb5Iy/OYFi5YqSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007311; c=relaxed/simple;
	bh=bC02IXRyUtam/K63OqClv6GezabIVoXLE1LRXZMRCmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LAi7ED4gPpHE/5zKDDglmKCZSKdQuZSpf7RaKJ3e0zWmKXzKHknygPaBn9jiTCVxqlHcp9VjNEvfKMqQs6XJPOBCOCl/EqkKLxpGtarLGF8A67GjpQs/KtOy4NNWSGRFWP5HmgdTWJU8CUYJvpEx8g/9iF0tNBickIlXGAAf5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm8LBoU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm8LBoU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F81F000E9;
	Thu,  2 Jul 2026 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007310;
	bh=mAQwTMxJrdyHL3I8Pf5y0dbT9yvLueulFvkIgfXWEC4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Sm8LBoU5UzyMOGMClgbU25/yaSAVQnr+SPK5ZoSJWoW7nWqHNYu1jY8B1PW9pbkEO
	 hfP18jSg35VBxcgoiKKT3Pd8ZypIQaWN5eXgBGRK8dwegjU8vC9aF9yn9uN1ldBPJo
	 tw2jFd9WND9nRfLMZTOIiEXGYjjrBTqOeeBXJEdrPgNEWJ+jjwDDBNhAFPZ7H1Khaa
	 TiI5A7QAbaGa3YEw/RXYv+lE0fp6S4Uqmua2VQYkzHGBLwrKY7M8cYZ6XCEy32ENBt
	 PxY6Ggb9W9I+4kdjmCndsaSiCHMO+BR+9pnn+hKI51xY8pJ7rK0zDnn4684YiaaA3Y
	 BvWZrViYiS6hQ==
From: Lee Jones <lee@kernel.org>
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, Lee Jones <lee@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-sound@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
References: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org>
Subject: Re: (subset) [PATCH] mfd: db8500-prcmu: Fold dbx500 header into
 db8500
Message-Id: <178300730531.2216044.15808904000613354673.b4-ty@b4>
Date: Thu, 02 Jul 2026 16:48:25 +0100
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 19 Jun 2026 22:27:10 +0200, Linus Walleij wrote:
> Move the DBx500 PRCMU definitions into the DB8500 PRCMU
> header and delete the wrapper header.
> 
> Convert users of simple PRCMU wrappers to call the DB8500 helpers
> directly.
> 
> The dbx500-prcmu.h header was the result of an earlier attempt to
> abstract several DBx5x SoC PRCMU units to use the same abstract
> header. They are deleted from the kernel and this is not just
> causing maintenance burden and build errors.
> 
> [...]

Applied, thanks!

[1/1] mfd: db8500-prcmu: Fold dbx500 header into db8500
      commit: 6fd345e209284bc939693989bb7144133a8e93fd

--
Lee Jones [李琼斯]

