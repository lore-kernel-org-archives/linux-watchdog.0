Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC42EBDE9;
	Wed, 30 Sep 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769293; cv=none; b=Svzumrn+aFO6jGjNHUdble7nmO/FngmTiSPcVBUZsslC+VLyxDCDN7e+KyIfg4fuqPNbxh3U+vBXpYblcgu0a7y0JmEa1rv1nY7W3tM/MfnHN4clDvhJmEPyCUaw50PAwft1biGBFuY7utjC/5Rt/hbuqHLlLw+OcPilQkrGqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769293; c=relaxed/simple;
	bh=iMvDvDD50O7JPJhDEfQJ6xQHelyxs1neFd2ZSH5mpcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcFghViz7xjayH9KvqB3x9BJAru3X8gqWWUcVb0kTfLHldFnQU8rt7jaSkSav4i9SVFs3kxMCvshpZrOuFO+3Ph2CrEYAl/aGdN4XJ1mz+S3AmdW3UaJ/9px3iDeoa4U8fbUv/gMo9yisby+acO9ARtVMsrcuB63Zu/jZDDIEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/ZeSvsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/ZeSvsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDF71F000FF;
	Wed, 30 Sep 2026 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769292;
	bh=Y9OY6q6JtpMyCLRK/JVfImQPXMO8EqrZtQgE/hDe7r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A/ZeSvsxkd55ckxzmhNhhS4lTyNHbLPkxSjNIyueAHU0fWB/Nk2mBw58n3P+xTcFg
	 TWzu1nl6a45veYCXELWYCVMXyqFMofSTdiGUG4l2gbGjE3IcIF2MnUdVWbvNfrDKPJ
	 2o7NjCpo4L+bjT4zQLiclA3/VBGS4D3mnca7RUxHdmwrwLBw6NN8MnfNlhWY/rxXij
	 B9iLRlyaEqHmNzWWqBKtb8eNjVxNreIHiCQMrKmj8B31L58MToTrbgbRPc9Hx3gzAB
	 qOlsmhzZcsps9VMJnKes4AGHiPBKQsXQFQxHuzYUZNtzAD+9/laiBOT+qOz9CXSldf
	 e89UvwBjhrWYQ==
Date: Wed, 30 Sep 2026 19:54:49 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] watchdog: core: Update last_keepalive in
 watchdog_start()
Message-ID: <arz4iU0SQDRDFMjU@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-9-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-9-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:35AM -0700, Guenter Roeck wrote:
> When starting a watchdog whose hardware is already running,
> watchdog_start() calls __watchdog_ping() before marking the watchdog
> active, and fails to update wd_data->last_keepalive. As a result:
> 
> 1. wd_data->last_keepalive remains 0, causing watchdog_get_timeleft() to
>    calculate the elapsed time since the epoch and return 0 time left.
> 2. watchdog_update_worker() inside __watchdog_ping() evaluates
>    watchdog_need_worker() and watchdog_next_keepalive() while WDOG_ACTIVE
>    is still clear, using wd_data->open_deadline instead of
>    wd_data->last_keepalive. If open_deadline has expired, the background
>    keepalive timer is not armed; conversely, if the active watchdog does
>    not need a worker, the boot keepalive timer is not canceled.
> 
> Set WDOG_ACTIVE and wd_data->last_keepalive to started_at before calling
> __watchdog_ping(), and revert WDOG_ACTIVE and update the worker if
> __watchdog_ping() fails.
> 
> Fixes: fbbe35dfcf94 ("watchdog: use __watchdog_ping in startup")
> Assisted-by: LLM
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
