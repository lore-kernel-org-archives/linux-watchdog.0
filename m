Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1154051AFF4;
	Thu, 15 Oct 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067531; cv=none; b=RD4RZTa0evp4KXOtnaoDutuGfry93s0t8YlAELa+g+tGLqoiU019ulDbt4fqRYq3EXWlNNvbaBAVotesmxJVwDriRLM5GnCubXcHkjuJd0+QR66O5omdvCl2WPU5nGLJqaVZx90WdLUtmsvqyGiQc9KieGfBgVj+8TZ0xon0NgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067531; c=relaxed/simple;
	bh=kzWJ+SNZHchjY3ftI4ZKDI8gBkfD4rC3k6Atfox9R0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPt7mKXQwDjhQP7tR2SzYsHT0KwdsZPOnuVV6VWxMkTisnbesV/9La59DAQlCU5f9+q9wBDIbUps0Znq0SAyc8cgFaa5H7CT7TvEk+R729Dw1XKVsegwpXpDmspEvisgaAqSUELhlVqp3jDAlxPukGaJjS4MtX8KOhbCU9jifkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoXuu5iV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoXuu5iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A611F000C4;
	Thu, 15 Oct 2026 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067529;
	bh=l0G1u5/k4DcckxQeq3RlZifz6+ya0XrhqOvHOHu/ECU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WoXuu5iVYKzi0YL78zWXnX1DzmJ9moh6C+TQj5egRlmmHOKiGZopRHDcl5ahXN4jO
	 UijgWMZFE6Wakd4tlP8zhkv2mYEc1+Y9DXIBSd1JujYrZAKw8959VM5rR2sRFXrzLK
	 +lMXbP80hpSBDDq3NxjBhcouNDhyAqjkXSsF/v1XtYeAAyVxvJI3NBJg3EjLe5qDb+
	 +wzbLMyZUS6SWTyx4nQ3BAgIhUPS1v9zHFtBbcmMpoMcwL6wtvWoop8Zl2dnNSTUoH
	 0miTYK7WiOJ090Q/1u4tQW7fXC7lt7OejPe89lrNrsZQSA/8ATyEywSehgxhDOPms9
	 BIJkjWi0xatog==
From: Thomas Gleixner <tglx@kernel.org>
To: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>,
 Radu Rendec <radu@rendec.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Andi
 Shyti <andi.shyti@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, Fil Dunsky
 <filipp.dunsky@gmail.com>
Subject: Re: [PATCH v3 02/11] irqchip: Add Cortina Systems CS75xx peripheral
 interrupt controller
In-Reply-To: <20261013-b4-cs75xx-s2-v3-2-181bb0d23f4c@gmail.com>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-2-181bb0d23f4c@gmail.com>
Date: Thu, 15 Oct 2026 14:32:06 +0200
Message-ID: <87tsmndu0p.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 13 2026 at 09:07, Fil Dunsky via B4 Relay wrote:
> +static int __init cs75xx_intc_init(struct device_node *np,
> +				   struct device_node *parent)

No line break required. You have 100 characters. Please fix that all
over the place.

Other than that this looks good.

Thanks,

        tglx
