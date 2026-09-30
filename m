Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68160250BF2;
	Wed, 30 Sep 2026 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769284; cv=none; b=XW7JSs28FS44cU3POQfoGVMpZ7mTweaCnoVhAbsTHkzXvX7GVuDSmcrEjDBTqPF2iKCChMmYPxcI6aqt2acwlYYblMD0w/cfHGHfuB1uMbr8fPJjbQtXBi+IIOc4hl0Mb4UaFRBVZO/shWkSULf04OgvWF2eyF0KCigXcqRaVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769284; c=relaxed/simple;
	bh=56S9HWCMRLnjkhhrIAk5qjCk8fJVOxBmKEMLnkEK3xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3ydoO1+EIN7rUFjJ4btc09LGO9+84TKydbUpoA16F+IDfhTX6bR8OGw7u/DmkzZs91i97jx6j5bFd6sM+n4oUHvcV8HhSCAM0acQYJEqKXwh125yAanA1E8I/RLlL2JaJKoScqKLRJqvZqgjZrB3C3IAqmRp2ncExFSBk1rhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6yn+tcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6yn+tcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637CE1F00893;
	Wed, 30 Sep 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769283;
	bh=e3Q+FXMl3aZSuxKVTNqPnQyXaLnFfJEPGs2bUnwBQM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P6yn+tcLzBDLaAfH2mGsnSwgQDAP6EOCI05qezjC/Rd6Kb4xVdfRmHubmTdCGZwzV
	 fvBDOXSt0IszthpRrl7W2goKjfWdU+I/AiUX4KJsf0lCu3lPiB8XiFI7xz1iqkfTXs
	 2cP1fQBkcYQMaoDM+Pz291m8bvRrjJFATcE/udeo39N6yEKI+400W94umiVTxKG7xE
	 ePAGIWJMKaOSDisQHe7/ry9ZOkWQyr3Hr2A7XYAtd1IVww8Axzy/desahVxRkzCp8m
	 O9Hz/62qBns7ppZhVjdZONHTly78e2Wdgsu8l5vxF0o+ISIieAwzMT7YCsmUKaz3fk
	 NJ1uvFaUZyPTA==
Date: Wed, 30 Sep 2026 19:54:40 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] watchdog: core: Fix unbalanced module_put() in
 watchdog_open()
Message-ID: <arz4gIzKGH2nUoLr@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-8-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-8-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:34AM -0700, Guenter Roeck wrote:
> If the hardware watchdog is running (hw_running is true), try_module_get()
> is skipped. However, if watchdog_start() then fails, the code jumps to
> out_mod and unconditionally calls module_put().
> 
> This can cause a premature driver module unload while hardware timers or
> interrupts are active by dropping a reference that was never acquired.
> 
> Only call module_put() if the hardware watchdog is not running to fix the
> problem.
> 
> Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
> Assisted-by: LLM
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
