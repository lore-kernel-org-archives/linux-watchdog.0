Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847989;
	b=nLiIPIMnvT/+T93o7ErNgr3DFaYRwFvga6aZsKAN7YedARnzSUdFAnD5KqCnZgXhx0xJ
	 z9GTigb6qM8MPSlzKxjA/2UwKNsZpLtiHBpHpXGyX3Y4HJuJvVj7VjuoaXpu7JzbPQag9
	 1CJmyNaOoFNkWQZXcyuV6edLkyYKWUuVyxh6t5AsJEXitbSaOHdKbTfHX/iIJttSidYJA
	 ILEAvBozhb2gnriSYgB/jEcMIThwHvtRibd3FqM1RBuvgDsQlbNw+nJmL/liHuiwn+j+b
	 HQTdwtIbfAcegrfMrfELqQtHvG+mAeuLy7MU47hZbrurqyLqnJ/Qp0iKkxZ4ZDKBc/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847989;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7wsWGABAa20x3UfbBunMrvukgY3ryCim2pIQc23hZa8=;
	b=HfHsLUIZF4+rWe/Wztc6Tytr6IA1b6S4INTswj2Gg6aefOUoAgwTHt/rCuTqFllRzDFw
	 RUfk0zr9Iy39Pu2cG4M98PkvBBD3gytJyL0WXlnVPY3ukLbFwrd6S2rD8ROtT2mhL13W0
	 Gv/arJT/7lGGoKOF/E8AWhEJ1fq8A6AsrlQQ10bQ7aeoqayqvuvECo5KHaaSJi80ABMmZ
	 H5YuP4mlj/X1O0qDYH+gLi06S6fsy4HPYmuaPkZO1tK+WCBzD7CLxm0NTExdFwIdf6fqp
	 +V9mlljiT7hio28VPp30q6+EUHHhtjc9y9GCpOQW1kEPJU7C9cEzpR7OEdLtQOXfyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHLNJPnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8D606A31A;
	Sat, 24 Oct 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHLNJPnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCA11F01825;
	Sat, 24 Oct 2026 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792847988;
	bh=7wsWGABAa20x3UfbBunMrvukgY3ryCim2pIQc23hZa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fHLNJPnbUcZsAE2Ev7QiCrc1p4p1lIKtBo1h6h8P3bvSmVIqF7NTK71UgcxsRRoa0
	 P7Mq3eaZXJ+23i3pf83OrWFRHi4sP99CcQwdVBP7wjCw4LHVwlpmj1h7IjgZf+dd2g
	 HLxbq8TrlI9xMhyql5uCRwljPfPze5WGnc5TvJem28ubbpkuBEE+Ye3WbXZqs5Rt+V
	 +VPB5s0YguvFmlDP2WaHgpU6ysn7dTV8Ha56lDNN22qjHBte5JahqsaHYvrz9GWv1y
	 c4e1UkC1ijq2Zn6jkyJbyy7+Ql7m4D+xRpu+rj1Xgc5FT2gNHYevlHQbI0mXPZYkIU
	 P1+SYBkdk28mg==
Date: Sat, 24 Oct 2026 21:19:44 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: linux@roeck-us.net, p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org, iav@iav.lv, wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: dw_wdt: manage reset line during system
 suspend/resume
Message-ID: <atywcMUwkv1KxVaK@tzungbi-laptop>
References: <y>
 <20261024121428.18862-1-a.shimko.dev@gmail.com>
 <20261024121428.18862-3-a.shimko.dev@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024121428.18862-3-a.shimko.dev@gmail.com>

On Sat, Oct 24, 2026 at 03:14:24PM +0300, Artem Shimko wrote:
> The watchdog controller reset line is not currently managed during system
> suspend/resume. This can lead to an inconsistent hardware state when
> resuming from suspend, as the controller may not be properly reinitialized.
> 
> Assert the reset line before disabling clocks during suspend to ensure
> the controller is held in reset while power is gated. During resume,
> deassert the reset after clocks are enabled and before restoring register
> state to guarantee the controller is properly initialized.
> 
> Tested-by: Igor Velkov <iav@iav.lv>
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
