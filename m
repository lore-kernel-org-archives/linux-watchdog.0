Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A64CB8CA;
	Wed, 30 Sep 2026 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769235; cv=none; b=jju6KZWD7PEdeXcpKHnGxZ1FV9Hj5x88YkXGi61VzjUI+RgKCb/0JclRWHItOZWYZYiaoa55PgTVbCDqAMCW6alqBentYYP88fZlNtyq8qRJUdpHn+qQmZUrQ3IY5hcSdDplnXNR3ZpqZ04CfDSGxsNdCqOCy1N7eEb5OKiwhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769235; c=relaxed/simple;
	bh=98uDiU4m1CE5IG1CnHox+0Q6cUQSs2Gryvac1FIRwRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A32isXLxRigi3mJJVL2ukOQo4ugzX7aCS69A9g409fTB4CFibjn5y0zkkbtp/ts2wm4JBWpfK917HDCnfM3WPbD78Ma7sMrFkEhGM3grYhXqHY27iU1ruoqTfEg53E+Ot8PmkI4P3KwvfkNl2EUP42nipJmaUZX4HjSn2NbVTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM3LlTFe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM3LlTFe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C391F00893;
	Wed, 30 Sep 2026 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769232;
	bh=aDOKFxsfS8+uIYWfLyaNLqSR5dW8auR5x2hQl2P7bBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VM3LlTFe7sF2yMA9sCQW78hWZ8pklD/BRUrFtTYZU0ZFFDka38geWh/aP8PVI82Dt
	 EKV1r6cbkrnRh8kczAF7u0aq/8Qyqz9DfH6VB592f4is7mrS/Dp04Lx2YY+UpZsdpz
	 +d6i2vuTSVjO+zAuuDBlGoJTiw/Vf1gRVdEN0Ft8HXQKdVkP3iZnhYQlbmFUy8sH3q
	 mSh3ykjc2ntcL8nMATs3trkBZdluIkrYbqgUxcEGfjpCjwS+KnXB1Tww5o6RuVzwgT
	 dzeFF9tZ7M+3hpx6KbS5IYwZkuYItboUXiRKcDGDRvS0s8ahsKLcHKVOEdLxz/YxGo
	 ZudKRxiDh1ndg==
Date: Wed, 30 Sep 2026 19:53:49 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] watchdog: core: Prevent ping worker from re-arming
 timer on suspend
Message-ID: <arz4TZhOKTadhqx3@tzungbi-laptop>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-4-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929134635.2567137-4-linux@roeck-us.net>

On Tue, Sep 29, 2026 at 06:46:30AM -0700, Guenter Roeck wrote:
> In watchdog_dev_suspend(), hrtimer_cancel() is called before
> kthread_cancel_work_sync(). If the timer expired just before
> hrtimer_cancel() and queued watchdog_ping_work(), the worker can run
> and acquire wd_data->lock while kthread_cancel_work_sync() waits for it
> to finish. Because no state flag indicates that the watchdog is
> suspended, watchdog_worker_should_ping() returns true and
> __watchdog_ping() re-arms wd_data->timer while the device is suspended.
> 
> Add a _WDOG_SUSPENDED internal status bit to wd_data->status, set it
> under wd_data->lock in watchdog_dev_suspend(), clear it under
> wd_data->lock in watchdog_dev_resume(), and check it in
> watchdog_worker_should_ping(), watchdog_need_worker(), and
> __watchdog_ping() so the timer cannot be armed while suspended.
> 
> Fixes: 60bcd91aafd2 ("watchdog: introduce watchdog_dev_suspend/resume")
> Assisted-by: LLM
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
