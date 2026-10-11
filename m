Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325A3451C6;
	Sun, 11 Oct 2026 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791696666; cv=none; b=UXSMULH2Betg9oXMkRO8XcmgTntheWE3CiKtwnJAbU4CW8eO3ob5WcsaXk5N5+NABO+rup5Uhyt1qVFLhiDgxh2zjAXk1RiK8wuGRiFmltlsrLjuzxGpyJJI7fSJS4OATRvIX4HEQ2VzxUsVGVwPSSc67x0z78wzUVW1jH1LR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791696666; c=relaxed/simple;
	bh=mmkOBjydK8X1MPZjQ+oe1RAsEXoznMVWMyZLqangTok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh3RavRJ5W4undoLaIumg24/FfKCKsRwSfHvlBnJYU3h/55s48SHX1nRe/12q670L00LzFNui5FnNxPBWirBnbT+KbILjstgG9y/BI3kfEbWQj2phovSV/mJ1sFvf3BR+B6F27E51lT31gueg4/qMQdpFWGJaG2qlbtUYmTwQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUrpTlgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUrpTlgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7794E1F0089B;
	Sun, 11 Oct 2026 05:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791696664;
	bh=9UINK8Ylgw2POp8mtSoHe0NZ1kXpFn45FN0OmGDfuuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SUrpTlgbVIRHiOgX1oK0kAIDCT9ok7g9D7ot6DGNaGdldQ8dMwoTMyWHEUW2Zr3tl
	 LjZzh+CTCCQZ8GMe0bNiKhEoLjwAnEIwx03ETzpI2XZxb2IwwvsjPmcFjrY/G6BLIF
	 YIA+YfdQBEc2ODULd44o4sdIPv6ybChZsiy4J8Z8z+upgMuEY+uWJ4Rd/4ZYTnJHyN
	 KLCaa5ih8LbhAKDSYc4ApgYFj09VtRR4/03ihFnO1vkNj6uoUpYwvpXqmSpjFY2Nnp
	 COgoXU/tRd8qX2I5qH6NahXgFm63ClsTAtomQ38W23lWRw/UF21aWREG7xRJAe8IvZ
	 Fi+6ju0AiZZJw==
Date: Sun, 11 Oct 2026 07:30:59 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: a0282524688@gmail.com
Cc: lee@kernel.org, Ming Yu <tmyu0@nuvoton.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v8 06/13] mfd: nct6694: Move module type macros to shared
 header
Message-ID: <asse8LZ76649tShM@zenone.zhora.eu>
References: <20261007092102.3768818-1-a0282524688@gmail.com>
 <20261007092102.3768818-7-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007092102.3768818-7-a0282524688@gmail.com>

Hi Ming,

On Wed, Oct 07, 2026 at 05:20:55PM +0800, a0282524688@gmail.com wrote:
> From: Ming Yu <a0282524688@gmail.com>
> 
> Each sub-device driver defines the module type used by its own
> commands. The upcoming HIF transport also needs to recognise
> NCT6694_RPT_MOD, as report accesses are served from a separate
> register space rather than through the command mailbox.
> 
> Move all module types into the shared header so that the transports
> and the sub-device drivers use a single set of definitions.
> 
> No functional change.
> 
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
