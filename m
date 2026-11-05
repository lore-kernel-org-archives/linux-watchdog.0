Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891739;
	b=00Zvnx+aCW0O7KPc2FgRBQAr6jb+/z4ldlhbDTeV28PvrJYAA2BVyrGyl0qjbcJ8D282
	 upTJr0BA3/wyx7Rf1vYdOlPprfB+QaRWgEtaodU23rOa9F48Tb39zUialzY9ck3dkteUx
	 XV+/nrXXdhZrYzbDW/ZZNVyATz4+jHe9+VQUIY+h1qaXlP+W+uDEf82wY4VKHckC3sxNj
	 LutYX+oz1P4O0zZh5MmhJELi2Zlc2hXaC6qedvubf1M8PCLA6Ot+Gv28EddCGZdympamp
	 oc19lyH1UuYv3/OBHfd//AVkkpQOIIxfVFF/dWIK5W+uKOU5nlnVsj33k565PV3P41A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891739;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fzoTKslqfXNyjL6FTu8Jr3yAW9QENWGpwtTy9t4qGGM=;
	b=kqx0Ngf8P857uEPX5CC8hnvJobXMKP3ufGjucCLxdp4IiY6fCBavXJWo1mpR45cRUyoy
	 bdWiF1bSY+TrwlCuHGQoYQzM6h6ra2E8DnE2ASybt29YZkMVONRXpHlJOAhc+6aJ0yZA5
	 tqI/v9wjA6EK0oEz0UEtJN9ljwQaMJdsHX1yB1ao1wXpskAPkwf9qdia8kN5zaH55M5VT
	 ZAZgJgX9T2moyFdA/s4zW9Z36X60UbebBGJ1u5ODCBDIJxoxMsmJCfx3LcQZ8kgC543cm
	 HU2P66/D+2YWQG874V+ELlmcX3NlVuiecWBlqg1r0BSxW2Jo344mfVkCG/Cb3y35+GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJ8xkDYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CA606A331
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJ8xkDYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A4C1F000C1;
	Thu,  5 Nov 2026 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891739;
	bh=fzoTKslqfXNyjL6FTu8Jr3yAW9QENWGpwtTy9t4qGGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RJ8xkDYd4CEueJxmMoNt786aI2PqLhFq3Aiw81hpI3gqb0g+n7mJKhNNKmAZZq48l
	 33hf5h313eB4CjH5YD/bJt6vTdTZITYG0DZxA44c9GC5IhBcFFvQCFMMS9CzCCuGQR
	 JRhqqRvmAFOweeq/aRrGOhyIN9ZXZ7iHQyxOdubr2TaR38aJWqukVyS8FYVdgifvJE
	 X8RZ/hzcYiCUP7mlnYfWpfD4QRyaUJBdjOGiWVzQK/+S1Cyo2eQN3eKvqfhlecgOGY
	 PVlKdy0weaz+h0xOoTTiebl3xgiywZAgAQIVKZcrzqd2ppBnoRu/th6XsQk+tiSZq/
	 lw5qtI3eclSeg==
Date: Thu, 5 Nov 2026 15:15:36 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 4/5] watchdog: starfive-wdt: Fix runtime PM usage count
 leaks in probe and remove
Message-ID: <auydmH-6hEHxBEBv@google.com>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-5-linux@roeck-us.net>
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
In-Reply-To: <20261104164445.3209560-5-linux@roeck-us.net>

On Wed, Nov 04, 2026 at 08:44:44AM -0800, Guenter Roeck wrote:
> When runtime PM is enabled, starfive_wdt_probe() acquires a runtime PM
> reference via pm_runtime_resume_and_get(). On subsequent probe failures,
> err_exit manually disables clocks via starfive_wdt_disable_clock() and
> calls pm_runtime_disable(), without dropping the acquired runtime PM
> reference (and leaving the hardware timer running if early_enable was
> enabled and watchdog_register_device() failed).
> 
> Similarly, when early_enable is set (or the watchdog was left running
> on close), the active runtime PM reference is retained after probe, but
> starfive_wdt_remove() never releases it before calling
> pm_runtime_disable().
> 
> Release the runtime PM reference with pm_runtime_put_sync() on probe
> error paths (stopping the watchdog first if running) and in
> starfive_wdt_remove() when watchdog_hw_running() is still set.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
