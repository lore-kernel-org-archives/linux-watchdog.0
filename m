Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886419;
	b=5N2Y7ir5DDVF1Icva3aZXJRtZmdfviCZpmxdD1xJtFXEfLBTa8IjluxMo11bnmD8ko9D
	 LFpPXlTJ61P9jEyPmPj/h8ClSTiV7kESR39vswz0s62ndXkqbTq3PGoDaAkklFX8wXBJQ
	 e5i96BmM30S/huJuevdc+x8sMXTan/Ad18VL7S/Aaxipz3jtVKYK8cgfHOh9AgRFiNJ0F
	 EZYah0LSRyC3Tlio4R6HczywHApLrE2/H77mdPpIJzYov+WAN0kBQfPJ2czfR2z93u7q9
	 OB3BmFYBkaYMdeiA8XJfTAx/NKqxPMFXgTvAAKTQptrr5n8qMcxApZTZf7FtILOl9Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886419;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HX2o0c3L8r3gkFEL1+sTsc3CSwJDqgKQ97Hofop43SA=;
	b=1aQC7wswf6ioBboaqmIn67SmjnY99luu3wa1Dcvx4W8M+eXESiUyaVMz3HlMRyDLJgr5
	 WrMeEs7J9VyYlpD1WrevMHLOYp502NQ2puh56auD537cyqhsBG0zJIRG0pu3jgANTjI6N
	 DfFWukvgTwcKkBl2FaqhtaeEq3ekqDljCaH8SJ6fPNfckfLvu6u2srGveiHsnHaVWepEg
	 q4xr3eTAVhOeL5OHRfwDz7LwlUDEAtoktS80rSsPCBVvHAYTDuKBw5PjjPa5GpFr8DWQG
	 d/9qeP+hxNHwvEmjvzVIIKkcyms5IpPp9nptVsOdeT87EMWZ2xsODw0YK8W+kGD2zkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J15Ad+vT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35365606A329
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J15Ad+vT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51851F00919;
	Thu,  5 Nov 2026 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886418;
	bh=HX2o0c3L8r3gkFEL1+sTsc3CSwJDqgKQ97Hofop43SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J15Ad+vTXcOgH9R8uEZfnspT0QnP4bmBhpuIF7mvsQ7goLi/QBqHJiD3eQkjqex/z
	 QG7NCECZ2dhXdJmXvJTdavCrUAyH8HKXkNcrJAwl0Uz2DDksJukQ80Fn0Mm/IDUdsa
	 kXjWkq77IGpdhD0sGczZDGd6jaclDcRUyZLo91vB8Xo9ljoLZKSHlP09ivesB+tyul
	 OO6+h1V0oDCcellHK49qdEHj+hs7VA8PCub1AIpldsE80B7P0NNZFYmH2a1NlBo1r9
	 yUQdMqvVwQbaausQ/r1vbrHFQ5xUh7RFMquvi/ltxteDEQtWnP95QcP8ByUW41Enjj
	 cxNlBIQ+tlyQA==
Date: Thu, 5 Nov 2026 13:46:56 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 2/5] watchdog: starfive-wdt: Balance pm_runtime_enable()
 on probe error paths
Message-ID: <auyI0Ber8pCmrdU-@google.com>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-3-linux@roeck-us.net>
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
In-Reply-To: <20261104164445.3209560-3-linux@roeck-us.net>

On Wed, Nov 04, 2026 at 08:44:42AM -0800, Guenter Roeck wrote:
> In starfive_wdt_probe(), pm_runtime_enable() is called before attempting
> to resume the device via pm_runtime_resume_and_get() or enable its clocks
> via starfive_wdt_enable_clock(). If either call fails, probe returns
> directly without calling pm_runtime_disable(), leaving the runtime PM
> disable_depth counter unbalanced (and triggering "Unbalanced
> pm_runtime_enable!" warnings on deferred probe retries).
> 
> Add an err_disable_pm error label and jump to it so pm_runtime_disable()
> is called on these error paths.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
